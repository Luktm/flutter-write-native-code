import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  int _batteryLevel;
  

  Future<void>_getBatteryLevel() async {
    const platform = MethodChannel("course.flutter.dev/battery");
    try{

      final batteryLevel = await platform.invokeMethod("getBatteryLevel", [1]);

      setState(() {
        _batteryLevel = batteryLevel;
      });
      
    }on PlatformException catch(error) {
      setState(() {
        _batteryLevel = null;
      });
    }
    
  }

  @override
  void initState() {
    _getBatteryLevel();
    super.initState();
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Native Code'),
      ),
      body: Center(
        child: Text('Battery Level: $_batteryLevel'),
      ),
     
    );
  }
}
