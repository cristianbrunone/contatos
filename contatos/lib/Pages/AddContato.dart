import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../Model/Contato.dart';

class AddContato extends StatefulWidget {
  @override
  _AddContatoState createState() => _AddContatoState();
}

class _AddContatoState extends State<AddContato> {
  final _formKey = GlobalKey<FormState>();
  String _name = '';
  String _sobeNome = '';
  String _email = '';
  String _phone = '';
  String _cep = '';
  late File galleryFile;

  void _submitForm() {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();
      Contato newContato = Contato(
          title: _name,
          subtitle: _sobeNome,
          telefone: _phone,
          cep: _cep,
          email: _email);
      Navigator.of(context).pop(newContato);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.elliptical(10.5, 0.5),
                  bottomLeft: Radius.elliptical(350.0, 60.5),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      colors: [
                        Color.fromARGB(255, 1, 37, 166),
                        Color.fromARGB(255, 7, 106, 187),
                      ],
                    ),
                  ),
                  height: MediaQuery.of(context).size.height * 0.2,
                ),
              ),
              AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                iconTheme: IconThemeData(color: Colors.white),
                title: const Text(
                  'Novo Contato',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Nome',
                          hintText: 'Digite seu nome',
                          prefixIcon: Icon(Icons.person, color: Colors.blue),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50.0),
                          ),
                          filled: true,
                          fillColor: Colors.grey[200],
                        ),
                        validator: (nome) {
                          if (nome == null || nome.isEmpty) {
                            return 'Por favor, insira um nome';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _name = value!;
                        },
                      ),
                      SizedBox(height: 16),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Sobre Nome',
                          hintText: 'Digite seu sobre nome',
                          prefixIcon: Icon(Icons.person, color: Colors.blue),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50.0),
                          ),
                          filled: true,
                          fillColor: Colors.grey[200],
                        ),
                        validator: (sobnome) {
                          if (sobnome == null || sobnome.isEmpty) {
                            return 'Por favor, insira um nome';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _sobeNome = value!;
                        },
                      ),
                      SizedBox(height: 16),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'E-mail',
                          hintText: 'name@email.com',
                          prefixIcon: Icon(Icons.email, color: Colors.blue),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50.0),
                          ),
                          filled: true,
                          fillColor: Colors.grey[200],
                        ),
                        validator: (email) {
                          if (email == null || email.isEmpty) {
                            return 'Por favor, insira um email';
                          } else if (!RegExp(
                                  r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                              .hasMatch(email)) {
                            return 'Por favor, insira um email válido';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _email = value!;
                        },
                      ),
                      SizedBox(height: 16),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Telefone',
                          hintText: 'Digite seu Telefone (XX XXXX-XXXX)',
                          prefixIcon: Icon(Icons.phone, color: Colors.blue),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50.0),
                          ),
                          filled: true,
                          fillColor: Colors.grey[200],
                        ),
                        validator: (phone) {
                          if (phone == null || phone.isEmpty) {
                            return 'Por favor, insira um Telefone';
                          } else if (!RegExp(r'^\d{2}\s\d{4,5}-\d{4}$')
                              .hasMatch(phone)) {
                            return 'Por favor, insira um telefone válido (formato: XX XXXX-XXXX)';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _phone = value!;
                        },
                      ),
                      SizedBox(height: 16),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'CEP',
                          hintText: 'Digite seu CEP ()',
                          prefixIcon:
                              Icon(Icons.location_on, color: Colors.blue),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50.0),
                          ),
                          filled: true,
                          fillColor: Colors.grey[200],
                        ),
                        validator: (cep) {
                          if (cep == null || cep.isEmpty) {
                            return 'Por favor, insira um CEP';
                          } else if (!RegExp(r'^\d{5}-\d{3}$').hasMatch(cep)) {
                            return 'Por favor, insira um telefone válido (formato: XXXXX-XXX)';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _cep = value!;
                        },
                      ),
                      SizedBox(height: 18),
                      ElevatedButton(
                        onPressed: _submitForm,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                        ),
                        child: const Text(
                          'Adicionar',
                          style: TextStyle(
                              fontSize: 18, color: Colors.white, height: 2.6),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  imageSelectorGallery() async {
    galleryFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxHeight: 800.0,
      maxWidth: 700.0,
    ) as File;
    setState(() {});
  }
}
