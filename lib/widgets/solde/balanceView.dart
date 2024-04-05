import 'dart:js';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gestion_tickets/model/tickets.dart';
import 'package:provider/provider.dart';

// Modèle de ticket

class BalanceView extends StatelessWidget {
  const BalanceView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nombre de tickets'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Table(
              border: TableBorder.all(),
              children: [
                const TableRow(
                  children: [
                    TableCell(child: Center(child: Text('Type'))),
                    TableCell(child: Center(child: Text('Nombre'))),
                  ],
                ),
                TableRow(
                  children: [
                    const TableCell(child: Center(child: Text('Repas'))),
                    TableCell(
                      child: Center(
                        child: FutureBuilder<int>(
                          future: countTicketsByType(TypeTicket.repas),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return const CircularProgressIndicator();
                            } else {
                              return Text(snapshot.data.toString());
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    const TableCell(child: Center(child: Text('Petit déjeuner'))),
                    TableCell(
                      child: Center(
                        child: FutureBuilder<int>(
                          future: countTicketsByType(TypeTicket.petitDejeuner),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return const CircularProgressIndicator();
                            } else {
                              return Text(snapshot.data.toString());
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<int> countTicketsByType(TypeTicket type) async {
    String userId = Provider.of<User>(context as BuildContext, listen: false).uid;

    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('tickets')
        .where('userId', isEqualTo: userId)
        .where('type', isEqualTo: type.index)
        .get();

    return querySnapshot.docs.length;
  }
}
