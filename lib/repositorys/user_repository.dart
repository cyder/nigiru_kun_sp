import 'package:nigiru_kun/entities/user_data.dart';

class UserRepository {
  UserData _user = new UserData('Atsushi', 'Mori');
  UserData get currentUser => _user;
}