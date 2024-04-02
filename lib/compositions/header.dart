import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color.fromARGB(0, 223, 221, 221),
      elevation: 0,
      title: const Text('Gestion des tickets'),
      leading: IconButton(
        onPressed: (){

        },
        icon: const Icon(Icons.menu),
      ),
      // Ajoutez d'autres éléments d'en-tête selon vos besoins
    );
  }
}
