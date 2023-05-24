// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  String? name;
  String? token;
  String? email;
  String? gender;
  String? image;
  String? currentLevel;
  String? currentSemester;
  int? facultyId;
  int? status;
  int? indexNo;
  int? deptId;
  int? programId;
  String? yrOfAdmission;
  String? yrOfCompletion;
  int? id;

  User(
      {this.name,
      this.email,
      this.gender,
      this.facultyId,
      this.indexNo,
      this.deptId,
      this.programId,
      this.status,
      this.yrOfAdmission,
      this.yrOfCompletion,
      this.id,
      this.token,
      this.image,
      this.currentLevel,
      this.currentSemester});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['user']['name'],
      email: json['user']['email'],
      currentLevel: json['user']['current_level'],
      currentSemester: json['user']['current_sem'],
      image: json['user']['user_img'] ?? '1',
      gender: json['user']['gender'],
      facultyId: json['user']['faculty_id'],
      indexNo: json['user']['index_no'],
      deptId: json['user']['dept_id'],
      programId: json['user']['program_id'],
      status: json['user']['status'],
      yrOfAdmission: json['user']['yr_of_admission'],
      yrOfCompletion: json['user']['yr_of_completion'],
      id: json['user']['id'],
      token: json['authorisation']['token'],
    );
  }

  Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "user_img": image,
        "gender": gender,
        "faculty_id": facultyId,
        "index_no": indexNo,
        "dept_id": deptId,
        "program_id": programId,
        "status": status,
        "yr_of_admission": yrOfAdmission,
        "yr_of_completion": yrOfCompletion,
        "id": id,
        "token": token,
      };
}
