import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:encrypt/encrypt.dart' as encrypt_pkg;

class PaymentResult {
  final bool success;
  final String message;
  final String? transactionId;

  PaymentResult({
    required this.success,
    required this.message,
    this.transactionId,
  });
}

class PaymentService {
  static const String _mpesaBaseUrl = 'https://sandbox.safaricom.co.ke';
  static const String _airtelBaseUrl = 'https://openapiuat.airtel.africa';

  // Security measures
  static const int _maxRetries = 3;
  static const Duration _requestTimeout = Duration(seconds: 30);
  static final _secureRandom = Random.secure();
  
  // Rate limiting
  static final Map<String, List<DateTime>> _requestLog = {};
  static const int _maxRequestsPerMinute = 5;

  // Test credentials and configuration
  static const bool isTestMode = true; // Set to false in production
  static const String _mpesaConsumerKey = 'GpcV3sQnm1GWTXGn4z0V9GRCAkPGHKyA';
  static const String _mpesaConsumerSecret = 'IfI7UeSuDGANIHBx';
  static const String _mpesaPasskey = 'bfb279f9aa9bdbcf158e97dd71a467cd2e0c893059b10f78e6b72ada1ed2c919';
  static const String _mpesaShortcode = '174379';

  static const String _airtelClientId = 'a089d83a-9d08-4e0c-9581-f53c0248c1b9';
  static const String _airtelClientSecret = '7f74bd8e-c6d9-4613-96d9-79d091438750';
  static const String _airtelCountryCode = 'KE';
  static const String _airtelCurrency = 'KES';
  static const String _airtelEnvironment = 'sandbox';

  // Encryption key for sensitive data (in production, this should be stored securely)
  static const String _encryptionKey = 'test_key_123';

  // Input validation
  static final RegExp _phoneRegex = RegExp(r'^(?:\+254|254|0)?([17]\d{8})$');
  static const double _maxAmount = 300000.0; // KES 300,000 limit

  bool _isRateLimited(String phoneNumber) {
    final now = DateTime.now();
    final minutes = now.subtract(Duration(minutes: 1));
    
    _requestLog[phoneNumber] = _requestLog[phoneNumber]?.where((time) => time.isAfter(minutes)).toList() ?? [];
    
    if (_requestLog[phoneNumber]!.length >= _maxRequestsPerMinute) {
      return true;
    }
    
    _requestLog[phoneNumber]?.add(now);
    return false;
  }

  String _encryptSensitiveData(String data) {
    final key = encrypt_pkg.Key.fromUtf8(_encryptionKey);
    final iv = encrypt_pkg.IV.fromLength(16);
    final encrypter = encrypt_pkg.Encrypter(encrypt_pkg.AES(key));
    return encrypter.encrypt(data, iv: iv).base64;
  }

  Future<String> _getMpesaAccessToken() async {
    final authResponse = await http.get(
      Uri.parse('$_mpesaBaseUrl/oauth/v1/generate?grant_type=client_credentials'),
      headers: {
        'Authorization': 'Basic ${base64Encode(utf8.encode('$_mpesaConsumerKey:$_mpesaConsumerSecret'))}',
      },
    );

    if (authResponse.statusCode != 200) {
      throw Exception('Failed to authenticate with M-Pesa');
    }

    return json.decode(authResponse.body)['access_token'];
  }

  Future<String> _getAirtelAccessToken() async {
    final authResponse = await http.post(
      Uri.parse('$_airtelBaseUrl/auth/oauth2/token'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Basic ${base64Encode(utf8.encode('$_airtelClientId:$_airtelClientSecret'))}',
      },
    );

    if (authResponse.statusCode != 200) {
      throw Exception('Failed to authenticate with Airtel Money');
    }

    return json.decode(authResponse.body)['access_token'];
  }

  Future<PaymentResult> initiatePayment({
    required double amount,
    required String phoneNumber,
    required String paymentMethod,
  }) async {
    try {
      // Validate amount
      if (amount <= 0 || amount > _maxAmount) {
        return PaymentResult(
          success: false,
          message: 'Invalid amount. Must be between 1 and $_maxAmount',
        );
      }

      // Validate phone number
      if (!_phoneRegex.hasMatch(phoneNumber)) {
        return PaymentResult(
          success: false,
          message: 'Invalid phone number format',
        );
      }

      // Check rate limiting
      if (_isRateLimited(phoneNumber)) {
        return PaymentResult(
          success: false,
          message: 'Too many requests. Please try again later.',
        );
      }

      // Generate a unique transaction ID using secure random
      final transactionId = List.generate(16, (_) => 
        _secureRandom.nextInt(16).toRadixString(16)).join();

      if (paymentMethod.toLowerCase() == 'mpesa') {
        return _processMpesaPayment(
          amount: amount,
          phoneNumber: phoneNumber,
          transactionId: transactionId,
        );
      } else if (paymentMethod.toLowerCase() == 'airtel') {
        return _processAirtelPayment(
          amount: amount,
          phoneNumber: phoneNumber,
          transactionId: transactionId,
        );
      } else {
        return PaymentResult(
          success: false,
          message: 'Invalid payment method',
        );
      }
    } catch (e) {
      return PaymentResult(
        success: false,
        message: 'Payment initiation failed: ${e.toString()}',
      );
    }
  }

