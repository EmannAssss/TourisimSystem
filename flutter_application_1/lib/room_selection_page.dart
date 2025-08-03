import 'package:flutter/material.dart';
import 'package:flutter_application_1/BookingConfirmationPage.dart';

class RoomSelectionPage extends StatefulWidget {
  final String hotelName;
  final int hotelPrice;
  final int flightPrice;
  final String airline;
  final String departure;
  final String arrival;
  final String departureDate;
  final String arrivalDate;

  const RoomSelectionPage({
    super.key,
    required this.hotelName,
    required this.hotelPrice,
    required this.flightPrice,
    required this.airline,
    required this.departure,
    required this.arrival,
    required this.departureDate,
    required this.arrivalDate,
  });

  @override
  State<RoomSelectionPage> createState() => _RoomSelectionPageState();
}

class _RoomSelectionPageState extends State<RoomSelectionPage> {
  final List<Map<String, dynamic>> selectedRooms = [];
  final List<Map<String, dynamic>> selectedServices = [];
  final Map<int, int> roomQuantities = {};
  final Color textColor = const Color(0xFF003366);

  final List<Map<String, dynamic>> rooms = [
    {
      'name': 'Suite Room',
      'price': 250,
      'image': 'https://images.unsplash.com/photo-1582719478250-c89cae4dc85b?ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=80',
      'description': 'Luxurious suite with king bed and city view',
      'services': [
        {'name': 'Breakfast', 'price': 15},
        {'name': 'Airport Transfer', 'price': 30},
        {'name': 'Spa Access', 'price': 50},
        {'name': 'Laundry Service', 'price': 20},
        {'name': 'Mini Bar', 'price': 25},
      ]
    },
    {
      'name': 'Double Room',
      'price': 180,
      'image': 'https://images.unsplash.com/photo-1631049307264-da0ec9d70304?ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=80',
      'description': 'Comfortable room with two queen beds',
      'services': [
        {'name': 'Breakfast', 'price': 15},
        {'name': 'Late Checkout', 'price': 20},
        {'name': 'Room Service', 'price': 25},
        {'name': 'Extra Bed', 'price': 30},
        {'name': 'Daily Newspaper', 'price': 5},
      ]
    },
    {
      'name': 'Single Room',
      'price': 120,
      'image': 'https://images.unsplash.com/photo-1578683010236-d716f9a3f461?ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=80',
      'description': 'Cozy room with single bed',
      'services': [
        {'name': 'Breakfast', 'price': 15},
        {'name': 'WiFi Premium', 'price': 10},
        {'name': 'Parking Space', 'price': 15},
        {'name': 'Safe Deposit Box', 'price': 5},
      ]
    },
  ];

  void _toggleRoomSelection(int index) {
    setState(() {
      if (selectedRooms.contains(rooms[index])) {
        selectedRooms.remove(rooms[index]);
        roomQuantities.remove(index);
        selectedServices.removeWhere((service) => service['roomIndex'] == index);
      } else {
        selectedRooms.add(rooms[index]);
        roomQuantities[index] = 1;
      }
    });
  }

  void _toggleServiceSelection(int roomIndex, int serviceIndex) {
    setState(() {
      final serviceKey = {'roomIndex': roomIndex, 'serviceIndex': serviceIndex};
      if (selectedServices.contains(serviceKey)) {
        selectedServices.remove(serviceKey);
      } else {
        selectedServices.add(serviceKey);
      }
    });
  }

  void _updateRoomQuantity(int index, int newQuantity) {
    setState(() {
      if (newQuantity > 0) {
        roomQuantities[index] = newQuantity;
      } else {
        _toggleRoomSelection(index);
      }
    });
  }

  bool _isRoomSelected(int index) {
    return selectedRooms.contains(rooms[index]);
  }

