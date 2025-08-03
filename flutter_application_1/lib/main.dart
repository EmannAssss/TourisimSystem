import 'package:flutter/material.dart';
import 'package:flutter_application_1/hotel_selection_page.dart';
import 'package:flutter_application_1/Splash_Screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Travel Planner',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
        useMaterial3: true,
        fontFamily: 'Roboto',
      ),
      home: const SplashScreen(),
      routes: {
        '/hotelSelection': (context) => HotelSelectionPage(
              selectedFlight: 'Qatar Airways',
              flightPrice: 650,
              destination: 'Bahrain',
              airline: 'Qatar Airways',
              departure: 'KWI - Kuwait',
              arrival: 'BAH - Bahrain',
              departureDate: '24 Sep. 08:30 AM',
              arrivalDate: '24 Sep. 11:45 AM',
            ),
      },
    );
  }
}