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
            "Number Shapes",
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

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsetsDirectional.all(16),
      child: ListView(
        children: [
          Column(
            children: <Widget>[
              const Text(
                "Please input a positive integer to see if it is square or triangular.",
                style: TextStyle(
                  fontSize: 22,
                ),
              ),
              TextField(
                controller: controller,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.55,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      final double? value = double.tryParse(controller.text);
                      int intValue = -1;
                      String alertText = "";

                      if (value == null) {
                        alertText = "Please enter a valid number";
                      } else if (value < 0) {
                        if (value == value.floor()) {
                          intValue = value.floor();
                        }
                        alertText = "Please enter a positive number";
                      } else {
                        if (value == value.floor()) {
                          intValue = value.floor();
                        }
                        if (intValue == -1) {
                          if (CheckConstraints.isSquare(value) &&
                              CheckConstraints.isCube(value)) {
                            alertText =
                                "Number $value is both SQUARE and TRIANGULAR.";
                          } else if (CheckConstraints.isSquare(value)) {
                            alertText = "Number $value is SQUARE.";
                          } else if (CheckConstraints.isCube(value)) {
                            alertText = "Number $value is TRIANGULAR.";
                          } else {
                            alertText =
                                "Number $value is neither TRIANGULAR or SQUARE.";
                          }
                        } else {
                          if (CheckConstraints.isSquare(intValue) &&
                              CheckConstraints.isCube(intValue)) {
                            alertText =
                                "Number $intValue is both SQUARE and TRIANGULAR.";
                          } else if (CheckConstraints.isSquare(intValue)) {
                            alertText = "Number $intValue is SQUARE.";
                          } else if (CheckConstraints.isCube(intValue)) {
                            alertText = "Number $intValue is TRIANGULAR.";
                          } else {
                            alertText =
                                "Number $intValue is neither TRIANGULAR or SQUARE.";
                          }
                        }
                      }

                      AlertDialog alert = AlertDialog(
                        title:
                            intValue == -1 ? Text("$value") : Text("$intValue"),
                        content: Text(alertText),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                              controller.clear();
                            },
                            child: const Text("Okay"),
                          ),
                        ],
                      );

                      showDialog<AlertDialog>(
                        context: context,
                        builder: (BuildContext ctx) {
                          return alert;
                        },
                      );
                    },
                    child: const Icon(Icons.check),
                    style: ElevatedButton.styleFrom(
                      shape: const CircleBorder(),
                      padding: const EdgeInsetsDirectional.all(20),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class CheckConstraints {
  static bool isSquare(dynamic number) {
    double squareRoot = sqrt(number);
    return squareRoot - squareRoot.floor() == 0;
  }

  static bool isCube(dynamic number) {
    int cube;
    bool flag = false;
    for (int i = 0; i <= number; i++) {
      cube = i * i * i;

      if (cube == number) {
        flag = true;
        break;
      } else if (cube > number) {
        flag = false;
        break;
      }
    }
    return flag;
  }
}
