import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

class WordScrambleGame extends StatefulWidget {
  @override
  _WordScrambleGameState createState() => _WordScrambleGameState();
}

class _WordScrambleGameState extends State<WordScrambleGame> {
  final List<String> words = ['APPLE', 'BANANA', 'CHERRY', 'DATES'];
  String _scrambledWord = '';
  String _correctWord = '';
  String _userGuess = '';
  int _timeLeft = 30;
  Timer? _timer;
  String _hint = '';
  bool _showSuccess = false;

  @override
  void initState() {
    super.initState();
    _loadNewWord();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _loadNewWord() {
    final random = Random();
    setState(() {
      _correctWord = words[random.nextInt(words.length)];
      _scrambledWord = _scrambleWord(_correctWord);
      _userGuess = '';
      _timeLeft = 30;
      _showSuccess = false;
      _hint = '';
    });
    _startTimer();
  }

  String _scrambleWord(String word) {
    final chars = word.split('');
    chars.shuffle();
    return chars.join('');
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_timeLeft > 0) {
          _timeLeft--;
        } else {
          _timer?.cancel();
          _showSuccess = true;
        }
      });
    });
  }

  void _checkAnswer() {
    setState(() {
      if (_userGuess.toUpperCase() == _correctWord) {
        _showSuccess = true;
      } else {
        _hint = 'Try again!';
      }
    });
  }

  void _giveHint() {
    setState(() {
      if (_hint.isEmpty) {
        _hint = 'The word starts with "${_correctWord[0]}"';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Word Scramble Game'),
        backgroundColor: Colors.purple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _showSuccess
            ? Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                _userGuess.toUpperCase() == _correctWord
                    ? 'Congratulations! You solved it!'
                    : 'Time\'s up! The correct word was $_correctWord.',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _loadNewWord,
                child: Text('Next'),
              ),
            ],
          ),
        )
            : Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Scrambled Word: $_scrambledWord',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            TextField(
              onChanged: (value) {
                _userGuess = value;
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Enter your guess',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _checkAnswer,
              child: Text('Submit'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _giveHint,
              child: Text('Hint'),
            ),
            SizedBox(height: 20),
            Text(
              'Time Left: $_timeLeft seconds',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: _timeLeft > 5 ? Colors.black : Colors.red,
              ),
            ),
            SizedBox(height: 10),
            LinearProgressIndicator(
              value: _timeLeft / 30,
              backgroundColor: Colors.grey[300],
              valueColor: AlwaysStoppedAnimation<Color>(
                  _timeLeft > 5 ? Colors.blue : Colors.red),
            ),
            SizedBox(height: 20),
            if (_hint.isNotEmpty)
              Text(
                _hint,
                style: TextStyle(color: Colors.blue, fontSize: 16),
              ),
          ],
        ),
      ),
    );
  }
}
