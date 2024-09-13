import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ESignLearningPage extends StatefulWidget {
  @override
  _ESignLearningPageState createState() => _ESignLearningPageState();
}

class _ESignLearningPageState extends State<ESignLearningPage> {
  late SharedPreferences _prefs;
  List<bool> _progress = List.generate(26, (index) => false);

  @override
  void initState() {
    super.initState();
    _loadProgress();
  }

  Future<void> _loadProgress() async {
    _prefs = await SharedPreferences.getInstance();
    setState(() {
      for (int i = 0; i < 26; i++) {
        _progress[i] = _prefs.getBool('progress_$i') ?? false;
      }
    });
  }

  Future<void> _updateProgress(int index, bool value) async {
    setState(() {
      _progress[index] = value;
    });
    await _prefs.setBool('progress_$index', value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("English Sign Language"),
      ),
      body: Column(
        children: [
          LinearProgressIndicator(
            value: _progress.where((completed) => completed).length / 26,
            backgroundColor: Colors.grey[200],
            color: Colors.deepPurple,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 26,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    title: Text(String.fromCharCode(index + 65)),
                    subtitle: Text("Learn the sign for ${String.fromCharCode(index + 65)}"),
                    trailing: Checkbox(
                      value: _progress[index],
                      onChanged: (bool? value) {
                        _updateProgress(index, value ?? false);
                      },
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
