import 'package:flutter/material.dart';

class TestResultPage extends StatefulWidget {
  @override
  _TestResultPageState createState() => _TestResultPageState();
}

class _TestResultPageState extends State<TestResultPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('结果'),
      ),
      body: Container(
        child: Center(
          child: Text('测试结果您非常适合学习钢琴！'),
        ),
      ),
    );
  }
}