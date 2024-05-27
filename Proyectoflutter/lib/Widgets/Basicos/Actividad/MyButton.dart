import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return myOutlinedButton();
  }

  myElevateButton() {
    return ElevatedButton.icon(
      icon: Icon(Icons.save, color: Colors.red),
      label: Text("Guardar"),
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.black,
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        elevation: 20,
      ),
      onLongPress: () {
        print("ElevatedButton");
      },
      onPressed: () {
        print("ElevatedButton");
      },
    );
  }

  myTextButton() {
    return TextButton(
        onPressed: () {
          print("TextButton");
        },
        child: Text("Guardar"));
  }

  myOutlinedButton() {
    return OutlinedButton(
        style: OutlinedButton.styleFrom(
            side: BorderSide(color: Colors.black, width: 5),
            backgroundColor: Colors.white),
        onPressed: () {
          print("OutlineButton");
        },
        child: Text("Guardar"));
  }
}
