import 'package:flutter/material.dart';

class MenuView extends StatelessWidget {
  const MenuView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const <Widget>[
        ListTile(
          title: Text('Menu du jour 1'),
          subtitle: Text('Description du menu'),
          trailing: Text('Prix : \$5'),
        ),
        ListTile(
          title: Text('Menu du jour 2'),
          subtitle: Text('Description du menu'),
          trailing: Text('Prix : \$6'),
        ),
        // Ajoutez plus d'éléments de menu ici...
      ],
    );
  }
}