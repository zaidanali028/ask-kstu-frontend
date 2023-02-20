import 'package:first_app/feature/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {super.key,
      required this.onPress,
      required this.iconData,
      required this.title});
  final VoidCallback onPress;
  final String title;
  final IconData iconData;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Container(
        padding: const EdgeInsets.only(right: 10),
        width: double.infinity,
        height: 60.0,
        decoration: BoxDecoration(
            color: kblue, borderRadius: BorderRadius.circular(20)),
        child: Row(
          children: [
            const Spacer(),
            Text(
              title,
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
            ),
            const Spacer(),
            Icon(
              iconData,
              color: Colors.white,
            )
          ],
        ),
      ),
    );
  }
}
