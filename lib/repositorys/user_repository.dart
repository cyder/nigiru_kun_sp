import 'package:nigiru_kun/entities/user_data.dart';

abstract class UserRepository {
  UserData get currentUser;
}

class UserRepositoryImpl implements UserRepository{
  UserData _user = new UserData('Atsushi', 'Mori');
  UserData get currentUser => _user;
}
