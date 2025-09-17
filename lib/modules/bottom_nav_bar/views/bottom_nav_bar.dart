import 'package:flutter/material.dart';
import 'package:soundify/core/theme/app_colors.dart';
import 'package:soundify/modules/bottom_nav_bar/views/song_bottom_sheet.dart';
import 'package:soundify/modules/home/views/home.dart';
import 'package:soundify/modules/profile/views/profile.dart';
import 'package:soundify/modules/songs/views/songs.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int currentIndex = 0;
  final List<Widget> _pages = [Home(), Songs(), Profile()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[currentIndex],
      bottomSheet: SongBottomSheet(),
      bottomNavigationBar: NavigationBar(
        // backgroundColor: AppColors.background,
        height: 60,
        selectedIndex: currentIndex,
        onDestinationSelected: (idx) {
          setState(() {
            currentIndex = idx;
          });
        },
        destinations: [
          NavigationDestination(
            icon: Icon(Icons.home),
            label: "Home",
            selectedIcon: Icon(Icons.home, color: AppColors.primary),
          ),
          NavigationDestination(
            icon: Icon(Icons.music_note),
            label: "All Songs",
            selectedIcon: Icon(Icons.music_note, color: AppColors.primary),
          ),
          NavigationDestination(
            icon: Icon(Icons.person),
            label: "Profile",
            selectedIcon: Icon(Icons.person, color: AppColors.primary),
          ),
        ],
      ),
    );
  }
}
