import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final String title;
  final IconData icon;
  ButtonWidget({@required this.icon, @required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          color: Colors.white,
        ),
        Text(
          title,
          style: TextStyle(color: Colors.white),
        )
      ],
    );
  }
}
