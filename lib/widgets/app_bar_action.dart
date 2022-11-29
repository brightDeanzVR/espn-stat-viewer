import 'package:flutter/material.dart';

class AppBarAction extends StatefulWidget {
  final double margin;
  final IconData iconData;
  final double size;
  final Color color;
  final Function() onPressed;
  const AppBarAction(
      {super.key,
      this.margin = 8.0,
      required this.iconData,
      this.size = 25.0,
      this.color = Colors.white,
      required this.onPressed});

  @override
  State<AppBarAction> createState() => _AppBarActionState();
}

class _AppBarActionState extends State<AppBarAction> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(90)),
      child: Center(
        child: IconButton(
          icon: Icon(
            widget.iconData,
            color: widget.color,
          ),
          onPressed: widget.onPressed,
          iconSize: widget.size,
          splashColor: Colors.transparent,
          hoverColor: Colors.transparent,
          splashRadius: 0.1,
        ),
      ),
    );
  }
}
