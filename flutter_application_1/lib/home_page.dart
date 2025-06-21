import 'package:flutter/material.dart';
import 'TripDetailsPage.dart';
import 'MyTripsPage.dart';
import 'ProfilePage.dart';
import 'settingsPage.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  final PageController _pageController = PageController();
  final List<Map<String, String>> _bookedTrips = [];

  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      MainPage(onTripBooked: _addTripToBooked),
      MyTripsPage(bookedTrips: _bookedTrips),
      const ProfilePage(),
      const SettingsPage(),
    ];
  }

  void _addTripToBooked(Map<String, String> trip) {
    setState(() {
      _bookedTrips.add(trip);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Trip added to My Trips: ${trip['title']}')),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _pageController.jumpToPage(index);
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Welcome to Triplla',
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
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search for trips...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          Expanded(
            child: PageView(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(),
              children: _pages,
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: const Color(0xFF003366),
        unselectedItemColor: const Color(0xFF003366).withOpacity(0.5),
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        backgroundColor: const Color(0xFFFFFAF0),
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_filled),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.airplane_ticket),
            label: 'My Trips',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}

// ------------------ MainPage -----------------------

class MainPage extends StatelessWidget {
  final void Function(Map<String, String>) onTripBooked;

  MainPage({super.key, required this.onTripBooked});

  final List<Map<String, String>> popularTrips = [
    {
      'title': 'Paris',
      'imageUrl': 'https://images.unsplash.com/photo-1502602898657-3e91760cbb34?auto=format&fit=crop&w=800&q=60',
      'rating': '4.7',
    },
    {
      'title': 'Rome',
      'imageUrl': 'https://images.unsplash.com/photo-1501594907352-04cda38ebc29?auto=format&fit=crop&w=800&q=60',
      'rating': '4.6',
    },
    {
      'title': 'Tokyo',
      'imageUrl': 'https://images.unsplash.com/photo-1549924231-f129b911e442?auto=format&fit=crop&w=800&q=60',
      'rating': '4.5',
    },
    {
      'title': 'Dubai',
      'imageUrl': 'https://images.unsplash.com/photo-1506744038136-46273834b3fb?auto=format&fit=crop&w=800&q=60',
      'rating': '4.8',
    },
  ];

  final List<Map<String, String>> exploratoryTrips = [
    {
      'title': 'Amazon',
      'imageUrl': 'https://images.unsplash.com/photo-1509228627152-72ae9ae6848e',
      'rating': '4.9',
    },
    {
      'title': 'Himalayas',
      'imageUrl': 'https://images.unsplash.com/photo-1600671818370-e4dd86ed9b82',
      'rating': '4.8',
    },
    {
      'title': 'Sahara',
      'imageUrl': 'https://images.unsplash.com/photo-1602435119691-030cc5ca2b67',
      'rating': '4.7',
    },
    {
      'title': 'Africa Forests',
      'imageUrl': 'https://images.unsplash.com/photo-1619019093926-3b723b94d9d3',
      'rating': '4.6',
    },
  ];

  final List<Map<String, String>> specialOffers = [
    {
      'title': 'Turkey Offer',
      'imageUrl': 'https://images.unsplash.com/photo-1603618091609-c7c82647aede',
      'rating': '4.8',
    },
    {
      'title': 'Thailand Offer',
      'imageUrl': 'https://images.unsplash.com/photo-1549887534-2487c3a2f63b',
      'rating': '4.9',
    },
    {
      'title': 'Morocco Offer',
      'imageUrl': 'https://images.unsplash.com/photo-1569931725684-5bdbd1b3297a',
      'rating': '4.7',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildSectionTitle('Popular Places'),
          horizontalTripList(context, popularTrips),
          buildSectionTitle('Exploratory Trips'),
          horizontalTripList(context, exploratoryTrips),
          buildSectionTitle('Special Offers'),
          offerList(context),
        ],
      ),
    );
  }

  Widget buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Text(
        title,
        style: const TextStyle(
            fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF003366)),
      ),
    );
  }

  Widget horizontalTripList(BuildContext context, List<Map<String, String>> trips) {
    return SizedBox(
      height: 180,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: trips.map((trip) {
          return GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => TripDetailsPage(
                    title: trip['title']!,
                    imageUrl: trip['imageUrl']!,
                    description:
                        'A wonderful trip to ${trip['title']} awaits you. Explore and enjoy!',
                    tripPlan: [
                      'Arrival and check-in',
                      'City tour',
                      'Visit local attractions',
                      'Departure',
                    ],
                    onBookTrip: () {
                      onTripBooked({
                        'title': trip['title']!,
                        'imageUrl': trip['imageUrl']!,
                        'rating': trip['rating'] ?? '4.5',
                      });
                    },
                  ),
                ),
              );
            },
            child: TripCard(
              title: trip['title']!,
              imageUrl: trip['imageUrl']!,
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget offerList(BuildContext context) {
    return Column(
      children: specialOffers.map((offer) {
        return GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => TripDetailsPage(
                  title: offer['title']!,
                  imageUrl: offer['imageUrl']!,
                  description: 'Special deal to ${offer['title']}!',
                  tripPlan: [
                    'Airport pickup',
                    'Amazing tours',
                    'Local cuisine tasting',
                    'Departure',
                  ],
                  onBookTrip: () {
                    onTripBooked({
                      'title': offer['title']!,
                      'imageUrl': offer['imageUrl']!,
                      'rating': offer['rating'] ?? '4.5',
                    });
                  },
                ),
              ),
            );
          },
          child: OfferCard(
            title: offer['title']!,
            imageUrl: offer['imageUrl']!,
          ),
        );
      }).toList(),
    );
  }
}

class TripCard extends StatelessWidget {
  final String title;
  final String imageUrl;

  const TripCard({super.key, required this.title, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 140,
      margin: const EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        image: DecorationImage(
          image: NetworkImage(imageUrl),
          fit: BoxFit.cover,
          colorFilter:
              ColorFilter.mode(Colors.black.withOpacity(0.2), BlendMode.darken),
        ),
      ),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            title,
            style: const TextStyle(
                color: Color(0xFF003366), fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}

class OfferCard extends StatelessWidget {
  final String title;
  final String imageUrl;

  const OfferCard({super.key, required this.title, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        image: DecorationImage(
          image: NetworkImage(imageUrl),
          fit: BoxFit.cover,
          colorFilter:
              ColorFilter.mode(Colors.black.withOpacity(0.3), BlendMode.darken),
        ),
      ),
      child: Align(
        alignment: Alignment.center,
        child: Text(
          title,
          style: const TextStyle(
              color: Color(0xFF003366), fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
