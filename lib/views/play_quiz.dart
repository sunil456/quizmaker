import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quizmaker/models/question_model.dart';
import 'package:quizmaker/services/database.dart';
import 'package:quizmaker/views/result.dart';
import 'package:quizmaker/widgets/pay_quiz_widgets.dart';
import 'package:quizmaker/widgets/widgets.dart';


int total = 0;
int _correct = 0;
int _incorrect = 0;
int _notAttempted = 0;

class PlayQuiz extends StatefulWidget {

  final String quizId;
  PlayQuiz({this.quizId});

  @override
  _PlayQuizState createState() => _PlayQuizState();
}

class _PlayQuizState extends State<PlayQuiz> {

  DatabaseService databaseService = new DatabaseService();
  QuerySnapshot questionSnapshot;

  QuestionModel getQuestionModelFromDataSnapshot(DocumentSnapshot dataQuestionSnapshot)
  {
    QuestionModel questionModel = new QuestionModel();

    questionModel.question = dataQuestionSnapshot.data["question"];

    List<String> options = [
      dataQuestionSnapshot.data["option1"],
      dataQuestionSnapshot.data["option2"],
      dataQuestionSnapshot.data["option3"],
      dataQuestionSnapshot.data["option4"],
    ];

    options.shuffle();

    questionModel.option1 = options[0];
    questionModel.option2 = options[1];
    questionModel.option3 = options[2];
    questionModel.option4 = options[3];
    questionModel.correctOption = dataQuestionSnapshot.data["option1"];
    questionModel.answered = false;

    return questionModel;
  }

  @override
  void initState() {
    print("${widget.quizId}");
    databaseService.getQuestionData(widget.quizId).then((value){
      questionSnapshot = value;
      _notAttempted = 0;
      _correct = 0;
      _incorrect = 0;
      total = questionSnapshot.documents.length;

      print("$total this is total ${widget.quizId}");

      setState(() {

      });

    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.transparent,
        brightness: Brightness.light,
        title: appBar(context),
        iconTheme: new IconThemeData(
          color: Colors.black54,
        ),
        elevation: 0.0,
      ),

      body: new Container(

        child: new Column(
          children: <Widget>[
            questionSnapshot == null ? new Container(
              child: new Center(
                child: new CircularProgressIndicator(),
              ),
            )
                :
                new Container(
                  child: new ListView.builder(
                    shrinkWrap: true,
                    padding: EdgeInsets.symmetric(horizontal: 24),
                    physics: ClampingScrollPhysics(),
                    itemCount: questionSnapshot.documents.length,
                    itemBuilder: (context, index){
                      return PlayQuizTile(
                        questionModel: getQuestionModelFromDataSnapshot(questionSnapshot.documents[index]),
                        index: index,
                      );
                    },
                  ),
                )
          ],

        ),
      ),

      floatingActionButton: new FloatingActionButton(
        onPressed: (){
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context)=> new Result(correctAnswer: _correct, incorrectAnswer: _incorrect, total: total)
            )
          );
        },
        child: Icon(Icons.check),
      ),

    );
  }
}

class PlayQuizTile extends StatefulWidget {
  final QuestionModel questionModel;
  final int index;

  const PlayQuizTile({Key key, this.questionModel, this.index}) : super(key: key);

  @override
  _PlayQuizTileState createState() => _PlayQuizTileState();
}

class _PlayQuizTileState extends State<PlayQuizTile> {

  String optionSelected = "";

  @override
  Widget build(BuildContext context) {
    return Container(
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[

          new Text(
            "Q${widget.index+1} ${widget.questionModel.question}",
            style: new TextStyle(
              fontSize: 18,
              color: Colors.black87
            ),
          ),
          new SizedBox(height: 12,),

          new GestureDetector(
            onTap: (){
              if(!widget.questionModel.answered)
              {
                if(widget.questionModel.option1 == widget.questionModel.correctOption)
                {
                  optionSelected = widget.questionModel.option1;
                  widget.questionModel.answered = true;
                  _correct = _correct + 1;
                  _notAttempted = _notAttempted -1;
                  setState(() {

                  });
                }
                else
                {
                  optionSelected = widget.questionModel.option1;
                  widget.questionModel.answered = true;
                  _incorrect = _incorrect + 1;
                  _notAttempted = _notAttempted -1;
                  setState(() {

                  });
                }
              }
            },
            child: new PlayQuizWidget(
              option: "A",
              description: widget.questionModel.option1,
              correctAnswer: widget.questionModel.correctOption,
              optionSelected: optionSelected,
            ),
          ),

          new SizedBox(height: 4,),

          new GestureDetector(
            onTap: (){
              if(!widget.questionModel.answered)
              {
                if(widget.questionModel.option2 == widget.questionModel.correctOption)
                {
                  optionSelected = widget.questionModel.option2;
                  widget.questionModel.answered = true;
                  _correct = _correct + 1;
                  _notAttempted = _notAttempted -1;
                  setState(() {

                  });
                }
                else
                {
                  optionSelected = widget.questionModel.option2;
                  widget.questionModel.answered = true;
                  _incorrect = _incorrect + 1;
                  _notAttempted = _notAttempted -1;
                  setState(() {

                  });
                }
              }
            },
            child: new PlayQuizWidget(
              option: "B",
              description: widget.questionModel.option2,
              correctAnswer: widget.questionModel.correctOption,
              optionSelected: optionSelected,
            ),
          ),

          new SizedBox(height: 4,),

          new GestureDetector(
            onTap: (){
              if(!widget.questionModel.answered)
              {
                if(widget.questionModel.option3 == widget.questionModel.correctOption)
                {
                  optionSelected = widget.questionModel.option3;
                  widget.questionModel.answered = true;
                  _correct = _correct + 1;
                  _notAttempted = _notAttempted -1;
                  setState(() {

                  });
                }
                else
                {
                  optionSelected = widget.questionModel.option3;
                  widget.questionModel.answered = true;
                  _incorrect = _incorrect + 1;
                  _notAttempted = _notAttempted -1;
                  setState(() {

                  });
                }
              }
            },
            child: new PlayQuizWidget(
              option: "C",
              description: widget.questionModel.option3,
              correctAnswer: widget.questionModel.correctOption,
              optionSelected: optionSelected,
            ),
          ),

          new SizedBox(height: 4,),

          new GestureDetector(
            onTap: (){
              if(!widget.questionModel.answered)
              {
                if(widget.questionModel.option4 == widget.questionModel.correctOption)
                {
                  optionSelected = widget.questionModel.option4;
                  widget.questionModel.answered = true;
                  _correct = _correct + 1;
                  _notAttempted = _notAttempted -1;
                  setState(() {

                  });
                }
                else
                {
                  optionSelected = widget.questionModel.option4;
                  widget.questionModel.answered = true;
                  _incorrect = _incorrect + 1;
                  _notAttempted = _notAttempted -1;
                  setState(() {

                  });
                }
              }
            },
            child: new PlayQuizWidget(
              option: "D",
              description: widget.questionModel.option4,
              correctAnswer: widget.questionModel.correctOption,
              optionSelected: optionSelected,
            ),
          ),

          new SizedBox(height: 12,),

        ],
      ),
    );
  }
}

