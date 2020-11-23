import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Method Channel Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Method Channel Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String response = "No data";
  var methodChannel = MethodChannel("com.test.messages");

  void startServiceInPlatform() async {
    if (Platform.isAndroid) {
      String _response = await methodChannel.invokeMethod("startService");
      debugPrint(_response);
      setState(() {
        response = _response;
      });
    }
  }

  void stopServiceInPlatform() async {
    if (Platform.isAndroid) {
      String _response = await methodChannel.invokeMethod("stopService");
      debugPrint(_response);
      setState(() {
        response = _response;
      });
    }
  }

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
            Text(
              "Response",
            ),
            Text(
              response,
            ),
            MaterialButton(
              color: Colors.green,
              child: Text("Start service"),
              onPressed: () {
                startServiceInPlatform();
              },
            ),
            MaterialButton(
              color: Colors.red,
              child: Text("Stop service"),
              onPressed: () {
                stopServiceInPlatform();
              },
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
