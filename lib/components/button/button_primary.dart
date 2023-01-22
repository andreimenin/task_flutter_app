import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ButtonPrimary extends StatefulWidget {
  final String text;
  Function onPressed;
  bool isEnable;
  ButtonPrimary(
      {super.key,
      required this.text,
      required this.onPressed,
      required this.isEnable});

  ButtonPrimaryState createState() => ButtonPrimaryState();
}

class ButtonPrimaryState extends State<ButtonPrimary> {
  Widget build(BuildContext context) {
    return _body();
  }

  _body() {
    return SizedBox(
        height: 40,
        width: MediaQuery.of(context).size.width,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: widget.isEnable ? Colors.blueGrey : Colors.grey,
            foregroundColor: Colors.white,
            elevation: 0.0,
          ),
          onPressed: widget.isEnable
              ? () {
                  widget.onPressed();
                }
              : () {},
          child: Text(widget.text),
        ));
  }
}
