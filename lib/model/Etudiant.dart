class Etudiant {
  final String id;
  final String email;
  final String nom;
  final String prenom;

  Etudiant({
    required this.id,
    required this.email,
    required this.nom,
    required this.prenom,
  });

  factory Etudiant.fromJson(Map<String, dynamic> json) {
    return Etudiant(
      id: json['id'] ?? '',
      email: json['email'] ?? '',
      nom: json['nom'] ?? '',
      prenom: json['prenom'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'nom': nom,
      'prenom': prenom,
    };
  }
}
