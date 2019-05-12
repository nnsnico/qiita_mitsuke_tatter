import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:qiita_mitsuke_tatter/repository/qiita_repository.dart';
import 'package:qiita_mitsuke_tatter/theme.dart';
import 'package:qiita_mitsuke_tatter/ui/container/home_screen.dart';

class MyApp extends StatelessWidget {
  final QiitaRepository repository;

  MyApp({Key key, @required this.repository})
      : assert(repository != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'QiitaMitsukeTatter',
      theme: themeData,
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      supportedLocales: [Locale('ja', '')],
      home: MyHomePage(title: 'Home', repository: repository),
    );
  }
}
