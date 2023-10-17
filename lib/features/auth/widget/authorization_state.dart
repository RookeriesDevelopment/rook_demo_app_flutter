sealed class InitializationState {}

class InitializationNone extends InitializationState {}

class InitializationLoading extends InitializationState {}

class InitializationSuccess extends InitializationState {
  final DateTime? expirationDate;

  InitializationSuccess(this.expirationDate);
}

class InitializationError extends InitializationState {
  final String message;

  InitializationError(this.message);
}
