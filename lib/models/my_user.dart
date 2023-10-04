class MyUser {
  static const String collectionName = 'users';

  String? id;
  String? name;
  String? email;

  MyUser({required this.email, required this.id, required this.name});

  Map<String, dynamic> toFirestore() {
    return {'id': id, 'name': name, 'email': email};
  }

  MyUser.fromFirestore(Map<String, dynamic>? data)
      : this(
          email: data?['email'],
          id: data?['id'],
          name: data?['name'],
        );
}
