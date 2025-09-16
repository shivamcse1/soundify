import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soundify/core/theme/app_colors.dart';
import 'package:soundify/modules/home/widget/custom_song_tile.dart';
import 'package:soundify/widgets/custom_text.dart';

class PlaylistDetails extends StatefulWidget {
  const PlaylistDetails({super.key});

  @override
  State<PlaylistDetails> createState() => _PlaylistDetailsState();
}

class _PlaylistDetailsState extends State<PlaylistDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        toolbarHeight: 50,
        iconTheme: IconThemeData(color: AppColors.primary),
        backgroundColor: AppColors.background,
        title: CustomText(
          text: "PlayList 1",
          style: TextStyle(
            fontSize: 16.sp,
            color: AppColors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          InkWell(
            onTap: () {},
            child: Icon(Icons.add, color: AppColors.primary),
          ),
          SizedBox(width: 10),

          InkWell(
            onTap: () {},
            child: Icon(Icons.search, color: AppColors.primary),
          ),
          SizedBox(width: 10),
          InkWell(
            onTap: () {},
            child: Icon(Icons.more_vert, color: AppColors.primary),
          ),
          SizedBox(width: 10),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: ListView.separated(
                padding: EdgeInsets.zero,
                itemCount: 20,

                itemBuilder: (context, index) {
                  return CustomSongTile();
                },
                separatorBuilder: (context, index) {
                  return Divider(height: 5, color: AppColors.darkGrey);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
