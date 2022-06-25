import 'package:flutter/material.dart';
import 'router_delegate.dart';

class FlashBackButtonDispatcher extends RootBackButtonDispatcher {

  final PagesRouterDelegate _routerDelegate;

  FlashBackButtonDispatcher(this._routerDelegate)
      : super();

  Future<bool> didPopRoute() {
    print("YUo");
    return _routerDelegate.popRoute();
  }
}