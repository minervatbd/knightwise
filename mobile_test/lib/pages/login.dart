import 'package:flutter/material.dart';
import 'package:mobile_test/overlays.dart';
import 'package:mobile_test/pages/home.dart';
import '../styles.dart';

final buttonStyle = Styles.yellowButtonStyle;

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
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
                  spacing: 40,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    //username textbox
                    Container(
                      color: Colors.grey[300],
                      padding: EdgeInsets.fromLTRB(0, 25, 0, 5),
                      width: 336,
                      height: 65,
                      child: TextField(
                        controller: usernameController,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          hintText: 'Username',
                          hintStyle: Styles.fieldTextStyle,
                          border: InputBorder.none,
                        ),
                      ),
                    ),

                    //password textbox
                    Container(
                      color: Colors.grey[300],
                      padding: EdgeInsets.fromLTRB(0, 25, 0, 5),
                      width: 336,
                      height: 65,
                      child: TextField(
                        controller: passwordController,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          hintText: 'Password',
                          hintStyle: Styles.fieldTextStyle,
                          border: InputBorder.none,
                          suffixIcon: IconButton(
                            icon: isPasswordVisible
                              ? Icon(Icons.visibility_off)
                              : Icon(Icons.visibility),
                            onPressed: () =>
                              setState(() => isPasswordVisible = !isPasswordVisible),
                          ),
                        ),
                        obscureText: isPasswordVisible,
                      ),
                    ),

                    //Sign in button
                    MaterialButton(
                      onPressed: () {
                        //temp solution; ideally would be passed as json for login endpoint or something like that
                        print('username: ${usernameController.text}');
                        print('password: ${passwordController.text}');
                        
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const HomePage()),
                        );
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
                  ],
                ),
              ),

        /*
        child: Container(
          height: 50,
          child: ElevatedButton(
            style: buttonStyle,
            child: const Text('LOGIN'),
            // navigate to dashboard
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const HomePage()),
              );
            },
          )
        ),
        */
              
      ),
    );
  }
}
