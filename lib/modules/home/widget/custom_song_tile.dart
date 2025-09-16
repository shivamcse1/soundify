import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soundify/core/constant/image_constant.dart';
import 'package:soundify/core/theme/app_colors.dart';
import 'package:soundify/modules/home/views/song_details.dart';
import 'package:soundify/widgets/custom_text.dart';

class CustomSongTile extends StatelessWidget {
  final bool isFavorite;
  const CustomSongTile({super.key, this.isFavorite = false});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SongDetails()),
        );
      },
      contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
      leading: Container(
        padding: EdgeInsets.all(.5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(isFavorite ? 50.h : 10.r),
          color: AppColors.primary,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(isFavorite ? 50.h : 10.r),
          child: Image.asset(
            ImageConstant.albumImg,
            height: 50.h,
            width: 50.w,
            fit: BoxFit.fill,
          ),
        ),
      ),
      title: CustomText(
        text: "Tujhe Yaad Na Meri Ayi tujhe ab kya kahna",
        style: TextStyle(color: AppColors.white, fontSize: 16.sp),
      ),

      subtitle: CustomText(
        text: "Sonu Nigam",
        style: TextStyle(color: AppColors.lightGrey, fontSize: 14.sp),
      ),
      trailing: Icon(
        Icons.play_circle_outline_outlined,
        color: AppColors.primary,
      ),
    );
  }
}
