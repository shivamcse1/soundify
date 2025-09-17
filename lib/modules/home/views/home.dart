import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:soundify/core/theme/app_colors.dart';
import 'package:soundify/modules/home/controller/home_controller.dart';
import 'package:soundify/modules/home/widget/custom_song_silder.dart';
import 'package:soundify/modules/home/widget/custom_song_tile.dart';
import 'package:soundify/widgets/custom_text.dart';
import 'package:soundify/widgets/custom_textfield.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isSearchTap = false;
  final HomeController homeController = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        leadingWidth: 100,
        leading: Padding(
          padding: const EdgeInsets.only(left: 10, top: 15),
          child: CustomText(
            text: "SK Player",
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
            ),
          ),
        ),
        title: Visibility(visible: isSearchTap, child: _buildHeader()),
        actions: [
          InkWell(
            onTap: () {
              setState(() {
                isSearchTap = !isSearchTap;
              });
            },
            child: Icon(
              isSearchTap ? Icons.cancel : Icons.search,
              color: AppColors.primary,
            ),
          ),
          SizedBox(width: 20),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(left: 10, right: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeading(text: "Recommended"),
            CustomSongSilder(songData: []),

            /// All Song List ///
            SizedBox(height: 10.h),
            _buildSectionTile(),
            Obx(
              () => ListView.separated(
                physics: NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                itemCount: homeController.allSongs.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return CustomSongTile(song: homeController.allSongs[index]);
                },
                separatorBuilder: (context, index) {
                  return Divider(height: 5, color: AppColors.darkGrey);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return CustomTextField(
      height: 40,
      backGroundColor: AppColors.darkGrey,
      prefix: Icon(Icons.search, color: AppColors.softWhite),
      hintText: "Search Album Song",
      hintStyle: TextStyle(color: AppColors.softWhite, fontSize: 14.sp),
    );
  }

  Widget _buildHeading({required String text}) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.h),
      child: CustomText(
        text: text,
        style: TextStyle(
          fontSize: 18.sp,
          fontWeight: FontWeight.w500,
          color: AppColors.softWhite,
        ),
      ),
    );
  }

  Widget _buildSectionTile() {
    return Row(
      children: [
        CustomText(
          text: "Songs",
          style: TextStyle(color: AppColors.secondary, fontSize: 16.sp),
        ),
      ],
    );
  }
}
