import 'package:flutter/material.dart';

class BaseBtn extends StatelessWidget {
  const BaseBtn({
    Key? key,
    required this.text,
    this.onPressed,
  }) : super(key: key);

  final String text;

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
      minWidth: 1,
      height: 26,
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(text, style: TextStyle(fontSize: 14, color: Colors.white)),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(
            const Color(0xFF1C88E5),
          ),
          padding: MaterialStateProperty.all(
            EdgeInsets.symmetric(horizontal: 13),
          ),
          textStyle: MaterialStateProperty.all(
            TextStyle(
              color: Colors.white,
            ),
          ),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ),
    );
  }
}
