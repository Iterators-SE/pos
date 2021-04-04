class User {
  final String token;

  User({this.token});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(token: json['action']);
  }

  Map<String, dynamic> toJson() {
    return {token: token};
  }
}
