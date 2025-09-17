import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:soundify/core/constant/app_strings.dart';
import 'package:soundify/core/routes/app_routes.dart';
import 'package:soundify/core/theme/app_colors.dart';
import 'package:soundify/modules/home/controller/home_controller.dart';
import 'package:soundify/widgets/custom_text.dart';

class SongBottomSheet extends StatefulWidget {
  const SongBottomSheet({super.key});

  @override
  State<SongBottomSheet> createState() => _SongBottomSheetState();
}

class _SongBottomSheetState extends State<SongBottomSheet> {
  final HomeController homeController = Get.find<HomeController>();
  @override
  Widget build(BuildContext context) {
    final song = homeController.allSongs[0];
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
                id: 22,
                artworkBorder: BorderRadius.circular(10.r),
                type: ArtworkType.AUDIO,
                nullArtworkWidget: const Icon(
                  Icons.music_note,
                ), // agar image na ho
              ),
            ),
            title: CustomText(
              text: "ksdkdksdnksdndwk",
              style: TextStyle(color: AppColors.white, fontSize: 16.sp),
            ),

            subtitle: CustomText(
              text: AppStrings.unknown,
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
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.play_circle_outline_outlined,
                    size: 30.r,
                    color: AppColors.primary,
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
