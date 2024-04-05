import 'dart:async';
import 'dart:math';

class PaymentBloc {
  final _paymentController = StreamController<void>();

  Stream<void> get paymentStream => _paymentController.stream;

  void initiatePayment(String selectedPaymentMethod) async {
  try {
    // Simule une attente de 2 secondes avant de terminer le paiement
    await Future.delayed(Duration(seconds: 2));

    // Simulation de la logique de paiement réussi (par exemple, en supposant que le paiement réussit dans 80% des cas)
    final bool paymentSuccessful = Random().nextInt(10) < 8; // 80% de chance de réussite

    if (paymentSuccessful) {
      // Le paiement a réussi, émettre un événement à travers le stream
      _paymentController.sink.add(true);
    } else {
      // Le paiement a échoué, émettre un événement à travers le stream avec false ou gérer l'erreur autrement
      _paymentController.sink.addError('Le paiement a échoué');
    }
  } catch (e) {
    // En cas d'erreur lors du traitement du paiement, émettre un événement d'erreur à travers le stream
    _paymentController.sink.addError('Une erreur est survenue lors du traitement du paiement : $e');
  }
}


  void dispose() {
    _paymentController.close();
  }
}
