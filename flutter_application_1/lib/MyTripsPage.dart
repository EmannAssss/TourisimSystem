import 'package:flutter/material.dart';

class MyTripsPage extends StatefulWidget {
  final List<Map<String, String>> bookedTrips;

  const MyTripsPage({super.key, required this.bookedTrips});

  @override
  State<MyTripsPage> createState() => _MyTripsPageState();
}

class _MyTripsPageState extends State<MyTripsPage> {
  late List<Map<String, String>> trips;

  @override
  void initState() {
    super.initState();
    trips = List<Map<String, String>>.from(widget.bookedTrips);
  }

  void _removeTrip(int index) {
    setState(() {
      trips.removeAt(index);
      widget.bookedTrips.removeAt(index);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Trip removed')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: const Text(
          'My Trips',
          style: TextStyle(color: Color(0xFF003366)),
        ),
        centerTitle: true,
      ),
      body: trips.isEmpty
          ? Center(
              child: Text(
                'No trips booked yet',
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 18,
                ),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: trips.length,
              itemBuilder: (context, index) {
                final trip = trips[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                  child: ListTile(
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        trip['imageUrl'] ?? '',
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => const Icon(Icons.broken_image),
                      ),
                    ),
                    title: Text(
                      trip['title'] ?? '',
                      style: const TextStyle(color: Color(0xFF003366)),
                    ),
                    subtitle: trip['rating'] != null
                        ? Row(
                            children: [
                              const Icon(Icons.star, color: Colors.orange, size: 16),
                              const SizedBox(width: 4),
                              Text(
                                trip['rating']!,
                                style: const TextStyle(color: Color(0xFF003366))),
                            ],
                          )
                        : null,
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () => _removeTrip(index),
                    ),
                    onTap: () {
                      // Optional: Add navigation to trip details if needed
                    },
                  ),
                );
              },
            ),
    );
  }
}