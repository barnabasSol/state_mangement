part of 'note_bloc.dart';

@immutable
sealed class NoteState {}

final class NoteInitial extends NoteState {}

//ADD STATE
final class NoteAddLoading extends NoteState {}

final class NoteAddSuccess extends NoteState {}

final class NoteAddFailure extends NoteState {}

//FETCH STATE
final class NotesLoading extends NoteState {}

final class NoteFetchSuccess extends NoteState {
  final List<NoteModel> notes;

  NoteFetchSuccess({required this.notes});
}

//DELETE STATE
final class NoteDeleteLoading extends NoteState {}

final class NoteDeleteSuccess extends NoteState {}

final class NotDeletFailure extends NoteState {}
