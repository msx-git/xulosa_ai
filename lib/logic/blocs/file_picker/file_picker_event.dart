part of 'file_picker_bloc.dart';

/// sealed - bu abstract bo'lib faqat shu faylda meros olish mumkin
sealed class FilePickerEvent {}

/// final - bu meros olishlikni cheklaydi
final class PickFileEvent extends FilePickerEvent {}
