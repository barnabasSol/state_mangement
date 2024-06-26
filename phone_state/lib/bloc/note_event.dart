part of 'note_bloc.dart';

@immutable
sealed class NoteEvent {}

final class NoteAdd extends NoteEvent {
  final NoteModel note;
  NoteAdd({required this.note});
}

final class NoteDelete extends NoteEvent {
  final NoteModel note;
  NoteDelete({required this.note});
}

final class NoteFetched extends NoteEvent {}
