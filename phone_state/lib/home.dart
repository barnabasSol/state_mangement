// ignore: library_prefixes
import 'package:badges/badges.dart' as badgeLib;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:phone_state/add_note.dart';
import 'package:phone_state/bloc/note_bloc.dart';
import 'package:phone_state/note_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    context.read<NoteBloc>().add(NoteFetched());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "SOME SHITTY NOTE APP",
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          BlocBuilder<NoteBloc, NoteState>(
            builder: (context, state) {
              if (state is NoteFetchSuccess) {
                final notesCount = state.notes.length;
                return Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: badgeLib.Badge(
                    position: badgeLib.BadgePosition.custom(
                      bottom: 7,
                      start: 18,
                      isCenter: false,
                    ),
                    badgeContent: Text(
                      '$notesCount',
                      style: const TextStyle(color: Colors.white),
                    ),
                    child: const Icon(
                      FontAwesomeIcons.message,
                      color: Colors.white,
                    ),
                  ),
                );
              }
              return const Padding(
                padding: EdgeInsets.only(right: 20),
                child: badgeLib.Badge(
                  child: Icon(
                    FontAwesomeIcons.message,
                    color: Colors.white,
                  ),
                ),
              );
            },
          )
        ],
        backgroundColor: Colors.deepPurple[400],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepPurple,
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const AddNotePage(),
            ),
          );
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: BlocBuilder<NoteBloc, NoteState>(
        builder: (context, state) {
          if (state is NoteFetchSuccess) {
            if (state.notes.isEmpty) {
              return const Text("YOU HAVE NO FUCKING NOTES");
            }
            return ListView.builder(
              itemCount: state.notes.length,
              itemBuilder: (context, index) {
                final note = state.notes[index];
                return Container(
                  margin: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: Colors.deepPurple,
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: ListTile(
                    title: Text(
                      note.id.toString(),
                      style: const TextStyle(color: Colors.white),
                    ),
                    subtitle: Text(
                      note.value,
                      style: const TextStyle(color: Colors.white),
                    ),
                    trailing: IconButton(
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                      onPressed: () {
                        context.read<NoteBloc>().add(
                              NoteDelete(
                                note: NoteModel(id: note.id, value: note.value),
                              ),
                            );
                      },
                    ),
                  ),
                );
              },
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
