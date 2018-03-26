# qiita_mitsuke_tatter
FlutterでつくるよQiitaクライアント

## Description
- QiitaAPI V2を読み込んで記事一覧を表示します
- 投稿が新しい順に上から並び、いいねが押された数を右に表示します
- 各アイテムを押すと記事の詳細を見ることができます

## Architecture
- konifarさんが作成した[DroidKaigi2018のFlutterアプリ](https://github.com/konifar/droidkaigi2018-flutter)を参考にしました
- Apiレイヤとrepositoryレイヤ、そして各Screenが状況に応じてrepositoryからApiを呼び出すだけの簡単なアーキテクチャです
    - Vanilla

## DevelopmentEnvironment
```
Flutter 0.1.5 • channel beta • https://github.com/flutter/flutter.git
Framework • revision 3ea4d06340 (5 weeks ago) • 2018-02-22 11:12:39 -0800
Engine • revision ead227f118
Tools • Dart 2.0.0-dev.28.0.flutter-0b4f01f759
```

- IntelliJ Idea Ultimate 2017 3.5
