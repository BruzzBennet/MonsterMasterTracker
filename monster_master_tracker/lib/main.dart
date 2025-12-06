import 'dart:math' as math;
import 'package:flutter/material.dart';

// ALL isBlack bools in the functions are to change the coloring of the letters and buttons according to background color 

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(
            children: <Widget> [
              // OTHER PLAYER'S STAT'S TRACKER
              // MAKE THE PLAYERS PART FIT THE WHOLE MIDDLE PART
               Expanded(
                child: Container(
                  color: Colors.black,
                  //FILL OUT THE WHOLE WIDTH
                  width: double.infinity,
                  child: Column(
                    //ALIGN IT IN THE CENTER OF ITS CHUNK
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children:<Widget>[
                        //ROTATE IT 180 DEGREES FOR THE OTHER PLAYER
                        Transform.rotate(
                          angle: 180 * math.pi / 180, // This flips the content vertically (upside down)
                            child: StatTracker(isBlack: true,)
                        ),
                    ]
                  )
                ),
              ),

              //ONE PLAYER'S STATS TRACKER
              //MAKE THE PLAYERS PART FIT THE WHOLE MIDDLE PART
              Expanded(
                //DO THIS TO FORMAT IT
                child: Container(
                  color: Colors.white, // First "column" (child)
                  width: double.infinity,
                  //IN A COLUMN TO BE SPACED RIGHT IN ITS MIDDLE
                  child: Column(
                    //ALIGN IT IN THE MIDDLE
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children:<Widget>[
                      StatTracker(),
                    ],
                  ),
                ),
              ),  
            ],
          ),
        )
    );
  }
}

//---------------------------Stat Interface---------------------
class StatTracker extends StatelessWidget {
  final bool? isBlack;

  const StatTracker({super.key, this.isBlack});

  @override
  Widget build(BuildContext context) {
  return
    Column(
      children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children:<Widget> [
          PWRStatTracker(isBlack:isBlack),
          DEFStatTracker(isBlack:isBlack),   
        ],
      ), 
      MoveStatTracker(isBlack:isBlack)
      ],
    ); 
  }
}

//---------------------------PWR TRACKER---------------------
class PWRStatTracker extends StatefulWidget {
  final bool? isBlack;

  const PWRStatTracker({super.key, this.isBlack});

  @override
  State<PWRStatTracker> createState() => _PWRStatTrackerState();
}

class _PWRStatTrackerState extends State<PWRStatTracker> {
  int count=2;
  int sum=0;
  late bool? isBlack=widget.isBlack;

  void addToStat(int sum) {
        setState(() {
          if(count<=1 && sum<0){
            count=0;
          }
          else{
            count=count+sum;
          }         
        });
  }

  @override
  Widget build(BuildContext context) {
  return 
    Row(
      children:<Widget> [
      StatButtons(isBlack:isBlack, sum: 2, onButtonPressed: addToStat),
      StatButtons(isBlack:isBlack, sum: 1, onButtonPressed: addToStat),
      PWRorDEFStatNumber(isBlack:isBlack, text:"PWR", number: count),
      ]
    ); 
  }
}

//---------------------------DEF TRACKER---------------------
class DEFStatTracker extends StatefulWidget {
  final bool? isBlack;

  const DEFStatTracker({super.key, this.isBlack});

  @override
  State<DEFStatTracker> createState() => _DEFStatTrackerState();
}

class _DEFStatTrackerState extends State<DEFStatTracker> {
  int count=0;
  int sum=0;
  late bool? isBlack=widget.isBlack;

  void addToStat(int sum) {
        setState(() {
          //The stat can't be less than 0
          if(count<=1 && sum<0){
            count=0;
          }
          else{
            count=count+sum;
          }         
        });
  }

  @override
  Widget build(BuildContext context) {
  return 
    Row(
      children:<Widget> [
      PWRorDEFStatNumber(isBlack:isBlack, text:"DEF", number: count),
      StatButtons(isBlack:isBlack, sum: 1, onButtonPressed: addToStat),
      StatButtons(isBlack:isBlack,sum: 2, onButtonPressed: addToStat),
      ]
    ); 
  }
}

//---------------------------Moves TRACKER---------------------
class MoveStatTracker extends StatefulWidget {
  final bool? isBlack;

  const MoveStatTracker({super.key, this.isBlack});

  @override
  State<MoveStatTracker> createState() => _MoveStatTracker();
}

class _MoveStatTracker extends State<MoveStatTracker> {
  int count=0;
  int sum=0;
  late bool? isBlack=widget.isBlack;

  void addToStat(int sum) {
        setState(() {
          //The stat can't be less than 0
          if(count<=0 && sum<0){
            count=4;
          }
          else if(count>=4 && sum>0){
            count=0;
          }else{
            count=count+sum;
          }      
        });
  }

