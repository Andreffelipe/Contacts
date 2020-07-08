import 'dart:io';
import 'package:contact/ios/ios.app.dart';
import 'package:flutter/material.dart';
import 'package:contact/android/android.app.dart';

void main() {
  if (Platform.isIOS) {
    runApp(IOSApp());
  } else {
    runApp(AndroidApp());
  }
}
