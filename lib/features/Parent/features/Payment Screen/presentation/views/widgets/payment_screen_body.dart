import 'package:edunourish/core/utils/constants.dart';
import 'package:edunourish/features/Parent/core/widgets/base_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Define the custom colors


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
          backgroundColor: ourMainColor,
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
    return  BaseScaffold(
      child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
             
              // Payment Icon
              const Text(
              'Payment',
              style: TextStyle(
                color: myBlackColor,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
              const Icon(
                Icons.account_balance_wallet,
                size: 64,
                color: ourMainColor,
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
                  labelStyle: const TextStyle(color: ourMainColor),
                  prefixIcon: const Icon(Icons.attach_money, color: ourMainColor),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: ourMainColor),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: ourMainColor, width: 2),
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
                    backgroundColor: ourMainColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    disabledBackgroundColor: ourMainColor.withOpacity(0.6),
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
                      ? ourMainColor.withOpacity(0.2) // Very light teal for success
                      : redWarning.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: _isSuccess ? ourMainColor : redWarning,
                      width: 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        _isSuccess ? Icons.check_circle : Icons.error,
                        color: _isSuccess ? ourMainColor : redWarning,
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          _paymentStatus!,
                          style: TextStyle(
                            color: _isSuccess ? ourMainColor : redWarning,
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