import 'package:oktoast/oktoast.dart';

class KPLToast {
  static void _commonShow(String msg, {ToastPosition position = ToastPosition.center, Duration duration = const Duration(seconds: 1)}) {
    showToast(msg, position: position, duration: duration, dismissOtherToast: true);
  }
  static void show(String msg) {
    KPLToast._commonShow(msg);
  }
  static void hide() {
    dismissAllToast();
  }
}