import 'package:firebase_auth/firebase_auth.dart' show FirebaseAuth;
import 'package:flutter/widgets.dart';

enum AuthAction {
  signIn,
  signUp,
  link,
}

abstract class AuthController {
  static T ofType<T extends AuthController>(BuildContext context) {
    final ctrl = context
        .dependOnInheritedWidgetOfExactType<AuthControllerProvider>()
        ?.ctrl;

    if (ctrl == null || ctrl is! T) {
      throw Exception(
        'No controller of type $T found. '
        'Make sure to wrap your code with AuthFlowBuilder<$T>',
      );
    }

    return ctrl;
  }

  AuthAction get action;
  FirebaseAuth get auth;

  void findProvidersForEmail(String email);
}

class AuthControllerProvider extends InheritedWidget {
  final AuthAction action;
  final AuthController ctrl;

  AuthControllerProvider({
    required Widget child,
    required this.action,
    required this.ctrl,
  }) : super(child: child);

  @override
  bool updateShouldNotify(AuthControllerProvider oldWidget) {
    return ctrl != oldWidget.ctrl || action != oldWidget.action;
  }
}
