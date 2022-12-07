import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  String? _error;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  _login() async {
    if (_formKey.currentState!.validate()) {
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: _emailController.text, password: _passwordController.text);
      } on FirebaseAuthException catch (e) {
        String? error;
        switch (e.code) {
          case 'wrong-password':
            error = 'Senha incorreta';
            break;
          case 'invalid-email':
            error = 'Email inválido';
            break;
          case 'user-not-found':
            error = 'Email não encontrado';
            break;
          default:
            error = e.code;
            break;
        }
        setState(() {
          _error = error;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Form(
              key: _formKey,
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxHeight: 500, minWidth: double.infinity),
                child: Column(
                    children: <Widget>[
                      const Expanded(flex: 1, child: SizedBox.shrink()),
                      const Text('Bem-vindo', style: TextStyle(fontSize: 50)),
                      const Expanded(flex: 4, child: SizedBox.shrink()),
                      ConstrainedBox(
                          constraints:
                              const BoxConstraints.tightFor(width: 250),
                          child: TextFormField(
                            controller: _emailController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter some text';
                              }
                              return null;
                            },
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Email Address',
                            ),
                          )),
                      const Expanded(flex: 1, child: SizedBox.shrink()),
                      ConstrainedBox(
                          constraints:
                              const BoxConstraints.tightFor(width: 250),
                          child: TextFormField(
                            controller: _passwordController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter some text';
                              }
                              return null;
                            },
                            obscureText: true,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Password',
                            ),
                          )),
                      const Expanded(flex: 2, child: SizedBox.shrink()),
                      ConstrainedBox(
                          constraints: const BoxConstraints.tightFor(
                              width: 280, height: 50),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xff9b1536),
                                textStyle: const TextStyle(fontSize: 20)),
                            onPressed: () => _login(),
                            child: const Text('Login'),
                          )),
                      const Expanded(flex: 1, child: SizedBox.shrink()),
                      if (_error != null)
                        Text("$_error!",
                            style: const TextStyle(
                                color: Colors.red, fontSize: 20)),
                    ]),
              ))),
    );
  }
}
