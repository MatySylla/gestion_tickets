import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({Key? key}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color.fromARGB(0, 223, 221, 221),
      elevation: 0,
      title: const Text('Gestion des tickets'),
      leading: IconButton(
        onPressed: () {
          // Action lorsque l'utilisateur appuie sur l'icône de menu
        },
        icon: const Icon(Icons.menu),
      ),
      actions: [
        IconButton(
          onPressed: () {
            // Action lorsque l'utilisateur appuie sur l'icône de notification
          },
          icon: const Icon(Icons.notifications),
        ),
        IconButton(
          onPressed: () {
            // Action lorsque l'utilisateur appuie sur l'icône de recherche
          },
          icon: const Icon(Icons.search),
        ),
      ],
      // Ajoutez d'autres éléments d'en-tête selon vos besoins
    );
  }
}
