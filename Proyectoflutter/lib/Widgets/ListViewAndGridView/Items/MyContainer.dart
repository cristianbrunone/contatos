import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      width: 200,
      height: 200,
      alignment: Alignment.center,
      margin: EdgeInsets.symmetric(vertical: 30),
      padding: EdgeInsets.only(top: 60),
      child: Text("Hola mundo"),
      decoration: BoxDecoration(
          color: Colors.green,
          border: Border.all(color: Colors.black, width: 10),
          shape: BoxShape.circle,
          boxShadow: [BoxShadow(color: Colors.black12, offset: Offset(4, 8))],
          gradient: LinearGradient(colors: [
            Colors.red,
            Colors.blue,
          ], begin: Alignment.topLeft, end: Alignment.bottomRight),
          image:
              DecorationImage(image: AssetImage("assets/images/perfil.png"))),
    );
  }
}
