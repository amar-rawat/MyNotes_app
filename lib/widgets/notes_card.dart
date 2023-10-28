import 'package:flutter/material.dart';

class NotesCard extends StatelessWidget {
  const NotesCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(
            context,
            '/notesDetailPage',
          );
        },
        child: Container(
          height: MediaQuery.of(context).size.height * 0.20,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 219, 198, 255),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Title ' * 3,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                Divider(thickness: 1, color: Colors.deepPurple),
                Text('Body....' * 20)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
