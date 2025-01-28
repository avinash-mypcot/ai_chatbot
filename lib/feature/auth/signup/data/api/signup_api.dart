
import 'dart:developer';

import 'package:ai_chatbot/feature/auth/signup/data/model/signup_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SignUpApi {
  FirebaseAuth auth = FirebaseAuth.instance;
  final SupabaseClient _supabaseclient = Supabase.instance.client;

  Future<SignUpModel> signUpReq(Map<String, dynamic> body) async {
    try {
      // final credential = await auth.createUserWithEmailAndPassword(
      //     email: body["email"], password: body["password"]);
          final credential = await _supabaseclient.auth.signUp(
          email: body["email"], password: body["password"]);
          log("Respponse :$credential");
      return SignUpModel(message: "User created");
    } on FirebaseAuthException {
      rethrow;
    }
  }
}
