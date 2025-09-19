import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:soundify/core/theme/app_colors.dart';
import 'package:soundify/modules/home/widget/custom_song_tile.dart';
import 'package:soundify/modules/songs/controller/song_controller.dart';

class AllSongs extends StatefulWidget {
  const AllSongs({super.key});

  @override
  State<AllSongs> createState() => _AllSongsState();
}

class _AllSongsState extends State<AllSongs> {
  final SongController songController = Get.find<SongController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w),

        child: Column(
          children: [
            Obx(
              ()=> Expanded(
                child: ListView.separated(
                  padding: EdgeInsets.zero,
                  itemCount: 20,
              
                  itemBuilder: (context, index) {

                    return CustomSongTile(song: songController.allSongs[index],index: index,);
                  },
                  separatorBuilder: (context, index) {
                    return Divider(height: 5, color: AppColors.darkGrey);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
