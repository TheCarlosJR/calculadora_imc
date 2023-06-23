
import 'package:flutter/material.dart';
import 'package:calculo_imc/repositories/defines.dart';

class STxtFrmField extends StatelessWidget {

  STxtFrmField({
    Key? key,
    required this.sLabelTxt,
    required this.sController
  }): super(key: key);

  final String sLabelTxt;
  final TextEditingController? sController;


  //validate text
  String? _textValidator(String? value) {
    if (value == null) {
      return "ERRO: Valor nulo";
    }
    if (value.isEmpty) {
      return "Digite um valor válido";
    }
    if (double.tryParse(value) == null) {
      return "Digite um valor numérico";
    }
    return null;
  }


  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.number,
      textAlign: TextAlign.center,
      style: TextStyle(
        color: textFontColor,
        fontSize: 26,
      ),
      decoration: InputDecoration(
        labelText: sLabelTxt,
        labelStyle: TextStyle(
          color: editFontColor,
          fontSize: 32,
        ),
      ),
      controller: sController,
      validator: _textValidator,
    );
  }
}