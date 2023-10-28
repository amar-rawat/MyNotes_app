import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/providers/all_providers.dart';
import 'package:notes_app/widgets/alert_dialogue.dart';
import 'package:provider/provider.dart';

class Register extends StatelessWidget {
  const Register({super.key});

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final TextEditingController _email = TextEditingController();

    final TextEditingController _password = TextEditingController();

    final TextEditingController _username = TextEditingController();

    moveToLogin() async {
      try {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: _email.text, password: _password.text);
        if (FirebaseAuth.instance.currentUser.toString().isNotEmpty) {
          await context.read<ButtonStateProvider>().changeButton(true);
          await Future.delayed(Duration(seconds: 1));
          Navigator.pushNamedAndRemoveUntil(
              context, '/accountCreated', (route) => false);
          context.read<ButtonStateProvider>().changeButton(false);
        } else {
          return null;
        }
      } on FirebaseException catch (e) {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialogBox(
                error: '${e.message}',
              );
            });
      }
    }

    return Consumer(
      builder: (context, value, child) => GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Container(
                    height: MediaQuery.sizeOf(context).height * 0.41,
                    child: Image.asset("assets/images/register_image.png",
                        fit: BoxFit.cover),
                  ),
                  const Text(
                    'Welcome',
                    style: TextStyle(fontSize: 30, color: Colors.black),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(30),
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _username,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Username can not be empty';
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                              hintText: 'Enter username here',
                              labelText: 'Username'),
                        ),
                        TextFormField(
                            controller: _email,
                            keyboardType: TextInputType.emailAddress,
                            autofillHints: const [AutofillHints.email],
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Email can no be empty';
                              } else if (!value.contains('@') ||
                                  !value.contains('.com')) {
                                return 'Enter correct email adress please';
                              }
                              return null;
                            },
                            decoration: const InputDecoration(
                                hintText: 'Enter email here',
                                labelText: 'Email')),
                        TextFormField(
                            controller: _password,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Password can not be empty';
                              } else if (value.length < 6) {
                                return 'Password length should be atleast 6';
                              }
                              return null;
                            },
                            obscureText: true,
                            enableSuggestions: false,
                            decoration: const InputDecoration(
                              hintText: 'Enter password here',
                              labelText: 'Password',
                            )),
                      ],
                    ),
                  ),
                  InkWell(
                    splashColor: Colors.black,
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        moveToLogin();
                      } else {
                        null;
                      }
                    },
                    child: AnimatedContainer(
                      duration: const Duration(seconds: 1),
                      width: context.watch<ButtonStateProvider>().buttonState
                          ? 40
                          : 150,
                      height: 40.0,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Colors.deepPurple,
                          borderRadius: BorderRadius.circular(40)),
                      child: context.watch<ButtonStateProvider>().buttonState
                          ? const Icon(Icons.done, color: Colors.white)
                          : const Text(
                              'Register',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),
                            ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/login');
                    },
                    child: const Text(
                      'Back to login page',
                      style: TextStyle(
                          color: Colors.cyan,
                          decoration: TextDecoration.underline),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
