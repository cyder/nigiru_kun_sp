import 'package:scoped_model/scoped_model.dart';
import 'package:nigiru_kun/usecases/user_use_case.dart';

class HomeViewModel extends Model {
  UserUseCase useCase = new UserUseCase();

  String get userName => useCase.userName;
}
