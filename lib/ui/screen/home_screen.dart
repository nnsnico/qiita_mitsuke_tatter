import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:qiita_mitsuke_tatter/api/qiita_api.dart';
import 'package:qiita_mitsuke_tatter/api/qiita_api_impl.dart';
import 'package:qiita_mitsuke_tatter/model/topic.dart';
import 'package:qiita_mitsuke_tatter/model/user.dart';
import 'package:qiita_mitsuke_tatter/repository/qiita_repository_impl.dart';
import 'package:qiita_mitsuke_tatter/ui/screen/detail_screen.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({
    Key key,
    @required this.title,
  })
      : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Topic> topics = [];

  @override
  void initState() {
    super.initState();
    QiitaApi api = new QiitaApiImpl();
    QiitaRepositoryImpl repo = new QiitaRepositoryImpl(api);
    repo.findTopic().then((topic) {
      setState(() => topics = topic);
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text(widget.title),
        ),
        body: new ListView(
            children: topics.map((Topic topic) {
          return new MyListItem(
            topic: topic,
          );
        }).toList()));
  }
}

class MyListItem extends StatefulWidget {
  MyListItem({
    Key key,
    @required this.topic
  })
      : super(key: key);

  final Topic topic;

  @override
  _MyListItem createState() => new _MyListItem();
}

class _MyListItem extends State<MyListItem> {
  @override
  Widget build(BuildContext context) {
    return new Container(
      child: new ListTile(
        leading: new CircleAvatar(
          backgroundImage: (widget.topic.user.imageUrl != null)
              ? new NetworkImage(widget.topic.user.imageUrl)
              : null,
        ),
        trailing: new Row(
          children: <Widget>[
            new Icon(
              Icons.favorite,
              color: Colors.pinkAccent,
            ),
            new Text(
              widget.topic.likesCount.toString(),
              style: const TextStyle(
                color: Colors.pinkAccent,
              ),
            )
          ],
        ),
        isThreeLine: true,
        title: new Text(
          widget.topic.title,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
        subtitle: new Text(
          widget.topic.user.id,
          maxLines: 3,
        ),
        onTap: () => Navigator.of(context).push(
              new MaterialPageRoute(
                builder: (BuildContext context) => new DetailScreen(
                      topic: widget.topic,
                    ),
              ),
            ),
      ),
    );
  }
}
