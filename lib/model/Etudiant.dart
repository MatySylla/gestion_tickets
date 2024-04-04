class Etudiant {
  final String id;
  final String email;
  final String nom;
  final String prenom;
  late final String? photoUrl;
  final String? photoCouvertureUrl;

  Etudiant({
    required this.id,
    required this.email,
    required this.nom,
    required this.prenom,
    this.photoUrl,
    this.photoCouvertureUrl,
  });

  factory Etudiant.fromJson(Map<String, dynamic> json) {
    return Etudiant(
      id: json['id'] ?? '',
      email: json['email'] ?? '',
      nom: json['nom'] ?? '',
      prenom: json['prenom'] ?? '',
      photoUrl: json['photoUrl'],
       photoCouvertureUrl: json['photoCouvertureUrl']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'nom': nom,
      'prenom': prenom,
      if (photoUrl != null) 'photoUrl': photoUrl,
      if (photoCouvertureUrl != null) 'photoCouvertureUrl': photoCouvertureUrl,
    };
  }
}
