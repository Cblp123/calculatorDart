import 'package:flutter/material.dart';
import 'package:function_tree/function_tree.dart';

void main() => runApp(MyApp());

String funct(final str){
  final t = '${str}';
  final y = "${t.interpret()}";
  return y;
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Calculator(),
    );
  }
}
class Calculator extends StatefulWidget {
  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  dynamic displaytxt = 20;
  //Button Widget
  Widget calcbutton(String btntxt, Color btncolor, Color txtcolor, double FontSize) {
    return Container(

      child: ElevatedButton(
        onPressed: () {
          calculation(btntxt);
        },

        style: ElevatedButton.styleFrom(

          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15), // Set the border radius to 0 for square shape
          ),
            fixedSize: const Size(75, 75),
            backgroundColor: Colors.black,
        ),

        child: Text(
          '$btntxt',
          style: TextStyle(
            fontSize: FontSize,
            color: txtcolor,

          ),

        ),


      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    //Calculator
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Calculator'),
        backgroundColor: Colors.lightGreen,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 1),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            // Calculator display
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Flexible(

                      child: Text(
                        '$text',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: Colors.green,
                          fontSize: 40,
                        ),
                          softWrap: true,
                          maxLines: 2,
                      ),
                    ),
                  )
                ],

              ),
            )
            ,

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                calcbutton('C',Colors.grey,Colors.blueAccent, 25),
                calcbutton('⌫',Colors.grey,Colors.blueAccent, 25),
                calcbutton('^',Colors.grey,Colors.blueAccent, 35),
                calcbutton('/',Colors.grey,Colors.blueAccent, 35),
                calcbutton('x²',Colors.grey,Colors.blueAccent, 20),

              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                calcbutton('7',Colors.grey,Colors.lightGreen, 45),
                calcbutton('8',Colors.grey,Colors.lightGreen, 45),
                calcbutton('9',Colors.grey,Colors.lightGreen, 45),
                calcbutton('*',Colors.amber,Colors.blueAccent, 35),
                calcbutton('√x',Colors.grey,Colors.blueAccent, 20),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                calcbutton('4',Colors.grey,Colors.lightGreen, 45),
                calcbutton('5',Colors.grey,Colors.lightGreen, 45),
                calcbutton('6',Colors.grey,Colors.lightGreen, 45),
                calcbutton('-',Colors.amber,Colors.blueAccent, 35),
                calcbutton('%',Colors.grey,Colors.blueAccent, 25),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                calcbutton('1',Colors.grey,Colors.lightGreen, 45),
                calcbutton('2',Colors.grey,Colors.lightGreen, 45),
                calcbutton('3',Colors.grey,Colors.lightGreen, 45),
                calcbutton('+',Colors.amber,Colors.blueAccent, 35),
                calcbutton('ln',Colors.grey,Colors.blueAccent, 25),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                //this is button Zero


                calcbutton('e',Colors.amber,Colors.blueAccent, 35),
                calcbutton('0',Colors.amber,Colors.lightGreen, 45),

                calcbutton('.',Colors.grey,Colors.blueAccent, 45),
                calcbutton('=',Colors.amber,Colors.blueAccent, 45),
                calcbutton('π',Colors.grey,Colors.blueAccent, 25),
              ],
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }


  //Calculator logic
  dynamic text = '0';


  dynamic result = '';
  dynamic finalResult = '0';

  dynamic preOpr = '';
  dynamic point = '';
  void calculation(btnText) {
    if ((finalResult == '∞' || finalResult == 'Ошибка') && btnText != 'C' && btnText != '⌫'){
      return;
    }
    if (finalResult.length > 0)  preOpr = finalResult[finalResult.length - 1];
    switch(btnText){
      case 'C':
        text ='0';

        result = '';
        finalResult = '0';
        point = '';

        preOpr = '';
        break;
      case '=':
        if (preOpr == '-' || preOpr == '+' || preOpr == '*' ||preOpr == '/' ||preOpr == '%' ||preOpr == '^' || finalResult[finalResult.length - 1] == '.'){
          finalResult = finalResult.substring(0, finalResult.length - 1);
        }
        final FinalR = funct(finalResult.replaceAll('π', 'pi'));
        finalResult = "${FinalR}";
        if (finalResult.contains('e')) {
          finalResult = finalResult.replaceAll('e', '*10^(') + ')';
        }
        if (finalResult == 'Infinity' || finalResult == 'NaN'){
          finalResult = '∞';
        }

        break;
      case '⌫':
        if (finalResult[finalResult.length - 1] == '.'){
          point = '';
        }
        else{
          point = '.';
        }
        finalResult = finalResult.substring(0, finalResult.length - 1);
        if (finalResult == '' || finalResult == 'Ошибк') {
          finalResult = '0';
        }

        break;
      case 'x²':
        if (preOpr == '-' || preOpr == '+' || preOpr == '*' ||preOpr == '/' ||preOpr == '%' ||preOpr == '^' || finalResult[finalResult.length - 1] == '.'){
          finalResult = finalResult.substring(0, finalResult.length - 1);
        }
        finalResult = '(' + finalResult + ')^2';
        final FinalR = funct(finalResult.replaceAll('π', 'pi'));
        finalResult = "${FinalR}";
        if (finalResult.contains('e')) {
          finalResult = finalResult.replaceAll('e', '*10^(') + ')';
        }
        if (finalResult == 'Infinity' || finalResult == 'NaN'){
          finalResult = '∞';
        }
        point = '.';
        break;
      case '√x':
        if (preOpr == '-' || preOpr == '+' || preOpr == '*' ||preOpr == '/' ||preOpr == '%' ||preOpr == '^'|| finalResult[finalResult.length - 1] == '.'){
          finalResult = finalResult.substring(0, finalResult.length - 1);
        }
        finalResult = '(' + finalResult + ')^(1/2)';
        final FinalR = funct(finalResult.replaceAll('π', 'pi'));
        finalResult = "${FinalR}";
        if (finalResult.contains('e')) {
          finalResult = finalResult.replaceAll('e', '*10^(') + ')';
        }
        if (finalResult == 'NaN'){
          finalResult = 'Ошибка';
        }

        break;
      case 'ln':
        if (preOpr == '-' || preOpr == '+' || preOpr == '*' ||preOpr == '/' ||preOpr == '%' ||preOpr == '^' || finalResult[finalResult.length - 1] == '.'){
          finalResult = finalResult.substring(0, finalResult.length - 1);
        }
        finalResult = 'ln(' + finalResult + ')';
        final FinalR = funct(finalResult.replaceAll('π', 'pi'));
        finalResult = "${FinalR}";
        if (finalResult.contains('e')) {
          finalResult = finalResult.replaceAll('e', '*10^(') + ')';
        }
        if (finalResult == 'NaN'){
          finalResult = 'Ошибка';
        }
        if (finalResult == 'Infinity' || finalResult == '-Infinity'){
          finalResult = '∞';
        }
        break;
      case '.':
        List<String> operators = ['+', '-', '*', '/', '%', '^'];
        int countOp = 0;

        bool hasDot = false;

        for (String operator in operators) {
          int index = finalResult.indexOf(operator);
          while (index < finalResult.length) {
              if (index == -1) {
                countOp += 1;
                break;
              }
              if (finalResult[index] == '.') {
                hasDot = true;
                break;
              }
              index += 1;
            }
        }
        if (!(hasDot) && !('πe+-*/^%'.contains(finalResult[finalResult.length - 1]))){
          if (!((countOp == 6) && (finalResult.contains('.')))) {
            finalResult += btnText;
          }
        }
        break;
      default:
        if  (preOpr == '-' || preOpr == '+' || preOpr == '*' || preOpr == '/' || preOpr == '%' || preOpr == '^'|| finalResult[finalResult.length - 1] == '.'){
          if (btnText == '-' || btnText == '+' || btnText == '*' || btnText == '/' || btnText == '%' || btnText == '^'){
            finalResult = finalResult.substring(0, finalResult.length - 1) + btnText;
          } else if ((btnText == 'e' || btnText == 'π')){
            if (preOpr != '.') finalResult += btnText;
          } else {
            finalResult += btnText;
          }
        } else if (preOpr == 'e' || preOpr == 'π') {
          if (btnText == '-' || btnText == '+' || btnText == '*' || btnText == '/' || btnText == '%' || btnText == '^'){
            finalResult += btnText;
          }
        } else {
            if (btnText == 'e' || btnText == 'π') {
              if (finalResult == '0') {
                finalResult = finalResult.substring(0, finalResult.length - 1) + btnText;
              }

            }
            else{
              if (finalResult == '0' && (btnText != '.' && btnText != '+' && btnText != '-' && btnText != '=' && btnText != '/' && btnText != '*' && btnText != '^' && btnText != '%' ) ) {
                finalResult = btnText;
              }
              else finalResult += btnText;


            }
        }

        break;
    }
    setState(() {
      text = finalResult;
    });
    return finalResult;
  }
  String doesContainDecimal(dynamic result) {

    if(result.toString().contains('.')) {
      List<String> splitDecimal = result.toString().split('.');
      if(!(int.parse(splitDecimal[1]) > 0))
        return result = splitDecimal[0].toString();
    }
    return result;
  }

}


