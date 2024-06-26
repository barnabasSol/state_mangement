import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phone_state/bloc/note_bloc.dart';
import 'package:phone_state/note_model.dart';

class AddNotePage extends StatelessWidget {
  const AddNotePage({super.key});
  @override
  Widget build(BuildContext context) {
    final inputController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "ADD SOME SHITTY NOTE",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.deepPurple[400],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: inputController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                filled: true,
                fillColor: Colors.white,
                hintText: 'Enter your note',
                hintStyle: const TextStyle(color: Colors.grey),
              ),
            ),
            const SizedBox(height: 20),
            BlocConsumer<NoteBloc, NoteState>(
              builder: (context, state) {
                if (state is NoteAddLoading) {
                  return const CircularProgressIndicator();
                }
                return ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.deepPurple,
                    backgroundColor: Colors.deepPurple,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  onPressed: () {
                    context.read<NoteBloc>().add(NoteAdd(
                          note: NoteModel(
                            id: 0,
                            value: inputController.text,
                          ),
                        ));
                  },
                  child: const Text(
                    'Add Note',
                    style: TextStyle(color: Colors.white),
                  ),
                );
              },
              listener: (BuildContext context, NoteState state) {
                if (state is NoteAddSuccess) {
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
