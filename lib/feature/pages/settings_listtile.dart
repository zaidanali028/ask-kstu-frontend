import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SettingsListTile extends StatelessWidget {
  SettingsListTile(
      {super.key,
      required this.title,
      required this.trailingIcon,
      required this.leadingIcon,
      this.isLast = false});
  String title;
  IconData trailingIcon;
  IconData leadingIcon;
  bool isLast;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text(
            title,
            style: TextStyle(
                color: Colors.black38,
                fontWeight: FontWeight.w300,
                fontSize: 20),
          ),
          trailing: IconButton(
              onPressed: () {},
              icon: Icon(
                trailingIcon,
                size: 20,
                color: Colors.grey,
              )),
          leading: Icon(
            leadingIcon,
            size: 20,
            color: Colors.grey,
          ),
        ),
        isLast
            ? Text('')
            : Divider(
                color: Colors.grey,
              )
      ],
    );
  }
}
