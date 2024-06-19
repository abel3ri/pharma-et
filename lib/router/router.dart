import 'package:go_router/go_router.dart';
import 'package:pharma_et/pages/HomePage.dart';
import 'package:pharma_et/pages/LoginPage.dart';
import 'package:pharma_et/pages/OTPPage.dart';
// import 'package:pharma_et/pages/OTPPage.dart';
import 'package:pharma_et/pages/SignUpPage.dart';
import 'package:pharma_et/pages/WelcomePage.dart';
import 'package:pharma_et/utils/SlideTransition.dart';

class AppRouter {
  static final router = GoRouter(routes: [
    GoRoute(
      path: "/",
      name: 'splashPage',
      pageBuilder: (context, state) => SlideTransitionPage(
        key: state.pageKey,
        child: const WelcomePage(),
      ),
    ),
    GoRoute(
      path: "/login",
      name: 'login',
      pageBuilder: (context, state) => SlideTransitionPage(
        key: state.pageKey,
        child: const LoginPage(),
      ),
    ),
    GoRoute(
      path: "/signup",
      name: 'signup',
      pageBuilder: (context, state) => SlideTransitionPage(
        key: state.pageKey,
        child: const SignUpPage(),
      ),
    ),
    GoRoute(
      path: "/otp",
      name: 'otp',
      pageBuilder: (context, state) => SlideTransitionPage(
        key: state.pageKey,
        rtl: false,
        child: const OTPPage(),
      ),
    ),
    GoRoute(
      path: "/home",
      name: 'home',
      pageBuilder: (context, state) => SlideTransitionPage(
        key: state.pageKey,
        child: const HomePage(),
      ),
    ),
  ]);
}
