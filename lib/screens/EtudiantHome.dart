import 'package:flutter/material.dart';
import 'package:gestion_tickets/main.dart';
import 'package:gestion_tickets/model/Etudiant.dart';
import 'package:image_picker/image_picker.dart';


class EtudiantHomePage extends StatelessWidget {
  final Etudiant etudiant;

  const EtudiantHomePage({Key? key, required this.etudiant}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Accueil'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

                      IconButton(
            icon: const Icon(Icons.camera_alt), // Utilisez une icône appropriée pour l'édition du profil
            onPressed: () {

              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Modifier le profil'),
                      content: const Text('Choisissez ou prenez une photo pour votre profil.'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () async {
                            // Ajoutez votre logique pour choisir une photo depuis la galerie

                            // Ouvrir la galerie pour choisir une photo
                            final XFile? image = await ImagePicker().pickImage(source: ImageSource.gallery);
                            if (image != null) {
                              // Vous pouvez maintenant utiliser l'image sélectionnée
                              // Par exemple, vous pouvez l'afficher dans votre interface utilisateur
                              // Ou l'enregistrer dans la base de données, l'envoyer à un serveur, etc.
                              print('Chemin de l\'image sélectionnée depuis la galerie : ${image.path}');
                            } else {
                              // L'utilisateur a annulé la sélection
                              print('Aucune image sélectionnée');
                            }
                          },
                          
                          child: const Text('Choisir depuis la galerie'),
                        ),
                        TextButton(
                          onPressed: () {
                            // Ajoutez votre logique pour prendre une nouvelle photo avec l'appareil photo
                          },
                          child: const Text('Prendre une photo'),
                        ),
                      ],
                    );
                  },
                );
                            
            },
            ),



            Text('Nom: ${etudiant.nom}'),
            Text('Prénom: ${etudiant.prenom}'),
            Text('Email: ${etudiant.email}'),
            // Ajoutez d'autres informations de l'étudiant ici si nécessaire
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Naviguer vers la page d'achat de tickets
                // Remplacer 'AchatTicketsPage' par le nom de votre page d'achat de tickets
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => const MyApp()));
              },
              child: const Text('Acheter des tickets'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                // Naviguer vers la page de l'historique des achats
                // Remplacer 'HistoriqueAchatsPage' par le nom de votre page d'historique des achats
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => const MyApp()));
              },
              child: const Text('Historique des achats'),
            ),
            // Ajoutez d'autres fonctionnalités ici
          ],
        ),
      ),
    );
  }
}
