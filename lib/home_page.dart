import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(children: [
        ConstrainedBox(
            constraints: const BoxConstraints.tightFor(height: 150, width: double.infinity),
            child: const ColoredBox(color: Color(0xFF1C1939))),
        const SizedBox(height: 50),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff9b1536),
                  textStyle: const TextStyle(fontSize: 20)),
              onPressed: () {},
              child: const Text('Cadastrar'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff9b1536),
                  textStyle: const TextStyle(fontSize: 20)),
              onPressed: () {},
              child: const Text('Sign out'),
            )
          ],
        )
      ]),
    ));
  }
}
