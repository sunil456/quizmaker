import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  Future<void> addQuizData(Map quizData, String quizId) async {
    await Firestore.instance
        .collection("Quiz")
        .document(quizId)
        .setData(quizData)
        .catchError((e) {
      print(e.toString());
    });
  }

  Future<void> addQuestion(Map questionData, String quizId) async
  {
    await Firestore.instance.collection("Quiz")
        .document(quizId)
        .collection("QNA")
        .add(questionData)
        .catchError((onError){
          print(onError.toString());
    });
  }

  getQuizData() async
  {
    return await Firestore.instance.collection("Quiz").snapshots();
  }

  getQuestionData(String quizId) async
  {
    return await Firestore.instance.collection("Quiz")
        .document(quizId)
        .collection("QNA")
        .getDocuments()
        .catchError((onError){
          print(onError.toString());
    });
  }
}
