import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_picker/flutter_picker.dart';

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

  PlatformFile? _file;
  late String _id;
  String _fileError = '';

  _addCertificate() async {
    if (_formKey.currentState!.validate() && _file != null) {
      DocumentReference doc = await FirebaseFirestore.instance
          .collection("users/$_id/certificates")
          .add({
        "hours": int.parse(_hoursController.text),
        "category": _categoryController.text,
      });

      _upload(doc.id);

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('DocumentSnapshot added with ID: ${doc.id}'),
      ));

      Navigator.of(context).pop();
    } else {
      if (_file == null) {
        setState(() {
          _fileError = "Nenhum arquivo selecionado";
        });
      }
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

  _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.custom, allowedExtensions: ['pdf'], withData: true);

    setState(() {
      _file = result?.files.first;
    });
  }

  _upload(String id) async {
    if (_file?.bytes != null) {
      try {
        final storageRef = FirebaseStorage.instance.ref('users/$_id/$id.${_file!.extension}');
        await storageRef.putData(_file!.bytes!);
      } catch (e) {
        print(e);
      }
    } else {
      throw Exception('No bytes!');
    }
  }

  @override
  void initState() {
    super.initState();
    _id = FirebaseAuth.instance.currentUser!.uid;
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
      child: Form(
          key: _formKey,
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxHeight: 500),
            child: Column(
                children: <Widget>[
                  const Expanded(flex: 1, child: SizedBox.shrink()),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    IconButton(
                        iconSize: 36,
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: const Icon(
                          Icons.arrow_back,
                        )),
                    const Text('Cadastro de horas',
                        style: TextStyle(fontSize: 30)),
                  ]),
                  const Expanded(flex: 2, child: SizedBox.shrink()),
                  ConstrainedBox(
                      constraints: const BoxConstraints.tightFor(width: 250),
                      child: TextFormField(
                        controller: _hoursController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Campo vazio';
                          } else if (double.tryParse(value) == null) {
                            return 'Insira um número';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Horas feitas',
                        ),
                      )),
                  const Expanded(flex: 2, child: SizedBox.shrink()),
                  ConstrainedBox(
                      constraints: const BoxConstraints.tightFor(width: 250),
                      child: TextFormField(
                        readOnly: true,
                        onTap: () => _showPicker(),
                        controller: _categoryController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Campo vazio';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Categoria',
                        ),
                      )),
                  const Expanded(flex: 2, child: SizedBox.shrink()),
                  ConstrainedBox(
                      constraints:
                          const BoxConstraints.tightFor(width: 210, height: 45),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xff9b1536),
                            textStyle: const TextStyle(fontSize: 20)),
                        onPressed: () => _pickFile(),
                        child: Text(_file != null
                            ? 'Mudar certificado'
                            : 'Anexar certificado'),
                      )),
                  const SizedBox(height: 14),
                  _file != null
                      ? Text('Nome do certificado: ${_file!.name}')
                      : Text(_fileError,
                          style: const TextStyle(color: Colors.red)),
                  const Expanded(flex: 3, child: SizedBox.shrink()),
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
                  const Expanded(flex: 1, child: SizedBox.shrink()),
                ]),
          ))),
    );
  }
}
