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
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          padding: EdgeInsets.only(left: 15.w, right: 15.w),
          decoration: BoxDecoration(
            color: AppColors.darkGrey,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.r),
              topRight: Radius.circular(20.r),
            ),
          ),
          child: ListTile(
            onTap: () {
              Get.toNamed(AppRoutes.songDetails);
            },
            contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
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
                nullArtworkWidget: const Icon(
                  Icons.music_note,
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
                  onPressed: () {},
                  icon: Icon(
                    Icons.skip_previous,
                    size: 30.r,
                    color: AppColors.primary,
                  ),
                ),
                InkWell(
                  onTap: () async {},
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 5.w),
                    padding: EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.primary,
                    ),
                    child: Icon(
                      Icons.play_arrow_rounded,
                      color: AppColors.white,
                      size: 20.r,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {},
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
        LinearProgressIndicator(
          color: AppColors.primary,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(2.r),
            bottomRight: Radius.circular(2.r),
          ),
          value: .5,
        ),
      ],
    );
  }
}
