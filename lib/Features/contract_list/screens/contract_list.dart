import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ContractList extends StatelessWidget {
  const ContractList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Contracts"),
        centerTitle: true,
      ),
    );
  }
}
