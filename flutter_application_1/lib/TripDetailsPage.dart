import 'package:flutter/material.dart';
import 'flight_selection_page.dart';

class TripDetailsPage extends StatelessWidget {
  final String title;
  final String imageUrl;
  final String description;
  final List<String> tripPlan;
  final VoidCallback? onBookTrip;

  const TripDetailsPage({
    super.key,
    required this.title,
    required this.imageUrl,
    required this.description,
    required this.tripPlan,
    this.onBookTrip,
  });

  String _getDestinationCode(String destination) {
    switch (destination.toLowerCase()) {
      case 'paris': return 'CDG';
      case 'rome': return 'FCO';
      case 'tokyo': return 'HND';
      case 'dubai': return 'DXB';
      case 'amazon': return 'MAO';
      case 'himalayas': return 'KTM';
      case 'sahara': return 'TGR';
      case 'african forests': return 'NBO';
      case 'turkey offer': return 'IST';
      case 'thailand offer': return 'BKK';
      case 'morocco offer': return 'CMN';
      default: return 'MAI';
    }
  }

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
              'Trip Plan',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            ...tripPlan.map(
              (step) => ListTile(
                leading: const Icon(Icons.check_circle_outline, color: Colors.orange),
                title: Text(step),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (onBookTrip != null) {
                  onBookTrip!();
                }
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => FlightSelectionPage(
                      title: title,
                      destination: title,
                      destinationCode: _getDestinationCode(title),
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text(
                'Book Now',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}