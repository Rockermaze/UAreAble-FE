import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'GAlphabet.dart';
import 'GSignCam.dart';

class GSignLearninggg extends StatefulWidget {
  final GAlphabet alphabet;
  final Function(String) onProgressUpdate;

  GSignLearninggg({required this.alphabet, required this.onProgressUpdate});

  @override
  _GSignLearningggState createState() => _GSignLearningggState();
}

class _GSignLearningggState extends State<GSignLearninggg> {
  double _progress = 0.0;
  int _tryCount = 0;
  final int maxTries = 10;

  @override
  void initState() {
    super.initState();
    _loadProgress();
  }

  Future<void> _loadProgress() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _tryCount = prefs.getInt('${widget.alphabet.alphabet}_try_count') ?? 0;
      _progress = _tryCount / maxTries;
    });
  }

  Future<void> _saveProgress() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('${widget.alphabet.alphabet}_try_count', _tryCount);
  }

  void _incrementProgress() {
    if (_tryCount < maxTries) {
      setState(() {
        _tryCount++;
        _progress = _tryCount / maxTries;
      });
      _saveProgress();
      // Notify the main page to update its progress
      if (_tryCount == maxTries) {
        widget.onProgressUpdate(widget.alphabet.alphabet);
      }
    }
  }

  void _openCameraPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => GSignCam(
          onDone: () {
            _incrementProgress(); // Increment progress when 'Done' is clicked
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Learn Sign - ${widget.alphabet.alphabet}'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 20.0),
            Container(
              height: 200.0,
              width: 200.0,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.deepPurple),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Center(
                child: Text(
                  widget.alphabet.alphabet, // Display Gujarati letter
                  style: TextStyle(fontSize: 100.0, color: Colors.deepPurple),
                ),
              ),
            ),
            SizedBox(height: 30.0),
            Text(
              'Try Count: $_tryCount/$maxTries',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10.0),
            LinearProgressIndicator(
              value: _progress,
              minHeight: 10.0,
              backgroundColor: Colors.grey[300],
              valueColor: AlwaysStoppedAnimation<Color>(Colors.deepPurple),
            ),
            SizedBox(height: 30.0),
            ElevatedButton(
              onPressed: _openCameraPage,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 15.0),
              ),
              child: Text(
                'Try It',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
