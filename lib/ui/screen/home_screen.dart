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
  _MyHomePageState createState() =>
      _MyHomePageState(); // ignore: undefined_method
}

class _MyHomePageState extends State<MyHomePage> {
  List<Topic> topics = [];

  @override
  void initState() {
    super.initState();
    QiitaApi api = QiitaApiImpl(); // ignore: undefined_method
    QiitaRepositoryImpl repo =
        QiitaRepositoryImpl(api); // ignore: undefined_method
    repo.findTopic().then((topic) {
      setState(() => topics = topic);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // ignore: undefined_method
          title: Text(widget.title), // ignore: undefined_method
        ),
        body: ListView(
            // ignore: undefined_method
            children: topics.map((Topic topic) {
          return MyListItem(
            // ignore: undefined_method
            topic: topic,
          );
        }).toList()));
  }
}

class MyListItem extends StatefulWidget {
  MyListItem({Key key, @required this.topic}) : super(key: key);

  final Topic topic;

  @override
  _MyListItem createState() => _MyListItem(); // ignore: undefined_method
}

class _MyListItem extends State<MyListItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: (widget.topic.user.imageUrl != null)
              ? NetworkImage(widget.topic.user.imageUrl)
              : null,
        ),
        trailing: Row(
          children: <Widget>[
            Icon(
              Icons.favorite,
              color: Colors.pinkAccent,
            ),
            Text(
              widget.topic.likesCount.toString(),
              style: TextStyle(
                color: Colors.pinkAccent,
              ),
            )
          ],
        ),
        isThreeLine: true,
        title: Text(
          widget.topic.title,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
        subtitle: Text(
          widget.topic.user.id,
          maxLines: 3,
        ),
        onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) => DetailScreen(
                      topic: widget.topic,
                    ),
              ),
            ),
      ),
    );
  }
}
