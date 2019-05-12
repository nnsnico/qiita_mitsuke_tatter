import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:qiita_mitsuke_tatter/model/topic.dart';

abstract class QiitaState extends Equatable {
  QiitaState([List props = const []]) : super(props);
}

class QiitaEmpty extends QiitaState {}

class QiitaLoading extends QiitaState {}

class QiitaSuccess extends QiitaState {
  final List<Topic> topics;

  QiitaSuccess({@required this.topics})
      : assert(topics != null),
        super([topics]);
}

class QiitaError extends QiitaState {}
