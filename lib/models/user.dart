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
    String? facultyId;
    int? status;
    int? indexNo;
    String? deptId;
    String? programId;
    String? yrOfAdmission;
    String? yrOfCompletion;
    int? id;

    User({
        this.name,
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
        this.currentSemester
    });

    factory User.fromJson(Map<String, dynamic> json){
      return User(
        name: json['user']['name'],
        email: json['user']['email'],
        currentLevel: json['user']['current_level'],
        currentSemester: json['user']['current_sem'],
        image: json['user']['user_img'] ?? 'https://cdn-icons-png.flaticon.com/512/3135/3135715.png',
        gender: json['user']['gender'],
        facultyId: json['user']['faculty_name'],
        indexNo: json['user']['index_no'],
        deptId: json['user']['dept_name'],
        programId: json['user']['program_name'],
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
        "faculty": facultyId,
        "index_no": indexNo,
        "dept": deptId,
        "program": programId,
        "status": status,
        "yr_of_admission": yrOfAdmission,
        "yr_of_completion": yrOfCompletion,
        "id": id,
        "token": token,
    };
}
