import 'package:equatable/equatable.dart';

// Base class for SignUp Events
abstract class SignUpEvent extends Equatable {
  const SignUpEvent();

  @override
  List<Object?> get props => [];
}

// Event to handle user signup
class SignUpSubmittedEvent extends SignUpEvent {
  final String username;
  final String email;
  final String password;

  const SignUpSubmittedEvent({
    required this.username,
    required this.email,
    required this.password,
  });

  @override
  List<Object?> get props => [username, email, password];
}
