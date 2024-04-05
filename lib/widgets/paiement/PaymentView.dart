import 'package:flutter/material.dart';
import 'package:gestion_tickets/widgets/paiement/paymentBloc.dart';


class PaymentView extends StatefulWidget {
  const PaymentView({Key? key}) : super(key: key);

  @override
  _PaymentViewState createState() => _PaymentViewState();
}

class _PaymentViewState extends State<PaymentView> {
  final PaymentBloc _paymentBloc = PaymentBloc();
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
                _paymentBloc.initiatePayment(_selectedPaymentMethod);
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
    _paymentBloc.dispose();
    super.dispose();
  }
}
