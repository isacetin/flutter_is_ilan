import 'package:flutter/material.dart';
class CustomCardWidget extends StatelessWidget {
  Icon leading;
  Text title;
  VoidCallback onpress = () {};

  CustomCardWidget({this.leading, this.title, this.onpress});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: onpress,
        leading: leading,
        title: title,
        trailing: Icon(Icons.arrow_forward_ios_rounded),
      ),
    );
  }
}
