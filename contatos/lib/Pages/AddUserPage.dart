import 'package:flutter/material.dart';
import '../classes/auth_firebase.dart';

class AddUserPage extends StatefulWidget {
  const AddUserPage({Key? key, required this.auth}) : super(key: key);
  final AuthFirebase auth;

  @override
  _AddUserPageState createState() => _AddUserPageState();
}

class _AddUserPageState extends State<AddUserPage> {
  GlobalKey<FormState> formKey = GlobalKey();
  var _emailController = TextEditingController();
  var _senhaController = TextEditingController();
  var repeatpasswordCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Adicionar Usuário'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                    labelText: "E-mail",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50.0))),
                validator: (value) {
                  String pattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
                  RegExp regExp = new RegExp(pattern);
                  if (value?.isEmpty ?? true) {
                    return "O E-mail é necessário";
                  } else if (!regExp.hasMatch(value.toString())) {
                    return "O E-mail é inválido";
                  }
                  return null;
                },
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _senhaController,
                decoration: InputDecoration(
                    labelText: "Senha",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50.0))),
                validator: (value) {
                  if (value!.length < 6) {
                    return "A senha deve ter pelo menos 6 caracteres";
                  }
                  return null;
                },
                obscureText: true,
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: repeatpasswordCtrl,
                decoration: InputDecoration(
                    labelText: "Repetir Senha",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50.0))),
                validator: (value) {
                  if (value != _senhaController.text) {
                    return "As senhas não são iguais";
                  }
                  return null;
                },
                obscureText: true,
              ),
              SizedBox(height: 24),
              ElevatedButton(
                onPressed: () => save(),
                child: Text(
                  "Cadastrar",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
              )
            ],
          ),
        ),
      ),
    );
  }

  save() async {
    if (formKey.currentState!.validate()) {
      String email = _emailController.text;
      String password = _senhaController.text;
      try {
        await widget.auth.createUser(email, password);
        print("Usuário registrado com sucesso!");
        formKey.currentState!.reset();
      } catch (error) {
        // Manejar el error aquí
        print("Error al registrar usuario: $error");
        // Mostrar un mensaje de error al usuario
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Error al registrar usuario: $error'),
        ));
      }
    }
  }
}
