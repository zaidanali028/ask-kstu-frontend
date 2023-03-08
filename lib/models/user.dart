import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  User({
    this.id,
    this.token,
    this.email,
    this.name,
    this.password,
    this.student_number,
    this.profileImage,
    this.birthDate,
    this.department,
    this.program,
    this.telephone,
  });

  int? id;
  String? token;
  String? email;
  String? name;
  String? password;
  String? student_number;
  String? profileImage;
  String? birthDate;
  String? department;
  String? program;
  String? telephone;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        token: json["token"],
        name: json["name"],
        email: json["email"],
        password: json["password"],
        student_number: json["student_number"],
        profileImage: json["profileImage"],
        birthDate: json["birth_date"],
        department: json["department"],
        program: json["program"],
        telephone: json["telephone"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "token": token,
        "email": email,
        "password": password,
        "student_number": student_number,
        "profileImage": profileImage,
        "birth_date": birthDate,
        "department": department,
        "program": program,
        "telephone": telephone,
      };
}
