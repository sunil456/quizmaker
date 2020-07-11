import 'package:flutter/material.dart';
import 'package:quizmaker/helper/functions.dart';
import 'package:quizmaker/services/auth.dart';
import 'package:quizmaker/views/home.dart';
import 'package:quizmaker/views/sign_up.dart';
import 'package:quizmaker/widgets/widgets.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _formKey = GlobalKey<FormState>();
  String email, password;
  bool isLoading = false;
  AuthService authService = new AuthService();

  signInWIthEmailAndPass() async {
    if (_formKey.currentState.validate()) {
      setState(() {
        isLoading = true;
      });
      authService.signInEmailAndPassword(email, password).then((value) {
        if (value != null) {
          setState(() {
            isLoading = false;
          });
          HelperFunctions.saveUserLoggedInDetails(isLoggedIn: true);

          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => Home()));

        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: appBar(context),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        brightness: Brightness.light,
      ),
      body: isLoading
          ? new Container(
              child: new Center(child: new CircularProgressIndicator()),
            )
          : new Form(
              key: _formKey,
              child: new Container(
                margin: EdgeInsets.symmetric(horizontal: 24),
                child: new Column(
                  children: <Widget>[
                    new Spacer(),
                    new TextFormField(
                      validator: (emailValue) {
                        return emailValue.isEmpty
                            ? "Please Enter Correct Email Address"
                            : null;
                      },
                      decoration: InputDecoration(hintText: "Email"),
                      onChanged: (emailValue) {
                        email = emailValue;
                      },
                    ),
                    new SizedBox(
                      height: 6,
                    ),
                    new TextFormField(
                      obscureText: true,
                      validator: (passwordValue) {
                        return passwordValue.isEmpty
                            ? "Please Enter Correct Password"
                            : null;
                      },
                      decoration: InputDecoration(hintText: "Password"),
                      onChanged: (passwordValue) {
                        password = passwordValue;
                      },
                    ),
                    new SizedBox(
                      height: 26,
                    ),
                    new GestureDetector(
                        onTap: () {
                          signInWIthEmailAndPass();
                        },
                        child:
                            signInAndSignUpAndCreateButton(context: context ,label: "Sign In", buttonWidth: null)),
                    new SizedBox(
                      height: 26,
                    ),
                    new Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        new Text(
                          "Don't have an account? ",
                          style: new TextStyle(fontSize: 15.5),
                        ),
                        new GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => new SignUp()));
                          },
                          child: new Text(
                            "Sign Up",
                            style: new TextStyle(
                              fontSize: 15.5,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ],
                    ),
                    new SizedBox(
                      height: 80,
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
