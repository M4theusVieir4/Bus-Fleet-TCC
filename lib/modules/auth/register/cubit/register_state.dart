sealed class RegisterState {
  RegisterState();
}

class RegisterIniticialState extends RegisterState {
  RegisterIniticialState() : super();
}

class RegisterInitializedState extends RegisterState {
  RegisterInitializedState();
}

class RegisterLoadingState extends RegisterState {
  RegisterLoadingState() : super();
}

class RegisterSucccessState extends RegisterState {
  RegisterSucccessState();
}

class RegisterErrorState extends RegisterState {
  final String? message;
  RegisterErrorState(this.message) : super();
}
