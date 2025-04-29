import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Define the custom colors
const Color lightGrayBackground = Color(0xFFF7F7F7);
const Color tealAccentColor = Color(0xFF209CA5);
const Color myBlackColor = Color(0xff1A1A1A);
const Color redWarning = Colors.red;

class PaymentScreenBody extends StatefulWidget {
  const PaymentScreenBody({super.key});

  @override
  State<PaymentScreenBody> createState() => _PaymentScreenBodyState();
}

class _PaymentScreenBodyState extends State<PaymentScreenBody> {
  final TextEditingController _amountController = TextEditingController();
  bool _isProcessing = false;
  String? _paymentStatus;
  bool _isSuccess = false;

  void _processPayment() {
    // Validate amount
    if (_amountController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter an amount'),
          backgroundColor: tealAccentColor,
        ),
      );
      return;
    }

    setState(() {
      _isProcessing = true;
      _paymentStatus = null;
    });

    // Simulate payment processing
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _isProcessing = false;
        
        // Simulate random success/failure for demo purposes
        _isSuccess = DateTime.now().millisecondsSinceEpoch % 2 == 0;
        _paymentStatus = _isSuccess 
          ? 'Payment Successful!' 
          : 'Payment Failed. Please try again.';
      });
    });
  }

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightGrayBackground,
      appBar: AppBar(
        title: const Text(
          'Payment',
          style: TextStyle(color: myBlackColor),
        ),
        centerTitle: true,
        backgroundColor: lightGrayBackground,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 40),
            // Payment Icon
            const Icon(
              Icons.account_balance_wallet,
              size: 64,
              color: tealAccentColor,
            ),
            const SizedBox(height: 30),
            // Amount input field
            TextField(
              controller: _amountController,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              inputFormatters: [
                
                FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,3}')),
              ],
              decoration: InputDecoration(
                labelText: 'Amount',
                labelStyle: const TextStyle(color: tealAccentColor),
                prefixIcon: const Icon(Icons.attach_money, color: tealAccentColor),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: tealAccentColor),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: tealAccentColor, width: 2),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 16,
                ),
                fillColor: Colors.white,
                filled: true,
              ),
            ),
            const SizedBox(height: 20),
            // Pay button
            SizedBox(
              height: 50,
              child: ElevatedButton(
                onPressed: _isProcessing ? null : _processPayment,
                style: ElevatedButton.styleFrom(
                  backgroundColor: tealAccentColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  disabledBackgroundColor: tealAccentColor.withOpacity(0.6),
                ),
                child: _isProcessing
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text(
                        'Pay Now',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
              ),
            ),
            const SizedBox(height: 30),
            // Payment status
            if (_paymentStatus != null)
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: _isSuccess 
                    ? tealAccentColor.withOpacity(0.2) // Very light teal for success
                    : redWarning.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: _isSuccess ? tealAccentColor : redWarning,
                    width: 1,
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      _isSuccess ? Icons.check_circle : Icons.error,
                      color: _isSuccess ? tealAccentColor : redWarning,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        _paymentStatus!,
                        style: TextStyle(
                          color: _isSuccess ? tealAccentColor : redWarning,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}