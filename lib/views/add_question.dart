import 'package:flutter/material.dart';
import 'package:quizmaker/services/database.dart';
import 'package:quizmaker/views/create_quiz.dart';
import 'package:quizmaker/widgets/widgets.dart';

class AddQuestion extends StatefulWidget {
  final String quizId;

  AddQuestion({this.quizId});

  @override
  _AddQuestionState createState() => _AddQuestionState();
}

class _AddQuestionState extends State<AddQuestion> {

  final _formKey = GlobalKey<FormState>();
  DatabaseService databaseService = new DatabaseService();
  String question, option1, option2,option3,option4;
  bool _isLoading = false;

  uploadQuestionData() async
  {
    if(_formKey.currentState.validate())
      {
        setState(() {
          _isLoading = true;
        });

        Map<String, String> questionMap = {
          "question": question,
          "option1": option1,
          "option2": option2,
          "option3": option3,
          "option4": option4
        };

        await databaseService.addQuestion(questionMap, widget.quizId).then((value){
          setState(() {
            _isLoading = false;
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
      body:_isLoading ? new Container(
        child: new Center(
          child: new CircularProgressIndicator(),
        ),
      ) : new Form(
        key: _formKey,
        child: new Container(
          margin: EdgeInsets.symmetric(horizontal: 24),
          child: new Column(
            children: <Widget>[

              new TextFormField(
                validator: (questionValue) {
                  return questionValue.isEmpty
                      ? "Please Enter Question"
                      : null;
                },
                decoration: new InputDecoration(
                  hintText: "Question"
                ),
                onChanged: (questionValue){
                  question = questionValue;
                },
              ),

              new SizedBox(height: 6,),

              new TextFormField(
                validator: (option1Value) {
                  return option1Value.isEmpty
                      ? "Please Enter First Option"
                      : null;
                },
                decoration: new InputDecoration(
                    hintText: "Option1 (Correct Answer)"
                ),
                onChanged: (option1Value){
                  option1 = option1Value;
                },
              ),

              new SizedBox(height: 6,),

              new TextFormField(
                validator: (option2Value) {
                  return option2Value.isEmpty
                      ? "Please Enter Second Option"
                      : null;
                },
                decoration: new InputDecoration(
                    hintText: "Option2"
                ),
                onChanged: (option2Value){
                  option2 = option2Value;
                },
              ),

              new SizedBox(height: 6,),

              new TextFormField(
                validator: (option3Value) {
                  return option3Value.isEmpty
                      ? "Please Enter Third Option"
                      : null;
                },
                decoration: new InputDecoration(
                    hintText: "Option3"
                ),
                onChanged: (option3Value){
                  option3 = option3Value;
                },
              ),

              new SizedBox(height: 6,),

              new TextFormField(
                validator: (option4Value) {
                  return option4Value.isEmpty
                      ? "Please Enter Forth Option"
                      : null;
                },
                decoration: new InputDecoration(
                    hintText: "Option4"
                ),
                onChanged: (option4Value){
                  option4 = option4Value;
                },
              ),

              new Spacer(),

              new Row(
                children: <Widget>[

                  new GestureDetector(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: signInAndSignUpAndCreateButton(
                      context: context,
                      label: "Submit",
                      buttonWidth: MediaQuery.of(context).size.width/2 - 36
                    ),
                  ),

                  new SizedBox(width: 16,),

                  new GestureDetector(
                    onTap: (){
                      uploadQuestionData();
                    },
                    child: signInAndSignUpAndCreateButton(
                        context: context,
                        label: "Add Question",
                        buttonWidth: MediaQuery.of(context).size.width/2 - 36
                    ),
                  )
                ],
              ),

              new SizedBox(height: 50,)

            ],
          ),
        ),
      ),
    );
  }
}
