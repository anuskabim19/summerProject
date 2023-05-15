import 'package:flutter/material.dart';
import 'package:healthcare/authentication/sign_in.dart';
import 'package:healthcare/authentication/sign_up.dart';



class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool isLogin = true;
  @override
  Widget build(BuildContext context) => isLogin
      ? MyLogin(onClickedSignUp: toggle,)
      : SignUp(onClickedSignIn: toggle);
  void toggle() => setState(() => isLogin = !isLogin);
}