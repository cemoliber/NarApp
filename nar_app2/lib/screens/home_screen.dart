import 'dart:math';

import 'package:flutter/material.dart';
import 'package:nar_app2/constant.dart';
import 'package:nar_app2/models/db_connect.dart';
import 'package:nar_app2/models/question_model.dart';
import 'package:nar_app2/widgets/next_button.dart';
import 'package:nar_app2/widgets/option_card.dart';
import 'package:nar_app2/widgets/question_widget.dart';

import '../widgets/result_box.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

void main() {
  runApp(HomeScreen());
}

class _HomeScreenState extends State<HomeScreen> {
  // create an object for Dbconnect
  var db = DBconnect();
  late Future _questions;

  Future<List<Question>> getData() async {
    return db.fetchQuestions();
  }

  // create an index to loop through _questions
  int index = 0;
  // create a score variable
  int score = 0;
  // create a boolean value to check if the user has clicked
  bool isPressed = false;
  // create a function to display the next question
  bool isAlreadySelected = false;

  int getRandomNumber(int max) {
    final random = Random();
    return random
        .nextInt(max); // 0 ile (max-1) arasında rastgele bir sayı döndürür
  }

  void nextQuestion(int questionLength) {
    if (index == questionLength - 1) {
      // Bu blok, soruların sona erdiği yerdir.
      showDialog(
        context: context,
        barrierDismissible: false, // Kutunun dışına tıklamayı devre dışı bırak
        builder: (ctx) => ResultBox(
          result: score, // Kullanıcının aldığı toplam puan
          questionLength: questionLength, // Toplam soru sayısı
          onPressed: startOver,
        ),
      );
    } else {
      // Rastgele bir sonraki soruyu seç
      final randomIndex = Random().nextInt(questionLength);
      if (randomIndex != index) {
        setState(() {
          index = randomIndex; // İndeksi rastgele seçilen soruya değiştir
          isPressed = false;
          isAlreadySelected = false;
        });
      } else {
        // Rastgele indeks mevcut indeksle aynıysa
        // Bu soruyu atlayabilir veya farklı şekilde ele alabilirsiniz
        // Şimdilik indeksi 1 artırıyoruz
        setState(() {
          index = (index + 1) % questionLength;
          isPressed = false;
          isAlreadySelected = false;
        });
      }
    }
  }

  // create a function for changing color
  void checkAnswerAndUpdate(bool value) {
    if (isAlreadySelected) {
      return;
    } else {
      if (value == true) {
        score++;
      }
      setState(() {
        isPressed = true;
        isAlreadySelected = true;
      });
    }
  }

  // create a function to start over
  void startOver() {
    setState(() {
      index = 0;
      score = 0;
      isPressed = false;
      isAlreadySelected = false;
    });
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    // use the FutureBuilder Widget
    return FutureBuilder(
      future: _questions as Future<List<Question>>,
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return Center(
              child: Text('${snapshot.error}'),
            );
          } else if (snapshot.hasData) {
            var extractedData = snapshot.data as List<Question>;
            return Scaffold(
              // change the background
              backgroundColor: background,
              appBar: AppBar(
                title: const Text('Quiz App'),
                backgroundColor: background,
                shadowColor: Colors.transparent,
                actions: [
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Text(
                      'Score: $score',
                      style: const TextStyle(fontSize: 18.0),
                    ),
                  ),
                ],
              ),
              body: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Column(
                  children: [
                    // add the questionWIdget here
                    QuestionWidget(
                      indexAction: index, // currently at 0.
                      question: extractedData[index]
                          .title, // means the first question in the list.
                      totalQuestions:
                          extractedData.length, // total length of the list
                    ),
                    const Divider(color: neutral),
                    // add some space
                    const SizedBox(height: 25.0),
                    for (int i = 0;
                        i < extractedData[index].options.length;
                        i++)
                      GestureDetector(
                        onTap: () => checkAnswerAndUpdate(
                            extractedData[index].options.values.toList()[i]),
                        child: OptionCard(
                          option: extractedData[index].options.keys.toList()[i],
                          color: isPressed
                              ? extractedData[index]
                                          .options
                                          .values
                                          .toList()[i] ==
                                      true
                                  ? correct
                                  : incorrect
                              : neutral,
                        ),
                      ),
                  ],
                ),
              ),

              // use the floating action button
              floatingActionButton: GestureDetector(
                onTap: () => nextQuestion(extractedData.length),
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  child: NextButton(), // the above function
                ),
              ),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerFloat,
            );
          }
        } else {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const CircularProgressIndicator(),
                const SizedBox(height: 20.0),
                Text(
                  'Please Wait while Questions are loading..',
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    decoration: TextDecoration.none,
                    fontSize: 14.0,
                  ),
                ),
              ],
            ),
          );
        }

        return const Center(
          child: Text('No Data'),
        );
      },
    );
  }
}
