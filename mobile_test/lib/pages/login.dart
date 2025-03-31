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
  bool isVerified = false;
  String emailV = '';

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
        //email textbox
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
        //send code to email button
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
        //otp code textbox
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
        //check otp code and verify email button
        MaterialButton(
          onPressed: () async {
            try {
              Verify verification = await verifyEmail(emailController.text, otpController.text);
              message = verification.message;
              if(message == 'Verify') {
                isVerified = true;
                emailV = emailController.text;
              }

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
        //submit and open change password dialog
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

            if(!isVerified) {
              message = 'Email not Verified';
              return;
            }

            Navigator.of(context).pop(otpController.text);
            //Navigator.of(context).pop(emailController.text);
            otpController.clear();
            emailController.clear();
            message = '';
            openPasswordDialog(emailV);
          },
          elevation: 4,
          color: Styles.schemeMain.secondary,
          shape: Styles.buttonShape,
          height: 60,
          minWidth: 265,
          child: const Text(
            'Done',
            style: Styles.buttonTextStyle,
          ),
        ),
        //display message updating user on input
        Container(
          padding: EdgeInsets.all(10),
          child: Text(message, textAlign: TextAlign.center, style: Styles.generalTextStyle,),
        ),
      ]),
    ),
  ));

  Future openPasswordDialog(String email) => showDialog(
    context: context,
    builder: (context) => StatefulBuilder(builder: (context, setState) => AlertDialog(

      title: Text('Reset Password', style: Styles.timeTextStyle, textAlign: TextAlign.center,),
      content: Column(mainAxisAlignment: MainAxisAlignment.start, spacing: 30, children: [
        //reset password textbox
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
        //validates password format
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
        //confirm password textbox
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
        //calls reset password api call and closes dialog
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

              ResetPassword passwordReset = await resetPassword(email,passwordResetController.text);
              message = passwordReset.message;

              print(email);
              print(passwordResetController.text);
              print(passwordReset.message);

              setState(() {});

              //Navigator.of(context).pop(passwordResetController.text);
              Navigator.of(context).pop(passwordConfirmController.text);
              passwordResetController.clear();
              passwordConfirmController.clear();

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
            'Reset Password',
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
                  //whitespacing
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
                  Container(
                    width: scrnWidth,
                    padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                    child: Center(
                      child: RichText(text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'No account? ',
                            style: Styles.smallTextStyle,
                          ),
                          // Goes to Signup page.
                          TextSpan
                            (
                            text: 'Signup here!',
                            style: Styles.linkSmallTextStyle,
                            recognizer: TapGestureRecognizer()
                              ..onTap = (){
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => const RegisterPage()),
                                );
                              },
                          ),
                        ])),
                    ),
                  ),
                  
                  Container(
                    width: scrnWidth,
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    child: Center(
                      child: RichText(text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'Forgot password? ',
                            style: Styles.smallTextStyle,
                          ),
                          // Goes to Signup page.
                          TextSpan
                            (
                            text: 'Reset password.',
                            style: Styles.linkSmallTextStyle,
                            recognizer: TapGestureRecognizer()
                              ..onTap = () async {
                                await openDialog();
                              },
                          ),
                        ])),
                    ),
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
