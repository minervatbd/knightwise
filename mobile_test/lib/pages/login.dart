import 'dart:convert';

import 'register.dart';
import 'package:flutter/material.dart';
import 'package:mobile_test/calls.dart';
import 'package:mobile_test/models.dart';
import '../overlays.dart';
import '../pages/home/homepage.dart';
import '../styles.dart';
import 'package:flutter_pw_validator/flutter_pw_validator.dart';

import 'package:http/http.dart' as http;

final buttonStyle = Styles.yellowButtonStyle;

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordResetController = TextEditingController();
  final passwordConfirmController = TextEditingController();
  final emailController = TextEditingController();
  final otpController = TextEditingController();
  String message = '';
  bool isPasswordVisible = true;
  bool isResetPasswordVisible = true;
  bool isConfirmPasswordVisible = true;

  @override
  void initState() {
    super.initState();
    usernameController.addListener(() => setState(() {}));
    passwordController.addListener(() => setState(() {}));
    emailController.addListener(() => setState(() {}));
    otpController.addListener(() => setState(() {}));
    passwordResetController.addListener(() => setState(() {}));
    passwordConfirmController.addListener(() => setState(() {}));
  }

  /*
  @override
  void dispose() {
    otpController.dispose();
    emailController.dispose();
    super.dispose();
  }
   */




  Future openDialog() => showDialog(
    context: context,
    builder: (context) => StatefulBuilder(builder: (context, setState) => AlertDialog(

      title: Text('Reset Password', style: Styles.timeTextStyle, textAlign: TextAlign.center,),
      content: Column(mainAxisAlignment: MainAxisAlignment.start, spacing: 30, children: [
        Container(
          color: Colors.grey[300],
          padding: EdgeInsets.fromLTRB(10, 25, 10, 0),
          width: 300,
          height: 65,
          child: TextField(
            controller: emailController,
            textAlign: TextAlign.start,
            style: TextStyle(
              color: Styles.schemeMain.primary,
              fontFamily: 'Mulish',
              fontWeight: FontWeight.w400,
              fontSize: 24,
            ),
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.only(
                  left: 4.0,
                  bottom: 4.0,
                  top: 4.0
              ),
              hintText: 'Email',
              hintStyle: Styles.fieldTextStyle,
              border: InputBorder.none,
            ),
          ),
        ),
        MaterialButton(
          onPressed: () async {
            try {
              SendOtp sentCode = await sendEmailCode(emailController.text, "reset");
              message = sentCode.message;
              setState(() {});
            }catch (e){
              print(e);
            }
          },
          elevation: 4,
          color: Styles.schemeMain.secondary,
          shape: Styles.buttonShape,
          height: 60,
          minWidth: 265,
          child: const Text(
            'Send Code',
            style: Styles.buttonTextStyle,
          ),
        ),
        Container(
          color: Colors.grey[300],
          padding: EdgeInsets.fromLTRB(10, 25, 10, 0),
          width: 300,
          height: 65,
          child: TextField(
            controller: otpController,
            textAlign: TextAlign.start,
            style: TextStyle(
              color: Styles.schemeMain.primary,
              fontFamily: 'Mulish',
              fontWeight: FontWeight.w400,
              fontSize: 24,
            ),
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.only(
                  left: 4.0,
                  bottom: 4.0,
                  top: 4.0
              ),
              hintText: 'Verification Code',
              hintStyle: Styles.fieldTextStyle,
              border: InputBorder.none,
            ),
          ),
        ),
        MaterialButton(
          onPressed: () async {
            try {
              Verify verification = await verifyEmail(emailController.text, otpController.text);
              message = verification.message;
              setState(() {});
            }catch (e){
              print(e);
            }
          },
          elevation: 4,
          color: Styles.schemeMain.secondary,
          shape: Styles.buttonShape,
          height: 60,
          minWidth: 265,
          child: const Text(
            'Verify Email',
            style: Styles.buttonTextStyle,
          ),
        ),
        Container(
          padding: EdgeInsets.all(10),
          child: Text(message, textAlign: TextAlign.center, style: Styles.generalTextStyle,),
        ),
        MaterialButton(
          onPressed: () async {

            final email = emailController.text.trim();
            final otp = otpController.text.trim();

            if (email.isEmpty || otp.isEmpty) {
              message = 'Please fill out all fields';
              setState(() {});
              return;
            }

            // check email verification
            final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
            if (!emailRegex.hasMatch(email)) {
              message = 'Invalid email format';
              setState(() {});
              return;
            }

            if(message != 'Verify') {
              message = 'Email not Verified';
              return;
            }

            Navigator.of(context).pop(otpController.text);
            Navigator.of(context).pop(emailController.text);
            otpController.clear();
            openPasswordDialog();
          },
          elevation: 4,
          color: Styles.schemeMain.secondary,
          shape: Styles.buttonShape,
          height: 60,
          minWidth: 265,
          child: const Text(
            'Reset Password',
            style: Styles.buttonTextStyle,
          ),
        ),
      ]),
      /*
      actions: [
        TextButton(
          onPressed: () => {
            Navigator.of(context).pop(otpController.text),
            Navigator.of(context).pop(emailController.text),
            otpController.clear(),
            openPasswordDialog(),
          },
          child: Text('Reset Password', style: Styles.buttonTextStyle,),)
      ],

       */
    ),
  ));

  Future openPasswordDialog() => showDialog(
    context: context,
    builder: (context) => StatefulBuilder(builder: (context, setState) => AlertDialog(

      title: Text('Reset Password', style: Styles.timeTextStyle, textAlign: TextAlign.center,),
      content: Column(mainAxisAlignment: MainAxisAlignment.start, spacing: 30, children: [
        Container(
          color: Colors.grey[300],
          padding: EdgeInsets.fromLTRB(10, 25, 10, 0),
          width: 300,
          height: 65,
          child: TextField(
            controller: passwordResetController,
            textAlign: TextAlign.start,
            style: TextStyle(
              color: Styles.schemeMain.primary,
              fontFamily: 'Mulish',
              fontWeight: FontWeight.w400,
              fontSize: 24,
            ),
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.only(
                  left: 4.0,
                  bottom: 4.0,
                  top: 4.0
              ),
              hintText: 'Reset Password',
              hintStyle: Styles.fieldTextStyle,
              border: InputBorder.none,

              suffixIcon: IconButton(
                icon: isResetPasswordVisible
                    ? Icon(Icons.visibility_off)
                    : Icon(Icons.visibility),
                color: Styles.schemeMain.primary,
                onPressed: () =>
                    setState(() =>
                    isResetPasswordVisible = !isResetPasswordVisible),
              ),
            ),
            obscureText: isResetPasswordVisible,
          ),
        ),
        FlutterPwValidator(
          controller: passwordResetController,
          minLength: 5,
          uppercaseCharCount: 1,
          lowercaseCharCount: 1,
          numericCharCount: 1,
          specialCharCount: 1,
          width: 300,
          height: 150,
          onSuccess: () {
            print("Password is valid");
          },
          onFail: () {
            print("Password is not valid");
          },
        ),
        Container(
          color: Colors.grey[300],
          padding: EdgeInsets.fromLTRB(10, 25, 10, 0),
          width: 300,
          height: 65,
          child: TextField(
            controller: passwordConfirmController,
            textAlign: TextAlign.start,
            style: TextStyle(
              color: Styles.schemeMain.primary,
              fontFamily: 'Mulish',
              fontWeight: FontWeight.w400,
              fontSize: 24,
            ),
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.only(
                  left: 4.0,
                  bottom: 4.0,
                  top: 4.0
              ),
              hintText: 'Confirm Password',
              hintStyle: Styles.fieldTextStyle,
              border: InputBorder.none,
              suffixIcon: IconButton(
                icon: isConfirmPasswordVisible
                    ? Icon(Icons.visibility_off)
                    : Icon(Icons.visibility),
                color: Styles.schemeMain.primary,
                onPressed: () =>
                    setState(() =>
                    isConfirmPasswordVisible = !isConfirmPasswordVisible),
              ),
            ),
            obscureText: isConfirmPasswordVisible,
          ),
        ),
        MaterialButton(
          onPressed: () async {
            try {

              final password = passwordResetController.text;
              final confirmPassword = passwordConfirmController.text;
              // check empty field
              if (password.isEmpty || confirmPassword.isEmpty) {
                message = 'Please fill out all fields';
                setState(() {});
                return;
              }

              // check password
              if (password != confirmPassword) {
                message = 'Passwords do not match';
                setState(() {});
                return;
              }

              ResetPassword passwordReset = await resetPassword(emailController.text,passwordResetController.text);
              message = passwordReset.message;

              setState(() {});
            }catch (e){
              print(e);
            }
          },
          elevation: 4,
          color: Styles.schemeMain.secondary,
          shape: Styles.buttonShape,
          height: 60,
          minWidth: 265,
          child: const Text(
            'Send Code',
            style: Styles.buttonTextStyle,
          ),
        ),
        Container(
          padding: EdgeInsets.all(10),
          child: Text(message, textAlign: TextAlign.center, style: Styles.generalTextStyle,),
        ),
      ]),
    )),
  );

  CurrentUser currUser = CurrentUser();

  @override
  Widget build(BuildContext context) {
    double scrnWidth = MediaQuery.of(context).size.width;
    double containerWidth = (scrnWidth- 65);

    return Scaffold(
      appBar: TopBarBlank(),
      bottomNavigationBar: BottomBarBlank(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: 45.0,
          children: <Widget>[
            //LOGIN stripe
            Material(
              elevation: 4,
              child: Container(
                color: Styles.schemeMain.secondary,
                width: 412,
                height: 89,
                child: Center(
                  child: Text(
                    'LOGIN',
                    style: TextStyle(
                      color: Styles.schemeMain.primary,
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Mulish',
                    ),
                  ),
                ),
              ),
            ),
            //textboxes and button
            Form(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  //username textbox
                  Container(
                    color: Colors.grey[300],
                    padding: EdgeInsets.fromLTRB(10, 25, 10, 0),
                    width: 336,
                    height: 65,
                    child: TextField(
                      controller: usernameController,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        color: Styles.schemeMain.primary,
                        fontFamily: 'Mulish',
                        fontWeight: FontWeight.w400,
                        fontSize: 24,
                      ),
                      decoration: InputDecoration(
                          contentPadding: const EdgeInsets.only(
                              left: 4.0,
                              bottom: 4.0,
                              top: 4.0
                          ),
                        hintText: 'Username',
                        hintStyle: Styles.fieldTextStyle,
                        border: InputBorder.none,
                      ),
                    ),
                  ),

                  SizedBox(height: 40),
                  //password textbox
                  Container(
                    color: Colors.grey[300],
                    padding: EdgeInsets.fromLTRB(10, 25, 10, 0),
                    width: 336,
                    height: 65,
                    child: TextField(
                      controller: passwordController,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        color: Styles.schemeMain.primary,
                        fontFamily: 'Mulish',
                        fontWeight: FontWeight.w400,
                        fontSize: 24,
                      ),
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.only(
                            left: 4.0,
                            bottom: 4.0,
                            top: 4.0
                        ),
                        hintText: 'Password',
                        hintStyle: Styles.fieldTextStyle,
                        border: InputBorder.none,
                        suffixIcon: IconButton(
                          icon: isPasswordVisible
                              ? Icon(Icons.visibility_off)
                              : Icon(Icons.visibility),
                          color: Styles.schemeMain.primary,
                          onPressed: () =>
                              setState(() =>
                              isPasswordVisible = !isPasswordVisible),
                        ),
                      ),
                      obscureText: isPasswordVisible,
                    ),
                  ),

                  SizedBox(height: 40),
                  //Sign in button
                  MaterialButton(
                    onPressed: () async {
                      try {
                          //print('username: ${usernameController.text}');
                          //print('password: ${passwordController.text}');

                          var login = await createLogin(usernameController.text, passwordController.text);
                          print(login.token);
                          print(login.message);
                          print(login.user.firstName);

                          currUser.token = login.token;
                          currUser.firstName = login.user.firstName;
                          currUser.lastName = login.user.lastName;
                          currUser.id = login.user.id;

                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const HomePage()),
                          );
                      }on Exception catch (e){
                        print('$e');
                      }
                    },
                    elevation: 4,
                    color: Styles.schemeMain.secondary,
                    shape: Styles.buttonShape,
                    height: 70,
                    minWidth: 350,
                    child: const Text(
                      'Sign In',
                      style: Styles.buttonTextStyle,
                    ),
                  ),
              Center(child: Container(
                  width: scrnWidth,
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Row(children: [
                    Text(
                        'No account?',
                        style: Styles.smallTextStyle,
                      ),
                      TextButton(
                        onPressed: () => {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const RegisterPage()),
                          )},
                        child: Text('Sign up here.', style: Styles.linkSmallTextStyle, textAlign: TextAlign.start,)
                      ),
                    ]),
                  )),

                  Center(child: Container(
                    width: scrnWidth,
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Row(children: [
                      Text(
                        'Forgot Password?',
                        style: Styles.smallTextStyle,
                      ),
                      TextButton(
                        onPressed: () async => {
                          await openDialog(),
                        },
                        child: Text('Reset Password', style: Styles.linkSmallTextStyle,)
                      ),
                    ])),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
