import 'dart:io' show Platform;

class TextUtils {
  static String getFontFamily() => Platform.isIOS ? "Courier" : "Roboto";
}
