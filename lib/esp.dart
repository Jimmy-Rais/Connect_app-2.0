import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp2());
}

class MyApp2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage2(),
    );
  }
}

class MyHomePage2 extends StatefulWidget {
  @override
  _MyHomePage2State createState() => _MyHomePage2State();
}

class _MyHomePage2State extends State<MyHomePage2> {
  DatabaseReference ledStatusRef =
      FirebaseDatabase.instance.reference().child('LED_STATUS');
  String currentStatus = 'Loading...';

  @override
  void initState() {
    super.initState();
    _loadLEDStatus();
  }

  _loadLEDStatus() async {
    DataSnapshot snapshot = await ledStatusRef.once() as DataSnapshot;
    setState(() {
      currentStatus = snapshot.value.toString();
    });
  }

  _toggleLEDStatus() async {
    String newStatus = currentStatus == 'ON' ? 'OFF' : 'ON';
    await ledStatusRef.set(newStatus);
    setState(() {
      currentStatus = newStatus;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('LED Control'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'LED Status: $currentStatus',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _toggleLEDStatus,
              child: Text('Toggle LED'),
            ),
          ],
        ),
      ),
    );
  }
}
