import 'dart:math' as math;
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget> [
              Transform.rotate(
                angle: 180 * math.pi / 180, // This flips the content vertically (upside down)
                  child: StatTracker()
                ),
              StatTracker(),
            ],
          ),
        )
      ),
    );
  }
}

//---------------------------Stat Interface---------------------
class StatTracker extends StatelessWidget {
  //final int stat;

  //const DEFStatTracker({super.key, required this.stat});
  const StatTracker({super.key});

  @override
  Widget build(BuildContext context) {
  return 
    Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children:<Widget> [
        PWRStatTracker(),
        DEFStatTracker(),    
      ],
    ); 
  }
}

//---------------------------PWR TRACKER---------------------
class PWRStatTracker extends StatefulWidget {

  const PWRStatTracker({super.key});

  @override
  State<PWRStatTracker> createState() => _PWRStatTrackerState();
}

class _PWRStatTrackerState extends State<PWRStatTracker> {
  int count=2;
  int sum=0;

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
      StatButtons(sum: 2, onButtonPressed: addToStat),
      StatButtons(sum: 1, onButtonPressed: addToStat),
      PWRorDEFStatNumber(text:"PWR", number: count),
      ]
    ); 
  }
}

//---------------------------PWR TRACKER---------------------
class DEFStatTracker extends StatefulWidget {

  const DEFStatTracker({super.key});

  @override
  State<DEFStatTracker> createState() => _DEFStatTrackerState();
}

class _DEFStatTrackerState extends State<DEFStatTracker> {
  int count=0;
  int sum=0;

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
      PWRorDEFStatNumber(text:"DEF", number: count),
      StatButtons(sum: 1, onButtonPressed: addToStat),
      StatButtons(sum: 2, onButtonPressed: addToStat)
      ]
    ); 
  }
}

//------------------------------------------------------------MEDIUM PARTS---------------------------------
//--------------------STAT BUTTONS (WITH AN *S*)--------------------------
class StatButtons extends StatefulWidget {
  final Function(int) onButtonPressed;
  final int sum;

  const StatButtons({super.key, required this.sum, required this.onButtonPressed});

  @override
  State<StatButtons> createState() => _StatButtonsState();
}

class _StatButtonsState extends State<StatButtons> {
  late int amount=widget.sum;
  late Function(int) doThis=widget.onButtonPressed;

  @override
  Widget build(BuildContext context) {
    return
    Column(
        children:<Widget> [
          StatButton(sum: amount, onButtonPressed: doThis),
          StatButton(sum: -amount, onButtonPressed: doThis)   
          ]
      ); 
  }
}

//--------------------------PWR OR DEF UI-----------------------------------------
class PWRorDEFStatNumber extends StatelessWidget {
  final int number;
  final String text;

  const PWRorDEFStatNumber({super.key, required this.text, required this.number});

  @override
  Widget build(BuildContext context) {
    return 
    Column(
      children: [
          Text(text),
          BigNumber(value:number),
      ],
    );
  }
}

//------------------------------------------------------------------------SMALL PARTS--------------------------------------
//--------------------STAT BUTTONS--------------------------
class StatButton extends StatefulWidget {
  final Function(int) onButtonPressed;
  final int sum;

  const StatButton({super.key, required this.sum, required this.onButtonPressed});

  @override
  State<StatButton> createState() => _StatButtonState();
}

class _StatButtonState extends State<StatButton> {
  late int amount=widget.sum;

  @override
  Widget build(BuildContext context) {
    String text='';

    if (amount>0){
        text='+$amount';
    }else{
        text='$amount';
    }
    return 
    ElevatedButton(
      onPressed: () {
          widget.onButtonPressed(amount);
      },
      style: ElevatedButton.styleFrom(
        shape: const CircleBorder(), // Makes the button circular
        padding: const EdgeInsets.all(15), // Adds padding inside the button
        //backgroundColor: Colors.blue, // Example background color
        //foregroundColor: Colors.white, // Example icon/text color
      ),
      child: Text(text, style: 
        TextStyle(
          fontSize: 20, 
          //fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

//------------------BIG NUMBER STYLE-----------------
class BigNumber extends StatelessWidget {
  final int value;

  const BigNumber({super.key, required this.value});

  @override
  Widget build(BuildContext context) {
    return Text(
      '$value',
      style: TextStyle(
        fontSize: 45, // Set the desired font size
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
