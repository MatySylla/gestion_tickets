import 'package:flutter/material.dart';

class BalanceView extends StatelessWidget {
  const BalanceView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Solde de tickets : 10',
        style: TextStyle(fontSize: 24.0),
      ),
    );
  }
}