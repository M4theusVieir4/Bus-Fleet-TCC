sealed class LoginState {
  LoginState();
}

class LoginIniticialState extends LoginState {
  LoginIniticialState() : super();
}

class LoginInitializedState extends LoginState {
  LoginInitializedState();
}

class LoginLoadingState extends LoginState {
  LoginLoadingState() : super();
}

class LoginSucccessState extends LoginState {
  LoginSucccessState();
}

class LoginErrorState extends LoginState {
  final String message;
  LoginErrorState(this.message) : super();
}
