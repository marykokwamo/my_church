import 'package:flutter/material.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../widgets/custom_app_bar.dart';

class CheckoutWidget extends StatefulWidget {
  const CheckoutWidget({Key? key}) : super(key: key);

  @override
  _CheckoutWidgetState createState() => _CheckoutWidgetState();
}

class _CheckoutWidgetState extends State<CheckoutWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  int _currentStep = 0;
  
  // Sample cart items
  final List<Map<String, dynamic>> cartItems = [
    {
      'title': 'Daily Devotional',
      'price': '1,599',
      'image': 'assets/images/book1.jpg',
      'quantity': 1,
    },
    {
      'title': 'Worship CD',
      'price': '799',
      'image': 'assets/images/cd1.jpg',
      'quantity': 2,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: CustomAppBar(
        title: 'Checkout',
        showBackButton: true,
      ),
      body: Stepper(
        currentStep: _currentStep,
        onStepContinue: () {
          if (_currentStep < 2) {
            setState(() {
              _currentStep++;
            });
          }
        },
        onStepCancel: () {
          if (_currentStep > 0) {
            setState(() {
              _currentStep--;
            });
          }
        },
        steps: [
          Step(
            title: Text('Cart Review'),
            content: Column(
              children: [
                ...cartItems.map((item) => _buildCartItem(item)),
                SizedBox(height: 16),
                _buildOrderSummary(),
              ],
            ),
            isActive: _currentStep >= 0,
          ),
          Step(
            title: Text('Delivery Details'),
            content: _buildDeliveryForm(),
            isActive: _currentStep >= 1,
          ),
          Step(
            title: Text('Payment'),
            content: _buildPaymentOptions(),
            isActive: _currentStep >= 2,
          ),
        ],
      ),
    );
  }

  Widget _buildCartItem(Map<String, dynamic> item) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Row(
          children: [
            Image.asset(
              item['image'] as String,
              width: 60,
              height: 60,
              fit: BoxFit.cover,
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item['title'] as String,
                    style: FlutterFlowTheme.of(context).titleSmall,
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Ksh ${item['price']}',
                    style: FlutterFlowTheme.of(context).bodyMedium.copyWith(
                          color: Color(0xFFE31E24),
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                IconButton(
                  icon: Icon(Icons.remove),
                  onPressed: () {
                    // Decrease quantity
                  },
                ),
                Text(
                  '${item['quantity']}',
                  style: FlutterFlowTheme.of(context).titleMedium,
                ),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    // Increase quantity
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderSummary() {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Order Summary',
              style: FlutterFlowTheme.of(context).titleMedium,
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Subtotal'),
                Text('Ksh 3,197'),
              ],
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Delivery'),
                Text('Ksh 200'),
              ],
            ),
            Divider(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total',
                  style: FlutterFlowTheme.of(context).titleMedium,
                ),
                Text(
                  'Ksh 3,397',
                  style: FlutterFlowTheme.of(context).titleMedium.copyWith(
                        color: Color(0xFFE31E24),
                      ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDeliveryForm() {
    return Column(
      children: [
        TextFormField(
          decoration: InputDecoration(
            labelText: 'Full Name',
            border: OutlineInputBorder(),
          ),
        ),
        SizedBox(height: 16),
        TextFormField(
          decoration: InputDecoration(
            labelText: 'Phone Number',
            border: OutlineInputBorder(),
          ),
        ),
        SizedBox(height: 16),
        TextFormField(
          decoration: InputDecoration(
            labelText: 'Email',
            border: OutlineInputBorder(),
          ),
        ),
        SizedBox(height: 16),
        TextFormField(
          decoration: InputDecoration(
            labelText: 'Delivery Address',
            border: OutlineInputBorder(),
          ),
          maxLines: 3,
        ),
      ],
    );
  }

  Widget _buildPaymentOptions() {
    return Column(
      children: [
        ListTile(
          leading: Radio(
            value: 0,
            groupValue: 0,
            onChanged: (value) {},
          ),
          title: Text('M-PESA'),
          subtitle: Text('Pay via M-PESA mobile money'),
        ),
        ListTile(
          leading: Radio(
            value: 1,
            groupValue: 0,
            onChanged: (value) {},
          ),
          title: Text('Card Payment'),
          subtitle: Text('Pay with credit or debit card'),
        ),
        SizedBox(height: 24),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              // Process payment
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFFE31E24),
              padding: EdgeInsets.symmetric(vertical: 16),
            ),
            child: Text(
              'Complete Payment',
              style: TextStyle(fontSize: 16),
            ),
          ),
        ),
      ],
    );
  }
}
