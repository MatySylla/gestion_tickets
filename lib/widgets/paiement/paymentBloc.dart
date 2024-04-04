import 'dart:async';
import 'dart:math';

class PaymentBloc {
  final _paymentController = StreamController<bool>();

  Stream<bool> get paymentStream => _paymentController.stream;

  void initiatePayment() async {
    // Simule une attente de 2 secondes avant de terminer le paiement
    await Future.delayed(Duration(seconds: 2));

    // Simule un paiement réussi dans 80% des cas, échoué dans les 20% restants
    final bool paymentSuccessful = Random().nextInt(10) < 8; // 80% de chance de réussite

    // Envoie le résultat du paiement via le stream
    _paymentController.sink.add(paymentSuccessful);
  }

  void dispose() {
    _paymentController.close();
  }
}
