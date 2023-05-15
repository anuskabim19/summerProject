import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'authentication/sign_in.dart';


class SplashPage extends StatefulWidget {
  const SplashPage({super.key});
  

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3)).then((value) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => MyLogin(onClickedSignUp: () {  },)));
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(30),
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/h3.jpg"), fit: BoxFit.cover),
          ),
          child: Column(
            children: [
              // Container(
              //   margin: EdgeInsets.fromLTRB(20, 200, 0, 20),
              //   child: Text(
              //       "Welcome to Narephat HealthCare! \n please wait a second..",
              //       style:
              //           TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
              // ),
              SizedBox(
                height: 10,
              ),
              SpinKitFadingCube(
                color: Color.fromARGB(255, 59, 124, 136),
                size: 30.0,
              ),
            ],
          )),
    );
  }
}
