import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main(){
  runApp(Calculator());
}
class Calculator extends StatelessWidget {
  const Calculator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculator',
      theme:ThemeData(primarySwatch:Colors.blue ),
      home: SimpleCalculator(),
    );
  }
}

class SimpleCalculator extends StatefulWidget {
  const SimpleCalculator({Key? key}) : super(key: key);

  @override
  State<SimpleCalculator> createState() => _SimpleCalculatorState();
}

class _SimpleCalculatorState extends State<SimpleCalculator> {

  String equation="0";
  String result="0";
  String expression="";

  buttonPressed(String buttonText){
    setState(() {
      if(buttonText=="C"){
        equation="0";
        result="0";
      }

      else if(buttonText=="⌫"){
        equation=equation.substring(0,equation.length-1);
        if(equation==""){
          equation="0";
        }
      }

      else if(buttonText=="="){
        expression=equation;
        expression=expression.replaceAll('×', '*');
        expression=expression.replaceAll('÷', "/");

        try{
          Parser p = Parser();
          Expression exp = p.parse(expression);

          ContextModel cm=ContextModel();
          result='${exp.evaluate(EvaluationType.REAL,cm)}';
        }catch(e){
          result="Error";
        }
      }

      else{
        if(equation=="0"){
          equation=buttonText;
        }else{
        equation=equation+buttonText;
      }
    }});


  }

  Widget buildButton(String buttonText, double buttonHeight,Color buttonColor){

    return Container(
      height: MediaQuery.of(context).size.height*0.1*buttonHeight,
      color: buttonColor,
      child: FloatingActionButton(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0.0),
              side: const BorderSide(
                  color: Colors.white,
                  width: 1 ,
                  style: BorderStyle.solid
              )
          ),
          onPressed:()=> buttonPressed(buttonText),
          child:Text(
            buttonText,
            style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.normal,
                color: Colors.white
            ),
          )
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Simple Calculator')),
      body: Column(
        children:<Widget>[
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
            child: Text(equation,style: TextStyle(fontSize: 38.0),),
          ),
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 30, 10, 0),
            child: Text(result,style: TextStyle(fontSize: 48.0),),
          ),
          const Expanded(
              child: Divider(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width*.75,
                child:Table(
                  children: [
                    TableRow(
                      children:[
                        buildButton("C", 1, Colors.red),
                        buildButton("⌫", 1, Colors.cyanAccent),
                        buildButton("÷", 1, Colors.cyanAccent),
                      ]
                    ),
                    TableRow(
                        children:[
                          buildButton("7", 1, Colors.black54),
                          buildButton("8", 1, Colors.black54),
                          buildButton("9", 1, Colors.black54),
                        ]
                    ),
                    TableRow(
                        children:[
                          buildButton("4", 1, Colors.black54),
                          buildButton("5", 1, Colors.black54),
                          buildButton("6", 1, Colors.black54),
                        ]
                    ),
                    TableRow(
                        children:[
                          buildButton("1", 1, Colors.black54),
                          buildButton("2", 1, Colors.black54),
                          buildButton("3", 1, Colors.black54),
                        ]
                    ),
                    TableRow(
                        children:[
                          buildButton(".", 1, Colors.black54),
                          buildButton("0", 1, Colors.black54),
                          buildButton("00", 1, Colors.black54),
                        ]
                    ),

                  ],
                ),
              ),

              Container(
                width: MediaQuery.of(context).size.width*0.25,
                child: Table(
                  children: [
                    TableRow(
                      children: [
                        buildButton("×", 1, Colors.cyanAccent),
                      ]
                    ),
                    TableRow(
                        children: [
                          buildButton("-", 1, Colors.cyanAccent),
                        ]
                    ),
                    TableRow(
                        children: [
                          buildButton("+", 1, Colors.cyanAccent),
                        ]
                    ),

                    TableRow(
                        children: [
                          buildButton("=", 2, Colors.cyanAccent),
                        ]
                    ),

                  ],
                ),
              )

            ],
          ),
        ],
      ),
    );
  }
}
