import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(GetMaterialApp.router(
    debugShowCheckedModeBanner: false,
    defaultTransition: Transition.fade,
    getPages: AppPages.pages,
    routerDelegate: AppRouterDelegate(),
  ));
}

abstract class Routes {
  static const HOME = '/';
  static const LOGIN = '/login';
  static const SIGNUP = '/signup';
}

abstract class AppPages {
  static final pages = [
    GetPage(
      name: Routes.HOME,
      page: () => Home(),
    ),
    GetPage(
      name: Routes.LOGIN,
      page: () => Login(),
    ),
    GetPage(
      name: Routes.SIGNUP,
      page: () => Signup(),
    ),
  ];
}

class AppRouterDelegate extends GetDelegate {
  @override
  Widget build(BuildContext context) {
    return Navigator(
      onPopPage: (route, result) => route.didPop(result),
      pages: currentConfiguration != null
          ? [currentConfiguration!.currentPage!]
          : [GetNavConfig.fromRoute(Routes.HOME)!.currentPage!],
    );
  }
}

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
      child: TextButton(
        child: Text(
          'Home',
          style: TextStyle(color: Colors.white),
        ),
        onPressed: () => Get.rootDelegate.toNamed(Routes.LOGIN),
      ),
    );
  }
}

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.orange,
      child: TextButton(
        child: Text(
          'Login',
          style: TextStyle(color: Colors.white),
        ),
        onPressed: () => Get.rootDelegate.toNamed(Routes.SIGNUP),
      ),
    );
  }
}

class Signup extends StatelessWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      child: TextButton(
        child: Text(
          'Signup',
          style: TextStyle(color: Colors.white),
        ),
        onPressed: () => Get.rootDelegate.toNamed(Routes.HOME),
      ),
    );
  }
}
