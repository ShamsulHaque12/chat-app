import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UnreadChat extends StatelessWidget {
  const UnreadChat({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Unread Chat"),
        ],
      ),
    );
  }
}
