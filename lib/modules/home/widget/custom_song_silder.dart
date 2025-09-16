import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soundify/core/constant/image_constant.dart';
import 'package:soundify/core/theme/app_colors.dart';
import 'package:soundify/data/models/song_model.dart';
import 'package:soundify/widgets/custom_text.dart';

class CustomSongSilder extends StatelessWidget {
  final List<SongModel> songData;
  final double viewPortFraction;
  final double? rightGap;
  final double? radius;
  final double height;

  const CustomSongSilder({
    super.key,
    required this.songData,
    this.viewPortFraction = .8,
    this.rightGap,
    this.radius,
    this.height = 220,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: PageView.builder(
        itemCount: 4,
        controller: PageController(viewportFraction: viewPortFraction),
        padEnds: false,
        itemBuilder: (context, index) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(radius ?? 10),
                  ),
                  margin: EdgeInsets.only(right: rightGap ?? 10),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(radius ?? 10),
                    child: Image.asset(
                      ImageConstant.albumImg,
                      fit: BoxFit.fill,
                      width: 1.sw,
                    ),
                  ),
                ),
              ),

              SizedBox(height: 10.h),
              CustomText(
                text: "Tera naam liya tujhe yaad kiya...",
                style: TextStyle(
                  color: AppColors.softWhite,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),

              CustomText(
                text: "Aditya kumar ",
                style: TextStyle(color: AppColors.grey, fontSize: 14.sp),
              ),
            ],
          );
        },
      ),
    );
  }
}
