import 'package:flutter/material.dart';
import 'package:notes_app/providers/all_providers.dart';
import 'package:notes_app/widgets/logout_dialog_box.dart';
import 'package:provider/provider.dart';

class NotesCardPage extends StatelessWidget {
  const NotesCardPage({super.key});

  @override
  Widget build(BuildContext context) {
    logout() {
      LogoutAlertDialog.logoutAlertDialog(context);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Notes'),
        actions: [
          IconButton(
              onPressed: () {
                logout();
                context.read<ButtonStateProvider>().changeButton(false);
              },
              icon: const Icon(Icons.logout))
        ],
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {},
          elevation: 10,
          backgroundColor: Colors.deepPurple,
          tooltip: 'Add new note',
          shape: ContinuousRectangleBorder(
              borderRadius: BorderRadius.circular(40)),
          child: const Icon(Icons.add)),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
