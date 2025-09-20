import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:soundify/core/constant/app_strings.dart';
import 'package:soundify/core/services/audio_player_services.dart';
import 'package:soundify/core/theme/app_colors.dart';
import 'package:soundify/modules/songs/controller/song_controller.dart';
import 'package:soundify/widgets/custom_text.dart';

class CustomSongTile extends StatelessWidget {
  final bool isFavorite;
  final SongModel song;
  final int index;
  const CustomSongTile({
    super.key,
    this.isFavorite = false,
    required this.song,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final songController = Get.find<SongController>();
    debugPrint(song.album);
    return ListTile(
      splashColor: Colors.transparent,
      onTap: () async {
        songController.currentSongIndex.value = index;
        songController.repeatSongNumber.value = 2;
        await AudioPlayerServices.repeatMusic(
          loopMode: LoopMode.all,
          initialIndex: index,
          playlist: songController.allSongs,
        );
      },
      contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
      leading: Container(
        height: 50.h,
        width: 50.w,
        padding: EdgeInsets.all(.2),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
          color: AppColors.primary,
        ),
        child: QueryArtworkWidget(
          id: song.id,
          artworkBorder: BorderRadius.circular(10.r),
          type: ArtworkType.AUDIO,
          nullArtworkWidget: const Icon(
            Icons.music_note,
            color: AppColors.white,
          ), // agar image na ho
        ),
      ),
      title: Obx(
        () => CustomText(
          text: song.title,
          style: TextStyle(
            color:
                songController.currentSongIndex.value == index
                    ? AppColors.primary
                    : AppColors.white,
            fontSize: 16.sp,
            fontWeight:
                songController.currentSongIndex.value == index
                    ? FontWeight.w600
                    : FontWeight.normal,
          ),
        ),
      ),

      subtitle: Obx(
        () => CustomText(
          text: song.artist ?? AppStrings.unknown,
          style: TextStyle(
            color:
                songController.currentSongIndex.value == index
                    ? AppColors.primary
                    : AppColors.lightGrey,
            fontSize: 13.sp,
            fontWeight:
                songController.currentSongIndex.value == index
                    ? FontWeight.w600
                    : FontWeight.normal,
          ),
        ),
      ),
      trailing: Obx(
        () => InkWell(
          onTap: () async {
            songController.currentSongIndex.value = index;
            await songController.stopSong();
            await songController.playPauseSong();
          },
          child: Container(
            padding: EdgeInsets.all(2),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.primary,
            ),
            child: Icon(
              songController.currentSongIndex.value == index
                  ? Icons.pause_rounded
                  : Icons.play_arrow_rounded,
              color: AppColors.white,
              size: 20.r,
            ),
          ),
        ),
      ),
    );
  }
}
