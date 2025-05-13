import 'package:flutter/material.dart';
import 'login_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int _currentIndex = 0;

  final List<Map<String, String>> onboardingData = [
    {
      "title": "Plan Your Trip",
      "description": "Easily organize flights, hotels, and attractions in one place.",
      "image": "🧳"
    },
    {
      "title": "Explore Top Spots",
      "description": "Discover beautiful places tailored to your interests.",
      "image": "🏔️"
    },
    {
      "title": "Make Memories",
      "description": "Enjoy a stress-free travel experience with our smart tools.",
      "image": "📸"
    },
  ];

 void _goToLogin() {
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (_) =>  LoginScreen()),
  );
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF8F0),
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _controller,
              onPageChanged: (index) => setState(() => _currentIndex = index),
              itemCount: onboardingData.length,
              itemBuilder: (_, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 60.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        onboardingData[index]["image"]!,
                        style: const TextStyle(fontSize: 80),
                      ),
                      const SizedBox(height: 40),
                      Text(
                        onboardingData[index]["title"]!,
                        style: const TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFDA6F2B),
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20),
                      Text(
                        onboardingData[index]["description"]!,
                        style: const TextStyle(fontSize: 16, color: Colors.brown),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              onboardingData.length,
              (index) => AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                margin: const EdgeInsets.symmetric(horizontal: 4),
                height: 8,
                width: _currentIndex == index ? 24 : 8,
                decoration: BoxDecoration(
                  color: _currentIndex == index ? Colors.orange : Colors.grey,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
          ),
          const SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFDA6F2B),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                minimumSize: const Size(double.infinity, 50),
              ),
              onPressed: _goToLogin,
              child: const Text("Get Started"),
            ),
          ),
          const SizedBox(height: 50),
        ],
      ),
    );
  }
}
