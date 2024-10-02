part of 'generative_ai_bloc.dart';

sealed class GenerativeAiEvent {}

final class SummarizeAiEvent extends GenerativeAiEvent {
  final List<Uint8List> images;
  final SummaryLength summaryLength;

  SummarizeAiEvent({required this.images, required this.summaryLength});
}
