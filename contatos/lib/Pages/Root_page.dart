import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lista_contatos/Pages/MyListContatoPage.dart';
import 'package:lista_contatos/Pages/MyLogin.dart';
import 'package:lista_contatos/classes/auth_firebase.dart';

import '../classes/Common/MyRouters.dart';

class RootPage extends StatefulWidget {
  RootPage({Key? key, required this.authFirebase}) : super(key: key);
  final AuthFirebase authFirebase;

  @override
  State<StatefulWidget> createState() => RootPageState();
}

enum AuthStatus {
  notSignedIn,
  signedIn,
}

class RootPageState extends State<RootPage> {
  AuthStatus authStatus = AuthStatus.notSignedIn;

  @override
  void initState() {
    super.initState();
    _checkAuthStatus();
  }

  void _checkAuthStatus() async {
    var currentUser = await widget.authFirebase.currentUser();

    if (currentUser != null) {
      setState(() {
        authStatus = AuthStatus.signedIn;
      });
    } else {
      setState(() {
        authStatus = AuthStatus.notSignedIn;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    switch (authStatus) {
      case AuthStatus.notSignedIn:
        return MyLogin(
          auth: widget.authFirebase,
          onSignIn: (status) => updateAuthStatus(status),
        );
      case AuthStatus.signedIn:
        return MyListContatoPage(
          onSignIn: () {},
          authStatus: AuthStatus.signedIn,
          authFirebase: myAuthInstance, // Asegúrate de pasar authFirebase aquí
        );

      default:
        return MyLogin(
          auth: widget.authFirebase,
          onSignIn: (status) => updateAuthStatus(status),
        );
    }
  }

  void updateAuthStatus(AuthStatus auth) {
    setState(() {
      authStatus = auth;
    });
  }
}
