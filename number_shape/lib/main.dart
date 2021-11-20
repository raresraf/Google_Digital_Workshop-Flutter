import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyCustomForm(),
    );
  }
}

class MyCustomForm extends StatefulWidget {
  const MyCustomForm({Key? key}) : super(key: key);

  @override
  _MyCustomFormState createState() => _MyCustomFormState();
}

class _MyCustomFormState extends State<MyCustomForm> {
  final TextEditingController controller = TextEditingController();

  bool isSquare(double number) {
    final double base2 = pow(number, 1 / 2).roundToDouble();
    return pow(base2, 2) == number;
  }

  bool isTriangular(double number) {
    final double base3 = pow(number, 1 / 3).roundToDouble();
    return pow(base3, 3) == number;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'Number Shapes',
            style: TextStyle(fontSize: 20),
          ),
        ),
        body: ListView(
          padding: const EdgeInsetsDirectional.all(16.0),
          children: <Widget>[
            Column(
              children: <Widget>[
                const Text(
                  'Please input a number to see if it is square or triangular.',
                  style: TextStyle(
                    fontSize: 22,
                  ),
                ),
                TextField(
                  controller: controller,
                  keyboardType: TextInputType.number,
                ),
              ],
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            final double? value = double.tryParse(controller.text);

            setState(() {
              showDialog<AlertDialog>(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: value == null ? const Text('Error') : Text(controller.text),
                    content: value == null
                        ? const Text('Please enter a valid number')
                        : isTriangular(value) && isSquare(value)
                            ? Text('Number ${controller.text} is both SQUARE and TRIANGULAR.')
                            : isTriangular(value) && !isSquare(value)
                                ? Text('Number ${controller.text} is TRIANGULAR.')
                                : !isTriangular(value) && isSquare(value)
                                    ? Text('Number ${controller.text} is SQUARE.')
                                    : !isTriangular(value) && !isSquare(value)
                                        ? Text('Number ${controller.text} is neither TRIANGULAR or SQUARE.')
                                        : Text('Number ${controller.text} is not special.'),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          controller.clear();
                        },
                        child: const Text('Okay'),
                      ),
                    ],
                  );
                },
              );
            });

            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: const Icon(Icons.check),
        ),
      ),
    );
  }
}
