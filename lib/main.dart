import 'package:flutter/material.dart';
import 'package:voice_to_text/pages/vtt_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Voice to Text',
      theme: ThemeData(
        brightness: Brightness.dark,
      ),
      home: VttScreen(),
    );
  }
}
