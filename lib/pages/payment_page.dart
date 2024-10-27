import 'package:flutter/material.dart';
import 'package:fooddeliveryapp/components/my_button.dart';
import 'package:fooddeliveryapp/pages/delivery_progress_page.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';

  void userTappedPay() {
    if (_formKey.currentState!.validate()) {
      // Show a confirmation dialog if the form is valid
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Confirm payment"),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                Text("Card Number: $cardNumber"),
                Text("Expiry Date: $expiryDate"),
                Text("Card Holder Name: $cardHolderName"),
                Text("CVV: $cvvCode"),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const DeliveryProgressPage(),
                ),
              ),
              child: const Text("Yes"),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Checkout"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Card Number Field
              TextFormField(
                decoration: const InputDecoration(
                  labelText: "Card Number",
                  hintText: "1234 5678 9012 3456",
                ),
                keyboardType: TextInputType.number,
                maxLength: 19,
                onChanged: (value) {
                  setState(() {
                    cardNumber = value;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter a card number";
                  } else if (value.length < 16) {
                    return "Card number must be at least 16 digits";
                  }
                  return null;
                },
              ),
              
              // Expiry Date Field
              TextFormField(
                decoration: const InputDecoration(
                  labelText: "Expiry Date",
                  hintText: "MM/YY",
                ),
                keyboardType: TextInputType.datetime,
                onChanged: (value) {
                  setState(() {
                    expiryDate = value;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter expiry date";
                  }
                  // Additional validation for format MM/YY can be added
                  return null;
                },
              ),
              
              // Card Holder Name Field
              TextFormField(
                decoration: const InputDecoration(
                  labelText: "Card Holder Name",
                ),
                onChanged: (value) {
                  setState(() {
                    cardHolderName = value;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter the cardholder's name";
                  }
                  return null;
                },
              ),
              
              // CVV Field
              TextFormField(
                decoration: const InputDecoration(
                  labelText: "CVV",
                  hintText: "123",
                ),
                keyboardType: TextInputType.number,
                maxLength: 3,
                obscureText: true,
                onChanged: (value) {
                  setState(() {
                    cvvCode = value;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter the CVV";
                  } else if (value.length < 3) {
                    return "CVV must be 3 digits";
                  }
                  return null;
                },
              ),
              
              const Spacer(),
              
              // Pay Now Button
              MyButton(
                onTap: userTappedPay,
                text: "Pay Now",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
