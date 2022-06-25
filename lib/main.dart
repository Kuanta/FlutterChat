import 'package:flash_chat/router/app_state.dart';
import 'package:flash_chat/router/back_button.dart';
import 'package:flash_chat/router/route_info_parser.dart';
import 'package:flash_chat/router/router_delegate.dart';
import 'package:flutter/material.dart';

void main() => runApp(FlashChat());

class FlashChat extends StatefulWidget {
  @override
  _FlashChat createState() => _FlashChat();
}


class _FlashChat extends State<FlashChat> {
  AppState appState;
  PagesRouterDelegate routerDelegate;
  RouteInfoParser parser;
  FlashBackButtonDispatcher backButtonDispatcher;

  _FlashChat()
  {
    appState = AppState();
    routerDelegate = PagesRouterDelegate(appState);
    parser = RouteInfoParser();
    backButtonDispatcher = FlashBackButtonDispatcher(routerDelegate);
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(routeInformationParser: parser,
      backButtonDispatcher: backButtonDispatcher,
      routerDelegate: routerDelegate,
    );
  }
}
