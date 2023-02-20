import 'package:first_app/feature/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween ,
              children: [
                IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.dashboard_rounded,
                      color: kblue,
                    )),
                IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.search_rounded,
                    )),
              ],
            );
  }
}