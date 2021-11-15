import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            "Guess my number",
            style: TextStyle(
              fontSize: 20,
            ),
          ),
        ),
        body: const CustomBody(),
      ),
    );
  }
}

class CustomBody extends StatefulWidget {
  const CustomBody({Key? key}) : super(key: key);

  @override
  _CustomBodyState createState() => _CustomBodyState();
}

class _CustomBodyState extends State<CustomBody> {
  final TextEditingController controller = TextEditingController();
  String textButton = "Guess";
  bool noGuess = true;
  int pickedNumber = -1;
  int targetNumber = Random().nextInt(100) + 1;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsetsDirectional.all(16),
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            const Text(
              "I'm thinking of a number between\n 1 and 100.",
              style: TextStyle(
                fontSize: 22,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 22,
            ),
            const Text(
              "It's your turn to guess my number!",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            if (!noGuess)
              Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "You tried $pickedNumber",
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 40,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  if (pickedNumber < targetNumber)
                    const Text(
                      "Try Higher",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 40,
                      ),
                    ),
                  if (pickedNumber > targetNumber)
                    const Text(
                      "Try Lower",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 40,
                      ),
                    ),
                  if (pickedNumber == targetNumber)
                    const Text(
                      "You guessed it right.",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 40,
                      ),
                    ),
                ],
              ),
            const SizedBox(
              height: 20,
            ),
            Card(
              elevation: 10,
              margin: const EdgeInsetsDirectional.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(
                    height: 5,
                  ),
                  const Text(
                    "Try a number!",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 40,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    margin: const EdgeInsetsDirectional.all(20),
                    child: TextField(
                      controller: controller,
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      final int? value = int.tryParse(controller.text);

                      setState(() {
                        if (textButton == "Reset") {
                          noGuess = true;
                          pickedNumber = -1;
                          targetNumber = Random().nextInt(100) + 1;
                          textButton = "Guess";
                        } else if (value != null) {
                          noGuess = false;
                          pickedNumber = value;
                          if (pickedNumber == targetNumber) {
                            textButton = "Reset";
                          }
                          controller.clear();
                        }
                      });
                      FocusScope.of(context).requestFocus(FocusNode());
                    },
                    child: Text(textButton),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.white54,
                      onPrimary: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
