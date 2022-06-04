import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: new Home(),
  ));
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  String _textoInformacao = "Informe seus dados!";

  TextEditingController pesoText = TextEditingController();
  TextEditingController alturaText = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _limparEntradas (){
    setState(() {
      pesoText.text = "";
      alturaText.text = "";
      _textoInformacao = "Informe seus dados!";
      _formKey = GlobalKey<FormState>();
    });
  }

  void calcIMC(){
    setState(() {
      double peso = double.parse(pesoText.text);
      double altura = double.parse(alturaText.text) / 100;

      double imc = peso /(altura * altura);

      if(imc < 18.6){
        _textoInformacao = "Abaixo do peso (${imc.toStringAsPrecision(3)})";
      } else if(imc >= 18.6 && imc < 24.9){
        _textoInformacao = "Peso ideal (${imc.toStringAsPrecision(3)})";
      }else if(imc >= 24.9 && imc < 29.9){
        _textoInformacao = "Levemente acima do peso (${imc.toStringAsPrecision(3)})";
      }else if(imc >= 29.9 && imc < 34.9){
        _textoInformacao = "Obesidade garu I (${imc.toStringAsPrecision(3)})";
      }else if(imc >= 34.9 && imc < 40){
        _textoInformacao = "Obesidade garu II (${imc.toStringAsPrecision(3)})";
      }else if(imc >= 40){
        _textoInformacao = "Obesidade garu III (${imc.toStringAsPrecision(3)})";
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calculadora IMC"),
        centerTitle: true,
        backgroundColor: Colors.orange,
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _limparEntradas,
          )
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Icon(
                Icons.person_outline,
                size: 140,
                color: Colors.orange,
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                controller: pesoText,
                validator: (value){
                  if(value!.isEmpty){
                    return "Insira seu peso!";
                  }
                },
                decoration: InputDecoration(
                    labelText: "Peso (Kg)",
                    labelStyle: TextStyle(
                      color: Colors.orange,
                    )),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.orange,
                  fontSize: 25,
                ),
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                controller: alturaText,
                validator: (value){
                  if(value!.isEmpty){
                    return "Insira sua altura";
                  }
                },
                decoration: InputDecoration(
                    labelText: "Altura (Cm)",
                    labelStyle: TextStyle(
                      color: Colors.orange,
                    )),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.orange,
                  fontSize: 25,
                ),
              ),
              Padding(
                  padding: EdgeInsets.only(bottom: 15, top: 15),
                child: Container(
                  height: 50,
                  child: ElevatedButton(
                    child: Text(
                      "Calcular",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 30
                      ),
                    ),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.orange),
                    ),
                    onPressed: () {
                      if(_formKey.currentState!.validate()){
                        calcIMC();
                      }
                    },
                  ),
                ),
              ),
              Text(
                _textoInformacao,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.orange,
                  fontSize: 25,
                ),
              ),
            ],
          ),
        ),
      )
    );
  }
}
