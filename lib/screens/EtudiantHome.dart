import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gestion_tickets/compositions/header.dart';
import 'package:image_picker/image_picker.dart';
import 'package:gestion_tickets/provider/EtudiantModel.dart';
import 'package:provider/provider.dart';
import 'package:firebase_storage/firebase_storage.dart';


class EtudiantHomePage extends StatefulWidget {
  const EtudiantHomePage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _EtudiantHomePageState createState() => _EtudiantHomePageState();
}

class _EtudiantHomePageState extends State<EtudiantHomePage> {
  NetworkImage? _image;
   NetworkImage? _coverPhoto;

  Future<void> _getImage() async {
  final picker = ImagePicker();
  final pickedImage = await picker.pickImage(source: ImageSource.gallery);

  if (pickedImage != null) {
    try {
      // Référence au bucket Firebase Storage où les images seront stockées
      final storageReference = FirebaseStorage.instance.ref().child('path/to/file');

      // Téléversement de l'image sur Firebase Storage
      final uploadTask = storageReference.putFile(File(pickedImage.path));

      // Récupération de l'URL téléchargeable de l'image
      final imageUrl = await (await uploadTask).ref.getDownloadURL();

      setState(() {
        _image = NetworkImage(imageUrl);
      });

      // Enregistrement de l'URL de l'image dans les informations de l'étudiant
      final etudiantModel = Provider.of<EtudiantModel>(context, listen: false);
      final etudiant = etudiantModel.etudiant;
      if (etudiant != null) {
        await FirebaseFirestore.instance
            .collection('etudiant')
            .doc(etudiant.id)
            .update({'photoProfilUrl': imageUrl});

        // Actualisation des informations de l'étudiant dans le modèle
        etudiantModel.fetchEtudiantDataFromFirestore(etudiant.id);
      }
    } catch (error) {
      print('Erreur lors du téléversement de l\'image : $error');
    }
  }
}

Future<void> _pickCoverPhoto() async {
  final picker = ImagePicker();
  final pickedImage = await picker.pickImage(source: ImageSource.gallery);

  if (pickedImage != null) {
    try {
      // Référence au bucket Firebase Storage où les images seront stockées
      final storageReference = FirebaseStorage.instance.ref().child('images');

      // Téléversement de l'image sur Firebase Storage
      final uploadTask = storageReference.putFile(File(pickedImage.path));

      // Récupération de l'URL téléchargeable de l'image
      final imageUrl = await (await uploadTask).ref.getDownloadURL();

      setState(() {
        _coverPhoto = NetworkImage(imageUrl);
      });

      // Enregistrement de l'URL de l'image dans les informations de l'étudiant
      final etudiantModel = Provider.of<EtudiantModel>(context, listen: false);
      final etudiant = etudiantModel.etudiant;
      if (etudiant != null) {
        await FirebaseFirestore.instance
            .collection('etudiant')
            .doc(etudiant.id)
            .update({'photoCouvertureUrl': imageUrl});

        // Actualisation des informations de l'étudiant dans le modèle
        etudiantModel.fetchEtudiantDataFromFirestore(etudiant.id);
      }
    } catch (error) {
      print('Erreur lors du téléversement de l\'image : $error');
    }
  }
}


  @override
  Widget build(BuildContext context) {
    final etudiant = Provider.of<EtudiantModel>(context).etudiant;

    return Scaffold(
      appBar: const MyAppBar(),
      body: Stack(
        children: [
          // Photo de couverture
          _coverPhoto != null
              ? Image.network(
                  _coverPhoto!.url,
                  width: double.infinity,
                  height: 200, // Hauteur de la photo de couverture
                  fit: BoxFit.cover,
                )
              : Container(
                  width: double.infinity,
                  height: 200, // Hauteur de la photo de couverture
                  color: Colors.grey[300], // Couleur de fond par défaut
                  child: Center(
                    child: IconButton(
                      icon: const Icon(Icons.add_a_photo),
                      onPressed: _pickCoverPhoto,
                      tooltip: 'Choisir une photo de couverture',
                    ),
                  ),
                ),
        Padding(
            padding: const EdgeInsets.all(16.0),
            
                  child: Center( 
                    child: SizedBox(
                      height: 300,
                      
                        child: Column(
                          
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CircleAvatar(
                                backgroundColor: Colors.grey[300], 
                                radius: 80, 
                               child: _image != null
                                  ? Image.network(
                                      _image!.url,
                                      width: double.infinity,
                                      height: 200, // Hauteur de la photo de couverture
                                      fit: BoxFit.cover,
                                    ): 
                                    IconButton( 
                                  icon: const Icon(Icons.add_a_photo),
                                  onPressed: () {
                                    showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text('Modifier le profil'),
                                      content: const Text('Choisissez ou prenez une photo pour votre profil.'),
                                      actions: <Widget>[
                                        IconButton(onPressed: _getImage, icon: const Icon(Icons.photo_library),tooltip: 'Choisir depuis la galerie',
                                ),
                                        IconButton(onPressed: _getImage, icon: const Icon(Icons.photo_camera),tooltip: 'Prendre une photo',
                                ),
                                      ],
                                    );
                                  
                                  },
                                    );
                                  
                                  },

                                  tooltip: 'Choisir une photo de profil',
                                )  ,
                            ),
                            
                            const SizedBox(height: 16),
                            if (etudiant != null)
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(' ${etudiant.prenom}   ${etudiant.nom}'),
                                
                                  // Ajoutez d'autres informations de l'étudiant ici si nécessaire
                                ],
                              ),
                            if (etudiant == null)
                              const Text('Aucune information sur l\'étudiant'),
                            
                          ],
                        ),
                      ),
                      ),
                ),
        ],
          )
    );
        }
      }