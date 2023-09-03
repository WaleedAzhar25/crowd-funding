class UserModel {
  String? uid;
  String? email;
  String? name;

  UserModel({
    required this.email,
    required this.uid,
    required this.name,

  });

  //Receiving data to server

  factory UserModel.fromMap(map) {
    return UserModel(
      email: map["email"],
      uid: map["uid"],
      name: map["name"],

    );
  }

  //Sending data to server

  Map<String, dynamic> toMap() {
    return {
      "uid": uid,
      "email": email,
      "name": name,

    };
  }
}

