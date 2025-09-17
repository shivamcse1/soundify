import 'package:get/get.dart';
import 'package:soundify/modules/bottom_nav_bar/views/bottom_nav_bar.dart';
import 'package:soundify/modules/home/views/home.dart';
import 'package:soundify/modules/home/views/song_details.dart';
import 'package:soundify/modules/profile/views/profile.dart';
import 'package:soundify/modules/songs/views/songs.dart';

class AppRoutes {
  /// App Routes ///
  static const String bottomNavBar = '/';
  static const String home = '/home';
  static const String songDetails = '/song_details';
  static const String profile = '/profile';
  static const String songs = '/songs';

  static List<GetPage> pages = [
    GetPage(name: bottomNavBar, page: () => BottomNavBar()),
    GetPage(name: home, page: () => Home()),
    GetPage(name: songDetails, page: () => SongDetails()),
    GetPage(name: profile, page: () => Profile()),
    GetPage(name: songs, page: () => Songs()),
  ];
}
