// ignore_for_file: camel_case_types, library_private_types_in_public_api

import 'package:flutter/material.dart';



class historiqueTransaction extends StatefulWidget {
  const historiqueTransaction({Key? key}) : super(key: key);

  @override
  _historiqueTransactionState createState() => _historiqueTransactionState();
}

class _historiqueTransactionState extends State<historiqueTransaction> {
  
  String _selectedPaymentMethod = '';

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Choisissez le mode de paiement :',
            style: TextStyle(fontSize: 18),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () {
                  setState(() {
                    _selectedPaymentMethod = 'Visa'; // Modifier selon votre logique
                  });
                },
                icon: const Icon(Icons.credit_card), // Icône pour Visa
                color: _selectedPaymentMethod == 'Visa' ? Colors.blue : Colors.grey,
              ),
              IconButton(
                onPressed: () {
                  setState(() {
                    _selectedPaymentMethod = 'PayPal'; // Modifier selon votre logique
                  });
                },
                icon: const Icon(Icons.payment), // Icône pour PayPal
                color: _selectedPaymentMethod == 'PayPal' ? Colors.blue : Colors.grey,
              ),
              // Ajoutez d'autres icônes pour les modes de paiement supplémentaires selon vos besoins
            ],
          ),
          ElevatedButton(
            onPressed: () {
              if (_selectedPaymentMethod.isNotEmpty) {
               
              } else {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text('Veuillez sélectionner un mode de paiement.'),
                ));
              }
            },
            child: const Text('Effectuer le paiement'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
   
    super.dispose();
  }
}
