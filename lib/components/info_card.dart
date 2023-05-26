import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InfoCard extends StatelessWidget {
  InfoCard(
      {Key? key,
      required this.name,
      required this.indexNo,
      required this.image})
      : super(key: key);

  String name;
  String indexNo;
  String image;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.white24,
        backgroundImage: image == '1'
            ? NetworkImage(
                "https://cdn-icons-png.flaticon.com/512/3135/3135715.png")
            : NetworkImage("${image}"),
      ),
      title: Text(
        name,
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
      subtitle: Text(
        indexNo,
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
