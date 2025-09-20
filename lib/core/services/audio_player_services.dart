// ignore_for_file: unused_local_variable, deprecated_member_use

import 'package:flutter/widgets.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';

class AudioPlayerServices {
  /// for Singleton logic ///
  static final AudioPlayerServices _instance = AudioPlayerServices._internal();
  AudioPlayerServices._internal();

  factory AudioPlayerServices() {
    return _instance;
  }

  /// Main Audio Player logic ///
  static AudioPlayer audioPlayer = AudioPlayer();

  /// This Method is used for play music ///
  static Future<void> playMusic({
    String? songPath,
    bool isNetwork = false,
  }) async {
    await audioPlayer.stop();
    if (isNetwork && songPath != null) {
      await audioPlayer.setUrl(songPath);
    } else if (songPath != null) {
      await audioPlayer.setAudioSource(AudioSource.uri(Uri.parse(songPath)));
    } else {
      debugPrint("No song source found");
      return;
    }
    await audioPlayer.play();
  }

  /// This Method is used for pause music ///
  static Future<void> pauseMusic() async {
    if (audioPlayer.playing) {
      await audioPlayer.pause();
    }
  }

  /// This Method is used for resume music ///
  static Future<void> resumeMusic() async {
    if (!audioPlayer.playing) {
      await audioPlayer.play();
    }
  }

  /// This Method is used for Stop music ///
  static Future<void> stopMusic() async {
    if (audioPlayer.playing) {
      await audioPlayer.stop();
    }
  }

  /// This Method is used for seek music ///
  static Future<void> seekMusic({required Duration currentPosition}) async {
    await audioPlayer.seek(currentPosition);
  }

  /// This method is used for shuffle music ///
  static Future<void> shuffleMusic() async {
    await audioPlayer.shuffle();
  }

  /// This method is used for shuffle music ///
  static Future<void> repeatMusic({
    LoopMode loopMode = LoopMode.one,
    List<SongModel>? playlist,
    int initialIndex = 0,
  }) async {
    if (loopMode == LoopMode.all && playlist != null) {
      final songPlaylist = ConcatenatingAudioSource(
        children:
            playlist.map((singleSong) {
              return AudioSource.uri(Uri.parse(singleSong.uri ?? ''));
            }).toList(),
      );

      await audioPlayer.setAudioSource(
        songPlaylist,
        initialIndex: initialIndex,
      );
    }
    await audioPlayer.setLoopMode(loopMode);
    if (!audioPlayer.playing) {
      await audioPlayer.play();
    }
  }
}
