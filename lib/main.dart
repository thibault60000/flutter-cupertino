import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Cupertino ',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Cupertino page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  bool switchValue = false;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (Platform.isAndroid) {
      print('on android');
    }
    if (Platform.isIOS) {
      print('on iOS');
    }

    return Platform.isIOS
        ? CupertinoPageScaffold(
            navigationBar: CupertinoNavigationBar(
                backgroundColor: Colors.pink, middle: Text(widget.title)),
            child: body())
        : Scaffold(
            appBar: AppBar(
              title: customText(widget.title),
            ),
            body: body(),
            floatingActionButton: FloatingActionButton(
              onPressed: _incrementCounter,
              tooltip: 'Increment',
              child: const Icon(Icons.add),
            ),
          );
  }

  Widget customText(String text, {color = Colors.black, fontSize = 15.0}) {
    if (Platform.isIOS) {
      return DefaultTextStyle(
          style: TextStyle(color: color, fontSize: fontSize),
          child: Text(text, textAlign: TextAlign.center));
    }
    return Text(text,
        textAlign: TextAlign.center,
        style: TextStyle(color: color, fontSize: fontSize));
  }

  Widget customSlider() {
    if (Platform.isIOS) {
      return CupertinoSlider(
          value: _counter.toDouble(),
          min: 0,
          max: 100,
          onChanged: (double value) {
            setState(() {
              _counter = value.toInt();
            });
          });
    } else {
      return Slider(
          value: _counter.toDouble(),
          min: 0,
          max: 100,
          onChanged: (double value) {
            setState(() {
              _counter = value.toInt();
            });
          });
    }
  }

  Widget customSwitch() {
    if (Platform.isIOS) {
      return CupertinoSwitch(
        value: switchValue,
        onChanged: (value) {
          setState(() {
            switchValue = value;
          });
        },
      );
    } else {
      return Switch(
          value: switchValue,
          inactiveTrackColor: Colors.pink,
          activeColor: Colors.blue,
          onChanged: (bool b) {
            setState(() {
              switchValue = b;
            });
          });
    }
  }

  Widget customAlert() {
    if (Platform.isIOS) {
      return CupertinoAlertDialog(
        title: const Text('Alert'),
        content: const Text('This is an alert'),
        actions: [
          CupertinoDialogAction(
            child: const Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          CupertinoDialogAction(
            child: const Text('Ok'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    } else {
      return AlertDialog(
        title: const Text('Alert'),
        content: const Text('This is an alert'),
        actions: [
          TextButton(
            child: const Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: const Text('Ok'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    }
  }

  Widget body() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          customText(
            'You have pushed the button this many times:',
          ),
          customText(
            '$_counter',
          ),
          customSwitch(),
          customSlider(),
          ElevatedButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return customAlert();
                  });
            },
            child: customText('Show Alert'),
          ),
        ],
      ),
    );
  }
}
