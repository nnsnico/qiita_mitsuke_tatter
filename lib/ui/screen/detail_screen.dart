import 'package:flutter/material.dart';
import 'package:qiita_mitsuke_tatter/model/topic.dart';

import 'package:qiita_mitsuke_tatter/theme.dart';

class DetailScreen extends StatefulWidget {
  DetailScreen({Key key, this.topic}) : super(key: key);

  final Topic topic;

  @override
  _DetailScreen createState() => new _DetailScreen();
}
// ガバッと開いているときのAppBarのサイズ
const double _kAppBarHeight = 200.0;

class _DetailScreen extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return new Theme(
      data: themeData,
      child: new Scaffold(
        body: new CustomScrollView(
          slivers: <Widget>[
            buildAppBar(widget.topic, context),
            buildBody(widget.topic, context),
          ],
        ),
      ),
    );
  }
}

Widget buildAppBar(Topic topic, BuildContext context) {
  final double statusBarHeight = MediaQuery.of(context).padding.top;

  return new SliverAppBar(
    pinned: true,
    expandedHeight: _kAppBarHeight,
    flexibleSpace: new LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final Size size = constraints.biggest;
        final double appBarHeight = size.height - statusBarHeight;
        final double t =
            (appBarHeight - kToolbarHeight) / (_kAppBarHeight - kToolbarHeight);

        return new Stack(
          children: <Widget>[
            buildHeader(topic, t),
            buildAppBarTitle(statusBarHeight, t, context, topic.title),
          ],
        );
      },
    ),
  );
}

Widget buildAppBarTitle(
    double statusBarHeight, double t, BuildContext context, String title) {
  final TextStyle textStyle = themeData.textTheme.title.merge(new TextStyle(
    fontSize: 18.0,
    color: Colors.white,
  ));
  final Curve _textOpacity = const Interval(0.4, 1.0, curve: Curves.easeInOut);
  final Size screenSize = MediaQuery.of(context).size;
  final double titleWidth =
      screenSize.width - kToolbarHeight - NavigationToolbar.kMiddleSpacing;
  final iOS = Theme.of(context).platform == TargetPlatform.iOS;

  return new Positioned.fromRect(
      rect: new Rect.fromLTWH(
          iOS
              ? kToolbarHeight - NavigationToolbar.kMiddleSpacing
              : kToolbarHeight,
          statusBarHeight,
          titleWidth,
          kToolbarHeight),
      child: new Container(
        alignment: iOS ? Alignment.center : Alignment.centerLeft,
        child: new Opacity(
          // 上にスクロールすると徐々に現れる
          opacity: _textOpacity.transform(1 - t.clamp(0.0, 1.0)),
          child: new Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: textStyle,
          ),
        ),
      ));
}

Widget buildHeader(Topic topic, double t) {
  final Curve _textOpacity = const Interval(0.4, 1.0, curve: Curves.easeInOut);

  return new Opacity(
    // 上にスクロールすると徐々に消えていく
    opacity: _textOpacity.transform(t.clamp(0.0, 1.0)),
    child: new Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        buildTitle(
          topic.title,
        ),
        buildUserContent(
          topic.user.imageUrl,
          topic.user.id,
        )
      ],
    ),
  );
}

Widget buildBody(Topic topic, BuildContext context) {
  final detailStyle = themeData.textTheme.body1;

  return new SliverPadding(
    padding: new EdgeInsets.all(16.0),
    sliver: new SliverList(
      delegate: new SliverChildListDelegate(
        [
          new Container(
            constraints: new BoxConstraints(
                minHeight: MediaQuery.of(context).size.height -
                    MediaQuery.of(context).padding.top -
                    kToolbarHeight),
            margin: const EdgeInsets.only(top: 16.0),
            child: new Text(
              topic.body,
              style: detailStyle,
            ),
          ),
        ],
      ),
    ),
  );
}

Widget buildTitle(String title) {
  return new Container(
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

Widget buildUserContent(String imageUrl, String name) {
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
