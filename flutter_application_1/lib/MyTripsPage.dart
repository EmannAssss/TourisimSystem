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
      widget.bookedTrips.removeAt(index); // تحديث القائمة الأصلية
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('تم حذف الرحلة')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return trips.isEmpty
        ? Center(
            child: Text(
              'لا توجد رحلات محجوزة حتى الآن',
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
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
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
                  title: Text(trip['title'] ?? ''),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () => _removeTrip(index),
                  ),
                ),
              );
            },
          );
  }
}
