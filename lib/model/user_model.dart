class UserModel {
  String id;
  String email;
  String password;
  String name;

  UserModel({
    this.id = "",
    required this.email,
    required this.password,
    required this.name,
  });

  UserModel.fromJson(Map<String, dynamic> json)
      : this(
          id: json["id"],
          email: json["email"],
          password: json["password"],
          name: json["name"],
        );

  Map<String, dynamic> toJson() {
    return {"id": id, "email": email, "password": password, "name": name};
  }
}