  bool _isServiceSelected(int roomIndex, int serviceIndex) {
    return selectedServices.any((service) => 
      service['roomIndex'] == roomIndex && service['serviceIndex'] == serviceIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Choose Your Room', style: TextStyle(color: Color(0xFF003366))),
        backgroundColor: Colors.orange,
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                ...rooms.asMap().entries.map((entry) {
                  final index = entry.key;
                  final room = entry.value;
                  final String roomName = room['name'] as String;
                  final int price = room['price'] as int;
                  final String image = room['image'] as String;
                  final String description = room['description'] as String;
                  final List<dynamic> services = room['services'] as List<dynamic>;
                  final bool isSelected = _isRoomSelected(index);
                  final int quantity = roomQuantities[index] ?? 1;

                  return Card(
                    margin: const EdgeInsets.only(bottom: 16),
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.vertical(top: Radius.circular(4)),
                          child: Image.network(
                            image,
                            height: 180,
                            width: double.infinity,
                            fit: BoxFit.cover,
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) return child;
                              return Container(
                                height: 180,
                                color: Colors.grey[200],
                                child: const Center(child: CircularProgressIndicator()),
                              );
                            },
                            errorBuilder: (_, __, ___) => Container(
                              height: 180,
                              color: Colors.grey[200],
                              child: const Icon(Icons.broken_image, size: 50),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    roomName,
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: textColor,
                                    ),
                                  ),
                                  Text(
                                    '\$$price',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: textColor,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Text(
                                description,
                                style: TextStyle(color: textColor),
                              ),
                              const SizedBox(height: 16),
                              ListTile(
                                title: Text(
                                  'Choose this room',
                                  style: TextStyle(color: textColor),
                                ),
                                trailing: Switch(
                                  value: isSelected,
                                  onChanged: (bool value) {
                                    _toggleRoomSelection(index);
                                  },
                                  activeColor: Colors.orange,
                                ),
                              ),
                              if (isSelected) ...[
                                const SizedBox(height: 8),
                                Row(
                                  children: [
                                    Text(
                                      'Quantity ',
                                      style: TextStyle(color: textColor),
                                    ),
                                    IconButton(
                                      icon: Icon(Icons.remove, color: textColor),
                                      onPressed: () {
                                        _updateRoomQuantity(index, quantity - 1);
                                      },
                                    ),
                                    Text(
                                      '$quantity',
                                      style: TextStyle(color: textColor),
                                    ),
                                    IconButton(
                                      icon: Icon(Icons.add, color: textColor),
                                      onPressed: () {
                                        _updateRoomQuantity(index, quantity + 1);
                                      },
                                    ),
                                  ],
                                ),
                                const Divider(),
                                Text(
                                  'Additional Services',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: textColor,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                ...services.asMap().entries.map((serviceEntry) {
                                  final serviceIndex = serviceEntry.key;
                                  final service = serviceEntry.value;
                                  final isServiceSelected = _isServiceSelected(index, serviceIndex);
                                  
                                  return CheckboxListTile(
                                    title: Text(
                                      service['name'],
                                      style: TextStyle(color: textColor),
                                    ),
                                    subtitle: Text(
                                      '\$${service['price']}',
                                      style: TextStyle(color: textColor),
                                    ),
                                    value: isServiceSelected,
                                    onChanged: (bool? value) {
                                      _toggleServiceSelection(index, serviceIndex);
                                    },
                                    activeColor: Colors.orange,
                                    controlAffinity: ListTileControlAffinity.leading,
                                  );
                                }).toList(),
                              ],
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: selectedRooms.isEmpty
                    ? null
                    : () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BookingConfirmationPage(
                              hotelName: widget.hotelName,
                              hotelPrice: widget.hotelPrice,
                              flightPrice: widget.flightPrice,
                              selectedRooms: selectedRooms,
                              roomQuantities: roomQuantities,
                              selectedServices: selectedServices,
                              allRooms: rooms,
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
                  'Next: Booking Confirmation',
                  style: TextStyle(
                    fontSize: 16,
                    color: textColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}