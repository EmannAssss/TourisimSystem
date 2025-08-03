import 'package:flutter/material.dart';
import 'TripDetailsPage.dart';
import 'MyTripsPage.dart';
import 'FavoritesPage.dart';
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
      FavoritesPage(bookedTrips: _bookedTrips),
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
      appBar: _selectedIndex == 0
          ? AppBar(
              title: const Text(
                'Home Page',
                style: TextStyle(
                  color: Color(0xFF003366),
                  fontWeight: FontWeight.bold,
                ),
              ),
              backgroundColor: Colors.orange,
              centerTitle: true,
              elevation: 0,
              iconTheme: const IconThemeData(color: Color(0xFF003366)),
            )
          : null,
      body: Column(
        children: [
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
            icon: Icon(Icons.favorite),
            label: 'Favorites',
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

class MainPage extends StatefulWidget {
  final void Function(Map<String, String>) onTripBooked;

  const MainPage({super.key, required this.onTripBooked});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final TextEditingController _searchController = TextEditingController();
  String searchText = '';

  final List<Map<String, String>> allPopularTrips = [
    {
      'title': 'Paris',
      'imageUrl': 'https://images.unsplash.com/photo-1494526585095-c41746248156?auto=format&fit=crop&w=800&q=60',
      'rating': '4.7',
    },
    {
      'title': 'Rome',
      'imageUrl': 'https://images.unsplash.com/photo-1507133750040-15c6c5c2b5e9?auto=format&fit=crop&w=800&q=60',
      'rating': '4.6',
    },
    {
      'title': 'Tokyo',
      'imageUrl': 'https://images.unsplash.com/photo-1559181567-c3190ca9959b?auto=format&fit=crop&w=800&q=60',
      'rating': '4.5',
    },
    {
      'title': 'Dubai',
      'imageUrl': 'https://images.unsplash.com/photo-1508051123996-69f8caf4891e?auto=format&fit=crop&w=800&q=60',
      'rating': '4.8',
    },
  ];

  final List<Map<String, String>> allExploratoryTrips = [
    {
      'title': 'Amazon',
      'imageUrl': 'https://images.unsplash.com/photo-1506744038136-46273834b3fb?auto=format&fit=crop&w=800&q=60',
      'rating': '4.9',
    },
    {
      'title': 'Himalayas',
      'imageUrl': 'https://images.unsplash.com/photo-1517821361339-4d5d8f18f40e?auto=format&fit=crop&w=800&q=60',
      'rating': '4.8',
    },
    {
      'title': 'Sahara',
      'imageUrl': 'https://images.unsplash.com/photo-1500534623283-312aade485b7?auto=format&fit=crop&w=800&q=60',
      'rating': '4.7',
    },
    {
      'title': 'African Forests',
      'imageUrl': 'https://images.unsplash.com/photo-1501769214405-82f3a8a7c430?auto=format&fit=crop&w=800&q=60',
      'rating': '4.6',
    },
  ];

  final List<Map<String, String>> allSpecialOffers = [
    {
      'title': 'Turkey Offer',
      'imageUrl': 'https://images.unsplash.com/photo-1509927085806-39791f84fbf7?auto=format&fit=crop&w=800&q=60',
      'rating': '4.8',
    },
    {
      'title': 'Thailand Offer',
      'imageUrl': 'https://images.unsplash.com/photo-1494522338154-53c3ec4f2a94?auto=format&fit=crop&w=800&q=60',
      'rating': '4.9',
    },
    {
      'title': 'Morocco Offer',
      'imageUrl': 'https://images.unsplash.com/photo-1506744038136-46273834b3fb?auto=format&fit=crop&w=800&q=60',
      'rating': '4.7',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final filteredPopular = allPopularTrips
        .where((trip) => trip['title']!.toLowerCase().contains(searchText.toLowerCase()))
        .toList();

    final filteredExploratory = allExploratoryTrips
        .where((trip) => trip['title']!.toLowerCase().contains(searchText.toLowerCase()))
        .toList();

    final filteredOffers = allSpecialOffers
        .where((trip) => trip['title']!.toLowerCase().contains(searchText.toLowerCase()))
        .toList();

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSearchBar(),
          const SizedBox(height: 10),
          _buildSectionTitle('Popular Places'),
          _buildHorizontalTripList(context, filteredPopular),
          _buildSectionTitle('Exploratory Trips'),
          _buildHorizontalTripList(context, filteredExploratory),
          _buildSectionTitle('Special Offers'),
          _buildOfferList(context, filteredOffers),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return TextField(
      controller: _searchController,
      decoration: InputDecoration(
        hintText: 'Search destinations...',
        prefixIcon: const Icon(Icons.search),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        filled: true,
        fillColor: Colors.grey[200],
      ),
      onChanged: (value) {
        setState(() {
          searchText = value;
        });
      },
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Color(0xFF003366),
        ),
      ),
    );
  }

  Widget _buildHorizontalTripList(BuildContext context, List<Map<String, String>> trips) {
    return SizedBox(
      height: 180,
      child: trips.isEmpty
          ? const Center(child: Text("No results found."))
          : ListView(
              scrollDirection: Axis.horizontal,
              children: trips.map((trip) {
                return Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: _TripCard(
                    title: trip['title']!,
                    imageUrl: trip['imageUrl']!,
                    rating: trip['rating']!,
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => TripDetailsPage(
                            title: trip['title']!,
                            imageUrl: trip['imageUrl']!,
                            description: 'A wonderful trip to ${trip['title']} awaits you!',
                            tripPlan: [
                              'Arrival and check-in',
                              'City tour',
                              'Visit local attractions',
                              'Departure',
                            ],
                            onBookTrip: () {
                              widget.onTripBooked({
                                'title': trip['title']!,
                                'imageUrl': trip['imageUrl']!,
                                'rating': trip['rating'] ?? '4.5',
                              });
                            },
                          ),
                        ),
                      );
                    },
                  ),
                );
              }).toList(),
            ),
    );
  }

  Widget _buildOfferList(BuildContext context, List<Map<String, String>> offers) {
    return Column(
      children: offers.map((offer) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: _OfferCard(
            title: offer['title']!,
            imageUrl: offer['imageUrl']!,
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
                      widget.onTripBooked({
                        'title': offer['title']!,
                        'imageUrl': offer['imageUrl']!,
                        'rating': offer['rating'] ?? '4.5',
                      });
                    },
                  ),
                ),
              );
            },
          ),
        );
      }).toList(),
    );
  }
}

class _TripCard extends StatelessWidget {
  final String title;
  final String imageUrl;
  final String rating;
  final VoidCallback onTap;

  const _TripCard({
    required this.title,
    required this.imageUrl,
    required this.rating,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 140,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          image: DecorationImage(
            image: NetworkImage(imageUrl),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.2),
              BlendMode.darken,
            ),
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              bottom: 8,
              left: 8,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.orange, size: 16),
                      Text(
                        rating,
                        style: const TextStyle(color: Colors.white),
                      ),
                    ],
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

class _OfferCard extends StatelessWidget {
  final String title;
  final String imageUrl;
  final VoidCallback onTap;

  const _OfferCard({
    required this.title,
    required this.imageUrl,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 120,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          image: DecorationImage(
            image: NetworkImage(imageUrl),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.3),
              BlendMode.darken,
            ),
          ),
        ),
        child: Center(
          child: Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
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