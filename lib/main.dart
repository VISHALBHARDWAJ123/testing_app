import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testing_app/Helper.dart';
import 'package:testing_app/StoryMode.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => ApiHelper()),
    ],
    child: MaterialApp(debugShowCheckedModeBanner: false,home: StoryClass()),
  ));
}
