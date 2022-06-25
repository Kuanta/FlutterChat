import 'package:flutter/cupertino.dart';

enum AppStates {
  Welcome,
  Login,
  Register,
  Chat,
}

class AppState extends ChangeNotifier
{
  AppStates currentState;
  AppState()
  {
    currentState = AppStates.Welcome;
  }

  void ChangeAppState(AppStates newState)
  {
    currentState = newState;
    notifyListeners();
  }
}