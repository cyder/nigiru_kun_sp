# にぎるくん – IoTハンドグリッパー

にぎるくんは握力測定を行うデバイスです．指ごとに独立した形状をした握力測定器(にぎるくん)とスマートフォンをBluetoothによって連携することで，握力測定の結果を記録したり，回数をカウントしたり，様々なトレーニングを提供したりします．

これまでハンドグリップのような握力トレーニングの機器はスキマ時間に行う手軽な筋力トレーニングやグリップ力の強化として広く認知されていましたが，それは適切なバネの強さや回数を指定できないという問題点があります．そこでにぎるくんはそれらの情報をスマートフォン上から指定・計測できるようにしました．

適切な重さ・回数を指定できたり，計測されたりすることで，ユーザはモチベーションを保ちながらトレーニングに励むことができます．また，指ごとの握力を計測できるためどの指に最も力が働いているか？等の情報もひと目で把握することができます．

* [GUGEN プロジェクトページ](https://gugen.jp/entry2018/2018-098)
* [動画](https://youtu.be/Eob8gxp4ctw)

## 必要環境
* [flutter v0.10.2](https://flutter.io/)
* [Android Studio](https://developer.android.com/studio)
* [Xcode](https://developer.apple.com/jp/xcode/)

## セットアップ
1. flutterをダウンロードし、pathを通す。
```
mkdir ~/develoment
cd ~/development
git clone -b beta https://github.com/flutter/flutter.git
echo 'export PATH=$HOME/development/flutter/bin:$PATH' >> ~/.zshrc
source ~/.zshrc
```

2. 必要に応じてツールをダウンロードする。
```
flutter doctor
```

3. コードをダウンロードする。
```
git clone git@github.com:cyder-akashi/nigiru_kun_sp.git
cd nigiru_kun_sp
```

4. 起動する。
```
flutter run
```

## 著者
* [森 篤史](@Mori-Atsushi)
