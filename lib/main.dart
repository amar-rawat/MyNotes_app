import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/pages/account_created.dart';
import 'package:notes_app/pages/login.dart';
import 'package:notes_app/pages/notes_card_page.dart';
import 'package:notes_app/pages/notes_detail_page.dart';
import 'package:notes_app/pages/registration.dart';
import 'package:notes_app/providers/all_providers.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => ButtonStateProvider())
        ],
        child: MaterialApp(
          title: 'My Notes',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          ),
          initialRoute: '/notesCardPage',
          routes: {
            '/login': (context) => const LoginPage(),
            '/register': (context) => const Register(),
            '/accountCreated': (context) => const AccountCreated(),
            '/notesCardPage': (context) => const NotesCardPage(),
            '/notesDetailPage': (context) => const NotesDetailPage(),
          },
        ));
  }
}
