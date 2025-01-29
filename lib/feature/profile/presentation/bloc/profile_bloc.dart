import 'dart:developer';

import 'package:ai_chatbot/feature/profile/data/model/profile_model.dart';
import 'package:ai_chatbot/feature/profile/data/repository/profile_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileRepository _repository;
  ProfileBloc(this._repository) : super(ProfileInitial()) {
    on<ProfileGetEvent>(_onGetProfile);
    on<ProfileUpdateEvent>(_onUpdateProfile);
  }
  _onGetProfile(event, emit) async {
    emit(ProfileLoadingState());
    try {
      final response = await _repository.getProfileData();

      emit(ProfileLoadedState(model: response));
    } catch (e) {
      log("Exception : $e");
      emit(ProfileFailedState());
    }
  }

  _onUpdateProfile(ProfileUpdateEvent event, Emitter<ProfileState> emit) async {
    final currentState = state;
    if (currentState is ProfileLoadedState) {
      emit(ProfileLoadedState(model: currentState.model, isUpdate: true));
    }
    Map<String, dynamic> body = {
      'name': event.username,
      'email': event.email,
      'mobile': event.mobile
    };
    try {
      final response = await _repository.updateProfileData(body);
      emit(ProfileLoadedState(model: response));
    } catch (e) {
      emit(ProfileFailedState());
    }
  }
}
