import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      home: Home(),
    ),
  );
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>(); // validação de forms

  String infoText = "Informe seus dados";

  void resetButton() {
    weightController.text = "";
    heightController.text = "";
    infoText = "Informe seus dados";
    formKey = GlobalKey<
        FormState>(); // Sem isso, se user resetar o campo continua como invalido
  }

  void calculate() {
    setState(() {
      double weight =
          double.parse(weightController.text); // converte string em double
      double height = double.parse(heightController.text) /
          100; // altura em cm, calculo em m
      double imc = weight / (height * height);
      if (imc < 18.6) {
        infoText =
            'Seu IMC (${imc.toStringAsPrecision(3)}) está abaixo do ideal';
        print(infoText);
      } else if (imc >= 18.6 && imc < 24.9) {
        infoText =
            'Seu IMC (${imc.toStringAsPrecision(3)}) está dentro do ideal';
      } else if (imc >= 24.9 && imc < 29.9) {
        infoText =
            'Seu IMC (${imc.toStringAsPrecision(3)}) está levemente acima do ideal';
      } else if (imc >= 20.9 && imc < 34.9) {
        infoText =
            'De acordo com seu IMC (${imc.toStringAsPrecision(3)}), você está com Obesidade de Grau 1';
      } else if (imc >= 34.9 && imc < 39.9) {
        infoText =
            'De acordo com seu IMC (${imc.toStringAsPrecision(3)}), você está com Obesidade de Grau 2';
      } else if (imc >= 39.9) {
        infoText =
            'De acordo com seu IMC (${imc.toStringAsPrecision(3)}), você está com Obesidade de Grau 3';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.green,
        title: Text(
          "Calculadora IMC",
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.refresh,
              size: 35,
            ),
            onPressed: () {
              setState(() {
                resetButton();
              });
            },
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Icon(
                Icons.person_outline,
                size: 120,
                color: Colors.green,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "Peso (kg):",
                    labelStyle: TextStyle(color: Colors.green),
                  ),
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20, color: Colors.green),
                  controller: weightController,
                  validator: (value) {
                    // validação de forms
                    if (value.isEmpty) {
                      return "Insira seu peso";
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "Altura (cm):",
                    labelStyle: TextStyle(color: Colors.green),
                  ),
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20, color: Colors.green),
                  controller: heightController,
                  validator: (value) {
                    // validação de forms
                    if (value.isEmpty) {
                      return "Insira sua altura";
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                child: Container(
                  // para definir um height pro botao
                  height: 50,
                  child: RaisedButton(
                    color: Colors.green,
                    onPressed: () {
                      if (formKey.currentState.validate()) {
                        // validação de forms
                        calculate();
                      }
                    },
                    child: Text(
                      "Calcular",
                      style: TextStyle(color: Colors.white, fontSize: 25),
                    ),
                  ),
                ),
              ),
              Text(
                infoText,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.green, fontSize: 20),
              )
            ],
          ),
        ),
      ),
    );
  }
}
