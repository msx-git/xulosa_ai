import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

import '../../../logic/blocs/blocs.dart';

class SummaryScreen extends StatelessWidget {
  const SummaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Xulosa"),
      ),
      body: BlocBuilder<GenerativeAiBloc, GenerativeAiState>(
        builder: (context, state) {
          return Markdown(data: (state as GenerativeAiLoadedState).response);
        },
      ),
    );
  }
}
