import 'package:flutter/material.dart';
import 'TripDetailsPage.dart';

class FavoritesPage extends StatelessWidget {
  final List<Map<String, String>> bookedTrips;

  const FavoritesPage({super.key, required this.bookedTrips});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Favorites',
          style: TextStyle(
            color: Color(0xFF003366),
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.orange,
        centerTitle: true,
        elevation: 0,
        iconTheme: const IconThemeData(color: Color(0xFF003366)),
      ),
      body: bookedTrips.isEmpty
          ? Center(
              child: Text(
                'No favorite trips yet.',
                style: TextStyle(fontSize: 18, color: Colors.grey[600]),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: bookedTrips.length,
              itemBuilder: (context, index) {
                final trip = bookedTrips[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
                  clipBehavior: Clip.hardEdge,
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(8),
                    leading: Image.network(
                      trip['imageUrl'] ?? '',
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                    ),
                    title: Text(
                      trip['title'] ?? 'Unknown Trip',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF003366),
                      ),
                    ),
                    subtitle: trip['rating'] != null
                        ? Row(
                            children: [
                              const Icon(Icons.star, color: Colors.orange, size: 16),
                              const SizedBox(width: 4),
                              Text(
                                trip['rating']!,
                                style: const TextStyle(color: Color(0xFF003366)),
                              ),
                            ],
                          )
                        : null,
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => TripDetailsPage(
                            title: trip['title'] ?? 'Trip Details',
                            imageUrl: trip['imageUrl'] ?? '',
                            description: 'Details for ${trip['title']}',
                            tripPlan: ['Details not available'],
                            onBookTrip: () {},
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
    );
  }
}