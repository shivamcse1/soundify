import 'package:get/get.dart';
import 'package:soundify/modules/home/controller/home_controller.dart';

class AppBinding  extends Bindings{
   @override
  void dependencies() {
     Get.lazyPut(()=> HomeController());
  }
}