
import 'dart:async';

import 'package:confetti/confetti.dart';
import 'package:crossword_puzzle/widgets/CustomRichText.dart';
import 'package:flutter/material.dart';
import 'dart:math';

import 'package:crossword/components/line_decoration.dart';


import 'package:crossword/crossword.dart';

                                     

class CrossWordWidget extends StatefulWidget {
  const CrossWordWidget({super.key});

  @override
  State<CrossWordWidget> createState() => _CrossWordWidgetState();
}

class _CrossWordWidgetState extends State<CrossWordWidget> {
  bool _isPlaying  = false;
  final controller = ConfettiController();
  bool win = false;
  // GlobalKey<CrosswordState> _crosswordKey = GlobalKey();
  // GlobalKey<_CrossWordWidgetState> _wordSearchKey = GlobalKey<_CrossWordWidgetState>();
  List<List<String>> letters = [];
  List<Color> lineColors = [];

  late List<String> displayedWords;

  // ...

  void shuffleDisplayedWords() {
    displayedWords = List.from(targetWord);
    displayedWords.shuffle();
  }



  List<int> letterGrid = [11, 14];
  int remainingTime = 60; // Initial time in seconds
  late Timer _timer;
  
  List<List<String>> generateRandomLetters() {
    final random = Random();
    const letters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    List<List<String>> array = List.generate(
        letterGrid.first,
        (_) => List.generate(
            letterGrid.last, (_) => letters[random.nextInt(letters.length)]));

    return array;
  }

