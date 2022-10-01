import 'package:flutter/material.dart';
import 'package:hiit/hiit_type.dart';
import 'hiit_timer.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(
        title: 'Flutter Demo Home Page',
        hiitType: hiitTypes.first,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({super.key, required this.title, required this.hiitType});
  final String title;
  HiitType hiitType;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            DropdownButton(
                items: dropdownHiitTypes, onChanged: dropdownCallback),
            CountdownTimer(hiitType: widget.hiitType)
          ],
        ),
      ),
    );
  }

  void dropdownCallback(HiitType? selectedValue) {
    setState(() {
      if (selectedValue != null) {
        widget.hiitType = selectedValue;
      }
    });
  }
}
