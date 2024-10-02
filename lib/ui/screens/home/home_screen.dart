import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xulosa_ai/core/utils/constants.dart';
import 'package:xulosa_ai/ui/screens/summary/summary_screen.dart';

import '../../../logic/blocs/blocs.dart';
import 'widgets/book_preview.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double summaryLength = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('HomeScreen')),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: BlocConsumer<GenerativeAiBloc, GenerativeAiState>(
                  listener: (context, state) {
                    if (state is GenerativeAiLoadedState) {
                      Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (context) => const SummaryScreen(),
                        ),
                      );
                    }
                  },
                  builder: (context, state) {
                    if (state is GenerativeAiLoadingState) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (state is GenerativeAiErrorState) {
                      return Center(child: Text(state.message));
                    }
                    return const Text("Pick a book");
                  },
                ),
              ),
            ),
            const BookPreview(),
            Slider(
              value: summaryLength,
              min: 1,
              max: 3,
              divisions: 2,
              label: SummaryLength.values[summaryLength.toInt() - 1].name,
              onChanged: (value) => setState(() => summaryLength = value),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  onPressed: () =>
                      context.read<FilePickerBloc>().add(PickFileEvent()),
                  icon: const Icon(Icons.attachment),
                ),
                BlocBuilder<PdfToImageBloc, PdfToImageState>(
                  builder: (context, state) {
                    return IconButton(
                      onPressed: state is PdfToImageLoadedState
                          ? () {
                              context
                                  .read<GenerativeAiBloc>()
                                  .add(SummarizeAiEvent(
                                    images: state.convertedImages,
                                    summaryLength: SummaryLength.values[summaryLength.toInt() - 1],
                                  ));
                            }
                          : null,
                      icon: const Icon(Icons.send),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
