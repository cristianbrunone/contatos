import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lista_contatos/Pages/Root_page.dart';
import '../../Model/Contato.dart';
import '../../Pages/AddContato.dart';
import '../../Pages/AddUserPage.dart';
import '../../Pages/MyListContatoPage.dart';
import '../../Pages/MyLogin.dart';
import '../auth_firebase.dart';

// Definir una instancia de AuthFirebase
final AuthFirebase myAuthInstance = AuthFirebase();

const String ROUTE_HOME = '/home';
const String ROUTE_LOGIN = '/login';
const String ROUTE_ADDUSER = '/add_user';
const String ROUTE_ADDCONTATO = '/add_contato';
const String ROUTE_LISTCONTATO = '/list_contato';

class MyRouters {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/login':
        return MaterialPageRoute(
          builder: (_) => MyLogin(
            auth: myAuthInstance,
            onSignIn: (status) {},
          ),
        );
      case '/home':
        return MaterialPageRoute(
          builder: (_) => StreamBuilder<User?>(
            stream: myAuthInstance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                // Muestra un indicador de carga mientras se verifica el estado de autenticación
                return CircularProgressIndicator();
              } else {
                // Verifica el estado de autenticación y emite el estado correspondiente
                final authStatus = snapshot.data != null
                    ? AuthStatus.signedIn
                    : AuthStatus.notSignedIn;
                return MyListContatoPage(
                  onSignIn: () {},
                  authStatus: authStatus,
                  authFirebase:
                      myAuthInstance, // Asegúrate de pasar authFirebase aquí
                );
              }
            },
          ),
        );
      case '/add_user':
        return MaterialPageRoute(
          builder: (_) => AddUserPage(auth: myAuthInstance),
        );
      case '/add_contato':
        return MaterialPageRoute<Contato>(
          builder: (context) => AddContato(),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => MyLogin(
            auth: myAuthInstance,
            onSignIn: (status) {},
          ),
        );
    }
  }
}
