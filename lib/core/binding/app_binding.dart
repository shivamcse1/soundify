import 'package:get/get.dart';
import 'package:soundify/modules/home/controller/home_controller.dart';
import 'package:soundify/modules/songs/controller/song_controller.dart';

class AppBinding  extends Bindings{
   @override
  void dependencies() {
     // Home Controller ///
     Get.lazyPut(()=> HomeController());


     /// Song Controller ///
     Get.lazyPut(()=> SongController());
  }
}