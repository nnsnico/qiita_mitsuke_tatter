import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:qiita_mitsuke_tatter/api/qiita_api.dart';
import 'package:qiita_mitsuke_tatter/api/qiita_api_impl.dart';
import 'package:qiita_mitsuke_tatter/model/topic.dart';
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
      topics.addAll(topic);
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
            title: topic.title,
            subTitle: topic.user.id,
            imageUrl: topic.user.imageUrl,
            favCounts: topic.likesCount,
          );
        }).toList()));
  }
}

class MyListItem extends StatefulWidget {
  MyListItem(
      {Key key,
      @required this.title,
      @required this.subTitle,
      @required this.imageUrl,
      @required this.favCounts})
      : super(key: key);

  final String title, subTitle, imageUrl;
  final int favCounts;

  @override
  _MyListItem createState() => new _MyListItem();
}

class _MyListItem extends State<MyListItem> {
  @override
  Widget build(BuildContext context) {
    return new Container(
      child: new ListTile(
        leading: widget.imageUrl != null
              ? new Image.network(widget.imageUrl)
              : new CircleAvatar(
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
        title: new Text(
          widget.title,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
        subtitle: new Text(
          widget.subTitle,
          maxLines: 3,
        ),
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
