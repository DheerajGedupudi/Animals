import 'package:flutter/material.dart';

class JungleQuizPage extends StatelessWidget {
  const JungleQuizPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      key: const ValueKey('quiz_page'),
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/frame.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Card(
            elevation: 12,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Text(
                    'Quiz Time!',
                    style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Test your jungle knowledge and earn rewards!',
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
