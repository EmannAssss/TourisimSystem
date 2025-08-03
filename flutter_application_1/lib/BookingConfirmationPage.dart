import 'package:flutter/material.dart';

class BookingConfirmationPage extends StatefulWidget {
  final String hotelName;
  final int hotelPrice;
  final int flightPrice;
  final List<Map<String, dynamic>> selectedRooms;
  final Map<int, int> roomQuantities;
  final List<Map<String, dynamic>> selectedServices;
  final List<Map<String, dynamic>> allRooms;
  final String airline;
  final String departure;
  final String arrival;
  final String departureDate;
  final String arrivalDate;

  const BookingConfirmationPage({
    super.key,
    required this.hotelName,
    required this.hotelPrice,
    required this.flightPrice,
    required this.selectedRooms,
    required this.roomQuantities,
    required this.selectedServices,
    required this.allRooms,
    required this.airline,
    required this.departure,
    required this.arrival,
    required this.departureDate,
    required this.arrivalDate,
  });

  @override
  State<BookingConfirmationPage> createState() => _BookingConfirmationPageState();
}

class _BookingConfirmationPageState extends State<BookingConfirmationPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _passportController;
  late TextEditingController _emailController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _passportController = TextEditingController();
    _emailController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _passportController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  int _calculateTotalPrice() {
    int total = widget.flightPrice; // Removed hotelPrice from total calculation
    
    for (var room in widget.selectedRooms) {
      final roomIndex = widget.allRooms.indexOf(room);
      final quantity = widget.roomQuantities[roomIndex] ?? 1;
      total += (room['price'] as int) * quantity;
    }
    
    for (var service in widget.selectedServices) {
      final roomIndex = service['roomIndex'] as int;
      final serviceIndex = service['serviceIndex'] as int;
      final quantity = widget.roomQuantities[roomIndex] ?? 1;
      total += (widget.allRooms[roomIndex]['services'][serviceIndex]['price'] as int) * quantity;
    }
    
    return total;
  }

  void _confirmBooking() {
    if (_formKey.currentState!.validate()) {
      final totalPrice = _calculateTotalPrice();
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Booking Successful'),
          content: Text('Booking ID: BK${DateTime.now().millisecondsSinceEpoch}\nTotal Amount: \$$totalPrice'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.popUntil(context, (route) => route.isFirst);
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final totalPrice = _calculateTotalPrice();
    final themeColor = const Color(0xFF003366);
    final backgroundColor = Colors.orange;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Booking Confirmation', style: TextStyle(color: Color(0xFF003366))),
        backgroundColor: backgroundColor,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Traveler information
              const Text('Traveler Information',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF003366))),
              const SizedBox(height: 16),
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Full Name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your full name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _passportController,
                decoration: const InputDecoration(
                  labelText: 'Passport Number / ID',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your passport/ID number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                  hintText: 'example@domain.com',
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                    return 'Please enter a valid email address';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),

              // Flight details
              const Text('Flight Details',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF003366))),
              const SizedBox(height: 8),
              Card(
                elevation: 3,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(widget.airline, 
                            style: TextStyle(color: themeColor, fontWeight: FontWeight.bold)),
                          Text('\$${widget.flightPrice}', 
                            style: TextStyle(color: themeColor, fontWeight: FontWeight.bold)),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(widget.departure, style: TextStyle(color: themeColor)),
                          const Icon(Icons.airplanemode_active, color: Color(0xFF003366)),
                          Text(widget.arrival, style: TextStyle(color: themeColor)),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(widget.departureDate, style: TextStyle(color: themeColor)),
                          Text(widget.arrivalDate, style: TextStyle(color: themeColor)),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Hotel details (without price)
              const Text('Hotel Details',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF003366))),
              const SizedBox(height: 8),
              Card(
                elevation: 3,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(widget.hotelName, 
                        style: TextStyle(fontWeight: FontWeight.bold, color: themeColor)),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Selected rooms
              const Text('Selected Rooms',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF003366))),
              const SizedBox(height: 8),
              ...widget.selectedRooms.map((room) {
                final roomIndex = widget.allRooms.indexOf(room);
                final quantity = widget.roomQuantities[roomIndex] ?? 1;
                final roomTotal = (room['price'] as int) * quantity;
                
                // Calculate services total for this room
                int servicesTotal = 0;
                final roomServices = widget.selectedServices.where((s) => s['roomIndex'] == roomIndex).map((service) {
                  final serviceIndex = service['serviceIndex'] as int;
                  final servicePrice = widget.allRooms[roomIndex]['services'][serviceIndex]['price'] as int;
                  servicesTotal += servicePrice * quantity;
                  return {
                    'name': widget.allRooms[roomIndex]['services'][serviceIndex]['name'],
                    'price': servicePrice * quantity,
                  };
                }).toList();

                return Card(
                  elevation: 3,
                  margin: const EdgeInsets.only(bottom: 8),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(room['name'], 
                              style: TextStyle(fontWeight: FontWeight.bold, color: themeColor)),
                            Text('$quantity ×', 
                              style: TextStyle(color: themeColor)),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text('Room Price: \$$roomTotal', 
                          style: TextStyle(color: themeColor)),
                        
                        if (roomServices.isNotEmpty) ...[
                          const SizedBox(height: 8),
                          const Text('Additional Services:',
                            style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF003366))),
                          ...roomServices.map((service) {
                            return Padding(
                              padding: const EdgeInsets.only(left: 8, top: 4),
                              child: Text(
                                '- ${service['name']}: \$${service['price']}',
                                style: TextStyle(color: themeColor),
                              ),
                            );
                          }),
                          const SizedBox(height: 8),
                          Text('Services Total: \$$servicesTotal',
                            style: TextStyle(color: themeColor)),
                        ],
                        
                        const Divider(),
                        Text('Room Total: \$${roomTotal + servicesTotal}',
                          style: TextStyle(fontWeight: FontWeight.bold, color: themeColor)),
                      ],
                    ),
                  ),
                );
              }).toList(),
              const SizedBox(height: 16),

              // Payment method
              const Text('Payment Method',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF003366))),
              const SizedBox(height: 8),
              Card(
                elevation: 3,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      RadioListTile(
                        title: const Text('Wallet Payment'),
                        value: 'wallet',
                        groupValue: 'wallet',
                        onChanged: (value) {},
                        activeColor: Colors.orange,
                      ),
                      const SizedBox(height: 8),
                      const Text('Pay directly from your wallet balance',
                        style: TextStyle(color: Colors.grey)),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Price summary (without hotel base price)
              const Text('Price Summary',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF003366))),
              const SizedBox(height: 8),
              Card(
                elevation: 3,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Flight Ticket:', style: TextStyle(color: Color(0xFF003366))),
                          Text('\$${widget.flightPrice}', style: TextStyle(color: themeColor)),
                        ],
                      ),
                      ...widget.selectedRooms.map((room) {
                        final roomIndex = widget.allRooms.indexOf(room);
                        final quantity = widget.roomQuantities[roomIndex] ?? 1;
                        final roomTotal = (room['price'] as int) * quantity;
                        return Column(
                          children: [
                            const SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('${room['name']} (×$quantity):', style: TextStyle(color: themeColor)),
                                Text('\$$roomTotal', style: TextStyle(color: themeColor)),
                              ],
                            ),
                            ...widget.selectedServices.where((s) => s['roomIndex'] == roomIndex).map((service) {
                              final serviceIndex = service['serviceIndex'] as int;
                              final serviceName = widget.allRooms[roomIndex]['services'][serviceIndex]['name'];
                              final servicePrice = (widget.allRooms[roomIndex]['services'][serviceIndex]['price'] as int) * quantity;
                              return Padding(
                                padding: const EdgeInsets.only(left: 16, top: 4),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('- $serviceName:', style: TextStyle(color: themeColor)),
                                    Text('\$$servicePrice', style: TextStyle(color: themeColor)),
                                  ],
                                ),
                              );
                            }),
                          ],
                        );
                      }),
                      const Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Total Price:', 
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF003366))),
                          Text('\$$totalPrice', 
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: themeColor)),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 32),

              // Final booking confirmation button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: backgroundColor,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  onPressed: _confirmBooking,
                  child: const Text('Confirm Booking', style: TextStyle(fontSize: 18, color: Color(0xFF003366))),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}