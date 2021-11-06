import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  final String appTitle = "Currency convertor";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: appTitle,
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            appTitle,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: const MyCustomForm(),
      ),
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
  final double exchange = 4.5;
  String? errorText;
  double money = 0;
  bool isCorrect = false;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.3,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/leu.jpg"),
                fit: BoxFit.fill,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsetsDirectional.all(16.0),
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                hintText: "enter the amount in EUR",
                errorText: errorText,
              ),
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              final double? doubleValue = double.tryParse(controller.text);

              setState(() {
                if (doubleValue == null) {
                  errorText = "please enter a number";
                  isCorrect = false;
                } else {
                  money = doubleValue * exchange;
                  errorText = null;
                  isCorrect = true;
                }
              });

              FocusScope.of(context).requestFocus(FocusNode());
            },
            child: const Text("CONVERT!"),
            style: ElevatedButton.styleFrom(
              primary: Colors.white54,
              onPrimary: Colors.black,
              fixedSize: const Size(100, 40),
            ),
          ),
          const SizedBox(height: 12,),
          if (isCorrect)
            Center(
              child: Text(
                "${money.toStringAsFixed(2)} RON",
                style: const TextStyle(
                  color: Colors.blueGrey,
                  fontSize: 32,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
