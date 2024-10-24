import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:testflutter/main.dart';
import 'package:testflutter/pages/camera.dart';

import 'package:testflutter/pages/home.dart';
import 'package:testflutter/pages/profile.dart';




class MainScreen extends StatefulWidget {

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final List<Widget> pages = [
    const HomePage(), // หน้าหลัก
     CameraPage(), //  Camera
    const Profile(), // หน้าโปรไฟล์
  ];
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentPage], // ใช้ body เพื่อแสดงหน้าที่เลือก
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