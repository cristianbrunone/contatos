import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:proyectoflutter/Common/MyKeys.dart';
import 'package:proyectoflutter/Widgets/ListViewAndGridView/Items/MyListTile.dart';
import 'package:proyectoflutter/model/Sound.dart';

class MyListView extends StatefulWidget {
  MyListView() : super(key: myListViewKey);
  @override
  State<StatefulWidget> createState() => MyListViewState();
}

class MyListViewState extends State<MyListView> {
  List<Sound> mySounds = [];

  @override
  void initState() {
    super.initState();
    mySounds = List.from(sounds);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: 270,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              //physics: NeverScrollableScrollPhysics,
              itemCount: sounds.length,
              itemBuilder: (context, index) {
                return CoverContainer(this.mySounds[index])
              },
            ),
          ),
          ListView.builder(itemBuilder: itemBuilder)
        ],
      )
    )


