import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:soundify/core/theme/app_colors.dart';
import 'package:soundify/modules/songs/controller/song_controller.dart';
import 'package:soundify/widgets/custom_text.dart';

class SongDetails extends StatefulWidget {
  const SongDetails({super.key});

  @override
  State<SongDetails> createState() => _SongDetailsState();
}

class _SongDetailsState extends State<SongDetails> {
  final SongController songController = Get.find<SongController>();

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
        child: Obx(() {
          final SongModel song =
              songController.allSongs[songController.currentSongIndex.value];
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeaderCircularImg(song: song),
              SizedBox(height: 20.h),
              _buildSongName(song: song),
              Spacer(),

              Padding(
                padding: EdgeInsets.symmetric(vertical: 30.h, horizontal: 10),
                child: _buildMusicSlider(song: song),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 30.h),
                child: _buildPlayButton(),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 10.h),
                child: _buildBottomAction(),
              ),
            ],
          );
        }),
      ),
    );
  }

  Widget _buildHeaderCircularImg({required SongModel song}) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        height: 220.h,
        width: 220.w,
        padding: EdgeInsets.all(2),
        margin: EdgeInsets.only(top: 50.h, bottom: 30.h),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.primary,
        ),
        child: QueryArtworkWidget(
          id: song.id,
          size: 220,
          artworkBorder: BorderRadius.circular(110),
          type: ArtworkType.AUDIO,
          artworkFit: BoxFit.cover,
          nullArtworkWidget: Icon(
            Icons.music_note,
            size: 70.r,
            color: AppColors.white,
          ),
        ),
      ),
    );
  }

  Widget _buildSongName({required SongModel song}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            text: song.title,
            style: TextStyle(
              color: AppColors.white,
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
            ),
            maxLines: 1,
          ),
          CustomText(
            text: "${song.artist}",
            maxLines: 1,
            style: TextStyle(color: AppColors.softWhite, fontSize: 14.sp),
          ),
        ],
      ),
    );
  }

  Widget _buildMusicSlider({required SongModel song}) {
    return Row(
      children: [
        CustomText(
          text: "00:23",
          style: TextStyle(color: AppColors.softWhite, fontSize: 14.sp),
        ),

        Expanded(
          child: Slider(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
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
        IconButton(
          splashColor: AppColors.primary,
          onPressed: () async {
            await songController.playPreviousSong();
          },
          icon: Icon(
            Icons.skip_previous_rounded,
            color: AppColors.white,
            size: 40.r,
          ),
        ),

        Container(
          padding: EdgeInsets.all(3.r),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.primary,
          ),
          child: Obx(
            () => IconButton(
              splashColor: AppColors.primary,
              onPressed: () async {
                await songController.playPauseSong();
              },
              icon: Icon(
                songController.isPlaying.value
                    ? Icons.pause_rounded
                    : Icons.play_arrow_rounded,
                color: AppColors.white,
                size: 35.r,
              ),
            ),
          ),
        ),

        IconButton(
          splashColor: AppColors.primary,
          onPressed: () async {
            await songController.playNextSong();
          },
          icon: Icon(
            Icons.skip_next_rounded,
            color: AppColors.white,
            size: 40.r,
          ),
        ),
      ],
    );
  }

  Widget _buildBottomAction() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildColumnIconItem(
          icon: Icons.shuffle,
          text: "Shuffle",
          onTap: () {},
        ),
        _buildColumnIconItem(
          icon: Icons.queue_music_sharp,
          text: "PlayList",
          onTap: () {},
        ),
        _buildColumnIconItem(
          icon: Icons.favorite_border,
          text: "Favorite",
          onTap: () {},
        ),

        _buildColumnIconItem(icon: Icons.repeat, text: "Repeat", onTap: () {}),
      ],
    );
  }

  Widget _buildColumnIconItem({
    required IconData icon,
    required String text,
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: AppColors.softWhite, size: 25.r),
          CustomText(
            text: text,
            style: TextStyle(fontSize: 12.sp, color: AppColors.softWhite),
          ),
        ],
      ),
    );
  }
}
