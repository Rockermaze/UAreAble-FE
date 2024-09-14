import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ur_able/ESignLearn/ESignLearning.dart';
import 'package:ur_able/main.dart';

class HomePage_Card extends StatelessWidget {
  const HomePage_Card({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildListDelegate([
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 20.0),
              Text(
                'Welcome to UAreAble!',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple,
                ),
              ),
              SizedBox(height: 10.0),
              Text(
                'Explore our tutorials and games to learn sign language in an interactive way.',
                style: TextStyle(fontSize: 16.0),
              ),
              SizedBox(height: 30.0),
              Text(
                'Tutorial Section',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 15.0),
              buildSectionCard(Icons.language, 'English Sign Language',context, ESignLearningPage()),
              buildSectionCard(Icons.translate, 'Gujarati Sign Language',context, ESignLearningPage()),
              buildSectionCard(Icons.numbers, 'Number Signs',context, ESignLearningPage()),
              buildSectionCard(Icons.calculate, 'Math Tutorials',context, ESignLearningPage()),
              buildSectionCard(Icons.group, 'International Signs',context, ESignLearningPage()),


              SizedBox(height: 30.0),
              Text(
                'Game Section',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 15.0),
              buildSectionCard(Icons.quiz_outlined, 'Memory Matching Game',context, ESignLearningPage()),
              buildSectionCard(Icons.wordpress_rounded, 'Word Scramble',context, ESignLearningPage()),
              buildSectionCard(Icons.quiz_rounded, 'Flashcard Quizs',context, ESignLearningPage()),

              SizedBox(height: 30.0),
              Text(
                'Related Videos',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 15.0),
              buildSectionCard(Icons.quiz_outlined, 'Online Study',context, ESignLearningPage()),
              buildSectionCard(Icons.wordpress_rounded, 'Emergency sign Tutorial',context, ESignLearningPage()),
              buildSectionCard(Icons.quiz_rounded, 'Awareness',context, ESignLearningPage()),
            ],
          ),
        ),
      ]),
    );
  }
}

Widget buildSectionCard(IconData icon, String title, BuildContext context, Widget destinationPage) {
  return Card(
    elevation: 5,
    margin: EdgeInsets.symmetric(vertical: 10.0),
    child: ListTile(
      leading: Icon(icon, size: 30.0, color: Colors.deepPurple),
      title: Text(
        title,
        style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
      ),
      trailing: Icon(Icons.arrow_forward_ios),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => destinationPage),
        );// Navigate to respective section
      },
    ),
  );
}
