class User {
  int? id;
  String? name;
  String? email;
  String? password;
  String? token;

  User({this.id, this.email, this.name, this.password, this.token});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['user']['id'],
      name: json['user']['name'],
      email: json['user']['email'],
      password: json['user']['password'],
      token: json['user']['token'],
    );
  }
}
