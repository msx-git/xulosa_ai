part of 'file_picker_bloc.dart';

sealed class FilePickerState {}

final class FilePickerInitialState extends FilePickerState {}

final class FilePickerLoadingState extends FilePickerState {}

final class FilePickerLoadedState extends FilePickerState {
  final File? file;

  FilePickerLoadedState({required this.file});
}

final class FilePickerErrorState extends FilePickerState {
  final String message;

  FilePickerErrorState({required this.message});
}
