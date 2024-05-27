import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../Model/Contato.dart';

typedef VoidCallbackParam(Contato contato, File? image);

class DetalhesContato extends StatefulWidget {
  final Contato contato;
  final VoidCallbackParam onUpdate; // Ajustar el tipo de función onUpdate
  final Function(File?) onUpdateImage;

  DetalhesContato({
    required this.contato,
    required this.onUpdate,
    required this.onUpdateImage,
  });

  @override
  _DetalhesContatoState createState() => _DetalhesContatoState();
}

class _DetalhesContatoState extends State<DetalhesContato> {
  late TextEditingController _titleController;
  late TextEditingController _subtitleController;
  late TextEditingController _phoneController;
  late TextEditingController _cepController;
  late TextEditingController _emailController;
  File? _selectedImage;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.contato.title);
    _subtitleController = TextEditingController(text: widget.contato.subtitle);
    _phoneController = TextEditingController(text: widget.contato.telefone);
    _cepController = TextEditingController(text: widget.contato.cep);
    _emailController = TextEditingController(text: widget.contato.email);
    _selectedImage = null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 1, 42, 187),
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          'Detalhes do Contato',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _saveForm,
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: _selectImageFromGallery,
                  child: CircleAvatar(
                    radius: 60,
                    backgroundImage: _selectedImage != null
                        ? FileImage(_selectedImage!)
                        : null,
                    child: _selectedImage == null
                        ? Icon(Icons.add_photo_alternate, size: 40)
                        : null,
                  ),
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: _titleController,
                  decoration: InputDecoration(
                    labelText: 'Nome',
                    prefixIcon: Icon(Icons.person, color: Colors.blue),
                  ),
                ),
                TextFormField(
                  controller: _subtitleController,
                  decoration: InputDecoration(
                    labelText: 'Sobrenome',
                    prefixIcon: Icon(Icons.person, color: Colors.blue),
                  ),
                ),
                TextFormField(
                  controller: _phoneController,
                  decoration: InputDecoration(
                    labelText: 'Telefone',
                    prefixIcon: Icon(Icons.phone, color: Colors.blue),
                  ),
                ),
                TextFormField(
                  controller: _cepController,
                  decoration: InputDecoration(
                    labelText: 'CEP',
                    prefixIcon: Icon(Icons.location_on, color: Colors.blue),
                  ),
                ),
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'E-mail',
                    prefixIcon: Icon(Icons.email, color: Colors.blue),
                  ),
                ),
                SizedBox(height: 100),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: Icon(Icons.favorite),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.share),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }

  void _saveForm() {
    final form = _formKey.currentState;
    if (form != null && form.validate()) {
      form.save();

      // Obtener los valores actualizados de los campos
      String nome = _titleController.text;
      String sobrenome = _subtitleController.text;
      String telefone = _phoneController.text;
      String cep = _cepController.text;
      String email = _emailController.text;

      // Crear un nuevo objeto Contato con los valores actualizados
      Contato contatoAtualizado = Contato(
        title: nome,
        subtitle: sobrenome,
        telefone: telefone,
        cep: cep,
        email: email,
        imageURL: _selectedImage?.path, // Añadir la ruta de la imagen
      );

      // Llamar a la función de actualización pasada como argumento
      widget.onUpdate(contatoAtualizado, _selectedImage); // Pasar la imagen

      // Volver a MyListContatoPage
      Navigator.pop(context);
    }
  }

  void _selectImageFromGallery() async {
    final pickedImage = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxHeight: 800.0,
      maxWidth: 700.0,
    );

    if (pickedImage != null) {
      setState(() {
        _selectedImage = File(pickedImage.path);
      });
      widget.onUpdateImage(_selectedImage);
    }
  }
}
