import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:soundify/core/services/audio_player_services.dart';
import 'package:soundify/core/services/permission_handler_services.dart';

class SongController extends GetxController {
  final OnAudioQuery onAudioQuery = OnAudioQuery();

  RxList<SongModel> allSongs = <SongModel>[].obs;
  RxInt currentSongIndex = RxInt(-1);
  Duration currentPosition = Duration.zero;
  Duration totalDuration = Duration.zero;
  RxBool isPlaying = RxBool(false);

  @override
  void onInit() {
    super.onInit();
    fetchAllDeviceAudio();
    listenSongStream();
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
    AudioPlayerServices.audioPlayer.playerStateStream.listen((state) {
      if (state.processingState == ProcessingState.completed) {
      } else if (state.processingState == ProcessingState.ready) {
      } else if (state.processingState == ProcessingState.idle) {
      } else if (state.processingState == ProcessingState.loading) {}
      isPlaying.value = state.playing;
    });
  }

   Future<void> playSong()async{
    try{   
            await stopSong();
            await AudioPlayerServices.playMusic(
        songPath: allSongs[currentSongIndex.value].uri,
      );
    }catch (ex){
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
      if (currentSongIndex.value < allSongs.length - 1) {
        currentSongIndex.value += 1;
      } else {
        currentSongIndex.value = 0;
      }
      await AudioPlayerServices.playMusic(
        songPath: allSongs[currentSongIndex.value].uri,
      );
    } catch (ex) {
      debugPrint("Exception ocurred while playing next song $ex");
    }
  }

  Future<void> playPreviousSong() async {
    try {
      if (currentSongIndex.value > 0) {
        currentSongIndex.value -= 1;
      } else {
        currentSongIndex.value = 0;
      }
      await AudioPlayerServices.playMusic(
        songPath: allSongs[currentSongIndex.value].uri,
      );
    } catch (ex) {
      debugPrint("Exception ocurred while playing previous song $ex");
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
}
