import 'package:flutter/material.dart';
import 'package:interfone_digital/services/auth_service.dart';
import 'package:interfone_digital/utils/providers.dart';
import 'package:interfone_digital/views/login_page.view.dart';
import 'package:interfone_digital/views/my_home_page.view.dart';

class AuthCheck extends StatefulWidget {
  const AuthCheck({super.key});

  @override
  State<AuthCheck> createState() => _AuthCheckState();
}

class _AuthCheckState extends State<AuthCheck> {
  final AuthService authService = getIt<AuthService>();

  @override
  void initState() {
    super.initState();
    authService.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    if (authService.isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    } else if (authService.usuario == null) {
      return const LoginPage();
    } else {
      return const MyHomePage();
    }
  }
}
