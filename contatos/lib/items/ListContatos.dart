import 'package:flutter/material.dart';
import '../../Model/Contato.dart';

class ListContatos extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ListContatosState();
}

class ListContatosState extends State<ListContatos> {
  List<Contato> myContatos = [];

  @override
  void initState() {
    super.initState();
    myContatos = contatos;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
