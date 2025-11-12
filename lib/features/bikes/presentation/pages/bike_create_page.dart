import 'package:flutter/material.dart';

class BikeCreatePage extends StatefulWidget {
  const BikeCreatePage({super.key});

  @override
  State<BikeCreatePage> createState() => _BikeCreatePageState();
}

class _BikeCreatePageState extends State<BikeCreatePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Create New Bike")),
      body: const Center(child: Text("Bike Creation Form")),
    );
  }
}
