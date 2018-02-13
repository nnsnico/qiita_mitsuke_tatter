import 'package:flutter/material.dart';

class DetailScreen extends StatefulWidget {
  DetailScreen({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _DetailScreen createState() => new _DetailScreen();
}

class _DetailScreen extends State<DetailScreen> {

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
    );
  }
}