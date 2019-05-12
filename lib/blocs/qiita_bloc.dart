import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:qiita_mitsuke_tatter/blocs/qiita_event.dart';
import 'package:qiita_mitsuke_tatter/blocs/qiita_state.dart';
import 'package:qiita_mitsuke_tatter/model/topic.dart';
import 'package:qiita_mitsuke_tatter/repository/qiita_repository.dart';

class QiitaBloc extends Bloc<QiitaEvent, QiitaState> {
  final QiitaRepository repository;

  QiitaBloc({@required this.repository}) : assert(repository != null);

  @override
  QiitaState get initialState => QiitaEmpty();

  @override
  Stream<QiitaState> mapEventToState(QiitaEvent event) async* {
    if (event is FindTopic) {
      yield QiitaLoading();
      try {
        final List<Topic> topics = await repository.findTopic();
        yield QiitaSuccess(topics: topics);
      } catch (_) {
        yield QiitaError();
      }
    }
  }
}
