

import '../../models/login_model.dart';

class LoginStates{}
class LoginInitialState extends LoginStates{}
class LoginLodingState extends LoginStates{}
class LoginSucssesState extends LoginStates{
  final LoginModel loginModel;

  LoginSucssesState(this.loginModel);


}
class LoginChangePaswordVisibilityState extends LoginStates{}
class LoginErrorState extends LoginStates{
  final String error;

  LoginErrorState(this.error);
}