import 'package:flutter/material.dart';

class BikeListPage extends StatefulWidget {
  const BikeListPage({super.key});

  @override
  State<BikeListPage> createState() => _BikeListPageState();
}

class _BikeListPageState extends State<BikeListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Our Bike Collection")),
      body: const Center(child: Text("List of Bikes")),
    );
  }
}
