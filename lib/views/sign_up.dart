import 'package:flutter/material.dart';
import 'package:quizmaker/helper/functions.dart';
import 'package:quizmaker/services/auth.dart';
import 'package:quizmaker/views/home.dart';
import 'package:quizmaker/views/sign_in.dart';
import 'package:quizmaker/widgets/widgets.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  String name, email, password;
  bool isLoading = false;
  AuthService authService = new AuthService();

  signUpWIthEmailAndPass() async {
    if (_formKey.currentState.validate()) {
      setState(() {
        isLoading = true;
      });
      authService.signUpWithEmailAndPassword(email, password).then((value) {
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
              child: new Center(
                child: new CircularProgressIndicator(),
              ),
            )
          : new Form(
              key: _formKey,
              child: new Container(
                margin: EdgeInsets.symmetric(horizontal: 24),
                child: new Column(
                  children: <Widget>[
                    new Spacer(),
                    new TextFormField(
                      validator: (nameValue) {
                        return nameValue.isEmpty ? "Please Enter Name" : null;
                      },
                      decoration: InputDecoration(hintText: "Name"),
                      onChanged: (nameValue) {
                        name = nameValue;
                      },
                    ),
                    new SizedBox(
                      height: 6,
                    ),
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
                        signUpWIthEmailAndPass();
                      },
                      child: signInAndSignUpAndCreateButton(context: context ,label: "Sign Up", buttonWidth: null),
                    ),
                    new SizedBox(
                      height: 26,
                    ),
                    new Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        new Text(
                          "Already have an account? ",
                          style: new TextStyle(fontSize: 15.5),
                        ),
                        new GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => new SignIn()));
                          },
                          child: new Text(
                            "Sign In",
                            style: new TextStyle(
                              fontSize: 15.5,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        )
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
