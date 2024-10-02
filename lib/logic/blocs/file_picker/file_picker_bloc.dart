import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'file_picker_event.dart';

part 'file_picker_state.dart';

class FilePickerBloc extends Bloc<FilePickerEvent, FilePickerState> {
  FilePickerBloc() : super(FilePickerInitialState()) {
    on<PickFileEvent>(_onPickFile);
  }

  void _onPickFile(event, emit) async {
    emit(FilePickerLoadingState());
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
      );

      final pickedFile = result != null && result.files.single.path != null
          ? File(result.files.single.path!)
          : null;
      emit(FilePickerLoadedState(file: pickedFile));
    } catch (e) {
      emit(FilePickerErrorState(message: "Error while file-picking: $e"));
    }
  }
}
