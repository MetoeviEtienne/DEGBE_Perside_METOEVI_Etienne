class Candidate {
  final int id;
  final String name;
  final String surname;
  final String bio;
  final String imagePath;
  final String birthdate;

  Candidate({
    required this.id,
    required this.name,
    required this.surname,
    required this.bio,
    required this.imagePath,
    required this.birthdate,
  });

  factory Candidate.fromJson(Map<String, dynamic> json) {
    return Candidate(
      id: json['id'],
      name: json['name'],
      surname: json['surname'],
      bio: json['bio'],
      imagePath: json['image_url'], // Use imagePath instead of imageUrl
      birthdate: json['birthdate'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'surname': surname,
      'bio': bio,
      'image_url': imagePath, // Use imagePath instead of imageUrl
      'birthdate': birthdate,
    };
  }
}
