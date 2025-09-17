import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:soundify/core/constant/app_strings.dart';
import 'package:soundify/core/theme/app_colors.dart';
import 'package:soundify/modules/home/views/song_details.dart';
import 'package:soundify/widgets/custom_text.dart';

class CustomSongTile extends StatelessWidget {
  final bool isFavorite;
  final SongModel song;
  const CustomSongTile({
    super.key,
    this.isFavorite = false,
    required this.song,
  });

  @override
  Widget build(BuildContext context) {
    debugPrint(song.album);
    return ListTile(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SongDetails()),
        );
      },
      contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
      leading: Container(
        height: 50.h,
        width: 50.w,
        padding: EdgeInsets.all(.5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
          color: AppColors.primary,
        ),
        child: QueryArtworkWidget(
          id: song.id,
          artworkBorder: BorderRadius.circular(10.r),
          type: ArtworkType.AUDIO,
          nullArtworkWidget: const Icon(Icons.music_note), // agar image na ho
        ),
      ),
      title: CustomText(
        text: song.title,
        style: TextStyle(color: AppColors.white, fontSize: 16.sp),
      ),

      subtitle: CustomText(
        text: song.artist ?? AppStrings.unknown,
        style: TextStyle(color: AppColors.lightGrey, fontSize: 13.sp),
      ),
      trailing: Icon(
        Icons.play_circle_outline_outlined,
        color: AppColors.primary,
        size: 25.r,
      ),
    );
  }
}
