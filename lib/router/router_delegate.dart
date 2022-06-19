import 'package:flutter/material.dart';

import 'page_config.dart';

class PagesRouterDelegate extends RouterDelegate<PageConfig>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<PageConfig> {
  final List<Page> _pages = [];
  final GlobalKey<NavigatorState> navigatorKey;
  PagesRouterDelegate() : navigatorKey = GlobalKey<NavigatorState>();

  @override
  PageConfig get currentConfiguration {}

  @override
  Future<bool> popRoute() {
    if (canPop()) {
      pop();
      return Future.value(true);
    }
    return Future.value(false);
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      pages: [],
      onPopPage: (route, result) {
        bool didPop = route.didPop(result);
        if (!didPop) return false;
        if (canPop()) {
          return true;
        }
        return false;
      },
    );
  }

  @override
  Future<void> setNewRoutePath(PageConfig config) async {}

  bool canPop() {
    return _pages.length > 1;
  }

  void pop() {
    if (canPop()) {
      _removePage(_pages.last);
    }
  }

  void _removePage(MaterialPage page) {
    if (page != null) {
      _pages.remove(page);
    }
  }
}
