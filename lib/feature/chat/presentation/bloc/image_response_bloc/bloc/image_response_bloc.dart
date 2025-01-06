import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'image_response_event.dart';
part 'image_response_state.dart';

class ImageResponseBloc extends Bloc<ImageResponseEvent, ImageResponseState> {
  ImageResponseBloc() : super(ImageResponseInitial()) {
    on<ImageResponseEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
