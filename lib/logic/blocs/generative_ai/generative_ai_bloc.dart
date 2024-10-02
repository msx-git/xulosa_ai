import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

import '../../../core/utils/constants.dart';

part 'generative_ai_event.dart';
part 'generative_ai_state.dart';

class GenerativeAiBloc extends Bloc<GenerativeAiEvent, GenerativeAiState> {
  GenerativeAiBloc() : super(GenerativeAiInitialState()) {
    on<SummarizeAiEvent>(_onSummarize);
  }

  void _onSummarize(SummarizeAiEvent event, emit) async {
    emit(GenerativeAiLoadingState());
    try {
      List<DataPart> dataParts = [];

      for (var image in event.images) {
        dataParts.add(DataPart('image/jpeg', image));
      }

      final model = GenerativeModel(
        model: 'gemini-1.5-flash-latest',
        apiKey: dotenv.get("API_KEY"),
      );

      final content = [
        Content.multi([
          TextPart(Constants.summarizePrompt(event.summaryLength.name)),
          ...dataParts,
        ]),
      ];

      final response = await model.generateContent(content);

      emit(GenerativeAiLoadedState(response: response.text ?? "No response"));
    } catch (e) {
      emit(GenerativeAiErrorState(message: ""));
    }
  }
}
