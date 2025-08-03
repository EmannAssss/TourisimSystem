import 'package:flutter/material.dart';
import 'package:flutter_application_1/room_selection_page.dart';

class HotelSelectionPage extends StatefulWidget {
  final String selectedFlight;
  final int flightPrice;
  final String destination;
  final String airline;
  final String departure;
  final String arrival;
  final String departureDate;
  final String arrivalDate;

  const HotelSelectionPage({
    super.key,
    required this.selectedFlight,
    required this.flightPrice,
    required this.destination,
    required this.airline,
    required this.departure,
    required this.arrival,
    required this.departureDate,
    required this.arrivalDate,
  });

  @override
  State<HotelSelectionPage> createState() => _HotelSelectionPageState();
}

class _HotelSelectionPageState extends State<HotelSelectionPage> {
  int? selectedHotelIndex;
  final Color textColor = const Color(0xFF003366);
  final List<Map<String, dynamic>> hotels = [
    {
      'name': 'Four Seasons',
      'price': 350,
      'rating': 5,
      'image': 'https://images.unsplash.com/photo-1566073771259-6a8506099945?ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=80',
      'location': 'Bahrain Bay',
      'amenities': ['Free WiFi', 'Pool', 'Spa', 'Beach Access'],
    },
    {
      'name': 'Novotel',
      'price': 220,
      'rating': 4,
      'image': 'https://images.unsplash.com/photo-1520250497591-112f2f40a3f4?ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=80',
      'location': 'Al Dana Resort',
      'amenities': ['Free WiFi', 'Pool', 'Restaurant'],
    },
    {
      'name': 'Gulf Hotel',
      'price': 265,
      'rating': 4,
      'image': 'https://images.unsplash.com/photo-1542314831-068cd1dbfeeb?ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=80',
      'location': 'Convention & Spa',
      'amenities': ['Free WiFi', 'Spa', 'Conference Rooms'],
    },
    {
      'name': 'Rotana',
      'price': 180,
      'rating': 3,
      'image': 'https://images.unsplash.com/photo-1557127275-f8b5ba93e24e?ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=80',
      'location': 'Downtown Manama',
      'amenities': ['Free WiFi', 'Restaurant', 'Gym'],
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Choose a hotel', style: TextStyle(color: textColor)),
        backgroundColor: Colors.orange,
      ),
      body: Column(
        children: [
          const SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: hotels.length,
              itemBuilder: (context, index) {
                final hotel = hotels[index];
                final isSelected = selectedHotelIndex == index;
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: HotelCard(
                    name: hotel['name'],
                    rating: hotel['rating'],
                    imageUrl: hotel['image'],
                    location: hotel['location'],
                    amenities: List<String>.from(hotel['amenities']),
                    isSelected: isSelected,
                    textColor: textColor,
                    onTap: () {
                      setState(() {
                        selectedHotelIndex = index;
                      });
                    },
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: selectedHotelIndex == null
                  ? null
                  : () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RoomSelectionPage(
                            hotelName: hotels[selectedHotelIndex!]['name'],
                            hotelPrice: hotels[selectedHotelIndex!]['price'],
                            flightPrice: widget.flightPrice,
                            airline: widget.airline,
                            departure: widget.departure,
                            arrival: widget.arrival,
                            departureDate: widget.departureDate,
                            arrivalDate: widget.arrivalDate,
                          ),
                        ),
                      );
                    },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                'Next: choose the room',
                style: TextStyle(
                  fontSize: 16,
                  color: textColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class HotelCard extends StatelessWidget {
  final String name;
  final int rating;
  final String imageUrl;
  final String location;
  final List<String> amenities;
  final bool isSelected;
  final Color textColor;
  final VoidCallback onTap;

  const HotelCard({
    super.key,
    required this.name,
    required this.rating,
    required this.imageUrl,
    required this.location,
    required this.amenities,
    required this.isSelected,
    required this.textColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(
            color: isSelected ? Colors.orange : Colors.grey.shade300,
            width: 2,
          ),
        ),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
              child: Image.network(
                imageUrl,
                height: 150,
                width: double.infinity,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Container(
                    height: 150,
                    color: Colors.orange,
                    child: const Center(child: CircularProgressIndicator()),
                  );
                },
                errorBuilder: (_, __, ___) => Container(
                  height: 150,
                  color: Colors.grey[200],
                  child: const Icon(Icons.hotel, size: 50, color: Colors.orange),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          name,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: textColor,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Row(
                        children: [
                          const Icon(Icons.star, color: Colors.amber, size: 18),
                          Text(
                            '$rating',
                            style: TextStyle(color: textColor),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    location,
                    style: TextStyle(
                      color: textColor.withOpacity(0.7),
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 4,
                    children: amenities
                        .map((amenity) => Chip(
                              label: Text(
                                amenity,
                                style: TextStyle(color: textColor),
                              ),
                              backgroundColor: textColor.withOpacity(0.1),
                              labelStyle: const TextStyle(fontSize: 12),
                            ))
                        .toList(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}