  @override
  Widget build(BuildContext context) {
  return 
    Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children:<Widget> [
      StatButton(isBlack: isBlack, sum: -1, onButtonPressed: addToStat),
      MovesUI(isBlack:isBlack, number: count),
      StatButton(isBlack: isBlack, sum: 1, onButtonPressed: addToStat),
      ]
    ); 
  }
}


//------------------------------------------------------------MEDIUM PARTS---------------------------------
//--------------------STAT BUTTONS (WITH AN *S*)--------------------------
class StatButtons extends StatefulWidget {
  final Function(int) onButtonPressed;
  final int sum;
  final bool? isBlack;

  const StatButtons({super.key, this.isBlack, required this.sum, required this.onButtonPressed});

  @override
  State<StatButtons> createState() => _StatButtonsState();
}

class _StatButtonsState extends State<StatButtons> {
  late int amount=widget.sum;
  late Function(int) doThis=widget.onButtonPressed;
  late bool? isBlack=widget.isBlack;

  @override
  Widget build(BuildContext context) {
    return
    Column(
        children:<Widget> [
          StatButton(isBlack:isBlack, sum: amount, onButtonPressed: doThis),
          StatButton(isBlack:isBlack, sum: -amount, onButtonPressed: doThis), 
          ]
      ); 
  }
}

//--------------------------PWR OR DEF UI-----------------------------------------
class PWRorDEFStatNumber extends StatelessWidget {
  final int number;
  final String text;
  final bool? isBlack;

  const PWRorDEFStatNumber({super.key, this.isBlack, required this.text, required this.number});

  @override
  Widget build(BuildContext context) {
    Color txtColor=Colors.black;
    if (isBlack!=null){
      txtColor=Colors.white;
    }
    return 
    Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
        child:Column(
        children: [
            //"PWR" or "DEF" text
            Text(text,
            style: TextStyle(
                fontSize: 15, 
                fontWeight: FontWeight.bold,
                color: txtColor
              ),
            ),  
            BigNumber(isBlack: isBlack,value:number),
        ],
      ),
    );
  }
}

//--------------------------Move Counter-----------------------------------------
class MovesUI extends StatelessWidget {
  final int number;
  final bool? isBlack;

  const MovesUI({super.key, this.isBlack, required this.number});

  @override
  Widget build(BuildContext context) {
    Color txtColor=Colors.black;

    if(isBlack!=null){
      txtColor=Colors.white;
    }

    return 
    Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
        child:Row(
        children: [
            BigNumber(isBlack: isBlack, value:number),
            Text(" Moves",
            style: TextStyle(
                color: txtColor,
                fontSize: 30, 
                fontWeight: FontWeight.bold,
              ),
            ),  
        ],
      ),
    );
  }
}

//------------------------------------------------------------------------SMALL PARTS--------------------------------------
//--------------------BUTTONS--------------------------
class StatButton extends StatefulWidget {
  final Function(int) onButtonPressed;
  final int sum;
  final bool? isBlack;

  const StatButton({super.key, this.isBlack, required this.sum, required this.onButtonPressed});

  @override
  State<StatButton> createState() => _StatButtonState();
}

class _StatButtonState extends State<StatButton> {
  late int amount=widget.sum;
  Color _bgColor=Colors.black;
  Color _txtColor=Colors.white;
  late bool? isBlack=widget.isBlack;

  @override
  Widget build(BuildContext context) {
    String text='';
    if (isBlack!=null){
        _bgColor=Colors.white;
        _txtColor=Colors.black;
    }


    if (amount>0){
        text='+$amount';
    }else{
        text='$amount';
    }
    return 
    Container(
      margin: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 10.0), 
      child:
      ElevatedButton(
        onPressed: () {
            widget.onButtonPressed(amount);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: _bgColor,
          shape: const CircleBorder(), // Makes the button circular
          padding: const EdgeInsets.all(15), // Adds padding inside the button
        ),
        child: Text(text, style: 
          TextStyle(
            fontSize: 18,
            color: _txtColor, 
            //fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

//------------------BIG NUMBER STYLE-----------------
class BigNumber extends StatelessWidget {
  final int value;
  final bool? isBlack;

  const BigNumber({super.key, this.isBlack, required this.value});

  @override
  Widget build(BuildContext context) {
    Color bgColor=Colors.black;
    if (isBlack!=null){
      bgColor=Colors.white;
    }
    return 
    Text(
      '$value',
      style: TextStyle(
        fontSize: 45, // Set the desired font size
        fontWeight: FontWeight.bold,
        color: bgColor,
      ),
    );
  }
}
