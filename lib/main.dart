import 'package:flutter/material.dart';
import 'package:flash_chat/screens/welcome_screen.dart';
import 'package:flash_chat/screens/login_screen.dart';
import 'package:flash_chat/screens/registration_screen.dart';
import 'package:flash_chat/screens/chat_screen.dart';

void main() => runApp(FlashChat());

class FlashChat extends StatefulWidget {
  @override
  _FlashChat createState() => _FlashChat();
}

enum AppStates {
  Welcome,
  Login,
  Register,
  Chat,
}

class _FlashChat extends State<FlashChat> {
  AppStates currentState;

  void SetCurrentState(AppStates newState) {
    setState(() {
      print("Setting current state to:" + newState.toString());
      currentState = newState;
    });
  }

  MaterialPage GetCurrentWidget() {
    switch (currentState) {
      case AppStates.Login:
        return MaterialPage(key: ValueKey("login"), child: LoginScreen());
      case AppStates.Register:
        return MaterialPage(
            key: ValueKey("register"), child: RegistrationScreen());
      case AppStates.Chat:
        return MaterialPage(key: ValueKey("chat"), child: ChatScreen());
      default:
        return MaterialPage(
            key: ValueKey("welcome"), child: WelcomeScreen(SetCurrentState));
    }
  }

  List<Page> buildPages() {
    List<Page> pages = [];
    pages.add(MaterialPage(
      key: ValueKey('welcome'),
      child: WelcomeScreen(SetCurrentState),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        textTheme: TextTheme(
          bodyMedium: TextStyle(color: Colors.black54),
        ),
      ),
      home: Navigator(
        pages: [
          MaterialPage(child: WelcomeScreen(SetCurrentState)),
          if (currentState == AppStates.Login)
            MaterialPage(key: ValueKey("login"), child: LoginScreen()),
        ],
        onPopPage: (route, result) {
          print("Pop");
          return route.didPop(result);
        },
      ),
    );
  }
}
