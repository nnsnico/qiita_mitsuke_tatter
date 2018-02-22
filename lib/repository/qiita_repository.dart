import 'dart:async';

import 'package:qiita_mitsuke_tatter/model/topic.dart';

abstract class QiitaRepository {
  Future<List<Topic>> findTopic();
}
