import 'package:flutter/material.dart';

class TripDetailsPage extends StatelessWidget {
  final String title;
  final String imageUrl;
  final String description;
  final List<String> tripPlan;
  final VoidCallback onBookTrip;

  const TripDetailsPage({
    super.key,
    required this.title,
    required this.imageUrl,
    required this.description,
    required this.tripPlan,
    required this.onBookTrip,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Colors.orange,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              imageUrl,
              height: 220,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => const Icon(Icons.broken_image, size: 100),
            ),
            const SizedBox(height: 12),
            Text(
              description,
              style: const TextStyle(fontSize: 16, height: 1.5),
            ),
            const SizedBox(height: 20),
            const Text(
              'خطة الرحلة',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            ...tripPlan.map((step) => ListTile(
                  leading: const Icon(Icons.check_circle_outline, color: Colors.orange),
                  title: Text(step),
                )),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                onBookTrip();
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text(
                'احجز الآن',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
