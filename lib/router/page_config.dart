import 'package:flutter/cupertino.dart';

enum PageTypes {
  Welcome,
  Login,
  Register,
  Chat,
}

const String WelcomePath = "welcome";
const String LoginPath = "login";
const String RegisterPath = "register";
const String ChatPath = "chat";

class PageConfig {
  final String key;
  final String path;
  final PageTypes type;

  PageConfig({
      @required this.key, @required this.path, @required this.type
  });
}

PageConfig WelcomePageConfig = PageConfig(key: "welcome", path: WelcomePath, type: PageTypes.Welcome);
PageConfig LoginPageConfig = PageConfig(key: "login", path: LoginPath, type: PageTypes.Login);
PageConfig RegisterPageConfig = PageConfig(key: "register", path: RegisterPath, type: PageTypes.Register);
PageConfig ChatPageConfig = PageConfig(key:"chat", path:ChatPath, type:PageTypes.Chat);

