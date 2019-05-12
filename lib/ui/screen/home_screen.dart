import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import 'package:qiita_mitsuke_tatter/api/qiita_api.dart';
import 'package:qiita_mitsuke_tatter/api/qiita_api_impl.dart';
import 'package:qiita_mitsuke_tatter/model/topic.dart';
import 'package:qiita_mitsuke_tatter/repository/qiita_repository.dart';
import 'package:qiita_mitsuke_tatter/repository/qiita_repository_impl.dart';
import 'package:qiita_mitsuke_tatter/ui/screen/detail_screen.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({
    Key key,
    @required this.title,
  }) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Topic> topics = [];

  @override
  void initState() {
    super.initState();
    // TODO: もしかしたらDIできるか??
    http.Client client = http.Client();
    QiitaApi api = QiitaApiImpl(httpClient: client);
    QiitaRepository repo = QiitaRepositoryImpl(api);
    repo.findTopic().then((topic) {
      setState(() => topics = topic);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: ListView(
            children: topics.map((Topic topic) {
          return MyListItem(
            topic: topic,
          );
        }).toList()));
  }
}

class MyListItem extends StatefulWidget {
  MyListItem({Key key, @required this.topic}) : super(key: key);

  final Topic topic;

  @override
  _MyListItem createState() => _MyListItem();
}

class _MyListItem extends State<MyListItem> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: (widget.topic.user.imageUrl != null)
            ? NetworkImage(widget.topic.user.imageUrl)
            : null,
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(
            Icons.favorite,
            color: Colors.pinkAccent,
          ),
          Text(
            widget.topic.likesCount.toString(),
            style: TextStyle(color: Colors.pinkAccent),
          )
        ],
      ),
//      isThreeLine: true,
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
    );
  }
}
