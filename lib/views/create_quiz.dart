import 'package:flutter/material.dart';
import 'package:quizmaker/services/database.dart';
import 'package:quizmaker/views/add_question.dart';
import 'package:quizmaker/views/home.dart';
import 'package:quizmaker/widgets/widgets.dart';
import 'package:random_string/random_string.dart';

class CreateQuiz extends StatefulWidget {
  @override
  _CreateQuizState createState() => _CreateQuizState();
}

class _CreateQuizState extends State<CreateQuiz> {
  final _formKey = GlobalKey<FormState>();
  String quizTitle, quizDescription, quizImageUrl, quizId;
  DatabaseService databaseService = new DatabaseService();
  bool _isLoading = false;

  createQuizOnline() async {
    if (_formKey.currentState.validate()) {
      setState(() {
        _isLoading = true;
      });
      quizId = randomAlphaNumeric(16);
      Map<String, String> quizMap = {
        "quizId": quizId,
        "quizImgUrl": quizImageUrl,
        "quizTitle": quizTitle,
        "quizDescription": quizDescription
      };
      await databaseService.addQuizData(quizMap, quizId).then((value) {
        setState(() {
          _isLoading = false;

          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => new AddQuestion(quizId: quizId,)));
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.transparent,
        brightness: Brightness.light,
        iconTheme: new IconThemeData(color: Colors.black87),
        title: appBar(context),
        elevation: 0.0,
      ),
      body: _isLoading
          ? new Container(
              child: new Center(child: new CircularProgressIndicator()),
            )
          : new Form(
              key: _formKey,
              child: new Container(
                margin: EdgeInsets.symmetric(horizontal: 24),
                child: new Column(
                  children: <Widget>[
                    new TextFormField(
                      validator: (quizImage) {
                        return quizImage.isEmpty
                            ? "Please Enter Quiz Image"
                            : null;
                      },
                      decoration: new InputDecoration(
                        hintText: "Quiz Image Url (optional)",
                      ),
                      onChanged: (quizImage) {
                        quizImageUrl = quizImage;
                      },
                    ),
                    new SizedBox(
                      height: 6.0,
                    ),
                    new TextFormField(
                      validator: (quizTitleValue) {
                        return quizTitleValue.isEmpty
                            ? "Please Enter Quiz Title"
                            : null;
                      },
                      decoration: new InputDecoration(
                        hintText: "Quiz Title",
                      ),
                      onChanged: (quizTitleValue) {
                        quizTitle = quizTitleValue;
                      },
                    ),
                    new SizedBox(
                      height: 6.0,
                    ),
                    new TextFormField(
                      validator: (quizDescriptionValue) {
                        return quizDescriptionValue.isEmpty
                            ? "Please Enter Quiz Description"
                            : null;
                      },
                      decoration: new InputDecoration(
                        hintText: "Quiz Description",
                      ),
                      onChanged: (quizDescriptionValue) {
                        quizDescription = quizDescriptionValue;
                      },
                    ),
                    new Spacer(),
                    new GestureDetector(
                      onTap: () {
                        createQuizOnline();
                      },
                      child: signInAndSignUpAndCreateButton(
                        context: context ,label: "Create Quiz", buttonWidth: null
                      ),
                    ),
                    new SizedBox(
                      height: 50,
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
