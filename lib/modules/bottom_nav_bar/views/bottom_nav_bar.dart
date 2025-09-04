import 'package:flutter/material.dart';
import 'package:soundify/modules/home/views/home.dart';
import 'package:soundify/modules/profile/views/profile.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int currentIndex = 0;
  final List<Widget> _pages = [
    Home(),
    Profile(),
    Profile(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[0],
      bottomNavigationBar: NavigationBar(
        destinations: [
            NavigationDestination(icon: Icon(Icons.home), label: "Home"),
            NavigationDestination(icon: Icon(Icons.favorite), label: "Wishlist"),
            NavigationDestination(icon: Icon(Icons.person), label: "Profile"),
         ]
        )
    );
  }
}
