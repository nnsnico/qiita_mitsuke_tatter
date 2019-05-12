import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:qiita_mitsuke_tatter/model/topic.dart';
import 'package:qiita_mitsuke_tatter/ui/container/detail_screen.dart';

class TopicListItem extends StatefulWidget {
  final Topic topic;

  TopicListItem({Key key, @required this.topic}) : super(key: key);

  @override
  _TopicListItem createState() => _TopicListItem();
}

class _TopicListItem extends State<TopicListItem> {
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
