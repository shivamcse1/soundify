import 'package:get/get.dart';
import 'package:soundify/modules/songs/controller/song_controller.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    /// Song Controller ///
    Get.lazyPut(() => SongController());
  }
}
