import 'package:betviewapp/colors.dart';
import 'package:betviewapp/strings.dart';
import 'package:flutter/material.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  final Widget buildSearchBar;
  const CustomAppbar({super.key, required this.buildSearchBar});

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: preferredSize,
      child: AppBar(
        toolbarHeight: preferredSize.height,
        backgroundColor: mainAppColor,
        elevation: 6.0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              appTitle,
              style: const TextStyle(fontSize: 20.0),
            ),
            Row(children: [
              Padding(
                  padding: const EdgeInsets.only(right: 20.0),
                  child: buildSearchBar),
            ])
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(90.0);
}
