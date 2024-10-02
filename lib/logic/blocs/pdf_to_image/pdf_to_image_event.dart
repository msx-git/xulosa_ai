part of 'pdf_to_image_bloc.dart';

sealed class PdfToImageEvent {}

final class ConvertPdfToImagesEvent extends PdfToImageEvent {
  final File file;

  ConvertPdfToImagesEvent({required this.file});
}
