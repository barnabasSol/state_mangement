import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phone_state/note_model.dart';
part 'note_event.dart';
part 'note_state.dart';

class NoteBloc extends Bloc<NoteEvent, NoteState> {
  List<NoteModel> notes = [];

  NoteBloc() : super(NoteInitial()) {
    on<NoteAdd>(
      (event, emit) async {
        emit(NoteAddLoading());
        await Future.delayed(
          const Duration(seconds: 3),
        );
        notes.add(
          NoteModel(id: notes.length + 1, value: event.note.value),
        );
        emit(NoteAddSuccess());
        emit(NoteFetchSuccess(notes: notes));
      },
    );

    on<NoteFetched>(
      (event, emit) async {
        emit(NotesLoading());
        emit(NoteFetchSuccess(notes: notes));
      },
    );

    on<NoteDelete>(
      (event, emit) async {
        emit(NoteDeleteLoading());
        // await Future.delayed(const Duration(milliseconds: 300));
        notes.removeWhere((element) => element.id == event.note.id);
        emit(NoteDeleteSuccess());
        emit(NoteFetchSuccess(notes: notes));
      },
    );
  }
}
