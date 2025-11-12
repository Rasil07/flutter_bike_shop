import 'package:flutter/material.dart';

class BikeVisuals extends StatelessWidget {
  const BikeVisuals({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Image(image: AssetImage('assets/images/bike1.png'), height: 230),
    );
  }
}
