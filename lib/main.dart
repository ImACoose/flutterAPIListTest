import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(),
        body: Center(
          child: ListView.builder(
              itemCount: 3,
              itemBuilder: ((context, int) => ElevatedButton(
                    onPressed: () {},
                    child: Text(
                      "hi",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ))),
        ),
      ),
    );
  }
}

class InformationPage extends StatelessWidget {
  const InformationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(),
        body: Center(),
      ),
    );
  }
}
