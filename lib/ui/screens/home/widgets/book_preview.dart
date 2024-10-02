import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../logic/blocs/blocs.dart';

class BookPreview extends StatelessWidget {
  const BookPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: BlocConsumer<FilePickerBloc, FilePickerState>(
        listener: (context, state) {
          if (state is FilePickerLoadedState) {
            if (state.file != null) {
              context
                  .read<PdfToImageBloc>()
                  .add(ConvertPdfToImagesEvent(file: state.file!));
            }
          }
        },
        builder: (context, state) {
          return BlocBuilder<PdfToImageBloc, PdfToImageState>(
            builder: (context, state) {
              if (state is PdfToImageErrorState) {
                return Center(child: Text(state.message));
              }
              if (state is PdfToImageLoadedState ||
                  state is PdfToImageLoadingState) {
                final images = state is PdfToImageLoadedState
                    ? state.convertedImages
                    : (state as PdfToImageLoadingState).convertedImages;

                return GridView.builder(
                  itemCount: images.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 1 / 1.5,
                  ),
                  itemBuilder: (context, index) {
                    return Container(
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Image.memory(
                        images[index],
                        fit: BoxFit.cover,
                      ),
                    );
                  },
                );
              }
              return const SizedBox();
            },
          );
        },
      ),
    );
  }
}
