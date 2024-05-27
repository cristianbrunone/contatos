import 'dart:io';
import 'package:flutter/material.dart';
import '../Model/Contato.dart';
import '../Pages/DetalhesContato.dart';

typedef VoidCallbackParam(Contato contato, File? image);

class MyListTile extends StatefulWidget {
  final Contato contato;
  final VoidCallbackParam onUpdate;
  final Function(File?) onUpdateImage; // Agregar la función onUpdateImage

  MyListTile(
      this.contato, this.onUpdate, this.onUpdateImage); // Ajustar constructor

  @override
  _MyListTileState createState() => _MyListTileState();
}

class _MyListTileState extends State<MyListTile> {
  late String? _imageURL;

  @override
  void initState() {
    super.initState();
    _imageURL = widget.contato.imageURL;
  }

  void _updateData(Contato updatedContato, File? newImage) {
    setState(() {
      _imageURL = newImage != null ? newImage.path : null;
    });
    widget.onUpdate(updatedContato, newImage);
  }

  String getInitials(String firstName, String lastName) {
    String firstInitial =
        firstName.isNotEmpty ? firstName[0].toUpperCase() : '';
    String lastInitial = lastName.isNotEmpty ? lastName[0].toUpperCase() : '';
    return firstInitial + lastInitial;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final updatedContato = await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetalhesContato(
              contato: widget.contato,
              onUpdate: _updateData,
              onUpdateImage:
                  widget.onUpdateImage, // Pasar la función onUpdateImage
            ),
          ),
        );
        if (updatedContato != null) {
          widget.onUpdate(updatedContato, null);
        }
      },
      child: ListTile(
        tileColor: Colors.transparent,
        selectedTileColor: Colors.red,
        splashColor: Colors.blue,
        title: Text(
          widget.contato.title,
          style: TextStyle(
            color: Color.fromARGB(255, 0, 0, 0),
            fontSize: 15,
          ),
        ),
        leading: CircleAvatar(
          backgroundColor: Colors.blue,
          backgroundImage: _imageURL != null ? NetworkImage(_imageURL!) : null,
          child: _imageURL == null
              ? Text(getInitials(widget.contato.title, widget.contato.subtitle))
              : null,
        ),
        subtitle: Text(
          widget.contato.telefone,
          style: TextStyle(
            color: Color.fromARGB(255, 70, 70, 70),
          ),
        ),
        trailing: IconButton(
          icon: Icon(Icons.edit),
          onPressed: () async {
            final updatedContato = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetalhesContato(
                  contato: widget.contato,
                  onUpdate: _updateData,
                  onUpdateImage:
                      widget.onUpdateImage, // Pasar la función onUpdateImage
                ),
              ),
            );
            if (updatedContato != null) {
              widget.onUpdate(updatedContato, null);
            }
          },
        ),
      ),
    );
  }
}
