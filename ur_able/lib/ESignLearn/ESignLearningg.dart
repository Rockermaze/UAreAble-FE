import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ESignLearninggg extends StatefulWidget {
  @override
  _ESignLearningggState createState() => _ESignLearningggState();
}

class _ESignLearningggState extends State<ESignLearninggg> {
  double _progress = 0.0;
  int _tryCount = 0;
  final int maxTries = 10;

  @override
  void initState() {
    super.initState();
    _loadProgress();
  }

  // Load saved progress from shared preferences
  Future<void> _loadProgress() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _tryCount = prefs.getInt('sign_try_count') ?? 0;
      _progress = _tryCount / maxTries;
    });
  }

  // Save progress to shared preferences
  Future<void> _saveProgress() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('sign_try_count', _tryCount);
  }

  void _incrementProgress() {
    if (_tryCount < maxTries) {
      setState(() {
        _tryCount++;
        _progress = _tryCount / maxTries;
      });
      _saveProgress();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Learn Sign - Try It'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 20.0),
            // Placeholder for sign image
            Container(
              height: 200.0,
              width: 200.0,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.deepPurple),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Center(
                child: Text(
                  'Sign Image Here',
                  style: TextStyle(fontSize: 16.0, color: Colors.deepPurple),
                ),
              ),
            ),
            SizedBox(height: 30.0),
            Text(
              'Try Count: $_tryCount/$maxTries',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10.0),
            // Progress Bar
            LinearProgressIndicator(
              value: _progress,
              minHeight: 10.0,
              backgroundColor: Colors.grey[300],
              valueColor: AlwaysStoppedAnimation<Color>(Colors.deepPurple),
            ),
            SizedBox(height: 30.0),
            ElevatedButton(
              onPressed: _incrementProgress,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 15.0),
              ),
              child: Text(
                'Try It',
                style: TextStyle(color: Colors.deepPurple,
                fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
