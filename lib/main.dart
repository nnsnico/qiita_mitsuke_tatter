import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:qiita_mitsuke_tatter/api/qiita_api.dart';
import 'package:qiita_mitsuke_tatter/api/qiita_api_impl.dart';
import 'package:qiita_mitsuke_tatter/repository/qiita_repository.dart';
import 'package:qiita_mitsuke_tatter/repository/qiita_repository_impl.dart';
import 'package:qiita_mitsuke_tatter/ui/app.dart';

class SimpleBlocDelegate extends BlocDelegate {
  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print(transition);
  }
}

void main() {
  BlocSupervisor().delegate = SimpleBlocDelegate();
  // TODO: もしかしたらDIできるか??
  http.Client client = http.Client();
  final QiitaApi api = QiitaApiImpl(httpClient: client);
  final QiitaRepository repository = QiitaRepositoryImpl(api: api);
  runApp(MyApp(repository: repository));
}
