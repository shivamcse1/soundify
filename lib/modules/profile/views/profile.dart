import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soundify/core/constant/image_constant.dart';
import 'package:soundify/core/theme/app_colors.dart';
import 'package:soundify/widgets/custom_text.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(backgroundColor: AppColors.darkGrey),
      body: Column(
        children: [
          /// Header Section ///
          buildHeader(),

          /// Body Section ///
          _buildTile(leadingIcon: Icons.art_track, title: "Theme"),
          _buildTile(leadingIcon: Icons.android, title: "App Version"),
          _buildTile(leadingIcon: Icons.settings, title: "Settings"),
        ],
      ),
    );
  }

  Widget _buildTile({required IconData leadingIcon, required String title}) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 10),
      leading: Icon(leadingIcon, color: AppColors.primary),
      title: CustomText(
        text: title,
        style: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.w500,
          color: AppColors.white,
        ),
      ),
    );
  }

  Widget buildHeader() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.darkGrey,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(10),
          bottomRight: Radius.circular(10),
        ),
      ),
      child: Column(
        children: [
          CircleAvatar(
            radius: 50,
            backgroundImage: AssetImage(ImageConstant.albumImg),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  CustomText(
                    text: "10",
                    style: TextStyle(fontSize: 15.sp, color: AppColors.white),
                  ),
                  CustomText(
                    text: "Songs",
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: AppColors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),

              Column(
                children: [
                  CustomText(
                    text: "10",
                    style: TextStyle(fontSize: 15.sp, color: AppColors.white),
                  ),
                  CustomText(
                    text: "Album",
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: AppColors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  CustomText(
                    text: "10",
                    style: TextStyle(fontSize: 15.sp, color: AppColors.white),
                  ),
                  CustomText(
                    text: "Artist",
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: AppColors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),

          SizedBox(height: 20),
        ],
      ),
    );
  }
}
