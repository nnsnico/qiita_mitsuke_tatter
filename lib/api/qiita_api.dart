import 'dart:async';

import 'package:qiita_mitsuke_tatter/model/topic.dart';
import 'package:qiita_mitsuke_tatter/model/user.dart';

abstract class QiitaApi {
  Future<List<Topic>> getTopics();

  Future<List<User>> getUsers();
}