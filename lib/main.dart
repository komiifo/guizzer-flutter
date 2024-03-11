import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Quizzer',
      home: QuizApp(),
    );
  }
}

final List<String> listeQuestions = [
  "1. Le piton des neiges est un volcan de la Réunion ?",
  "2. Flutter permet de faire des applications web également ?",
  "3. Php est le language utilisé par Flutter ?",
  "4. La lune a sa propre atmosphère?",
  "5. Un octet est composé de 10 bits.",
];
final List<bool> listeReponses = [true, false, true, true, false];

class QuizApp extends StatefulWidget {
  const QuizApp({Key? key}) : super(key: key);

  @override
  State<QuizApp> createState() => _QuizAppState();
}

class _QuizAppState extends State<QuizApp> {
  List<Icon> listeIcones = [];
  int indiceQuestionCourante = 0;

  void verifierReponse(bool reponseUtilisateur) {
    bool reponseCorrecte = listeReponses[indiceQuestionCourante];
    setState(() {
      if (reponseUtilisateur == reponseCorrecte) {
        listeIcones.add(const Icon(Icons.check, color: Colors.green));
      } else {
        listeIcones.add(const Icon(Icons.close, color: Colors.red));
      }

      if (indiceQuestionCourante < listeQuestions.length - 1) {
        indiceQuestionCourante++;
      } else {
        // réinitialiser le quiz ou afficher le score
        Alert(
          context: context,
          type: AlertType.success,
          title: "Vous avez terminé le quizz",
          desc: "Si vous souhaitez recommencer. Cliquez ci-dessous",
          buttons: [
            DialogButton(
              child: Text(
                "Recommencer",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              onPressed: () => {
                Navigator.pop(context),
                setState(() {
                  indiceQuestionCourante = 0;
                  listeIcones = [];
                }),
              },
              width: 150,
            )
          ],
        ).show();

        print("Terminer");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quizzer'),
        backgroundColor: Colors.grey[100],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (indiceQuestionCourante < listeQuestions.length)
            Expanded(
              flex: 5,
              child: Text(
                listeQuestions[indiceQuestionCourante],
                style: const TextStyle(fontSize: 25),
                textAlign: TextAlign.center,
              ),
            ),
          Expanded(
            child: Container(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => verifierReponse(true),
                child: Text('VRAI'),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.green,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => verifierReponse(false),
                child: Text('FAUX'),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.red,
                ),
              ),
            ),
          ),
          Expanded(
              child: Row(
            children: listeIcones,
          ))
        ],
      ),
    );
  }
}
