 import 'dart:io';

import 'package:permission_handler/permission_handler.dart';

class PermissionHandlerServices{


  static Future<bool> checkInternalStoragePermission()async{
    if(Platform.isAndroid){
        if(await Permission.audio.isGranted || await Permission.storage.isGranted){
         return true;
        }

        PermissionStatus status = await Permission.audio.request();
        if(status.isGranted) return true;

        status = await Permission.storage.request();

        return status.isGranted;
    }else if(Platform.isIOS){
     if(await Permission.mediaLibrary.isGranted){
      return true;
     }
     var status = await Permission.mediaLibrary.request();

     return status.isGranted;
  }
    return false;
    }

 }