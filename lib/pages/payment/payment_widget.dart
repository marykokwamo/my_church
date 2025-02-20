import 'dart:async';

import 'package:flutter/material.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/widgets/custom_app_bar.dart';
import '/services/payment_service.dart';

class PaymentWidget extends StatefulWidget {
  final double amount;
  final VoidCallback onPaymentSuccess;
  final bool testMode;

  const PaymentWidget({
    Key? key,
    required this.amount,
    required this.onPaymentSuccess,
    this.testMode = false,
  }) : super(key: key);

  @override
  _PaymentWidgetState createState() => _PaymentWidgetState();
}

class _PaymentWidgetState extends State<PaymentWidget> {
  String? _selectedPaymentMethod;
  final _phoneController = TextEditingController();
  bool _isProcessing = false;
  Timer? _statusCheckTimer;
  String? _currentTransactionId;
  bool _autoFillEnabled = false;

  @override
  void initState() {
    super.initState();
    if (widget.testMode) {
      _autoFillEnabled = true;
      _selectedPaymentMethod = 'mpesa';
      _phoneController.text = '0708374149';
    }
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _statusCheckTimer?.cancel();
    super.dispose();
  }

  void _toggleTestMode() {
    setState(() {
      _autoFillEnabled = !_autoFillEnabled;
      if (_autoFillEnabled) {
        _selectedPaymentMethod = 'mpesa';
        _phoneController.text = '0708374149';
      } else {
        _selectedPaymentMethod = null;
        _phoneController.text = '';
      }
    });
  }

  void _autoFillTestData(String paymentMethod) {
    if (_autoFillEnabled) {
      setState(() {
        _selectedPaymentMethod = paymentMethod;
        _phoneController.text = paymentMethod == 'mpesa' 
            ? '0708374149'  
            : '0999999999'; 
      });
    }
  }