  Color generateRandomColor() {
    Random random = Random();

    int r = random.nextInt(200) - 128; // Red component between 128 and 255
    int g = random.nextInt(200) - 128; // Green component between 128 and 255
    int b = random.nextInt(200) - 128; // Blue component between 128 and 255

    return Color.fromARGB(255, r, g, b);
  }
  List<String> guessWords =[];
  int score = 0;
  List<String> targetWord = ["FLUTTER","SALE", "GAMES","GEM", "UI", "COLORS","WET","DART","PAT","EAT","SIM","SUN","SOAP","SELL","TOY","LEG","SET","NOTE","NOT"];
  void showLoseWinDialog(win) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {

        return AlertDialog(
          title: win?Text("CONGRATULATIONS!!!!"): Text("YOU LOSE!!!"),
          content:win? Text("You Won!! 🤩🤩🤩 \nSCORE: ${score} "): Text("SCORE: ${score}\nBetter luck next time.\n😞😞😞"),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                restart(); // Restart the game
              },
              child: Text("Restart"),
            ),
          ],
        );
      },
    );
  }



   
   void restart() {
     Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => CrossWordWidget()),
              );
 
}
 void startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (Timer timer) {
      setState(() {
        if (remainingTime > 0 ) {
          // bool areEqual = displayedWords.every((element) => guessWords.contains(element));
          if ( score == 100){
            timer.cancel();
            controller.play();
            showLoseWinDialog(true);
            // restart();

          }
          remainingTime--;
        } else {
          timer.cancel(); // Stop the timer when time reaches 0
          showLoseWinDialog(false);
          // restart();
          // Add animation or other actions for failure
          // controller.stop();
        }
      });
    });
  }
 
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // controller.play();
    controller.addListener(() {
      setState(() {
        _isPlaying = controller.state == ConfettiControllerState.playing;
      });
     });
    lineColors = List.generate(100, (index) => generateRandomColor()).toList();
    startTimer();
    shuffleDisplayedWords(); // Shuffle the displayed words at the beginning
  }

  @override
  void dispose() {
    _timer.cancel(); // Cancel the timer to avoid memory leaks
    controller.dispose();
    super.dispose();
  }

  
  
  @override
  Widget build(BuildContext context) {

    // get the size of the screen
    Size size = MediaQuery.of(context).size;
    
    

    return Stack(
      alignment: Alignment.topCenter,
      children:[
         Scaffold(
      
          backgroundColor: const Color.fromARGB(255, 240, 242, 243),
          body: Column(
    
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 70,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Word Search", style: TextStyle(
                  fontFamily: "italic",
                  fontWeight: FontWeight.w400,
                  color: Colors.blue[400],
                  fontSize: 30
                ),),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  // width: 380,
                  // height: 400,
                  width: size.width * 0.98,
                  height: size.height * 0.5,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: Colors.blue.shade300,
                      width: 4.0,
                    ),
                    borderRadius: BorderRadius.circular(12.0)
                  ),
                  child: Crossword(
                  
                    letters: const [
                      ["F", "L", "U", "T", "T", "E", "R", "W", "U", "D", "B", "C"],
                      ["R", "M", "I", "O", "P", "U", "I", "Q", "R", "L", "E", "G"],
                      ["T", "V", "D", "I", "R", "I", "M", "U", "A", "H", "E", "A"],
                      ["D", "A", "R", "T", "N", "S", "T", "O", "Y", "J", "R", "M"],
                      ["O", "G", "E", "M", "E", "S", "C", "O", "L", "O", "R", "S"],
                      ["S", "R", "T", "I", "I", "I", "F", "X", "S", "P", "E", "D"],
                      ["Y", "S", "N", "E", "T", "M", "M", "C", "E", "A", "T", "S"],
                      ["W", "E", "T", "P", "A", "T", "D", "Y", "L", "M", "N", "E"],
                      ["O", "T", "E", "H", "R", "O", "G", "P", "L", "U", "O", "T"],
                      ["K", "R", "R", "C", "G", "A", "M", "E", "S", "S", "T", "S"],
                      ["S", "A", "L", "E", "S", "O", "A", "P", "U", "P", "E", "S"]
                    ],
                    spacing: const Offset(27, 27),
                    
                    // key: _crosswordKey,
                    
                    onLineDrawn: (words) {
                  
                      
                      print(words);
                      
                      // words.clear();
                    
                      // words = words;
                      setState(() {
                        guessWords = words;
                       // if (guessWords.isNotEmpty){
                          print("hello guess ${guessWords}");
                          String currentWord = guessWords.isNotEmpty ? guessWords[guessWords.length - 1] : '';
                           
                            if (targetWord.contains(currentWord)){
                              score += 25;
                            }
                            // words=[];
                       // }
                        // print("gg ${guessWords.isNotEmpty?guessWords[-1]: ''}");
                        // if(guessWords.isNotEmpty && guessWords.contains(guessWords[-1])){
                        //      print(guessWords[-1]);
                        //      score += 20;
    
                        // }
                           
                      });
                      // print("hello ${words}");
                      
                    },
                    // textStyle: const TextStyle(color: Colors.white, fontSize: 20),
                    textStyle: const TextStyle(color: Colors.black, fontSize: 20),
    
                    lineDecoration:
                        // LineDecoration(lineColors: lineColors, strokeWidth: 20),
                        LineDecoration(lineColors: lineColors, strokeWidth: 20, correctColor: Colors.teal, incorrectColor: Colors.redAccent),
                    hints: targetWord,
                    // hints: const ["FLUTTER", "GAMES", "UI", "COLORS"],
                  
                  ),
                ),
              ),
              SizedBox(
                height: 30.0,
              ),
              Padding(
                padding: const EdgeInsets.only(left:20.0, right: 10.0),
    
                // TIME AND WORDS
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // TIME
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
          
                          CustomRichText(title: "Time", subtitle: "${(remainingTime ~/ 60).toString().padLeft(2, '0')}:${(remainingTime % 60).toString().padLeft(2, '0')}"),
                          //  CustomRichText(title: "Time", subtitle: "0:25",),
                           SizedBox(
                            height: 10.0,
    
                           ),
                            CustomRichText(title: "Score", subtitle: "${score}",),
    
                          SizedBox(height: 20,),
    
    
                             Container(
                              width: size.width * 0.5,
                              height: size.height * 0.06,
              // width: 230.0,
              // height: 50.0,
              decoration: BoxDecoration(
                // color: Colors.redAccent,
                borderRadius: BorderRadius.circular(60.0), // Optional: Add rounded corners
              ),
              child: ElevatedButton(
                onPressed: () {
                  // Your button onPressed logic here
                  //  LineDecoration(correctColor: Colors.transparent, incorrectColor: Colors.transparent, strokeWidth: 0,);
                  /// In Web Platform, Fill webOrigin only when your new origin is different than the app's origin
                  
                  
                  setState(() {
                    
                    restart();
                    
                  });
                },
                // style: ButtonStyle(
                //   backgroundColor: MaterialStateProperty.all<Color>(Colors.transparent), // Make button background transparent
                // ),
                child: Text(
                  'Restart',
                  style: TextStyle(color: Colors.white,
                  fontSize: 24), // Optional: Customize text color
                ),
              ),
            ),
          
      
    
                      ],
                    ),
                   SizedBox(width: 12,),
    
                    Expanded(
                      child: Container(
                        // width: 120,
                        // height:200,
                    
                        decoration: BoxDecoration(
                          color: Colors.white,
                          
                          border: Border.all(
                          color: Colors.cyan.shade300,
                          width: 2.0,
                      ),
                      borderRadius: BorderRadius.circular(5.0)
                          
                        ),
                        child: ListView.builder(
                          padding: const EdgeInsets.all(3.0),
                          shrinkWrap: true,
                          itemCount: 4,
                          itemBuilder: ((context, index) {
    
                            // final currentWord = targetWord[index];
                            // final isWordFound = guessWords.contains(currentWord);
                            final currentWord = displayedWords[index];
                            final isWordFound = guessWords.contains(currentWord);
                            print('heelo ${isWordFound}');
                            print(currentWord);
                            print(guessWords);
    
                          return Text(
                            currentWord,
                            style: TextStyle(
                              decoration: isWordFound
                                  ? TextDecoration.lineThrough
                                  : TextDecoration.none,
                              decorationThickness: 3.0,
                              fontSize: 20,
                              color: Colors.black54,
                            ),
                          );
                                        // SizedBox(height: 8),
                            
                          })
                          ),
                      ),
                    ),
                    // SizedBox(height: 75,)
    
                    
                  ],
                  
                ),
              )
            ],
          )),
       ConfettiWidget(
        confettiController: controller,
        shouldLoop: true,

        //set direction
        // blastDirection: -pi / 2,//up
        blastDirectionality: BlastDirectionality.explosive,
        
        // set emission count
        emissionFrequency: 0.2,
        numberOfParticles: 20,

        // set intensity
        minBlastForce: 10,
        maxBlastForce: 100,

        // set speed
        gravity: 1.0,
        // child: ,
        ),


      ]
    );
  }
}