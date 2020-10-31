import 'package:flutter/material.dart';

const TextStyle style =
    TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold);

class TitleWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Text(
            'SIVISOFT',
            style: style,
          ),
          Divider(
            height: 30,
          ),
          Text(
            'Currency Converter',
            style: style,
          )
        ],
      ),
    );
  }
}
