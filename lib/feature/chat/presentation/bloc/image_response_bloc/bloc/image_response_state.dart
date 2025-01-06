part of 'image_response_bloc.dart';

sealed class ImageResponseState extends Equatable {
  const ImageResponseState();
  
  @override
  List<Object> get props => [];
}

final class ImageResponseInitial extends ImageResponseState {}