  Future<PaymentResult> _processMpesaPayment({
    required double amount,
    required String phoneNumber,
    required String transactionId,
  }) async {
    int retryCount = 0;
    while (retryCount < _maxRetries) {
      try {
        final response = await http.post(
          Uri.parse('$_mpesaBaseUrl/mpesa/stkpush/v1/processrequest'),
          headers: {
            'Authorization': 'Bearer ${await _getMpesaAccessToken()}',
            'Content-Type': 'application/json',
          },
          body: jsonEncode({
            'BusinessShortCode': _mpesaShortcode,
            'Password': _encryptSensitiveData(_mpesaPasskey),
            'Timestamp': DateTime.now().toIso8601String(),
            'TransactionType': 'CustomerPayBillOnline',
            'Amount': amount.round(),
            'PartyA': _encryptSensitiveData(phoneNumber),
            'PartyB': _mpesaShortcode,
            'PhoneNumber': _encryptSensitiveData(phoneNumber),
            'CallBackURL': 'https://example.com/callback',
            'AccountReference': transactionId,
            'TransactionDesc': 'Church App Payment',
          }),
        ).timeout(_requestTimeout);

        if (response.statusCode == 200) {
          final responseData = jsonDecode(response.body);
          if (responseData['ResponseCode'] == '0') {
            return PaymentResult(
              success: true,
              message: 'Payment initiated successfully',
              transactionId: transactionId,
            );
          }
          throw Exception(responseData['ResponseDescription'] ?? 'Unknown error occurred');
        } else {
          throw Exception('Failed to initiate payment: ${response.body}');
        }
      } catch (e) {
        retryCount++;
        if (retryCount == _maxRetries) {
          return PaymentResult(
            success: false,
            message: 'M-Pesa payment failed after $_maxRetries attempts: ${e.toString()}',
          );
        }
        await Future.delayed(Duration(seconds: 2 * retryCount));
      }
    }
    return PaymentResult(
      success: false,
      message: 'M-Pesa payment failed: Maximum retries reached',
    );
  }

  Future<PaymentResult> _processAirtelPayment({
    required double amount,
    required String phoneNumber,
    required String transactionId,
  }) async {
    int retryCount = 0;
    while (retryCount < _maxRetries) {
      try {
        final response = await http.post(
          Uri.parse('$_airtelBaseUrl/merchant/v1/payments'),
          headers: {
            'Authorization': 'Bearer ${await _getAirtelAccessToken()}',
            'Content-Type': 'application/json',
            'X-Country': _airtelCountryCode,
            'X-Currency': _airtelCurrency,
          },
          body: jsonEncode({
            'reference': transactionId,
            'subscriber': {
              'country': _airtelCountryCode,
              'currency': _airtelCurrency,
              'msisdn': _encryptSensitiveData(phoneNumber),
            },
            'transaction': {
              'amount': _encryptSensitiveData(amount.toString()),
              'country': _airtelCountryCode,
              'currency': _airtelCurrency,
              'id': transactionId,
            },
            'environment': _airtelEnvironment,
          }),
        ).timeout(_requestTimeout);

        if (response.statusCode == 200) {
          final responseData = jsonDecode(response.body);
          if (responseData['status']?['code'] == 'SUCCESS' || 
              responseData['status']?['code'] == 'PENDING') {
            return PaymentResult(
              success: true,
              message: 'Payment initiated successfully',
              transactionId: transactionId,
            );
          }
          throw Exception(responseData['status']?['message'] ?? 'Unknown error occurred');
        } else {
          throw Exception('Failed to initiate payment: ${response.body}');
        }
      } catch (e) {
        retryCount++;
        if (retryCount == _maxRetries) {
          return PaymentResult(
            success: false,
            message: 'Airtel payment failed after $_maxRetries attempts: ${e.toString()}',
          );
        }
        await Future.delayed(Duration(seconds: 2 * retryCount));
      }
    }
    return PaymentResult(
      success: false,
      message: 'Airtel payment failed: Maximum retries reached',
    );
  }

  // Add method to check payment status
  Future<PaymentResult> checkPaymentStatus({
    required String transactionId,
    required String paymentMethod,
  }) async {
    try {
      if (paymentMethod == 'airtel') {
        final authResponse = await http.post(
          Uri.parse('$_airtelBaseUrl/auth/oauth2/token'),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Basic ${base64Encode(utf8.encode('$_airtelClientId:$_airtelClientSecret'))}',
          },
        );

        if (authResponse.statusCode != 200) {
          throw Exception('Failed to authenticate with Airtel Money');
        }

        final accessToken = json.decode(authResponse.body)['access_token'];

        final response = await http.get(
          Uri.parse('$_airtelBaseUrl/standard/v1/payments/$transactionId'),
          headers: {
            'Authorization': 'Bearer $accessToken',
            'X-Country': _airtelCountryCode,
            'X-Currency': _airtelCurrency,
          },
        );

        if (response.statusCode == 200) {
          final responseData = json.decode(response.body);
          final status = responseData['status']['code'];

          return PaymentResult(
            success: status == 'SUCCESS',
            message: responseData['status']['message'],
            transactionId: transactionId,
          );
        }
      }
      // Add M-Pesa status check implementation here if needed

      throw Exception('Failed to check payment status');
    } catch (e) {
      return PaymentResult(
        success: false,
        message: 'Failed to check payment status: ${e.toString()}',
      );
    }
  }
}
