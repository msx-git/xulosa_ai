part of 'generative_ai_bloc.dart';

sealed class GenerativeAiState {}

final class GenerativeAiInitialState extends GenerativeAiState {}

final class GenerativeAiLoadingState extends GenerativeAiState {}

final class GenerativeAiLoadedState extends GenerativeAiState {
  final String response;

  GenerativeAiLoadedState({required this.response});
}

final class GenerativeAiErrorState extends GenerativeAiState {
  final String message;

  GenerativeAiErrorState({required this.message});
}
