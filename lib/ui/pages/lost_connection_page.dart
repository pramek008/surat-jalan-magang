import 'package:flutter/material.dart';

class ConnectionLostPage extends StatelessWidget {
  const ConnectionLostPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          'assets/connection_lost.png',
          width: 150,
          height: 150,
        ),
      ),
    );
  }
}
