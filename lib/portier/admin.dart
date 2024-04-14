import 'package:flutter/material.dart';
import 'package:gestion_tickets/provider/EtudiantModel.dart';
import 'package:provider/provider.dart';

class PageDebitTickets extends StatefulWidget {
  const PageDebitTickets({super.key});

  @override
  _PageDebitTicketsState createState() => _PageDebitTicketsState();
}

class _PageDebitTicketsState extends State<PageDebitTickets> {
  int _nombreTicketsRepas = 0;
  int _nombreTicketsPetitDej = 0;
  String _idEtudiant = ''; // L'ID de l'étudiant dont les tickets seront débités

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Débit de Tickets'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              decoration: InputDecoration(labelText: 'ID de l\'étudiant'),
              onChanged: (value) {
                _idEtudiant = value;
              },
            ),
            SizedBox(height: 20.0),
            TextField(
              decoration: InputDecoration(labelText: 'Nombre de Tickets Repas'),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  _nombreTicketsRepas = int.tryParse(value) ?? 0;
                });
              },
            ),
            SizedBox(height: 20.0),
            TextField(
              decoration: InputDecoration(labelText: 'Nombre de Tickets Petit Déj'),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  _nombreTicketsPetitDej = int.tryParse(value) ?? 0;
                });
              },
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                // Appeler la méthode pour débiter les tickets depuis le modèle EtudiantModel
                Provider.of<EtudiantModel>(context, listen: false).debiterTickets(
                  idEtudiant: _idEtudiant,
                  nombreTicketsRepas: _nombreTicketsRepas,
                  nombreTicketsPetitDej: _nombreTicketsPetitDej,
                );
              },
              child: Text('Débiter les Tickets'),
            ),
          ],
        ),
      ),
    );
  }
}
