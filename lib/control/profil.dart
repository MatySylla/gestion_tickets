import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class Transaction {
  final String title;
  final String date;
  final double amount;

  Transaction({required this.title, required this.date, required this.amount});
}

class MyApp extends StatelessWidget {
  final List<Transaction> transactions = [
    Transaction(title: 'Achat', date: '12/04/2024', amount: -50.0),
    Transaction(title: 'Dépôt', date: '10/04/2024', amount: 200.0),
    Transaction(title: 'Retrait', date: '08/04/2024', amount: -30.0),
    // Ajoutez davantage de transactions ici
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Historique des Transactions'),
        ),
        body: ListView.builder(
          itemCount: transactions.length,
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                leading: transactions[index].amount < 0
                    ? Icon(Icons.money_off, color: Colors.red)
                    : Icon(Icons.attach_money, color: Colors.green),
                title: Text(transactions[index].title),
                subtitle: Text(transactions[index].date),
                trailing: Text(
                  '${transactions[index].amount.toString()} €',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: transactions[index].amount < 0
                        ? Colors.red
                        : Colors.green,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}