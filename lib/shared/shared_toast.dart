import 'package:eventstracker/shared/shared_colors.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SharedToast
{
  static void show(String message)
  {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
    );
  }
}