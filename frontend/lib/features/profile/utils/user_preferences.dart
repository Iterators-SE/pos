import '../models/user.dart';

class UserPreferences {
  static const myUser = User(
      imagePath:
          'https://tse1.mm.bing.net/th?id=OIP.gXHav2DDnIAm2WfMlBtSfQHaEo&pid=Api&P=0&w=262&h=165',
      name: 'Zerthea Nicole Tuares',
      email: 'z@gmail.com',
      address: 'Brgy. Tiring, Cabatuan, Iloilo, Philippines',
      message: 'hi, welcome');

  // ignore: type_annotate_public_apis
  static getInstance() {}
}
