import 'dart:async';
import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:qiita_mitsuke_tatter/api/qiita_api.dart';
import 'package:qiita_mitsuke_tatter/model/tag.dart';
import 'package:qiita_mitsuke_tatter/model/topic.dart';
import 'package:qiita_mitsuke_tatter/model/user.dart';

class QiitaApiImpl implements QiitaApi {
  var topicList = List<Topic>();
  var userList = List<User>();
  static const baseUrl = 'http://qiita.com/api/v2/items';
  final http.Client httpClient;

  QiitaApiImpl({
    @required this.httpClient,
  });

  @override
  Future<List<Topic>> getTopics() async {
    if (topicList.isEmpty) {
      await requestAll();
    }

    return topicList;
  }

  @override
  Future<List<User>> getUsers() async {
    if (userList.isEmpty) {
      await requestAll();
    }

    return userList;
  }

  requestAll() async {
    var response = await this.httpClient.get(baseUrl);
    var json = jsonDecode(response.body);

    for (var value in json) {
      // User
      User user = User.fromJson(value);

      // Tags
      List<Tag> tags = Tag.getTagListFromJson(value);

      // Topic
      Topic topic = Topic.fromJson(user, tags, value);

      topicList.add(topic);
      userList.add(user);
    }
  }
}
