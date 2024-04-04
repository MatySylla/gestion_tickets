import 'package:flutter/material.dart';

class PaymentView extends StatelessWidget {
  const PaymentView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          // Logique pour effectuer un paiement
        },
        child: const Text('Effectuer un paiement'),
      ),
    );
  }
}