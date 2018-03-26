import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:qiita_mitsuke_tatter/api/qiita_api.dart';
import 'package:qiita_mitsuke_tatter/model/tag.dart';
import 'package:qiita_mitsuke_tatter/model/topic.dart';
import 'package:qiita_mitsuke_tatter/model/user.dart';

class QiitaApiImpl implements QiitaApi {

  var topicList = List<Topic>();
  var userList = List<User>();

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
    var response = await http.read('http://qiita.com/api/v2/items');
    var json = JSON.decode(response);

    for (var value in json) {
      var userJson = value['user'];

      // User
      User user = User(
        userJson['name'],
        userJson['id'],
        userJson['description'],
        userJson['profile_image_url'],
      );

      // Tag
      var tags = value['tags'];
      var tagList = List<Tag>();
      for (var tag in tags) {
        var t = Tag(
          tag['name'],
        );
        tagList.add(t);
      }

      // Topic
      Topic topic = Topic(
          value['title'],
          value['body'],
          value['likes_count'],
          tagList,
          value['updated_at'],
          user,
      );

      topicList.add(topic);
      userList.add(user);
    }
  }
}