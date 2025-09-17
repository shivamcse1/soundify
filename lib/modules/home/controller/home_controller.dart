import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:soundify/core/services/permission_handler_services.dart';

class HomeController extends GetxController {
  RxList<SongModel> allSongs = <SongModel>[].obs;
  RxInt currentSongIndex = RxInt(-1);
  final OnAudioQuery onAudioQuery = OnAudioQuery();

  @override
  void onInit() {
    super.onInit();
    fetchAllDeviceAudio();
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
}
