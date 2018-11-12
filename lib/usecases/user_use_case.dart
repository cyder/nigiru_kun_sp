import 'package:nigiru_kun/repositorys/user_repository.dart';

class UserUseCase {
  UserRepository repository = new UserRepositoryImpl();

  String get userName => '${repository.currentUser.lastName} ${repository.currentUser.firstName}';
}