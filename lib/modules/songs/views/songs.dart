import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soundify/core/theme/app_colors.dart';
import 'package:soundify/modules/songs/views/all_songs.dart';
import 'package:soundify/modules/songs/views/favourite_song.dart';
import 'package:soundify/modules/songs/views/playlists.dart';
import 'package:soundify/widgets/custom_text.dart';

class Songs extends StatefulWidget {
  const Songs({super.key});

  @override
  State<Songs> createState() => _SongsState();
}

class _SongsState extends State<Songs> {
  bool isSearchTap = false;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          toolbarHeight: 50,
          backgroundColor: AppColors.background,
          actions: [
            InkWell(
              onTap: () {
                setState(() {
                  isSearchTap = !isSearchTap;
                });
              },
              child: Icon(
                isSearchTap ? Icons.cancel : Icons.search,
                color: AppColors.primary,
              ),
            ),
            SizedBox(width: 20),
            InkWell(
              onTap: () {},
              child: Icon(Icons.more_vert, color: AppColors.primary),
            ),
            SizedBox(width: 20),
          ],
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TabBar(
              indicatorColor: AppColors.primary,
              indicatorSize: TabBarIndicatorSize.tab,
              labelColor: AppColors.primary,
              unselectedLabelColor: AppColors.white,
              tabs: [
                Tab(text: "All Songs"),
                Tab(text: "Favourite"),
                Tab(text: "Playlist"),
              ],
            ),

            Expanded(
              child: TabBarView(
                children: [AllSongs(), FavouriteSong(), Playlists()],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
