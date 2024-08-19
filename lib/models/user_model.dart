class UserModel {
  String id;
  String name;
  String email;
  UserModel({
    required this.email,
    required this.name,
   required this.id ,
  });
  UserModel.formJson(Map<String, dynamic> json)
      : this(
          name: json['name'],
          email: json['email'],
          id: json['id'],
        );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'email': email,
      };
}
