import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soundify/core/theme/app_colors.dart';
import 'package:soundify/modules/songs/views/playlist_details.dart';
import 'package:soundify/widgets/custom_text.dart';

class Playlists extends StatefulWidget {
  const Playlists({super.key});

  @override
  State<Playlists> createState() => _PlaylistsState();
}

class _PlaylistsState extends State<Playlists> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w),

        child: Column(
          children: [
            Expanded(
              child: ListView.separated(
                padding: EdgeInsets.zero,
                itemCount: 3,

                itemBuilder: (context, index) {
                  return buildPlayListTile(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PlaylistDetails(),
                        ),
                      );
                    },
                  );
                },
                separatorBuilder: (context, index) {
                  return Divider(height: 5, color: AppColors.darkGrey);
                },
              ),
            ),
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.secondary,
        onPressed: () {},
        child: Icon(Icons.add, color: AppColors.white),
      ),
    );
  }

  Widget buildPlayListTile({VoidCallback? onTap}) {
    return InkWell(
      onTap: onTap,
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
        leading: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.r),
            color: AppColors.grey,
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10.r),
            child: Icon(Icons.music_note, color: AppColors.primary),
          ),
        ),
        title: CustomText(
          text: "Tujhe Yaad Na Meri Ayi tujhe ab kya kahna",
          style: TextStyle(color: AppColors.white, fontSize: 16.sp),
        ),

        subtitle: CustomText(
          text: "2",
          style: TextStyle(color: AppColors.lightGrey, fontSize: 14.sp),
        ),
        trailing: Icon(Icons.chevron_right, color: AppColors.primary),
      ),
    );
  }
}
