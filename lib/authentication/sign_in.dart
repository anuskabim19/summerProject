import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import 'google_sign_in.dart';

class MyLogin extends StatefulWidget {
  final VoidCallback onClickedSignUp;
  const MyLogin({Key? key, required this.onClickedSignUp}) : super(key: key);

  @override
  _MyLoginState createState() => _MyLoginState();
}

class _MyLoginState extends State<MyLogin> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        // decoration: BoxDecoration(
        //   image: DecorationImage(
        //       image: AssetImage('assets/h7.jpg'), fit: BoxFit.cover),
        // ),
        child: Scaffold(
            backgroundColor: Color.fromARGB(255, 140, 175, 219),
            body: Stack(children: [
              Container(),
              Container(
                padding: EdgeInsets.only(left: 35, top: 130),
                child: Text(
                  'Welcome\nBack',
                  style: TextStyle(
                      color: Color.fromARGB(255, 8, 6, 6), fontSize: 40),
                ),
              ),
              SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.5),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 35, right: 35),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 40,
                              ),
                              TextFormField(
                                controller: emailController,
                                cursorColor: Colors.black,
                                textInputAction: TextInputAction
                                    .next, //it pass the cruser to next text field
                                decoration: InputDecoration(
                                    labelText: 'Email',
                                    border: OutlineInputBorder()),
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                validator: (email) => email != null &&
                                        !EmailValidator.validate(email)
                                    ? 'Enter a valid email'
                                    : null,
                              ),
                              SizedBox(height: 4),
                              TextFormField(
                                controller: passwordController,
                                cursorColor: Colors.black,
                                obscureText: true,
                                textInputAction: TextInputAction.done,
                                decoration: InputDecoration(
                                    labelText: 'password',
                                    border: OutlineInputBorder()),
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                validator: (value) =>
                                    value != null && value.length < 6
                                        ? 'please enter valid password'
                                        : null,
                              ),
                              SizedBox(height: 20),
                              ElevatedButton.icon(
                                style: ElevatedButton.styleFrom(
                                  minimumSize: Size.fromHeight(50),
                                ),
                                icon: Icon(Icons.lock_open, size: 32),
                                label: Text(
                                  'Sign In',
                                  style: TextStyle(fontSize: 24),
                                ),
                                onPressed: signIn,
                              ),
                              SizedBox(
                                height: 24,
                              ),
                              RichText(
                                  text: TextSpan(
                                      style: TextStyle(
                                          color:
                                              Color.fromARGB(255, 15, 16, 19),
                                          fontSize: 20),
                                      text: 'Do not have account? ',
                                      children: [
                                    TextSpan(
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = widget.onClickedSignUp,
                                        text: 'Sign Up',
                                        style: TextStyle(
                                            decoration:
                                                TextDecoration.underline,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .secondary))
                                  ])),
                              SizedBox(
                                height: 24,
                              ),
                              ElevatedButton.icon(
                                  style: ElevatedButton.styleFrom(
                                    minimumSize: Size(double.infinity, 50),
                                  ),
                                  icon: FaIcon(
                                    FontAwesomeIcons.google,
                                    color: Color.fromARGB(255, 61, 46, 99),
                                  ),
                                  label: Text('Sign Up with Google'),
                                  onPressed: () {
                                    final provider =
                                        Provider.of<GoogleSignInProvider>(
                                            context,
                                            listen: false);
                                    provider.googleLogin();
                                  })
                            ],
                          ),
                        ),
                      ]),
                ),
              ),
            ])));
  }

  Future signIn() async {
    showDialog(
        context: context,
        builder: (context) => Center(child: CircularProgressIndicator()));
    //Asynchronous function is a function that returns the type of Future.
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim());
    } on FirebaseAuthException catch (e) {
      print(e);
    }
    var navigatorKey;
    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }
}
