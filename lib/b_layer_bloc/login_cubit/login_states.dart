
import 'package:social_app_firebase/models/creat_user.dart';

abstract class LoginStates{}

class LoginScreenInitial extends LoginStates{}

class LoginScreenLoading extends LoginStates{}

class LoginScreenSuccess extends LoginStates{
 final String uId;

  LoginScreenSuccess(this.uId);
}

class LoginScreenError extends LoginStates{
  final String error;


  LoginScreenError(this.error);
}

class LoginScreenPassword extends LoginStates{}