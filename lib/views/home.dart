import 'package:flutter/material.dart';
import 'package:quizmaker/services/database.dart';
import 'package:quizmaker/views/create_quiz.dart';
import 'package:quizmaker/views/play_quiz.dart';
import 'package:quizmaker/widgets/widgets.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  Stream quizStream;
  DatabaseService databaseService = new DatabaseService();

  @override
  void initState() {
    getQuizDataList();
    super.initState();
  }

  getQuizDataList() async
  {
    await databaseService.getQuizData().then((value){
      setState(() {
        quizStream = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.transparent,
        brightness: Brightness.light,
        title: appBar(context),
        elevation: 0.0,
      ),
      body: QuizList(),

      floatingActionButton: new FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => new CreateQuiz()));
        },
        child: new Icon(Icons.add),
      ),
    );
  }

  Widget QuizList()
  {
    return new Container(
      margin: EdgeInsets.symmetric(horizontal: 24),
      child: StreamBuilder(
       stream: quizStream,
        builder: (context, snapshot){
         return snapshot.data == null ? new Container(

         ) : new ListView.builder(
           itemCount: snapshot.data.documents.length,
           itemBuilder: (context, index){
             return new QuizTile(
               imgUrl:snapshot.data.documents[index].data["quizImgUrl"] ,
               title: snapshot.data.documents[index].data["quizTitle"],
               description: snapshot.data.documents[index].data["quizDescription"],
               id: snapshot.data.documents[index].data["quizId"],
             );
           },
         );
        },
      ) ,
    );
  }
}

class QuizTile extends StatefulWidget {

  final String imgUrl, title, description,id;
  QuizTile({@required this.imgUrl, @required this.title, @required this.description, @required this.id});


  @override
  _QuizTileState createState() => _QuizTileState();
}

class _QuizTileState extends State<QuizTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      margin: EdgeInsets.only(bottom: 8),
//      width: MediaQuery.of(context).size.width,
      child: new GestureDetector(
        onTap: (){
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => new PlayQuiz(quizId: widget.id,))
          );
        },
        child: new Stack(
          children: <Widget>[
            new ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: new Image.network(
                widget.imgUrl,
                fit: BoxFit.cover,
                width: MediaQuery.of(context).size.width - 48,
              ),
            ),

            new Container(
              width: MediaQuery.of(context).size.width - 48,
              alignment: Alignment.center,
              decoration: new BoxDecoration(
                color: Colors.black26,
                borderRadius: BorderRadius.circular(8),
              ),
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[

                  new Text(
                    widget.title,
                    style: new TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                    ),
                  ),

                  new SizedBox(height: 5.0,),

                  new Text(
                    widget.description,
                    style: new TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  )

                ],

              ),
            )
          ],
        ),
      ),
    );
  }
}


