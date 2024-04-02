import 'dart:io';
import 'package:flutter/material.dart';
import 'package:gestion_tickets/compositions/header.dart';
import 'package:image_picker/image_picker.dart';
import 'package:gestion_tickets/provider/EtudiantModel.dart';
import 'package:provider/provider.dart';

class EtudiantHomePage extends StatefulWidget {
  const EtudiantHomePage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _EtudiantHomePageState createState() => _EtudiantHomePageState();
}

class _EtudiantHomePageState extends State<EtudiantHomePage> {
  File? _image;
   NetworkImage? _coverPhoto;

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
   Future<void> _pickCoverPhoto() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        _coverPhoto = NetworkImage(pickedImage.path);
      });
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
                    child: Container(
                      height: 300,
                      
                        child: Column(
                          
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CircleAvatar(
                                backgroundColor: Colors.grey[300], 
                                radius: 80, 
                                foregroundImage: _image != null ? FileImage(_image!) : null, // Image affichée à l'intérieur de l'avatar
                                child: _image == null ? 
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
                                ) : null,
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
