import 'dart:developer';
import 'dart:io';

import 'package:ai_chatbot/feature/chat/data/model/upload_image_model.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repository/chat_repository.dart';

part 'upload_image_event.dart';
part 'upload_image_state.dart';

class UploadImageBloc extends Bloc<UploadImageEvent, UploadImageState> {
  HomeRepository repository;
  MultipartFile? file;
  UploadImageBloc({required this.repository}) : super(UploadImageInitial()) {
    on<UploadImageToGemini>(_onUploadImage);
  }
  _onUploadImage(
      UploadImageToGemini event, Emitter<UploadImageState> emit) async {
    if (event.image != null && event.image!.isNotEmpty) {
      final image = File(event.image!);

      if (await image.exists()) {
        file = await MultipartFile.fromFile(
          image.path,
          filename: image.path.split('/').last,
        );
      } else {
        print("File does not exist at path: ${image.path}");
      }
    }

    Map<String, dynamic> data = {};
    if (file != null) {
      data['image'] = file;
    }

    FormData formData = FormData.fromMap(data);
    log("FORMDATA: ${formData.files}");
    try {
      final data = await repository.uploadImageToGemini(
          "AIzaSyDaKc-H4hWesxWJt6ARDVz7rYcBn0ILUQw", formData);

      emit(UploadImageSuccess(model: data));
      log(data.file1!.uri!);
    } catch (e) {
      log("ERROR :$e");
      emit(UploadImageExceptionState(
          error: 'image upload failed: ${e.toString()}'));
    }
  }
}
