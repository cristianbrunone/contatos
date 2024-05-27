import 'dart:io';

import 'package:flutter/material.dart';
import '../Model/Contato.dart';
import '../classes/Common/MyRouters.dart';
import '../items/MyListTile.dart';
import 'Root_page.dart';
import '../classes/auth_firebase.dart';

class MyListContatoPage extends StatefulWidget {
  MyListContatoPage({
    required this.onSignIn,
    required this.authStatus,
    required this.authFirebase,
  });

  final VoidCallback onSignIn;
  final AuthStatus authStatus;
  final AuthFirebase authFirebase;

  @override
  State<StatefulWidget> createState() =>
      MyListContatoPageState(authFirebase: authFirebase);
}

class MyListContatoPageState extends State<MyListContatoPage> {
  AuthFirebase authFirebase;
  List<Contato> myContatos = [];

  MyListContatoPageState({required this.authFirebase});

  @override
  void initState() {
    super.initState();
    if (widget.authStatus == AuthStatus.signedIn) {
      myContatos = contatos;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.authStatus != AuthStatus.signedIn) {
      return Container();
    }

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        onPressed: () async {
          final newContato =
              await Navigator.pushNamed<Contato>(context, ROUTE_ADDCONTATO);
          if (newContato != null) {
            _addContato(newContato);
          }
        },
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 1, 42, 187),
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          "Lista Contatos",
          style: TextStyle(color: Colors.white),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () async {
              try {
                await authFirebase.signOut();
                Navigator.pushReplacementNamed(context, ROUTE_LOGIN);
              } catch (error) {
                print("Error signing out: $error");
              }
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(20),
            child: TextField(
              onChanged: _runSearch,
              decoration: InputDecoration(
                labelText: 'Buscar...',
                prefixIcon:
                    Icon(Icons.search, color: Color.fromARGB(255, 1, 42, 187)),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50.0)),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
          ),
          Expanded(
            child: ListContatos(
              contatos: myContatos,
              onRemove: _removeContato,
              onUpdate: _updateContato,
              onUpdateImage: (file) {
                // Obtener el contacto actual para pasarlo a _updateImage
                Contato? contatoToUpdate;
                for (Contato contato in myContatos) {
                  if (contato.imageURL == file?.path) {
                    contatoToUpdate = contato;
                    break;
                  }
                }
                if (contatoToUpdate != null) {
                  _updateImage(contatoToUpdate, file);
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  void _runSearch(String enteredKeyboard) {
    List<Contato> results = [];
    if (enteredKeyboard.isEmpty) {
      results = contatos;
    } else {
      results = contatos
          .where((contato) =>
              contato.title
                  .toLowerCase()
                  .contains(enteredKeyboard.toLowerCase()) ||
              contato.telefone.contains(enteredKeyboard.toLowerCase()))
          .toList();
    }

    setState(() {
      myContatos = results;
    });
  }

  // En MyListContatoPageState:
  void _updateImage(Contato contato, File? newImage) {
    setState(() {
      int index = myContatos.indexOf(contato);
      if (index != -1) {
        myContatos[index].imageURL = newImage?.path;
      }
    });
  }

  void _removeContato(Contato contato) {
    setState(() {
      myContatos.remove(contato);
    });
  }

  void _addContato(Contato contato) {
    setState(() {
      myContatos.add(contato);
    });
  }

  void _updateContato(Contato updatedContato, File? newImage) {
    setState(() {
      int index = myContatos
          .indexWhere((contato) => contato.telefone == updatedContato.telefone);
      if (index != -1) {
        myContatos[index] = updatedContato;
        myContatos[index].imageURL = newImage?.path;
      }
    });
  }
}

class ListContatos extends StatelessWidget {
  final List<Contato> contatos;
  final Function(Contato) onRemove;
  final Function(Contato, File?) onUpdate;
  final Function(File?) onUpdateImage;

  ListContatos({
    required this.contatos,
    required this.onRemove,
    required this.onUpdate,
    required this.onUpdateImage,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: contatos.length,
        itemBuilder: (context, index) {
          Contato contato = contatos[index];
          return Dismissible(
            key: ObjectKey(contato),
            child: MyListTile(
              contato,
              onUpdate, // Se pasa la función onUpdate correctamente
              onUpdateImage, // Se pasa la función onUpdateImage correctamente
            ),
            onDismissed: (direction) {
              onRemove(contato);
            },
          );
        },
      ),
    );
  }
}
