import 'package:go_router/go_router.dart';
import 'package:pharma_et/pages/A-ZMedicines.dart';
import 'package:pharma_et/pages/AddEmaiPage.dart';
import 'package:pharma_et/pages/CategoryDetailsPage.dart';
import 'package:pharma_et/pages/ForgotPasswordPage.dart';
import 'package:pharma_et/pages/HomePage.dart';
import 'package:pharma_et/pages/LoginPage.dart';
import 'package:pharma_et/pages/OTPPage.dart';
import 'package:pharma_et/pages/PrescriptionsListPage.dart';
import 'package:pharma_et/pages/ProfilePage.dart';
import 'package:pharma_et/pages/SearchPage.dart';
import 'package:pharma_et/pages/SignUpPage.dart';
import 'package:pharma_et/pages/SplashPage.dart';
import 'package:pharma_et/pages/WelcomePage.dart';
import 'package:pharma_et/utils/SlideTransition.dart';

class AppRouter {
  static final router = GoRouter(routes: [
    GoRoute(
      path: "/",
      name: 'splash',
      pageBuilder: (context, state) => SlideTransitionPage(
        key: state.pageKey,
        child: const SplashPage(),
      ),
    ),
    GoRoute(
      path: "/welcome",
      name: "welcome",
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
    GoRoute(
      path: "/azmedicines",
      name: 'azmedicines',
      pageBuilder: (context, state) => SlideTransitionPage(
        key: state.pageKey,
        child: const AZMedicines(),
        rtl: false,
      ),
    ),
    GoRoute(
      path: "/categoryDetails",
      name: 'categoryDetails',
      pageBuilder: (context, state) => SlideTransitionPage(
        key: state.pageKey,
        child: const CategoryDetailsPage(),
        rtl: false,
      ),
    ),
    GoRoute(
      path: "/profile",
      name: 'profile',
      pageBuilder: (context, state) => SlideTransitionPage(
        key: state.pageKey,
        child: const ProfilePage(),
      ),
    ),
    GoRoute(
      path: "/addemail",
      name: 'addemail',
      pageBuilder: (context, state) => SlideTransitionPage(
        key: state.pageKey,
        rtl: false,
        child: const AddEmailAddress(),
      ),
    ),
    GoRoute(
      path: "/forgot",
      name: 'forgot',
      pageBuilder: (context, state) => SlideTransitionPage(
        key: state.pageKey,
        rtl: false,
        child: const ForgorPasswordPage(),
      ),
    ),
    GoRoute(
      path: "/search",
      name: 'search',
      pageBuilder: (context, state) => SlideTransitionPage(
        key: state.pageKey,
        child: const SearchPage(),
      ),
    ),
    GoRoute(
      path: "/prescriptions",
      name: 'prescriptions',
      pageBuilder: (context, state) => SlideTransitionPage(
        key: state.pageKey,
        child: const PrescriptionsListPage(),
      ),
    ),
  ]);
}
