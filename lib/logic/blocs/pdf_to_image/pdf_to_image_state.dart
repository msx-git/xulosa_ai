part of 'pdf_to_image_bloc.dart';

sealed class PdfToImageState {}

final class PdfToImageInitialState extends PdfToImageState {}

final class PdfToImageLoadingState extends PdfToImageState {
  final List<Uint8List> convertedImages;

  PdfToImageLoadingState({required this.convertedImages});
}

final class PdfToImageLoadedState extends PdfToImageState {
  final List<Uint8List> convertedImages;

  PdfToImageLoadedState({required this.convertedImages});
}

final class PdfToImageErrorState extends PdfToImageState {
  final String message;

  PdfToImageErrorState({required this.message});
}
