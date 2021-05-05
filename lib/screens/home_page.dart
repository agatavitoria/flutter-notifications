import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  String _message = '';

  _registerOnFirebase() {
    _firebaseMessaging.subscribeToTopic('all');
    _firebaseMessaging.getToken().then((token) => print(token));
  }

  @override
  void initState() {
    _registerOnFirebase();
    _getMessage();
    super.initState();
  }

  void _getMessage() {
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        setState(() => _message = message["notification"]["body"]);
      },
      onResume: (Map<String, dynamic> message) async {
        setState(() => _message = message["notification"]["body"]);
      },
      onLaunch: (Map<String, dynamic> message) async {
        setState(() => _message = message["notification"]["body"]);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: Container(
        child: Center(
          child: Text("Message: $_message"),
        ),
      ),
    );
  }
}
