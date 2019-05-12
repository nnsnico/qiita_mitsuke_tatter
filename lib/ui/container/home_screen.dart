import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:qiita_mitsuke_tatter/blocs/qiita_bloc.dart';
import 'package:qiita_mitsuke_tatter/blocs/qiita_event.dart';
import 'package:qiita_mitsuke_tatter/blocs/qiita_state.dart';
import 'package:qiita_mitsuke_tatter/model/topic.dart';
import 'package:qiita_mitsuke_tatter/repository/qiita_repository.dart';
import 'package:qiita_mitsuke_tatter/ui/topic_list_item.dart';

class MyHomePage extends StatefulWidget {
  final String title;
  final QiitaRepository repository;

  MyHomePage({
    Key key,
    @required this.title,
    @required this.repository,
  }) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  QiitaBloc _qiitaBloc;

  @override
  void initState() {
    super.initState();
    _qiitaBloc = QiitaBloc(repository: widget.repository);
    _qiitaBloc.dispatch(FindTopic());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        child: BlocBuilder(
          bloc: _qiitaBloc,
          builder: (_, QiitaState state) {
            if (state is QiitaLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is QiitaSuccess) {
              return ListView(
                children: state.topics
                    .map((Topic topic) => TopicListItem(topic: topic))
                    .toList(),
              );
            } else if (state is QiitaError) {
              return Center(
                child: Text("エラーです!!"),
              );
            }
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _qiitaBloc.dispose();
    super.dispose();
  }
}
