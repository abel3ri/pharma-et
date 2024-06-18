import 'package:go_router/go_router.dart';
import 'package:pharma_et/pages/SplashPage.dart';
import 'package:pharma_et/utils/SlideTransition.dart';

class AppRouter {
  static final router = GoRouter(routes: [
    GoRoute(
      path: "/",
      name: 'splashPage',
      pageBuilder: (context, state) => SlideTransitionPage(
        key: state.pageKey,
        child: const SplashPage(),
      ),
    ),
  ]);
}
