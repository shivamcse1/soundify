import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:soundify/core/constant/image_constant.dart';
import 'package:soundify/core/theme/app_colors.dart';
import 'package:soundify/widgets/custom_text.dart';

class SongDetails extends StatefulWidget {
  const SongDetails({super.key});

  @override
  State<SongDetails> createState() => _SongDetailsState();
}

class _SongDetailsState extends State<SongDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        toolbarHeight: 50,
        iconTheme: IconThemeData(color: AppColors.primary),
        backgroundColor: AppColors.background,
        title: CustomText(
          text: "Now Playing",
          style: TextStyle(
            fontSize: 16.sp,
            color: AppColors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        actions: [
          // InkWell(
          //   onTap: () {},
          //   child: Icon(Icons.favorite_border, color: AppColors.primary),
          // ),
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
            _buildHeaderCircularImg(),
            SizedBox(height: 20.h,),
            _buildSongName(),
             Spacer(),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 20.h,horizontal: 10),
              child: _buildMusicSlider(),
            ),

            Padding(
              padding: EdgeInsets.only(bottom: 30.h),
              child: _buildPlayButton(),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 20.h),
              child: _buildBottomAction(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderCircularImg() {
    return Align(
      alignment: Alignment.center,
      child: Container(
        margin: EdgeInsets.only(top: 50.h, bottom: 30.h),
        padding: EdgeInsets.all(2),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.primary,
        ),
        child: CircleAvatar(
          radius: 120,
          backgroundImage: AssetImage(ImageConstant.albumImg),
        ),
      ),
    );
  }

  Widget _buildSongName() {
    return Column(
      children: [
        CustomText(
          text: "Tujhe Yaad Na Meri Ayi tujhe ab kya kahna",
          style: TextStyle(
            color: AppColors.white,
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        CustomText(
          text: "Sonu Nigam",
          style: TextStyle(color: AppColors.softWhite, fontSize: 14.sp),
        ),
      ],
    );
  }

  Widget _buildMusicSlider() {
    return Row(
      children: [
        CustomText(
          text: "00:23",
          style: TextStyle(color: AppColors.softWhite, fontSize: 14.sp),
        ),

        Expanded(
          child: Slider(
            min: 0,
            max: 10,
            value: 3.0,
            onChanged: (newValue) {},
            activeColor: AppColors.primary,
          ),
        ),

        CustomText(
          text: "04:23",
          style: TextStyle(color: AppColors.softWhite, fontSize: 14.sp),
        ),
      ],
    );
  }

  Widget _buildPlayButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        InkWell(
            onTap: (){},
            child: Icon(Icons.skip_previous, color: AppColors.white, size: 35.r)),
        InkWell(
            onTap: (){},
            child: Icon(Icons.play_circle_fill, color: AppColors.white, size: 55.r)),
        InkWell(
            onTap: (){},
            child: Icon(Icons.skip_next_sharp, color: AppColors.white, size: 35.r)),
      ],
    );
  }

  Widget _buildBottomAction(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildColumnIconItem(
          icon: Icons.shuffle,
          text: "Shuffle",
          onTap: (){

          }
        ),
        _buildColumnIconItem(
            icon: Icons.queue_music_sharp,
            text: "PlayList",
            onTap: (){

            }
        ),
        _buildColumnIconItem(
            icon: Icons.favorite_border,
            text: "Favorite",
            onTap: (){

            }
        ),

        _buildColumnIconItem(
            icon: Icons.repeat,
             text: "Repeat",
            onTap: (){

            }
        )
      ],
    );
  }



  Widget _buildColumnIconItem({
    required IconData icon,
    required String text,
    VoidCallback? onTap,
  }){
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon,color: AppColors.softWhite,size: 25.r,),
          CustomText(text: text,style: TextStyle(fontSize: 12.sp, color: AppColors.softWhite),)
        ],
      ),
    );
  }
}
