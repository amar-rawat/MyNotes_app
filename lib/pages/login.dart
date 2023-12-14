import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:notes_app/providers/all_providers.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController _email = TextEditingController();
    final TextEditingController _password = TextEditingController();
    final _formKey = GlobalKey<FormState>();

    moveToHome() async {
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: _email.text.trim(), password: _password.text.trim());
        if (FirebaseAuth.instance.currentUser!.uid.isNotEmpty) {
          await context.read<ButtonStateProvider>().changeButton(true);
          await Future.delayed(const Duration(seconds: 1));
          Navigator.pushNamedAndRemoveUntil(
              context, '/noteCardPage', (route) => false);
        } else {
          return null;
        }
      } on FirebaseException catch (e) {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Error'),
                content: Text('${e.message}'),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Ok'))
                ],
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
                  const SizedBox(
                    height: 30,
                  ),
                  Image.asset("assets/images/welcome_image.png",
                      fit: BoxFit.cover),
                  const SizedBox(height: 30),
                  Shimmer(
                    gradient: LinearGradient(
                        colors: [Colors.blue, Colors.red, Colors.green]),
                    child: const Text(
                      'Welcome Back!',
                      style: TextStyle(fontSize: 30, color: Colors.black),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(30),
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _email,
                          keyboardType: TextInputType.emailAddress,
                          autofillHints: const [AutofillHints.email],
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Email can not be empty';
                            } else if (!value.contains('@') ||
                                !value.contains('.com')) {
                              return 'Enter correct email adress';
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                              hintText: 'Enter email here', labelText: 'Email'),
                        ),
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
                          ),
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        moveToHome();
                      } else {
                        null;
                      }
                    },
                    child: AnimatedContainer(
                      duration: const Duration(seconds: 1),
                      width: context.watch<ButtonStateProvider>().buttonState
                          ? 40
                          : 150,
                      height: 40,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Colors.deepPurple,
                          borderRadius: BorderRadius.circular(40)),
                      child: context.read<ButtonStateProvider>().buttonState
                          ? const Icon(Icons.done, color: Colors.white)
                          : const Text(
                              'Login',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),
                            ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  InkWell(
                    onTap: () {},
                    child: Container(
                      height: 40,
                      width: 250,
                      decoration: BoxDecoration(
                        color: Colors.deepPurple,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Image.asset('assets/images/google_logo.png'),
                          ),
                          const SizedBox(width: 10),
                          const Text(
                            'SignIn with Google',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 16),
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/register');
                    },
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Don't have an account? "),
                        Text(
                          'Sign Up',
                          style: TextStyle(
                              color: Colors.cyan,
                              decoration: TextDecoration.underline),
                        ),
                      ],
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
