import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:gestion_tickets/login/connexion.dart';

class HomePage extends StatelessWidget {
  final List<String> images = [
    'assets/s1.jpg',
    'assets/s2.jpg',
    'assets/s3.jpg',
    // Add more image paths as needed
  ];

  HomePage({super.key});

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bienvenue chez E-CROUS',
         style: TextStyle(fontWeight: FontWeight.bold), // Gras
         ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: CarouselSlider(
              options: CarouselOptions(
                height: MediaQuery.of(context).size.height, // Hauteur de l'écran
                enlargeCenterPage: true,
                autoPlay: false, // Désactiver la lecture automatique
                aspectRatio: 16 / 9,
                autoPlayCurve: Curves.fastOutSlowIn,
                enableInfiniteScroll: false,
                autoPlayAnimationDuration: const Duration(milliseconds: 800),
                viewportFraction: 1, // Afficher une seule image à la fois
                disableCenter: true, // Désactiver le centrage lorsque le dernier élément est atteint
                
              ),
              items: images.map((String imagePath) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: const BoxDecoration(
                        color: Colors.grey,
                      ),
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          Image.asset(
                            imagePath,
                            fit: BoxFit.fill, // Ajustement pour remplir l'écran sans zoom
                          ),
                          if (images.last == imagePath)
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 20.0),
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> Connexion()));
                                  },
                                  child: const Text('Commencer'),
                                ),
                              ),
                            ),
                        ],
                      ),
                    );
                  },
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}