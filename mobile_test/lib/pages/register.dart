import 'package:flutter/material.dart';
import 'package:mobile_test/overlays.dart';
import 'package:mobile_test/pages/home/homepage.dart';
import 'package:mobile_test/pages/login.dart';
import '../styles.dart';
import 'package:flutter_pw_validator/flutter_pw_validator.dart';


final buttonStyle = Styles.yellowButtonStyle;

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  final firstnameController = TextEditingController();
  final lastnameController = TextEditingController();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmpasswordController = TextEditingController();
  final emailController = TextEditingController();
  bool isPasswordVisible = true;
  bool isConfirmPasswordVisible = true;

  @override
  void initState(){
    super.initState();

    firstnameController.addListener(() => setState(() {}));
    lastnameController.addListener(() => setState(() {}));
    usernameController.addListener(() => setState(() {}));
    passwordController.addListener(() => setState(() {}));
    confirmpasswordController.addListener(() => setState(() {}));
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBarBlank(),
      bottomNavigationBar: BottomBarBlank(),
      body: Center(
        child: ListView(
         
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
                    'SIGN UP',
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

            Container(
              height:45
            ),

            //textboxes and button
            Form(
              child: Column(
                spacing: 40,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
            
                  //First name textbox
                  Container(
                    color: Colors.grey[300],
                    padding: EdgeInsets.fromLTRB(10, 25, 10, 0),
                    width: 336,
                    height: 65,
                    child: TextField(
                      controller: firstnameController,
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
                        hintText: 'First Name',
                        hintStyle: Styles.fieldTextStyle,
                        border: InputBorder.none,
                      ),
                    ),
                  ),

                  //Last Name textbox
                  Container(
                    color: Colors.grey[300],
                    padding: EdgeInsets.fromLTRB(10, 25, 10, 0),
                    width: 336,
                    height: 65,
                    child: TextField(
                      controller: lastnameController,
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
                        hintText: 'Last Name',
                        hintStyle: Styles.fieldTextStyle,
                        border: InputBorder.none,
                      ),
                    ),
                  ),

                  // Username Textbox
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

                  // Email Textbox
                  Container(
                    color: Colors.grey[300],
                    padding: EdgeInsets.fromLTRB(10, 25, 10, 0),
                    width: 336,
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

                  // Password textbox
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
                        fontFamily: '',
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

                  FlutterPwValidator(
                    controller: passwordController,
                    minLength: 5,
                    uppercaseCharCount: 1,
                    lowercaseCharCount: 1,
                    numericCharCount: 1,
                    specialCharCount: 1,
                    width: 336,
                    height: 150,
                    onSuccess: () {
                      print("Password is valid");
                    },
                    onFail: () {
                      print("Password is not valid");
                    },
                  ),


                  // Confirm Password textbox
                  Container(
                    color: Colors.grey[300],
                    padding: EdgeInsets.fromLTRB(10, 25, 10, 0),
                    width: 336,
                    height: 65,
                    child: TextField(
                      controller: confirmpasswordController,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        color: Styles.schemeMain.primary,
                        fontFamily: '',
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

                  //Create Account button
                  MaterialButton(
                    onPressed: () {
                      final firstname = firstnameController.text.trim();
                      final lastname = lastnameController.text.trim();
                      final username = usernameController.text.trim();
                      final email = emailController.text.trim();
                      final password = passwordController.text;
                      final confirmPassword = confirmpasswordController.text;

                      // check empty flied
                      if (firstname.isEmpty || lastname.isEmpty || username.isEmpty ||
                          email.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Please fill out all fields'),
                            backgroundColor: Colors.red,
                          ),
                        );
                        return;
                      }

                      // check email verification
                      final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                      if (!emailRegex.hasMatch(email)) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Invalid email format'),
                            backgroundColor: Colors.red,
                          ),
                        );
                        return;
                      }

                      // check password
                      if (password != confirmPassword) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Passwords do not match'),
                            backgroundColor: Colors.red,
                          ),
                        );
                        return;
                      }

                      //temp solution; ideally would be passed as json for login endpoint or something like that
                      print('firstname: ${firstnameController.text}');
                      print('lastname: ${lastnameController.text}');
                      print('username: ${usernameController.text}');
                      print('email: ${emailController.text}');
                      print('password: ${passwordController.text}');
                      print('confirm password: ${confirmpasswordController.text}');
            
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const LoginPage()),
                      );
                    },
                    elevation: 4,
                    color: Styles.schemeMain.secondary,
                    shape: Styles.buttonShape,
                    height: 70,
                    minWidth: 350,
                    child: Text(
                      'Create Account',
                      style: Styles.buttonTextStyle,
                    ),
                  ),
                ],
              ),
            ),
            
            // Login Hyperlink
            Container(
              width: 300,
              padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
              child: Center(
                child: RichText(text: TextSpan(
                children: [
                  TextSpan( 
                    text: 'Already Registered? ', 
                    style: Styles.smallTextStyle,
                  ),

                  // FIXME - Make text go to Login page.
                  TextSpan
                  ( 
                    text: 'Login here.',
                    style: Styles.linkSmallTextStyle,
                  ),
                
                ])),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