  void _startPaymentStatusCheck(String transactionId) {
    setState(() {
      _currentTransactionId = transactionId;
      _isProcessing = true;
    });
    
    _statusCheckTimer?.cancel();
    _statusCheckTimer = Timer.periodic(Duration(seconds: 5), (timer) async {
      if (!mounted) {
        timer.cancel();
        return;
      }

      final paymentService = PaymentService();
      final result = await paymentService.checkPaymentStatus(
        transactionId: _currentTransactionId!,
        paymentMethod: _selectedPaymentMethod!,
      );

      if (result.success) {
        timer.cancel();
        if (mounted) {
          setState(() {
            _currentTransactionId = null;
            _isProcessing = false;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Payment completed successfully!'),
              backgroundColor: Colors.green,
            ),
          );
          widget.onPaymentSuccess();
        }
      } else if (!result.message.toLowerCase().contains('pending')) {
        timer.cancel();
        if (mounted) {
          setState(() {
            _currentTransactionId = null;
            _isProcessing = false;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(result.message),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    });
  }

  void _cancelCurrentTransaction() {
    if (_currentTransactionId != null) {
      _statusCheckTimer?.cancel();
      setState(() {
        _isProcessing = false;
        _currentTransactionId = null;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Transaction cancelled'),
          backgroundColor: Colors.orange,
        ),
      );
    }
  }

  Future<void> _processPayment() async {
    if (_selectedPaymentMethod == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please select a payment method')),
      );
      return;
    }

    if (_phoneController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter your phone number')),
      );
      return;
    }

    // Don't start a new payment if one is in progress
    if (_currentTransactionId != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('A payment is already in progress. Please wait or cancel it.'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    setState(() {
      _isProcessing = true;
    });

    try {
      final paymentService = PaymentService();
      final result = await paymentService.initiatePayment(
        amount: widget.amount,
        phoneNumber: _phoneController.text,
        paymentMethod: _selectedPaymentMethod!,
      );

      if (result.success && result.transactionId != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(result.message),
            backgroundColor: Colors.green,
          ),
        );
        _startPaymentStatusCheck(result.transactionId!);
      } else {
        setState(() {
          _isProcessing = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(result.message),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      setState(() {
        _isProcessing = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Payment failed: ${e.toString()}'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      appBar: CustomAppBar(
        title: 'Payment',
        showBackButton: true,
        actions: [
          if (_currentTransactionId != null)
            IconButton(
              icon: Icon(Icons.cancel_outlined),
              onPressed: _cancelCurrentTransaction,
              tooltip: 'Cancel Transaction',
            ),
          if (widget.testMode)
            IconButton(
              icon: Icon(
                _autoFillEnabled ? Icons.bug_report : Icons.bug_report_outlined,
                color: _autoFillEnabled ? Colors.green : null,
              ),
              onPressed: _toggleTestMode,
              tooltip: 'Toggle Test Mode',
            ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (_currentTransactionId != null)
              Card(
                color: Colors.blue[100],
                child: Padding(
                  padding: EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Transaction in Progress',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text('Transaction ID: ${_currentTransactionId!}'),
                      Text('Please complete the payment on your phone'),
                    ],
                  ),
                ),
              ),
            if (widget.testMode && _autoFillEnabled)
              Card(
                color: Colors.yellow[100],
                child: Padding(
                  padding: EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Test Mode Active',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text('M-Pesa Test: 0708374149'),
                      Text('Airtel Test: 0999999999'),
                      Text('Test PIN: 0000'),
                    ],
                  ),
                ),
              ),
            SizedBox(height: 16),
            Text(
              'Amount to Pay',
              style: FlutterFlowTheme.of(context).titleMedium,
            ),
            SizedBox(height: 8),
            Text(
              'KES ${widget.amount.toStringAsFixed(2)}',
              style: FlutterFlowTheme.of(context).headlineMedium.copyWith(
                    color: FlutterFlowTheme.of(context).primary,
                  ),
            ),
            SizedBox(height: 32),
            Text(
              'Select Payment Method',
              style: FlutterFlowTheme.of(context).titleMedium,
            ),
            SizedBox(height: 16),
            Card(
              child: RadioListTile<String>(
                title: Row(
                  children: [
                    Image.asset(
                      'assets/images/mpesa_logo.png',
                      height: 24,
                    ),
                    SizedBox(width: 12),
                    Text('M-Pesa'),
                  ],
                ),
                value: 'mpesa',
                groupValue: _selectedPaymentMethod,
                onChanged: (value) {
                  setState(() {
                    _selectedPaymentMethod = value;
                    if (_autoFillEnabled) {
                      _autoFillTestData('mpesa');
                    }
                  });
                },
              ),
            ),
            SizedBox(height: 8),
            Card(
              child: RadioListTile<String>(
                title: Row(
                  children: [
                    Image.asset(
                      'assets/images/airtel_money_logo.png',
                      height: 24,
                    ),
                    SizedBox(width: 12),
                    Text('Airtel Money'),
                  ],
                ),
                value: 'airtel',
                groupValue: _selectedPaymentMethod,
                onChanged: (value) {
                  setState(() {
                    _selectedPaymentMethod = value;
                    if (_autoFillEnabled) {
                      _autoFillTestData('airtel');
                    }
                  });
                },
              ),
            ),
            SizedBox(height: 32),
            Text(
              'Enter Phone Number',
              style: FlutterFlowTheme.of(context).titleMedium,
            ),
            SizedBox(height: 8),
            TextFormField(
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                hintText: 'Enter your phone number',
                prefixIcon: Icon(Icons.phone),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            SizedBox(height: 32),
            FFButtonWidget(
              onPressed: _isProcessing ? null : _processPayment,
              text: _isProcessing ? 'Processing...' : 'Pay Now',
              options: FFButtonOptions(
                width: double.infinity,
                height: 50,
                color: FlutterFlowTheme.of(context).primary,
                textStyle: FlutterFlowTheme.of(context).titleSmall.copyWith(
                      color: Colors.white,
                    ),
                elevation: 2,
                borderRadius: BorderRadius.circular(8),
                disabledColor: FlutterFlowTheme.of(context).secondaryBackground,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
