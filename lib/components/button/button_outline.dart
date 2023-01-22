import 'package:flutter/material.dart';

class ButtonOutline extends StatefulWidget {
  final String text;
  Function onPressed;
  bool isEnable;
  ButtonOutline(
      {super.key,
      required this.text,
      required this.onPressed,
      required this.isEnable});

  ButtonOutlineState createState() => ButtonOutlineState();
}

class ButtonOutlineState extends State<ButtonOutline> {
  @override
  Widget build(BuildContext context) {
    return _body();
  }

  _body() {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 40,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
                side: BorderSide(
                    color: Colors.blueGrey, width: 1, style: BorderStyle.solid),
                borderRadius: BorderRadius.circular(4)),
            elevation: 0.0,
            backgroundColor: Colors.white,
            foregroundColor: Colors.blueGrey,
            textStyle: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          onPressed: () => widget.onPressed(),
          child: Text(widget.text)),
    );
  }
}
