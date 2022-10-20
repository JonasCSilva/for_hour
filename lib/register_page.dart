import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:for_hour/home_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _pickerData = ["Course", "Internship"];

  final _hoursController = TextEditingController();
  final _categoryController = TextEditingController();

  _addCertificate() async {
    if (_formKey.currentState!.validate()) {
      DocumentReference doc = await FirebaseFirestore.instance
          .collection("users/tIeMjnsFX2Ur69clWHgJvCxxltc2/certificates")
          .add({
        "hours": int.parse(_hoursController.text),
        "category": _categoryController.text,
      });

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('DocumentSnapshot added with ID: ${doc.id}'),
      ));

      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => const HomePage()));
    }
  }

  _showPicker() async {
    final result = await Picker(
      hideHeader: true,
      adapter: PickerDataAdapter(pickerdata: _pickerData),
      selectedTextStyle: const TextStyle(color: Color(0xff9b1536)),
    ).showDialog(context);
    if (result != null) {
      _categoryController.text = _pickerData[result[0]];
    }
  }

  @override
  void dispose() {
    _hoursController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      minimum: const EdgeInsets.only(top: 50, bottom: 50),
      child: Form(
        key: _formKey,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                IconButton(
                    iconSize: 36,
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(
                      Icons.arrow_back,
                    )),
                const Text('Cadastro de horas', style: TextStyle(fontSize: 30)),
              ]),
              ConstrainedBox(
                  constraints: const BoxConstraints.tightFor(width: 250),
                  child: TextFormField(
                    controller: _hoursController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      } else if (double.tryParse(value) == null) {
                        return 'Please enter a number';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Horas feitas',
                    ),
                  )),
              ConstrainedBox(
                  constraints: const BoxConstraints.tightFor(width: 250),
                  child: TextFormField(
                    readOnly: true,
                    onTap: () => _showPicker(),
                    controller: _categoryController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a value';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Categoria',
                    ),
                  )),
              ConstrainedBox(
                  constraints:
                      const BoxConstraints.tightFor(width: 210, height: 45),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff9b1536),
                        textStyle: const TextStyle(fontSize: 20)),
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Not implemented!'),
                      ));
                    },
                    child: const Text('Anexar certificado'),
                  )),
              ConstrainedBox(
                  constraints:
                      const BoxConstraints.tightFor(width: 250, height: 50),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff9b1536),
                        textStyle: const TextStyle(fontSize: 28)),
                    onPressed: () => _addCertificate(),
                    child: const Text('Enviar'),
                  )),
            ]),
      ),
    ));
  }
}
