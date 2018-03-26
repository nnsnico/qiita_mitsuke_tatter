import 'package:flutter/material.dart';
import 'package:qiita_mitsuke_tatter/model/topic.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:url_launcher/url_launcher.dart' as Browser;

import 'package:qiita_mitsuke_tatter/theme.dart';

class DetailScreen extends StatefulWidget {
  DetailScreen({Key key, this.topic}) : super(key: key);

  final Topic topic;

  @override
  _DetailScreen createState() => _DetailScreen();
}

// ガバッと開いているときのAppBarのサイズ
const double _kAppBarHeight = 200.0;

class _DetailScreen extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: themeData,
      child: Scaffold(
        body: CustomScrollView(
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

  return SliverAppBar(
    pinned: true,
    expandedHeight: _kAppBarHeight,
    flexibleSpace: new LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final Size size = constraints.biggest;
        final double appBarHeight = size.height - statusBarHeight;
        final double t =
            (appBarHeight - kToolbarHeight) / (_kAppBarHeight - kToolbarHeight);

        return Stack(
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
  final TextStyle textStyle = themeData.textTheme.title.merge(TextStyle(
    fontSize: 18.0,
    color: Colors.white,
  ));
  final Curve _textOpacity = Interval(0.2, 1.0, curve: Curves.easeInOut);
  final Size screenSize = MediaQuery.of(context).size;
  final double titleWidth =
      screenSize.width - kToolbarHeight - NavigationToolbar.kMiddleSpacing;
  final iOS = Theme.of(context).platform == TargetPlatform.iOS;

  return Positioned.fromRect(
      rect: Rect.fromLTWH(
          iOS
              ? kToolbarHeight - NavigationToolbar.kMiddleSpacing
              : kToolbarHeight,
          statusBarHeight,
          titleWidth,
          kToolbarHeight),
      child: Container(
        alignment: iOS ? Alignment.center : Alignment.centerLeft,
        child: Opacity(
          // 上にスクロールすると徐々に現れる
          opacity: _textOpacity.transform(1 - t.clamp(0.0, 1.0)),
          child: Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: textStyle,
          ),
        ),
      ));
}

Widget buildHeader(Topic topic, double t) {
  final Curve _textOpacity = const Interval(0.7, 1.0, curve: Curves.easeInOut);

  return Opacity(
    // 上にスクロールすると徐々に消えていく
    opacity: _textOpacity.transform(t.clamp(0.0, 1.0)),
    child: Column(
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

  return SliverPadding(
    padding: EdgeInsets.all(16.0),
    sliver: SliverList(
      delegate: SliverChildListDelegate(
        [
          Container(
            constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height -
                    MediaQuery.of(context).padding.top -
                    kToolbarHeight -
                    50
            ),
            margin: EdgeInsets.only(top: 16.0),
            child: MarkdownBody(
              data: topic.body,
              onTapLink: (url) => launchInBrowser(url),
            ),
          ),
        ],
      ),
    ),
  );
}

launchInBrowser(String url) async {
  if (await Browser.canLaunch(url)) {
    await Browser.launch(url, forceSafariVC: true, forceWebView: true);
  }
}

Widget buildTitle(String title) {
  return Container(
    child: Text(
      title,
      style: TextStyle(
        fontSize: 20.0,
        color: Colors.white,
      ),
    ),
    padding: EdgeInsets.all(16.0),
  );
}

Widget buildUserContent(String imageUrl, String name) {
  return Row(
    children: <Widget>[
      Padding(
        padding: EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 8.0),
        child: CircleAvatar(
          backgroundImage: imageUrl != null ? NetworkImage(imageUrl) : null,
        ),
      ),
      Text(
        name,
        style: TextStyle(
          fontSize: 16.0,
          color: Colors.white,
        ),
      ),
    ],
  );
}
