import 'package:flutter/material.dart';

@immutable
abstract final class ValueConstant {
// int values
  static const int connectTimeout = 9000;
  static const int defaultMaxAttemptsAPI = 2;
  static const int desirePhotoWidth = 1440;
  static const int desirePhotoHeight = 1080;
  static const int desirePhotoQuality = 100;
  static const int hideTextLength = 100;
  static const int imageGalleryPageSize = 0;
  static const int maxConcurrentTasks = 3;
  static const int maxFileSize = 10485760;
  static const int receiveTimeout = 120000;
  static const int sendTimeout = 9000;
  static const int snackbarDurationWithAction = 3500;

// double values
  static const double minButtonWidth = 100;
  static const double statusBarHeight = 28;
  static const double toolbarHeight = 84.0;

// string values
  static const String all = 'All';
  static const String android = 'android';
  static const String ios = 'ios';

  // regex
  static const alphanumericPattern = r'^[A-Za-z0-9]+';
  static const alphanumericWithSpacePattern = r'^[A-Za-z0-9 ]+';
  static const emojiPattern =
      r'(\u00a9|\u00ae|[\u2000-\u3300]|\ud83c[\ud000-\udfff]|\ud83d[\ud000-\udfff]|\ud83e[\ud000-\udfff])';
  static const emailPattern =
      r"[\w!#$%&'*+/=?^_`{|}~-]+(?:\.[\w!#$%&'*+/=?^_`{|}~-]+)*@(?:[\w](?:[\w-]*[\w])?\.)+[\w](?:[\w-]*[\w])?";
  static const spacePattern = r'\s';
  static const specialCharacterPattern =
      r'[\\\!@#$%^&*()_+=`~' "<>,.|''/:;?\"{}¥£\\[\\]]";
  static const urlPattern =
      r'((https?:www\.)|(https?:\/\/)|(www\.))[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9]{1,6}(\/[-a-zA-Z0-9()@:%_\+.~#?&\/=]*)?';
}
