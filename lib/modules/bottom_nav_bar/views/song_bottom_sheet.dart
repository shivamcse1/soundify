import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:soundify/core/constant/app_strings.dart';
import 'package:soundify/core/routes/app_routes.dart';
import 'package:soundify/core/theme/app_colors.dart';
import 'package:soundify/modules/songs/controller/song_controller.dart';
import 'package:soundify/widgets/custom_text.dart';

class SongBottomSheet extends StatefulWidget {
  const SongBottomSheet({super.key});

  @override
  State<SongBottomSheet> createState() => _SongBottomSheetState();
}

class _SongBottomSheetState extends State<SongBottomSheet> {
  final SongController songController = Get.find<SongController>();
  @override
  Widget build(BuildContext context) {
    final SongModel song =
        songController.allSongs[songController.currentSongIndex.value];
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: EdgeInsets.only(left: 15.w, right: 15.w),
          decoration: BoxDecoration(
            color: AppColors.grey,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.r),
              topRight: Radius.circular(20.r),
            ),
          ),
          child: ListTile(
            minTileHeight: 50.h,
            onTap: () {
              Get.toNamed(AppRoutes.songDetails);
            },
            contentPadding: EdgeInsets.zero,
            leading: Container(
              height: 40.h,
              width: 40.w,
              padding: EdgeInsets.all(.5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.r),
                color: AppColors.primary,
              ),
              child: QueryArtworkWidget(
                id: song.id,
                artworkBorder: BorderRadius.circular(10.r),
                type: ArtworkType.AUDIO,
                size: 500,
                nullArtworkWidget: Icon(
                  Icons.music_note,
                  color: AppColors.white,
                ), // agar image na ho
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
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  onPressed: () async {
                    await songController.playPreviousSong();
                  },
                  icon: Icon(
                    Icons.skip_previous,
                    size: 30.r,
                    color: AppColors.primary,
                  ),
                ),
                InkWell(
                  onTap: () async {
                    await songController.playPauseSong();
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 5.w),
                    padding: EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.primary,
                    ),
                    child: Obx(
                      () => Icon(
                        songController.isPlaying.value
                            ? Icons.pause_rounded
                            : Icons.play_arrow_rounded,
                        color: AppColors.white,
                        size: 20.r,
                      ),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () async {
                    await songController.playNextSong();
                  },
                  icon: Icon(
                    Icons.skip_next_rounded,
                    size: 30.r,
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
          ),
        ),
        Obx(() {
          final total = songController.totalDuration.value.inMilliseconds;
          final current = songController.currentPosition.value.inMilliseconds;
          if (total == 0) {
            return const LinearProgressIndicator(value: 0);
          }
          final progress = (current / total).clamp(0.0, 1.0);

          return LinearProgressIndicator(
            color: AppColors.primary,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(2.r),
              bottomRight: Radius.circular(2.r),
            ),
            value: progress,
          );
        }),
      ],
    );
  }
}
