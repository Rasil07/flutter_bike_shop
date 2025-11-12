import 'package:flutter/material.dart';

class BikeDetailPage extends StatefulWidget {
  const BikeDetailPage({super.key});

  @override
  State<BikeDetailPage> createState() => _BikeDetailPageState();
}

class _BikeDetailPageState extends State<BikeDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Bike Detail")),
      body: const Center(child: Text("Details of Bike")),
    );
  }
}
