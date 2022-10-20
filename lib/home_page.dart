import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:for_hour/register_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<String> entries = <String>[
    'Curso Online',
    'Curso Online',
    'Estágio',
    'Curso Online',
    'Curso Online',
    'Estágio',
    'Curso Online',
    'Curso Online'
  ];

  _signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: SafeArea(
                child: Column(children: [
      Material(
          borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(16),
              bottomRight: Radius.circular(16)),
          elevation: 6,
          child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(16),
                    bottomRight: Radius.circular(16)),
                color: Color(0xff9b1536),
              ),
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: const [
                      Text('Olá Victor!',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                              fontWeight: FontWeight.w600)),
                      Icon(Icons.account_circle_outlined,
                          color: Colors.white, size: 40),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.white),
                      margin: const EdgeInsets.symmetric(horizontal: 40),
                      height: 70,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Text('Horas cadastradas'),
                                  Text('178h',
                                      style: TextStyle(
                                          fontSize: 26,
                                          fontWeight: FontWeight.w700))
                                ]),
                            Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Text('Horas Restantes'),
                                  Text('60h',
                                      style: TextStyle(
                                          fontSize: 26,
                                          fontWeight: FontWeight.w700))
                                ])
                          ]))
                ],
              ))),
      const SizedBox(height: 20),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(
              height: 140,
              width: 120,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    side:
                        const BorderSide(width: 3.5, color: Color(0xff9b1536)),
                    elevation: 8,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12), // <-- Radius
                    ),
                    backgroundColor: Colors.white,
                    textStyle: const TextStyle(fontSize: 20)),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const RegisterPage()));
                },
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              color: const Color(0xff9b1536)),
                          child: const Icon(
                            Icons.add_outlined,
                          )),
                      const Text('Cadastrar',
                          style: TextStyle(color: Colors.black))
                    ]),
              )),
          SizedBox(
              height: 140,
              width: 120,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    side:
                        const BorderSide(width: 3.5, color: Color(0xff9b1536)),
                    elevation: 8,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    backgroundColor: Colors.white,
                    textStyle: const TextStyle(fontSize: 20)),
                onPressed: () => _signOut(),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              color: const Color(0xff9b1536)),
                          child: const Icon(
                            Icons.logout_outlined,
                          )),
                      const Text('Sign out',
                          style: TextStyle(color: Colors.black))
                    ]),
              ))
        ],
      ),
      const SizedBox(height: 20),
      Expanded(
        child: Material(
            color: const Color(0xff9b1536),
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16), topRight: Radius.circular(16)),
            elevation: 8,
            child: Container(
                padding: const EdgeInsets.only(top: 4),
                child: ListView.separated(
                  padding: const EdgeInsets.all(16),
                  separatorBuilder: (BuildContext context, int index) =>
                      const Divider(),
                  itemCount: entries.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.white,
                      ),
                      height: 80,
                      child: Center(
                          child: Text(entries[index],
                              style: const TextStyle(fontSize: 20))),
                    );
                  },
                ))),
      )
    ]))));
  }
}
