import 'package:nigiru_kun/repositorys/user_repository.dart';

class UserUseCase {
  UserRepository repository = new UserRepository();

  String get userName => '${repository.lastName} ${repository.firstName}';
}