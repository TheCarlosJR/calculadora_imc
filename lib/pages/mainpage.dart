
import 'package:flutter/material.dart';
import 'package:calculo_imc/repositories/defines.dart';
import 'package:calculo_imc/widgets/stxtfrmfield.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {


  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  IconData _themeIcon = themeIconLight;
  String _textResult = textResultReset;


  //change to light/dark mode
  void _changeColorMode() {
    setState(() {
      //change to Light mode
      if (_themeIcon == themeIconLight) {
        appBarColor   = appBarColorLight;
        bgColor       = bgColorLight;
        iconColor     = iconColorLight;
        textFontColor = textFontColorLight;
        editFontColor = editFontColorLight;

        _themeIcon = themeIconDark;
      }
      //change to Dark mode
      else {
        appBarColor   = appBarColorDark;
        bgColor       = bgColorDark;
        iconColor     = iconColorDark;
        textFontColor = textFontColorDark;
        editFontColor = editFontColorDark;

        _themeIcon = themeIconLight;
      }

      //textfield lost focus
      FocusManager.instance.primaryFocus?.unfocus();
    });
  }


  //clear text fields
  void _resetFields() {
    weightController.text = ""; //doesn't need to be inside setstate
    heightController.text = "";

    setState(() {
      //recovery default value text result
      _textResult = textResultReset;

      //recreate the form state
      _formKey = GlobalKey<FormState>();

      //textfield lost his focus
      FocusManager.instance.primaryFocus?.unfocus();
    });
  }

  //calculate IMC
  void _calculateIMC() {

    //check form validation
    if (_formKey.currentState?.validate() == false) {
      return;
    }

    double weightC = double.parse(weightController.text);
    double heightC = double.parse(heightController.text); //cm
    heightC = heightC / 100; //converts to m
    double imcC = weightC / (heightC * heightC);

    setState(() {
      if (imcC < 18.6) {
        _textResult = "${imcC.toStringAsPrecision(3)} - Abaixo do peso";
      }
      else if (imcC >- 18.6 && imcC < 24.9) {
        _textResult = "${imcC.toStringAsPrecision(3)} - Peso ideal";
      }
      else if (imcC >- 24.9 && imcC < 29.9) {
        _textResult = "${imcC.toStringAsPrecision(3)} - Levemente acima do peso";
      }
      else if (imcC >- 29.9 && imcC < 34.9) {
        _textResult = "${imcC.toStringAsPrecision(3)} - Obesidade Grau I";
      }
      else if (imcC >- 34.9 && imcC < 39.9) {
        _textResult = "${imcC.toStringAsPrecision(3)} - Obesidade Grau II";
      }
      else if (imcC >= 40) {
        _textResult = "${imcC.toStringAsPrecision(3)} - Obesidade Grau III";
      }

      //textfield lost focus
      FocusManager.instance.primaryFocus?.unfocus();
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Calculadora de IMC"),
          centerTitle: true,
          backgroundColor: appBarColor,
          actions: [
            IconButton(
              onPressed: _changeColorMode,
              icon: Icon(_themeIcon),
            ),
            IconButton(
              onPressed: _resetFields,
              icon: const Icon(Icons.refresh),
            ),
          ],
        ),
        backgroundColor: bgColor,
        body: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.calculate_outlined,
                        size: 56,
                        color: iconColor,
                      ),
                      Icon(
                        Icons.person,
                        size: 96,
                        color: iconColor,
                      ),
                    ],
                  ),
                  STxtFrmField(
                    sLabelTxt: "Peso (Kg)",
                    sController: weightController,
                  ),
                  const SizedBox(
                    height: paddingHeight,
                  ),
                  STxtFrmField(
                    sLabelTxt: "Altura (cm)",
                    sController: heightController,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: paddingHeight,
                        bottom: paddingHeight
                    ),
                    child: Container(
                      height: 62,
                      child: ElevatedButton(
                        onPressed: _calculateIMC,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: appBarColor,
                        ),
                        child: const Text(
                          "Calcular!",
                          style: TextStyle(
                            fontSize: 32,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        _textResult,
                        style: TextStyle(
                          color: textFontColor,
                          fontSize: 28,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        )
    );
  }
}
