
abstract class  SocialRegisterStates{}

class SocialRegisterInitialState extends SocialRegisterStates{}

class SocialRegisterLoadingState extends SocialRegisterStates{}

class SocialRegisterSuccessState extends SocialRegisterStates {}

class SocialRegisterErrorState extends SocialRegisterStates
{
  final String error ;
  SocialRegisterErrorState(this.error);
}

class CreateUserLoadingState extends SocialRegisterStates{}

class CreateUserSuccessState extends SocialRegisterStates {}

class CreateUserErrorState extends SocialRegisterStates
{
  final String error ;
  CreateUserErrorState(this.error);
}
class SocialRegisterChangePasswordVisibilityState extends SocialRegisterStates{}
