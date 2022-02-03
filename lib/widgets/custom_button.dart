import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final Color backgroundColor;
  final Color titleColor;
  final Function onTap;
  const CustomButton({
    Key? key,
    required this.title,
    required this.backgroundColor,
    required this.titleColor,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap(),
      child: Text(
        title,
        style: TextStyle(color: titleColor),
      ),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(
          backgroundColor,
        ),
      ),
    );
  }
}
