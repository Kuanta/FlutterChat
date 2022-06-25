import 'package:flash_chat/router/page_config.dart';
import 'package:flutter/material.dart';

//Convert given route information into parsed data
class RouteInfoParser extends RouteInformationParser<PageConfig>
{
  @override
  Future<PageConfig> parseRouteInformation(
      RouteInformation routeInformation) async {
    // 1
    final uri = Uri.parse(routeInformation.location);
    // 2
    if (uri.pathSegments.isEmpty) {
      return WelcomePageConfig;
    }

    // 3
    final path = uri.pathSegments[0];
    // 4
    switch (path) {
      case WelcomePath:
        return WelcomePageConfig;
      case LoginPath:
        return LoginPageConfig;
      case RegisterPath:
        return RegisterPageConfig;
      case ChatPath:
        return ChatPageConfig;
      default:
        return WelcomePageConfig;
    }
  }

  @override
  RouteInformation restoreRouteInformation(PageConfig configuration) {
    switch (configuration.type) {
      case PageTypes.Welcome:
        return const RouteInformation(location: WelcomePath);
      case PageTypes.Register:
        return const RouteInformation(location: RegisterPath);
      case PageTypes.Login:
        return const RouteInformation(location: LoginPath);
      case PageTypes.Chat:
        return const RouteInformation(location: ChatPath);
      default:
        return const RouteInformation(location: WelcomePath);
    }
  }
}