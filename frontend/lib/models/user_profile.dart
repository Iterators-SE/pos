class UserProfile {
  int id;
  String name;
  String email;
  String receiptMessage;
  String address;

  UserProfile(
      {this.id, this.name, this.email, this.receiptMessage, this.address});

  factory UserProfile.fromJson(Map<String, dynamic> userProfileJson) {
    return UserProfile(
      id: int.parse(userProfileJson['id']),
      email: userProfileJson['email'],
      name: userProfileJson['name'],
      address: userProfileJson['address'],
      receiptMessage: userProfileJson['receiptMessage']
    );
  }
}
