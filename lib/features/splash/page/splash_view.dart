import 'dart:async';

import 'package:flutter/material.dart';
import 'package:todo_app/features/login/page/login_view.dart';

// import '../../settings_provider.dart';

class SplashView extends StatefulWidget {
  static const String routeName = "/";

  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    Timer(const Duration(seconds: 1), () {
      Navigator.pushReplacementNamed(context, LoginView.routeName);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // var mediaQuery = MediaQuery
    //     .of(context)
    //     .size;
    // var vm = Provider.of<SettingsProvider>(context);
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFFDFECDB),
      ),
      child: Image.asset(
        "assets/images/logo.png",
      ),
    );
  }
}
