import 'package:flash_chat/router/app_state.dart';
import 'package:flash_chat/screens/chat_screen.dart';
import 'package:flash_chat/screens/login_screen.dart';
import 'package:flash_chat/screens/registration_screen.dart';
import 'package:flash_chat/screens/welcome_screen.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'page_config.dart';

class PagesRouterDelegate extends RouterDelegate<PageConfig>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<PageConfig> {
  final List<Page> _pages = [];
  final GlobalKey<NavigatorState> navigatorKey;
  PagesRouterDelegate(this.appState) : navigatorKey = GlobalKey<NavigatorState>()
  {
    appState.addListener(() {
      notifyListeners();
    });
  }
  AppState appState;

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
      pages: buildPages(),
      onPopPage: _onPopPage,
    );
  }

  @override
  Future<void> setNewRoutePath(PageConfig config) {
    final shouldAddPage = _pages.isEmpty || (_pages.last.arguments as PageConfig).type !=
        config.type;
    if(shouldAddPage)
    {
      _pages.clear();
      addPage(config);
    }
    return SynchronousFuture(null);
  }

  bool canPop() {
    return _pages.length > 1;
  }

  void pop() {
    _removePage(_pages.last);
    appState.ChangeAppState(AppStates.Welcome);
  }

  List<Page> buildPages()
  {
    switch(appState.currentState)
    {
      case AppStates.Welcome:
        _pages.clear();
        addPage(WelcomePageConfig);
        break;
      case AppStates.Login:
        addPage(LoginPageConfig);
        break;
      case AppStates.Chat:
        addPage(ChatPageConfig);
        break;
      case AppStates.Register:
        addPage(RegisterPageConfig);
        break;
      default:
        break;
    }
    return List.of(_pages);
  }

  MaterialPage _createPage(Widget child, PageConfig pageConfig)
  {
    return MaterialPage(
      child: child,
      key: Key(pageConfig.key),
      name: pageConfig.path,
      arguments: pageConfig,
    );
  }

  void _addPageData(Widget child, PageConfig pageConfig)
  {
    _pages.add(_createPage(child, pageConfig));
  }

  void addPage(PageConfig pageConfig)
  {
    bool shouldAddPage = _pages.isEmpty || (_pages.last.arguments as PageConfig).type !=
        pageConfig.type;

    if(!shouldAddPage) return;
    switch(pageConfig.type)
    {
      case PageTypes.Welcome:
        _addPageData(WelcomeScreen(appState), pageConfig);
        break;
      case PageTypes.Chat:
        _addPageData(ChatScreen(), pageConfig);
        break;
      case PageTypes.Register:
        _addPageData(RegistrationScreen(), pageConfig);
        break;
      case PageTypes.Login:
        _addPageData(LoginScreen(), pageConfig);
        break;
      default:
        break;
    }
  }

  // Replaces last page
  void replace(PageConfig newRoute)
  {
    if(_pages.isNotEmpty)
    {
      _pages.removeLast();
    }
    addPage(newRoute);
  }
  void setPath(List<MaterialPage> path) {
    _pages.clear();
    _pages.addAll(path);
  }

  void replaceAll(PageConfig newRoute) {
    setNewRoutePath(newRoute);
  }

  void push(PageConfig newRoute) {
    addPage(newRoute);
  }

  void pushWidget(Widget child, PageConfig newRoute) {
    _addPageData(child, newRoute);
  }

  void addAll(List<PageConfig> routes) {
    _pages.clear();
    routes.forEach((route) {
      addPage(route);
    });
  }

  void _removePage(MaterialPage page) {
    if (page != null) {
      _pages.remove(page);
    }
  }

  bool _onPopPage(Route<dynamic> route, result)
  {
    bool didPop = route.didPop(result);
    if(!didPop) return false;
    if(canPop())
    {
      pop();
      return true;
    }else{
      return false;
    }

  }
}
