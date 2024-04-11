import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PageAchatTickets extends StatefulWidget {
  const PageAchatTickets({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _PageAchatTicketsState createState() => _PageAchatTicketsState();
}

class _PageAchatTicketsState extends State<PageAchatTickets> {
  int _nombreTicketsRepas = 0;
  int _nombreTicketsPetitDej = 0;
  final double _prixTicketRepas = 100.0; // Prix unitaire du ticket repas
  final double _prixTicketPetitDej = 50.0; // Prix unitaire du ticket petit déjeuner
  double _prixTotal = 0.0; // Prix total initial

  final TextEditingController _controllerRepas = TextEditingController();
  final TextEditingController _controllerPetitDej = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controllerRepas.text = _nombreTicketsRepas.toString();
    _controllerPetitDej.text = _nombreTicketsPetitDej.toString();
  }

  // Méthode pour mettre à jour le prix total en fonction du nombre de tickets sélectionnés
  void _mettreAJourPrixTotal() {
    setState(() {
      _nombreTicketsRepas = int.parse(_controllerRepas.text);
      _nombreTicketsPetitDej = int.parse(_controllerPetitDej.text);
      _prixTotal = (_nombreTicketsRepas * _prixTicketRepas) +
          (_nombreTicketsPetitDej * _prixTicketPetitDej);
    });
  }

  // Méthode pour effectuer le paiement fictif
  void _effectuerPaiement() {
    // Ici, vous pouvez intégrer la logique de paiement réelle
    // Pour l'exemple, je vais simplement afficher un message de confirmation
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Paiement effectué'),
          content: Text(
              'Votre paiement de $_prixTotal fcf a été effectué avec succès.'),
          actions: [
            TextButton(
              onPressed: () {
                
                // Une fois le paiement effectué, enregistrer les tickets dans Firestore
                _enregistrerTicketsFirestore();
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _enregistrerTicketsFirestore() {
  String userId = FirebaseAuth.instance.currentUser!.uid; // Récupérer l'ID de l'utilisateur connecté

  FirebaseFirestore.instance.collection('tickets').add({
    'user_id': userId, // Ajouter l'ID de l'utilisateur connecté
    'nombreTicketsRepas': _nombreTicketsRepas,
    'nombreTicketsPetitDej': _nombreTicketsPetitDej,
    'prix_total': _prixTotal,
    'timestamp': Timestamp.now(), // Ajouter un timestamp pour enregistrer l'heure de l'achat
  }).then((value) {
    // Afficher un message pour indiquer que les tickets ont été enregistrés avec succès
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Achat réussi'),
          content: const Text('Vos tickets ont été enregistrés avec succès.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }).catchError((error) {
    // En cas d'erreur lors de l'enregistrement, afficher un message d'erreur
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Erreur'),
          content: Text('Une erreur s\'est produite lors de l\'enregistrement des tickets : $error'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  });
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Acheter des Tickets'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _controllerRepas,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Tickets Repas',
              ),
              onChanged: (_) => _mettreAJourPrixTotal(),
            ),
            const SizedBox(height: 20.0),
            TextField(
              controller: _controllerPetitDej,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Tickets Petit Déj',
              ),
              onChanged: (_) => _mettreAJourPrixTotal(),
            ),
            const SizedBox(height: 20.0),
            Text(
              'Prix total: $_prixTotal fcf',
              style: const TextStyle(fontSize: 20.0),
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                // Intégrer ici le processus de paiement
                _effectuerPaiement();
              },
              child: const Text('Payer et acheter maintenant'),
            ),
          ],
        ),
      ),
    );
  }
}
