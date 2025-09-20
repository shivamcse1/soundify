import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:soundify/core/helper/ui_helper.dart';
import 'package:soundify/core/services/audio_player_services.dart';
import 'package:soundify/core/services/permission_handler_services.dart';
import 'package:soundify/core/theme/app_colors.dart';

class SongController extends GetxController {
  final OnAudioQuery onAudioQuery = OnAudioQuery();

  RxList<SongModel> allSongs = <SongModel>[].obs;
  RxList<SongModel> filterSong = <SongModel>[].obs;
  RxDouble sliderValue = 0.0.obs;
  RxInt currentSongIndex = RxInt(-1);
  RxInt repeatSongNumber = RxInt(0);
  Rx<Duration> currentPosition = Duration.zero.obs;
  Rx<Duration> totalDuration = Duration.zero.obs;
  RxBool isPlaying = RxBool(false);
  RxBool isShuffle = RxBool(false);
  RxBool isDragging = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchAllDeviceAudio();
    listenSongStream();
  }

  @override
  void onClose() {
    AudioPlayerServices.audioPlayer.dispose();
    currentSongIndex.value = -1;
    super.onClose();
  }

  /// This method is used to fetch all audio in device ///
  void fetchAllDeviceAudio() async {
    try {
      if (!await PermissionHandlerServices.checkInternalStoragePermission()) {
        return;
      }
      debugPrint("Permission Granted");
      allSongs.value = await onAudioQuery.querySongs(
        ignoreCase: true,
        orderType: OrderType.ASC_OR_SMALLER,
        uriType: UriType.EXTERNAL,
      );
      if (allSongs.isNotEmpty) {
        debugPrint("Song fetch Successfully ${allSongs.length}");
      }
    } catch (ex) {
      debugPrint("Exception occurred while fetching song $ex");
    }
  }

  void listenSongStream() {
    /// This Stream is used to monitor state of song //

    AudioPlayerServices.audioPlayer.playerStateStream.listen((state) {
      if (state.processingState == ProcessingState.completed) {
        debugPrint("current audio Playback Completed");

        Future.delayed(Duration(milliseconds: 100), () async {
          refreshSliderValue();
          // await playNextSong();
        });
      } else if (state.processingState == ProcessingState.ready) {
        debugPrint("Assets or song loaded ready to play");
      } else if (state.processingState == ProcessingState.idle) {
        debugPrint(
          "Not any song url has loaded this is idle case when there is no song",
        );
      } else if (state.processingState == ProcessingState.loading) {
        debugPrint("Song are loading mainly in netwrok url");
      }
      isPlaying.value = state.playing;
    });

    /// This is used to calculate total duration //
    AudioPlayerServices.audioPlayer.durationStream.listen((duration) {
      if (duration != null && duration.inMilliseconds > 0) {
        totalDuration.value = duration;
      }
    });

    AudioPlayerServices.audioPlayer.positionStream.listen((position) {
      currentPosition.value = position;
    });
    AudioPlayerServices.audioPlayer.currentIndexStream.listen((index) {
      debugPrint("current playing song index$index");
      if (index != null) {
        currentSongIndex.value = index;
      }
    });
  }

  Future<void> playSong() async {
    try {
      currentPosition.value = Duration.zero;
      totalDuration.value = Duration.zero;
      await stopSong();
      await AudioPlayerServices.playMusic(
        songPath: allSongs[currentSongIndex.value].uri,
      );
    } catch (ex) {
      debugPrint("Exception occurred while play song $ex");
    }
  }

  /// This method is used for playing song ///
  Future<void> playPauseSong() async {
    try {
      if (AudioPlayerServices.audioPlayer.playing) {
        await AudioPlayerServices.pauseMusic();
        return;
      }
      if (AudioPlayerServices.audioPlayer.processingState !=
              ProcessingState.idle &&
          !AudioPlayerServices.audioPlayer.playing) {
        await AudioPlayerServices.resumeMusic();
        return;
      }
      await AudioPlayerServices.playMusic(
        songPath: allSongs[currentSongIndex.value].uri,
      );
    } catch (ex) {
      debugPrint("Exception while playing song: $ex");
    }
  }

  Future<void> playNextSong() async {
    try {
      currentPosition.value = Duration.zero;
      totalDuration.value = Duration.zero;
      if (allSongs.isEmpty) return;
      if (currentSongIndex.value < allSongs.length - 1) {
        currentSongIndex.value += 1;
      } else {
        currentSongIndex.value = 0;
      }
       await AudioPlayerServices.repeatMusic(
        initialIndex: currentSongIndex.value,
        loopMode: AudioPlayerServices.audioPlayer.loopMode,
        playlist: allSongs,
      );

    } catch (ex) {
      debugPrint("Exception ocurred while playing next song $ex");
    }
  }

  Future<void> playPreviousSong() async {
    try {
      currentPosition.value = Duration.zero;
      totalDuration.value = Duration.zero;
      if (currentSongIndex.value > 0) {
        currentSongIndex.value -= 1;
      } else {
        currentSongIndex.value = 0;
      }
      await AudioPlayerServices.repeatMusic(
        initialIndex: currentSongIndex.value,
        loopMode: AudioPlayerServices.audioPlayer.loopMode,
        playlist: allSongs,
      );
    } catch (ex) {
      debugPrint("Exception ocurred while playing previous song $ex");
    }
  }

  Future<void> seekSong({required Duration currentPosition}) async {
    try {
      await AudioPlayerServices.seekMusic(currentPosition: currentPosition);
    } catch (ex) {
      debugPrint("Exception occuured while seeking song $ex");
    }
  }

  Future<void> shuffleSong() async {
    try {
      isShuffle.value = !isShuffle.value;
      if (isShuffle.value) {
        UiHelper.showToast(msg: "Shuffle");
        await AudioPlayerServices.shuffleMusic();
      }
    } catch (ex) {
      debugPrint("Exception occuured while shuffle song $ex");
    }
  }

  void refreshSliderValue() {
    totalDuration.value = Duration.zero;
    currentPosition.value = Duration.zero;
  }

  Future<void> setRepeatSong() async {
    try {
      if (isShuffle.value == true) {
        isShuffle.value = false;
      }
      if (repeatSongNumber.value > 2) {
        repeatSongNumber.value = 1;
      } else {
        repeatSongNumber.value = repeatSongNumber.value + 1;
      }
      if (repeatSongNumber.value == 1) {
        UiHelper.showToast(msg: "Loop Song", textColor: AppColors.white);
        await AudioPlayerServices.repeatMusic();
      } else if (repeatSongNumber.value == 2) {
        UiHelper.showToast(msg: "Loop Playlist", textColor: AppColors.white);
        await AudioPlayerServices.repeatMusic(
          loopMode: LoopMode.all,
          playlist: allSongs,
          initialIndex: currentSongIndex.value,
        );
      } else {
        UiHelper.showToast(msg: "Loop off", textColor: AppColors.white);
        await AudioPlayerServices.repeatMusic(loopMode: LoopMode.off);
      }
    } catch (ex) {
      debugPrint("Exception occuured while seeking song $ex");
    }
  }

  /// This method is used for stop song ///
  Future<void> stopSong() async {
    try {
      await AudioPlayerServices.stopMusic();
    } catch (ex) {
      debugPrint("Exception while play song $ex");
    }
  }

  String calculateTotalDuration({required Duration duration}) {
    final totalDuration =
        "${(duration.inSeconds / 60).toStringAsFixed(0).padLeft(2, "0")}:${(duration.inSeconds % 60).toString().padLeft(2, "0")}";
    return totalDuration;
  }

  String getCurrentPosition({required Duration duration}) {
    final totalDuration =
        "${(duration.inSeconds / 60).toStringAsFixed(0).padLeft(2, "0")}:${(duration.inSeconds % 60).toString().padLeft(2, "0")}";
    return totalDuration;
  }
}
