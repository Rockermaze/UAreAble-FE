import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'ESignLearningg.dart';

class ESignLearningPage extends StatefulWidget {
  @override
  _ESignLearningPageState createState() => _ESignLearningPageState();
}

class _ESignLearningPageState extends State<ESignLearningPage> {
  double _progress = 0.0;
  final int totalLetters = 26; // A to Z
  List<bool> _isTickedList = List<bool>.filled(26, false); // List to track tick button states

  void _updateProgress() {
    int completedTicks = _isTickedList.where((isTicked) => isTicked).length;
    setState(() {
      _progress = completedTicks / totalLetters;
    });
  }

  void _resetProgress() {
    setState(() {
      _isTickedList = List<bool>.filled(26, false);
      _progress = 0.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('UAreAble - English Sign Learning'),
        backgroundColor: Colors.deepPurple,
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.account_circle),
            onPressed: () {
              // Profile action
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.deepPurple,
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              title: Text('Home'),
              onTap: () {
                Navigator.pushReplacementNamed(context, '/home');
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Progress: ${(_progress * 100).toStringAsFixed(0)}%',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10.0),
            Container(
              height: 10.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
                color: Colors.grey[300],
              ),
              child: Stack(
                children: <Widget>[
                  AnimatedContainer(
                    duration: Duration(milliseconds: 300),
                    width: MediaQuery.of(context).size.width * _progress,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      color: Colors.deepPurple,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 30.0),
            Expanded(
              child: ListView.builder(
                itemCount: totalLetters,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 5,
                    margin: EdgeInsets.symmetric(vertical: 10.0),
                    child: ListTile(
                      title: Text('Letter ${String.fromCharCode(65 + index)}'),
                      trailing: IconButton(
                        icon: Icon(
                          _isTickedList[index] ? Icons.check_circle : Icons.radio_button_unchecked,
                          color: _isTickedList[index] ? Colors.green : Colors.grey,
                        ),
                        onPressed: () {
                          setState(() {
                            _isTickedList[index] = !_isTickedList[index];
                            _updateProgress();
                          });
                        },
                      ),
                      onTap: () {
                        // Navigate to the ESignLearninggg page
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ESignLearninggg(), // Open the ESignLearninggg page
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: _resetProgress,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
              ),
              child: Text(
                'Reset Progress',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
