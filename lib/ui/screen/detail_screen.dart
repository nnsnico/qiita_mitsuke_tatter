import 'package:flutter/material.dart';
import 'package:qiita_mitsuke_tatter/model/topic.dart';

import 'package:qiita_mitsuke_tatter/theme.dart';

class DetailScreen extends StatefulWidget {
  DetailScreen({Key key, this.topic}) : super(key: key);

  final Topic topic;

  @override
  _DetailScreen createState() => new _DetailScreen();
}

class _DetailScreen extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return new Theme(
        data: themeData,
        child: new Scaffold(
          body: new CustomScrollView(
            slivers: [
              new SliverAppBar(
                pinned: false,
                expandedHeight: 200.0,
                flexibleSpace: new LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                    return new Container(
                        alignment: Alignment.bottomLeft,
                        child: new Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            buildTitle(widget.topic.title),
                            buildHeaderContents(widget.topic.user.imageUrl,
                                widget.topic.user.id),
                          ],
                        ));
                  },
                ),
              ),
            ],
          ),
        ));
  }
}

Widget buildTitle(title) {
  return new Padding(
    child: new Text(
      title,
      style: new TextStyle(
        fontSize: 20.0,
        color: Colors.white,
      ),
    ),
    padding: new EdgeInsets.all(16.0),
  );
}

Widget buildHeaderContents(imageUrl, name) {
  return new Row(
    children: <Widget>[
      new Padding(
        padding: new EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 8.0),
        child: new CircleAvatar(
          backgroundImage: imageUrl != null ? new NetworkImage(imageUrl) : null,
        ),
      ),
      new Text(
        name,
        style: new TextStyle(
          fontSize: 16.0,
          color: Colors.white,
        ),
      ),
    ],
  );
}
