import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pdfx/pdfx.dart';

part 'pdf_to_image_event.dart';
part 'pdf_to_image_state.dart';

class PdfToImageBloc extends Bloc<PdfToImageEvent, PdfToImageState> {
  PdfToImageBloc() : super(PdfToImageInitialState()) {
    on<ConvertPdfToImagesEvent>(_onConvert);
  }

  void _onConvert(ConvertPdfToImagesEvent event, emit) async {
    try {
      PdfDocument pdfDocument = await PdfDocument.openFile(event.file.path);
      List<Uint8List> images = [];

      for (int i = 1; i <= pdfDocument.pagesCount; i++) {
        PdfPage page = await pdfDocument.getPage(i);
        PdfPageImage? pageImage = await page.render(
          width: page.width,
          height: page.height,
          format: PdfPageImageFormat.jpeg,
          quality: 70,
        );
        if (pageImage != null) {
          images.add(pageImage.bytes);
          emit(PdfToImageLoadingState(convertedImages: images));
        }

        await page.close(); // Always close the page after rendering
      }

      emit(PdfToImageLoadedState(convertedImages: images));
    } catch (e) {
      emit(PdfToImageErrorState(message: "Error while converting: $e"));
    }
  }
}
