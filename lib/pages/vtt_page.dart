import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'about.dart';

class VttScreen extends StatefulWidget {
  @override
  _VttScreenState createState() => _VttScreenState();
}

class _VttScreenState extends State<VttScreen> {
  SpeechToText _speak;
  bool _isSpeaking = false;
  String _words = 'Tap the mic to start speaking...';

  void _listen() async {
    if (_isSpeaking == false) {
      bool isReady = await _speak.initialize(
        onStatus: (status) => print('onStatus: $status'),
        onError: (errorNotification) => print('onError: $errorNotification'),
      );

      if (isReady) {
        setState(() => _isSpeaking = true);
        _speak.listen(
          onResult: (result) => setState(() {
            _words = result.recognizedWords;
          }),
        );
      }
    } else {
      setState(() => _isSpeaking = false);
      _speak.stop();
    }
  }

  @override
  void initState() {
    super.initState();
    _speak = SpeechToText();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Voice To Speech'),
      ),
      drawer: Drawer(
        elevation: 30.0,
        child: ListView(
          children: [
            DrawerHeader(
              margin: EdgeInsets.all(20),
              child: Row(
                children: [
                  Icon(Icons.mic),
                  Text(
                    'Voice To Speech',
                    style: TextStyle(
                      fontSize: 25.0,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => About()));
              },
              leading: Icon(Icons.info_outline),
              title: Text('About'),
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
            )
          ],
        ),
      ),
      body: SingleChildScrollView(
          reverse: true,
          child: Container(
            padding: EdgeInsets.all(30.0),
            child: Center(
              child: Text(
                _words,
                style: TextStyle(
                  fontSize: 30.0,
                ),
              ),
            ),
          )),

      //Mic Function
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: _listen,
        child: Icon(_isSpeaking ? Icons.mic : Icons.mic_none),
      ),
    );
  }
}
