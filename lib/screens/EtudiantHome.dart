import 'dart:io';
import 'package:flutter/material.dart';
import 'package:gestion_tickets/compositions/header.dart';
import 'package:image_picker/image_picker.dart';
import 'package:gestion_tickets/login/provider/EtudiantModel.dart';
import 'package:provider/provider.dart';

class EtudiantHomePage extends StatefulWidget {
  const EtudiantHomePage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _EtudiantHomePageState createState() => _EtudiantHomePageState();
}

class _EtudiantHomePageState extends State<EtudiantHomePage> {
  File? _image;

  Future<void> _getImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedImage != null) {
        _image = File(pickedImage.path);
      } else {
        print('Aucune image sélectionnée.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final etudiant = Provider.of<EtudiantModel>(context).etudiant;

    return Scaffold(
      appBar: const MyAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
                backgroundColor: Colors.grey[300], 
                radius: 80, 
                foregroundImage: _image != null ? FileImage(_image!) : null, // Image affichée à l'intérieur de l'avatar
                child: _image == null ? 
                IconButton( 
                  icon: const Icon(Icons.photo_library),
                  onPressed: _getImage,
                  tooltip: 'Choisir une photo de profil',
                ) : null,
            ),
            
            const SizedBox(height: 16),
            if (etudiant != null)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Prénom: ${etudiant.prenom}'),
                  Text('Nom: ${etudiant.nom}'),
                  Text('Email: ${etudiant.email}'),
                  // Ajoutez d'autres informations de l'étudiant ici si nécessaire
                ],
              ),
            if (etudiant == null)
              const Text('Aucune information sur l\'étudiant'),
            
          ],
        ),
      ),
    );
  }
}
