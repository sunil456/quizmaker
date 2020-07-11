import 'package:flutter/material.dart';

Widget appBar(BuildContext context) {
  return new RichText(
    text: new TextSpan(
        style: new TextStyle(
          fontSize: 22,
        ),
        children: <TextSpan>[
          new TextSpan(
            text: 'Quiz',
            style: new TextStyle(
              fontWeight: FontWeight.w500,
              color: Colors.black54,
            ),
          ),
          new TextSpan(
            text: 'Maker',
            style:
                new TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
          ),
        ]),
  );
}

Widget signInAndSignUpAndCreateButton({BuildContext context, String label, buttonWidth}) {
  return new Container(
    width: buttonWidth != null ? buttonWidth : MediaQuery.of(context).size.width - 48,
    padding: EdgeInsets.symmetric(vertical: 16),
    alignment: Alignment.center,
    decoration: BoxDecoration(
      color: Colors.blue,
      borderRadius: BorderRadius.circular(30),
    ),
    child: new Text(
      label,
      style: new TextStyle(color: Colors.white, fontSize: 16),
    ),
  );
}
