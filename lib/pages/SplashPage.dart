import 'package:flutter/material.dart';
import 'package:pharma_et/pages/HomePage.dart';
import 'package:pharma_et/pages/WelcomePage.dart';
import 'package:pharma_et/utils/Constants.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: auth.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return const WelcomePage();
          }
          if (snapshot.data == null) return const WelcomePage();
          return const HomePage();
        },
      ),
    );
  }
}
