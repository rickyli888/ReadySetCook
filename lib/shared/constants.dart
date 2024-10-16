import 'package:flutter/material.dart';
const COLOR_BLUE = Colors.blue;
const COLOR_BLACK = Colors.black;
const COLOR_WHITE = Colors.white;
const COLOR_GREY = Colors.grey;

const textInputDecoration = InputDecoration(
  fillColor: Colors.white,
  filled: true,
  contentPadding: EdgeInsets.all(12.0),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.white, width: 2.0),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.green, width: 2.0),
  ),
);

class BigLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AssetImage logo = AssetImage('assets/images/readysetcooklogo.png');
    Image image = Image(
      image: logo,
      width: 500,
      height: 255,
    );
    return Container(
      child: image,
    );
  }
}

class SmallLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AssetImage logo = AssetImage('assets/images/readysetcooklogo.png');
    Image image = Image(
      image: logo,
      width: 20,
      height: 20,
    );
    return Container(
      child: image,
    );
  }
}

//Info for fruit, shelflife unit is days.
