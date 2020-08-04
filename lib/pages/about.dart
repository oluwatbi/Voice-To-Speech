import 'package:flutter/material.dart';

class About extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text('About'),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: height,
          child: Center(
            child: Column(
              children: [
                Text('Some text in here'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
