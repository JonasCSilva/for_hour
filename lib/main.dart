import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text('Bem-vindo', style: TextStyle(fontSize: 50)),
              const SizedBox(height: 120),
              ConstrainedBox(
                  constraints: const BoxConstraints.tightFor(width: 250),
                  child: const TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Email Address',
                    ),
                  )),
              const SizedBox(height: 30),
              ConstrainedBox(
                  constraints: const BoxConstraints.tightFor(width: 250),
                  child: const TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                    ),
                  )),
              const SizedBox(height: 60),
              ConstrainedBox(
                  constraints: const BoxConstraints.tightFor(width: 280, height: 50),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff9b1536),
                        textStyle: const TextStyle(fontSize: 20)),
                    onPressed: () {},
                    child: const Text('Login'),
                  )),
            ]),
      ),
    );
  }
}
