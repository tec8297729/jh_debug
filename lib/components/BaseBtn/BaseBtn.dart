import 'package:flutter/material.dart';

class BaseBtn extends StatelessWidget {
  const BaseBtn({
    Key key,
    @required this.text,
    this.onPressed,
  }) : super(key: key);

  final String text;

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
      minWidth: 1,
      height: 26,
      child: RaisedButton(
        onPressed: onPressed,
        textColor: Colors.white,
        color: Color(0xFF1C88E5),
        padding: EdgeInsets.symmetric(horizontal: 13),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(text, style: TextStyle(fontSize: 14)),
      ),
    );
  }
}
