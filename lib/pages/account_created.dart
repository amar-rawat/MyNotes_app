import 'package:flutter/material.dart';

class AccountCreated extends StatefulWidget {
  const AccountCreated({super.key});

  @override
  State<AccountCreated> createState() => _AccountCreatedState();
}

class _AccountCreatedState extends State<AccountCreated> {
  bool doneval = true;
  @override
  void initState() {
    super.initState();
    doneTick();
  }

  doneTick() async {
    await Future.delayed(const Duration(milliseconds: 600));
    doneval = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            const SizedBox(
              height: 40,
            ),
            Container(
              alignment: Alignment.center,
              height: 200,
              width: 200,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                height: doneval ? 1 : 200,
                width: doneval ? 1 : 200,
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: Colors.green),
                child: Container(
                  height: 200,
                  width: 200,
                  alignment: Alignment.center,
                  child: AnimatedContainer(
                    duration: const Duration(seconds: 0),
                    alignment: Alignment.center,
                    height: doneval ? 1 : 150,
                    width: doneval ? 1 : 150,
                    child: const Icon(
                      Icons.done_rounded,
                      size: 150,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 80,
            ),
            Text('Account created successfully!',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: MediaQuery.sizeOf(context).width * 0.06)),
            const SizedBox(
              height: 30,
            ),
            TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/login');
                },
                child: Title(
                    color: Colors.black, child: const Text('Go to login page')))
          ]),
        ),
      ),
    );
  }
}
