import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileViewModel with ChangeNotifier {
  var _profileImage = Image.asset('assets/images/nemesis.jpg');
  SharedPreferences? _prefs = null;

  ProfileViewModel() {
    startUp();
  }

  void startUp() async {
    _prefs = await getSharedPrefsAsync();
  }

  Image get profileImage {
    return _profileImage;
  }

  SharedPreferences? get prefs {
    return _prefs;
  }

  Future<SharedPreferences> getSharedPrefsAsync() async {
    return await SharedPreferences.getInstance();
  }

  Future checkprofileImage() async {
    if (_prefs?.containsKey('profpic') != null) {
      if (_prefs != null) {
        var img = _prefs?.getString('profpic');
        if(img != null) {

        _profileImage = Image.file(
          File(img),
          fit: BoxFit.fitWidth);
        }
        notifyListeners();
      }
    }
  }

  Widget ChangeProfileImage(XFile picture) {
    _profileImage = Image.file(
      File(picture.path),
      fit: BoxFit.fitWidth,
    );
    notifyListeners();
    return _profileImage;
  }
}
