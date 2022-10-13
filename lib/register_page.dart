import 'package:flutter/material.dart';
import 'package:for_hour/home_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        minimum: const EdgeInsets.symmetric(vertical: 50),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                IconButton(
                    iconSize: 36,                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(
                      Icons.arrow_back,
                    )),
                const Text('Cadastro de horas', style: TextStyle(fontSize: 30)),
              ]),
              const SizedBox(height: 90),
              ConstrainedBox(
                  constraints: const BoxConstraints.tightFor(width: 250),
                  child: const TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Horas feitas',
                    ),
                  )),
              const SizedBox(height: 30),
              ConstrainedBox(
                  constraints: const BoxConstraints.tightFor(width: 250),
                  child: const TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Categoria',
                    ),
                  )),
              const SizedBox(height: 60),
              ConstrainedBox(
                  constraints:
                      const BoxConstraints.tightFor(width: 210, height: 45),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff9b1536),
                        textStyle: const TextStyle(fontSize: 20)),
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const HomePage()));
                    },
                    child: const Text('Anexar certificado'),
                  )),
              const SizedBox(height: 60),
              ConstrainedBox(
                  constraints:
                      const BoxConstraints.tightFor(width: 250, height: 50),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff9b1536),
                        textStyle: const TextStyle(fontSize: 28)),
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const HomePage()));
                    },
                    child: const Text('Enviar'),
                  )),
            ]),
      ),
    );
  }
}
