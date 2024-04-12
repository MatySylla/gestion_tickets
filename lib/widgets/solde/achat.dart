import 'dart:math';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PageAchatTickets extends StatefulWidget {
  const PageAchatTickets({Key? key}) : super(key: key);

  @override
  _PageAchatTicketsState createState() => _PageAchatTicketsState();
}

class _PageAchatTicketsState extends State<PageAchatTickets> {
  int _nombreTicketsRepas = 0;
  int _nombreTicketsPetitDej = 0;
  final double _prixTicketRepas = 100.0;
  final double _prixTicketPetitDej = 50.0;
  double _prixTotal = 0.0;

  final TextEditingController _controllerRepas = TextEditingController();
  final TextEditingController _controllerPetitDej = TextEditingController();

  final List<String> _paymentOptionsImages = [
    'assets/wave.jpeg',
    'assets/om.jpeg',
    'assets/fm.png',
    'assets/ecobank.jpg',
    'assets/sesapay.jpg',
  ];

  String _selectedPaymentOption = '';

  @override
  void initState() {
    super.initState();
    _controllerRepas.text = _nombreTicketsRepas.toString();
    _controllerPetitDej.text = _nombreTicketsPetitDej.toString();
  }

  void _mettreAJourPrixTotal() {
    setState(() {
      _nombreTicketsRepas = int.parse(_controllerRepas.text);
      _nombreTicketsPetitDej = int.parse(_controllerPetitDej.text);
      _prixTotal = (_nombreTicketsRepas * _prixTicketRepas) +
          (_nombreTicketsPetitDej * _prixTicketPetitDej);
    });
  }

  void _effectuerPaiement() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Paiement effectué'),
          content: Text('Votre paiement de $_prixTotal F CFA a été effectué avec succès.'),
          actions: [
            TextButton(
              onPressed: () {
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
    String userId = FirebaseAuth.instance.currentUser!.uid;

    FirebaseFirestore.instance.collection('tickets').add({
      'user_id': userId,
      'nombreTicketsRepas': _nombreTicketsRepas,
      'nombreTicketsPetitDej': _nombreTicketsPetitDej,
      'prix_total': _prixTotal,
      'timestamp': Timestamp.now(),
    }).then((value) {
      
    }).catchError((error) {
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
        title: const Text('Achat Tickets'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.asset(
                'assets/payer.jpeg',
                height: 100,
                width: 100,
                fit: BoxFit.contain,
              ),
              const SizedBox(height: 20.0),
              TextField(
                controller: _controllerRepas,
                keyboardType: TextInputType.number,
                style: const TextStyle(fontSize: 15),
                decoration: const InputDecoration(
                  labelText: 'Tickets repas',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(50),
                    ),
                  ),
                ),
                onChanged: (_) => _mettreAJourPrixTotal(),
              ),
              const SizedBox(height: 20.0),
              TextField(
                controller: _controllerPetitDej,
                keyboardType: TextInputType.number,
                style: const TextStyle(fontSize: 15),
                decoration: const InputDecoration(
                  labelText: 'Tickets petit dèj',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(50),
                    ),
                  ),
                ),
                onChanged: (_) => _mettreAJourPrixTotal(),
              ),
              const SizedBox(height: 20.0),
              Text(
                'Prix total: $_prixTotal F CFA',
                style: const TextStyle(fontSize: 20.0),
              ),
              const SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Choisir un mode de paiement'),
                        content: SingleChildScrollView(
                          child: Column(
                            children: List.generate((_paymentOptionsImages.length / 2).ceil(), (index) {
                              return Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  for (int i = index * 2; i < min(index * 2 + 2, _paymentOptionsImages.length); i++)
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          _selectedPaymentOption = 'Mode de paiement ${i + 1}';
                                        });
                                        Navigator.of(context).pop();
                                        _effectuerPaiement();
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: SizedBox(
                                          width: 50.0,
                                          height: 50.0,
                                          child: Image.asset(
                                            _paymentOptionsImages[i],
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                                ],
                              );
                            }),
                          ),
                      ),
                    );
                  },
                );
              },
              child: const Text('Acheter'),
            ),
            const SizedBox(height: 20.0),
            if (_selectedPaymentOption.isNotEmpty)
              Text('Mode de paiement sélectionné: $_selectedPaymentOption'),
          ],
        ),
      ),
      )
    );
  }
}
