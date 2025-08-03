import 'package:flutter/material.dart';
import 'hotel_selection_page.dart';

class FlightSelectionPage extends StatefulWidget {
  final String title;
  final String destination;
  final String destinationCode;

  const FlightSelectionPage({
    super.key, 
    required this.title,
    required this.destination,
    required this.destinationCode,
  });

  @override
  State<FlightSelectionPage> createState() => _FlightSelectionPageState();
}

class _FlightSelectionPageState extends State<FlightSelectionPage> {
  int? selectedFlightIndex;
  int ticketCount = 1;

  List<Flight> get flights => [
    Flight(
      departureTime: '08:30 AM',
      arrivalTime: '11:45 AM',
      duration: '3h 15m',
      stops: 'Direct',
      airline: 'QATAR AIRWAYS',
      price: 650,
      departureDate: '24 Sep.',
      departureCode: 'KWI',
      arrivalCode: widget.destinationCode,
    ),
    Flight(
      departureTime: '02:15 PM',
      arrivalTime: '06:30 PM',
      duration: '4h 15m',
      stops: '1 STOP',
      airline: 'EMIRATES',
      price: 580,
      departureDate: '24 Sep.',
      departureCode: 'KWI',
      arrivalCode: widget.destinationCode,
    ),
    Flight(
      departureTime: '10:45 PM',
      arrivalTime: '05:20 AM',
      duration: '6h 35m',
      stops: '1 STOP',
      airline: 'SAUDIA',
      price: 420,
      departureDate: '24 Sep.',
      departureCode: 'KWI',
      arrivalCode: widget.destinationCode,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flights to ${widget.destination}'),
        backgroundColor: Colors.orange,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: flights.length,
              itemBuilder: (context, index) {
                final flight = flights[index];
                final isSelected = selectedFlightIndex == index;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedFlightIndex = index;
                    });
                  },
                  child: Card(
                    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: BorderSide(
                        color: isSelected ? Colors.orange : Colors.grey.shade300,
                        width: isSelected ? 2 : 1,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text('From'),
                                  Text(
                                    flight.departureCode,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  ),
                                  Text(flight.departureDate),
                                  Text(flight.departureTime),
                                ],
                              ),
                              Column(
                                children: [
                                  Text(flight.duration),
                                  Text(flight.stops),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  const Text('To'),
                                  Text(
                                    '${flight.arrivalCode} (${widget.destination})',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  ),
                                  Text(flight.departureDate),
                                  Text(flight.arrivalTime),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                flight.airline,
                                style: const TextStyle(color: Colors.grey),
                              ),
                              Text(
                                '\$${flight.price}',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18),
                              ),
                            ],
                          ),
                          if (isSelected) ...[
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                const Text('Tickets:'),
                                IconButton(
                                  icon: const Icon(Icons.remove),
                                  onPressed: () {
                                    if (ticketCount > 1) {
                                      setState(() {
                                        ticketCount--;
                                      });
                                    }
                                  },
                                ),
                                Text(ticketCount.toString()),
                                IconButton(
                                  icon: const Icon(Icons.add),
                                  onPressed: () {
                                    setState(() {
                                      ticketCount++;
                                    });
                                  },
                                ),
                              ],
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: selectedFlightIndex == null
                  ? null
                  : () {
                      final selectedFlight = flights[selectedFlightIndex!];
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => HotelSelectionPage(
                            selectedFlight: selectedFlight.airline,
                            flightPrice: selectedFlight.price * ticketCount,
                            destination: widget.destination,
                            airline: selectedFlight.airline,
                            departure: '${selectedFlight.departureCode} - Kuwait',
                            arrival: '${selectedFlight.arrivalCode} - ${widget.destination}',
                            departureDate: '${selectedFlight.departureDate} ${selectedFlight.departureTime}',
                            arrivalDate: '${selectedFlight.departureDate} ${selectedFlight.arrivalTime}',
                          ),
                        ),
                      );
                    },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text('Next: Choose Hotel'),
            ),
          ),
        ],
      ),
    );
  }
}

class Flight {
  final String departureTime;
  final String arrivalTime;
  final String duration;
  final String stops;
  final String airline;
  final int price;
  final String departureDate;
  final String departureCode;
  final String arrivalCode;

  Flight({
    required this.departureTime,
    required this.arrivalTime,
    required this.duration,
    required this.stops,
    required this.airline,
    required this.price,
    required this.departureDate,
    required this.departureCode,
    required this.arrivalCode,
  });
}