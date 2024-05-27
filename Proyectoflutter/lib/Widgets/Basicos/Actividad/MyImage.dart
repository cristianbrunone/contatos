import 'package:flutter/material.dart';

class MyImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Image(
      image: AssetImage("assets/images/perfil.png"),
      width: 400,
      height: 400,
      fit: BoxFit.fill,
    );
  }
}
