import 'package:flutter/material.dart';

class MyFloatingButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return FloatingActionButton.extended(
      onPressed: () {
        print("FloatingActionButton");
      },
      icon: Icon(Icons.add, size: 30),
      label: Text("Agregar Usuario", style: TextStyle(color: Colors.black)),
      backgroundColor: Colors.yellow,
      elevation: 20,
      tooltip: "Agregar usuario",
    );
  }
}
