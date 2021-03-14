class User {
  final String token;

  User({this.token});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(token: json['login']);
  }

  Map<String, dynamic> toJson() {
    return {token: token};
  }
}
