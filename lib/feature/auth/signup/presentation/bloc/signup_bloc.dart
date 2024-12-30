import 'package:ai_chatbot/feature/auth/signup/presentation/bloc/signup_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'signup_event.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc() : super(SignUpInitialState());

  @override
  Stream<SignUpState> mapEventToState(SignUpEvent event) async* {
    yield SignUpLoadingState();
    try {
      // Simulate signup logic (e.g., Firebase)
      await Future.delayed(Duration(seconds: 2));
      yield SignUpSuccessState();
    } catch (e) {
      yield SignUpErrorState("Failed to sign up");
    }
  }
}
