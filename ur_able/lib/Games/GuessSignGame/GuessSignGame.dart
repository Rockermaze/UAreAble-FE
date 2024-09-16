import 'dart:async';
import 'dart:convert'; // Import to decode JSON
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // For rootBundle
import 'SignItem.dart';

class GuessSignGame extends StatefulWidget {
  @override
  _GuessSignGameState createState() => _GuessSignGameState();
}

class _GuessSignGameState extends State<GuessSignGame> {
  List<SignItem> signs = [];
  SignItem? currentSign;
  List<String> options = [];
  String feedbackMessage = '';
  bool showFeedback = false;
  Timer? _timer;
  int _timeLeft = 10;

  @override
  void initState() {
    super.initState();
    _loadImages();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  Future<void> _loadImages() async {
    final manifestContent = await rootBundle.loadString('AssetManifest.json');
    final Map<String, dynamic> manifestMap = json.decode(manifestContent);

    final List<String> imagePaths = manifestMap.keys
        .where((String key) => key.startsWith('assets/signs/'))
        .toList();

    signs = imagePaths.map((path) {
      final String answer = path.split('/').last.split('.').first; // Extract answer from filename
      return SignItem(imagePath: path, correctAnswer: answer);
    }).toList();

    setState(() {
      if (signs.isNotEmpty) {
        _loadNewSign();
      }
    });
  }

  void _loadNewSign() {
    if (signs.isEmpty) return;

    final random = Random();
    setState(() {
      currentSign = signs[random.nextInt(signs.length)];
      options = [currentSign!.correctAnswer];

      while (options.length < 4) {
        String randomAnswer = signs[random.nextInt(signs.length)].correctAnswer;
        if (!options.contains(randomAnswer)) {
          options.add(randomAnswer);
        }
      }

      options.shuffle();
      feedbackMessage = '';
      showFeedback = false;
      _timeLeft = 10;
    });

    _startTimer();
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_timeLeft > 0) {
          _timeLeft--;
        } else {
          _timer?.cancel();
          _checkAnswer('');
        }
      });
    });
  }

  void _checkAnswer(String selectedAnswer) {
    _timer?.cancel();
    setState(() {
      if (selectedAnswer == currentSign!.correctAnswer) {
        feedbackMessage = 'Correct!';
      } else {
        feedbackMessage = 'Time\'s up! Try Again!';
      }
      showFeedback = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Guess the Right Sign'),
        backgroundColor: Colors.purple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: signs.isEmpty
            ? Center(child: CircularProgressIndicator())
            : Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Time Left: $_timeLeft seconds',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: _timeLeft > 3 ? Colors.black : Colors.red,
              ),
            ),
            SizedBox(height: 10),
            LinearProgressIndicator(
              value: _timeLeft / 10,
              backgroundColor: Colors.grey[300],
              valueColor: AlwaysStoppedAnimation<Color>(
                  _timeLeft > 3 ? Colors.blue : Colors.red),
            ),
            SizedBox(height: 20),
            Image.asset(
              currentSign!.imagePath,
              height: 200,
              errorBuilder: (context, error, stackTrace) {
                return Text('Image not found.');
              },
            ),
            SizedBox(height: 20),
            Text(
              'Choose the correct answer:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            ...options.map((option) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 5.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple,
                    foregroundColor: Colors.white,
                    textStyle: TextStyle(fontSize: 16),
                    padding: EdgeInsets.symmetric(vertical: 15),
                  ),
                  onPressed: () => _checkAnswer(option),
                  child: Text(option),
                ),
              );
            }).toList(),
            SizedBox(height: 20),
            if (showFeedback)
              Text(
                feedbackMessage,
                style: TextStyle(
                  color: feedbackMessage == 'Correct!'
                      ? Colors.green
                      : Colors.red,
                  fontSize: 18,
                ),
              ),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                textStyle: TextStyle(fontSize: 16),
                padding: EdgeInsets.symmetric(vertical: 15),
              ),
              onPressed: _loadNewSign,
              child: Text('Next'),
            ),
          ],
        ),
      ),
    );
  }
}
