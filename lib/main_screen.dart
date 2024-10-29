import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:testflutter/main.dart';
import 'package:testflutter/pages/camera.dart';
import 'package:testflutter/pages/home.dart';
import 'package:testflutter/pages/profile.dart';

class MainScreen extends StatefulWidget {
  final String email; 
  const MainScreen({super.key, required this.email});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late final List<Widget> pages; // Declare pages without initialization here

  int currentPage = 0;

  @override
  void initState() {
    super.initState();
    // Initialize pages in initState
    pages = [
      const HomePage(), // Home Page
      const CameraPage(), // Camera Page
      Profile(email: widget.email), // Profile Page
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentPage], // Display the selected page
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentPage,
        onTap: (value) {
          setState(() {
            currentPage = value;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.camera_alt),
            label: "Camera",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}
