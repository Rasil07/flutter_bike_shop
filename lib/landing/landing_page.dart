import 'package:bike_shop_2/bikes/presentation/routes.dart';
import 'package:bike_shop_2/landing/widgets/bike_visuals.dart';
import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Bike Shop')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [BikeVisuals()],
          ),

          Text(
            'Welcome to the Bike Shop!',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 100),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                OutlinedButton(
                  onPressed: () => context.push(bikeCreatePath),
                  style: OutlinedButton.styleFrom(
                    fixedSize: const Size.fromWidth(
                      250,
                    ), // Make buttons full width
                    foregroundColor: Colors.black,
                    side: const BorderSide(color: Colors.black),
                  ),
                  child: const Text("Add Bikes"),
                ),
                const SizedBox(height: 10),
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    fixedSize: const Size.fromWidth(
                      220,
                    ), // Make buttons full width
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                  ),

                  onPressed: () => context.push(bikesListPath),
                  child: const Text("Search Bikes"),
                ),
              ],
            ),
          ),
          // You can add more widgets here for landing page content
        ],
      ),
    );
  }
}
