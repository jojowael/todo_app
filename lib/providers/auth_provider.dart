import 'package:flutter/cupertino.dart';
import 'package:project2/model/my_user.dart';

class AuthProvider extends ChangeNotifier {
  MyUser? currentUser;

  void updateUser(MyUser newUser) {
    currentUser = newUser;
    notifyListeners();
  }
}
