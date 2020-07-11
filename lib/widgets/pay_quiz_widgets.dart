import 'package:flutter/material.dart';

class PlayQuizWidget extends StatefulWidget {

  final String option, description, correctAnswer, optionSelected;

  const PlayQuizWidget({Key key, @required this.option, @required this.description,@required this.correctAnswer,@required this.optionSelected}) : super(key: key);

  @override
  _PlayQuizWidgetState createState() => _PlayQuizWidgetState();
}

class _PlayQuizWidgetState extends State<PlayQuizWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10,),
      child: new Row(
        children: <Widget>[
          new Container(
            width: 29,
            height: 29,
            decoration: BoxDecoration(
              border: Border.all(
                color: widget.description == widget.optionSelected ? widget.optionSelected == widget.correctAnswer
                    ? Colors.green.withOpacity(0.7) : Colors.red.withOpacity(0.7) : Colors.grey,
                width: 1.7
              ),
              borderRadius: new BorderRadius.circular(30)
            ),
            alignment: Alignment.center,
            child: new Text(
              "${widget.option}",
              style: new TextStyle(
                color: widget.optionSelected == widget.description ? widget.correctAnswer == widget.optionSelected ?
                    Colors.grey.withOpacity(0.7) : Colors.red.withOpacity(0.7) : Colors.green
              ),
            ),
          ),

          new SizedBox(width: 8,),
          
          new Text(
            "${widget.description}",
            style: new TextStyle(
              fontSize: 15,
              color: Colors.black54,
            ),
          )
        ],
      ),
    );
  }
}
