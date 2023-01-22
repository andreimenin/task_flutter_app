import 'package:flutter/material.dart';

class ButtonIconCircle extends StatefulWidget {
  final Icon icon;
  Function onPressed;
  ButtonIconCircle({super.key, required this.icon, required this.onPressed});

  ButtonIconCircleState createState() => ButtonIconCircleState();
}

class ButtonIconCircleState extends State<ButtonIconCircle> {
  @override
  Widget build(BuildContext context) {
    return _body();
  }

  _body() {
    return MaterialButton(
      onPressed: () => widget.onPressed(),
      color: Colors.transparent,
      textColor: Colors.white,
      child: widget.icon,
      padding: EdgeInsets.all(0),
      shape: CircleBorder(),
    );
  }
}
