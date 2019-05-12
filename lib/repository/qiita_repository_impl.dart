import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:qiita_mitsuke_tatter/api/qiita_api.dart';
import 'package:qiita_mitsuke_tatter/model/topic.dart';
import 'package:qiita_mitsuke_tatter/repository/qiita_repository.dart';

class QiitaRepositoryImpl implements QiitaRepository {
  QiitaApi api;

  QiitaRepositoryImpl({
    @required this.api,
  });

  @override
  Future<List<Topic>> findTopic() async {
    return await api.getTopics().then((topics) {
      return topics;
    });
  }
}
