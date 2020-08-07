import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'about.dart';
import 'package:share/share.dart';
import 'package:sticky_headers/sticky_headers.dart';

class VttScreen extends StatefulWidget {
  @override
  _VttScreenState createState() => _VttScreenState();
}

class _VttScreenState extends State<VttScreen> {
  SpeechToText _speak;
  bool _isSpeaking = false;
  String _words = '';

// function to handle the Speech to text functionality
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

  void _share() {
    final String _isWords = _words;
    if (_isWords.isEmpty) {
      print(" cannot share empty text");
    } else {
      Share.share(_words);
    }
  }

  void _copy() {
    if (_words.isEmpty) {
      print('cannot copy empty word');
    } else {
      Clipboard.setData(ClipboardData(text: _words));
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
          child: Column(
            children: [
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(8.0),
                color: Colors.green[700],
                child: Text(
                  'Tap the mic button to start speaking',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              StickyHeader(
                header: Container(
                  height: 70.0,
                  width: 500.0,
                  color: Colors.deepPurple[800],
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          IconButton(onPressed: null, icon: Icon(Icons.edit)),
                          Text('Edit'),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          IconButton(
                              onPressed: _share, icon: Icon(Icons.share)),
                          Text('Share'),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          IconButton(
                              onPressed: _copy, icon: Icon(Icons.content_copy)),
                          Text('Copy'),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          IconButton(
                              onPressed: null, icon: Icon(Icons.translate)),
                          Text('Translate'),
                        ],
                      ),
                    ],
                  ),
                ),
                content: Container(
                  padding: EdgeInsets.all(30.0),
                  child: Center(
                    child: SelectableText(
                      _words,
                      style: TextStyle(
                        fontSize: 30.0,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          )),

      //Mic Function
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: _listen,
        child: Icon(
          _isSpeaking ? Icons.mic : Icons.mic_off,
          color: Colors.white,
        ),
      ),
    );
  }
}
