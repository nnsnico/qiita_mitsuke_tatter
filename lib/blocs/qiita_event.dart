import 'package:equatable/equatable.dart';

abstract class QiitaEvent extends Equatable {
  QiitaEvent([List props = const []]) : super(props);
}

class FindTopic extends QiitaEvent {}
