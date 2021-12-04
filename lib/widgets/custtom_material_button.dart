import 'package:flutter/material.dart';

class CustomMaterialButton extends StatelessWidget {
  final String? keyName;
  final String? title;
  final VoidCallback? onPressed;
  CustomMaterialButton({
    this.keyName,
    this.title,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      key: Key(keyName!),
      child: Text(title!, style: TextStyle(fontSize: 20.0)),
      onPressed: onPressed,
    );
  }
}
