import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'home_button.dart';
import 'register_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, dynamic>> _entries = <Map<String, dynamic>>[];

  num _hours = 0;

  _signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  @override
  void initState() {
    FirebaseFirestore.instance
        .collection("users/tIeMjnsFX2Ur69clWHgJvCxxltc2/certificates")
        .get()
        .then((event) {
      final List<Map<String, dynamic>> test = [];
      num test2 = 0;
      for (var doc in event.docs) {
        test.add(doc.data());
        test2 += doc.data()['hours'];
      }
      setState(() {
        _entries = test;
        _hours = test2;
      });
    });
    super.initState();
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
                  const Text('Olá Victor!',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.w600)),
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
                                children: [
                                  const Text('Horas cadastradas'),
                                  Text('${_hours.toString()}h',
                                      style: const TextStyle(
                                          fontSize: 26,
                                          fontWeight: FontWeight.w700))
                                ]),
                            Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text('Horas Restantes'),
                                  Text('${(238 - _hours).toString()}h',
                                      style: const TextStyle(
                                          fontSize: 26,
                                          fontWeight: FontWeight.w700))
                                ])
                          ]))
                ],
              ))),
      const SizedBox(height: 20),
      Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
        HomeButton(
          text: 'Cadastrar',
          icon: Icons.add_outlined,
          onPressed: () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const RegisterPage()));
          },
        ),
        HomeButton(
            text: 'Sign out',
            icon: Icons.logout_outlined,
            onPressed: () => _signOut())
      ]),
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
                  itemCount: _entries.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.white,
                      ),
                      height: 80,
                      child: Center(
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                            Text(_entries[index]['hours'].toString(),
                                style: const TextStyle(fontSize: 18)),
                            Text(_entries[index]['category'],
                                style: const TextStyle(fontSize: 18)),
                            Text(
                                _entries[index]['isValidadated'] == null
                                    ? 'Não validado'
                                    : 'Validado',
                                style: TextStyle(
                                    fontSize: 16,
                                    color:
                                        _entries[index]['isValidated'] == null
                                            ? Colors.red
                                            : Colors.green))
                          ])),
                    );
                  },
                ))),
      )
    ]))));
  }
}
