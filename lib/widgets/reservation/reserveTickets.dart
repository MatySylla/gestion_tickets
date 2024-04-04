import 'package:flutter/material.dart';

class ReservationView extends StatelessWidget {
  const ReservationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          // Logique pour réserver un repas
        },
        child: const Text('Réserver un repas'),
      ),
    );
  }
}