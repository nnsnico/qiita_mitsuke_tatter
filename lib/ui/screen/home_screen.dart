import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:qiita_mitsuke_tatter/ui/screen/detail_screen.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text(widget.title),
        ),
        body: new ListView(
          children: <Widget>[
            new MyListItem(
              title: 'ほげほげをふがふがする方法',
              subTitle: 'Scala',
              favCounts: 12,
            ),
            new MyListItem(
              title: 'ふがふがをぴよぴよにしてみた',
              subTitle: 'VisualStudio',
              favCounts: 243,
            )
          ],
        ));
  }
}

class MyListItem extends StatefulWidget {
  MyListItem(
      {Key key,
      @required this.title,
      @required this.subTitle,
      @required this.favCounts})
      : super(key: key);

  final String title, subTitle;
  final int favCounts;

  @override
  _MyListItem createState() => new _MyListItem();
}

class _MyListItem extends State<MyListItem> {
  @override
  Widget build(BuildContext context) {
    return new Container(
      child: new ListTile(
        leading: new CircleAvatar(
          backgroundColor: Colors.lightGreen,
          child: new Icon(
            Icons.account_circle,
            color: Colors.white,
            size: 32.0,
          ),
        ),
        trailing: new Row(
          children: <Widget>[
            new Icon(
              Icons.favorite,
              color: Colors.pinkAccent,
            ),
            new Text(
              widget.favCounts.toString(),
              style: const TextStyle(
                color: Colors.pinkAccent,
              ),
            )
          ],
        ),
        isThreeLine: true,
        title: new Text(widget.title),
        subtitle: new Text(widget.subTitle),
        onTap: () => Navigator.of(context).push(
              new MaterialPageRoute(
                builder: (BuildContext context) =>
                    new DetailScreen(title: widget.title),
              ),
            ),
      ),
    );
  }
}
