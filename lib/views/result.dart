import 'package:flutter/material.dart';
import 'package:quizmaker/views/home.dart';
import 'package:quizmaker/widgets/widgets.dart';

class Result extends StatefulWidget {

  final int correctAnswer, incorrectAnswer, total;

  const Result({Key key, @required this.correctAnswer, @required  this.incorrectAnswer, @required  this.total}) : super(key: key);


  @override
  _ResultState createState() => _ResultState();
}

class _ResultState extends State<Result> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Container(
        height: MediaQuery.of(context).size.height,
        child: new Center(
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Text(
                "${widget.correctAnswer} / ${widget.total}",
                style: new TextStyle(
                  fontSize: 25,
                ),
              ),
              new SizedBox(height: 8,),
              new Text(
                "You answered ${widget.correctAnswer} answer correctly and ${widget.incorrectAnswer} answer incorrectly",
                style: new TextStyle(
                  fontSize: 15,
                  color: Colors.grey,
                ),
                textAlign: TextAlign.center,
              ),
              new SizedBox(height: 14,),

              new GestureDetector(
                onTap: (){
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => new Home())
                  );
                },
                child: signInAndSignUpAndCreateButton(
                  context: context,
                  label: "Go To Home",
                  buttonWidth: MediaQuery.of(context).size.width/2
                ),
              )
            ],
          )
        ),
      ),
    );
  }
}
