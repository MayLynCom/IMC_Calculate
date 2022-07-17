import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: HomePage(),
  ));
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();//chave global

  String _infoText = "Informe seus dados!";

  void _resetFields(){
    weightController.text = "";
    heightController.text = "";
    setState(() {
      _infoText = "Informe seus dados!";
      _formKey = GlobalKey<FormState>();
    });
  }

  void calculate(){
    setState(() {
      double weight = double.parse(weightController.text);//.parse = transforma texto em double
      double height = double.parse(heightController.text) / 100;

      double imc = weight / (height * height);
      print(imc);

      if(imc < 18.6){
        _infoText = "Abaixo do Peso (${imc.toStringAsPrecision(4)})";
      } else if(imc >= 18.6 && imc < 24.9){
        _infoText = "Peso Ideal (${imc.toStringAsPrecision(4)})";
      } else if(imc >= 24.9 && imc < 29.9){
        _infoText = "Levemente Acima do Peso (${imc.toStringAsPrecision(4)})";
      } else if(imc >= 29.9 && imc < 34.9){
        _infoText = "Obesidade Grau I (${imc.toStringAsPrecision(4)})";
      } else if(imc >= 34.9 && imc < 39.9){
        _infoText = "Obesidade Grau II (${imc.toStringAsPrecision(4)})";
      } else if(imc >= 40){
        _infoText = "Obesidade Grau III (${imc.toStringAsPrecision(4)})";
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  const Text("Calculadora IMC"),
        centerTitle: true,
        backgroundColor: Colors.green,
        actions: <Widget>[
          IconButton(onPressed:_resetFields,
              icon: const Icon(Icons.refresh))
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        //funciona para quando ultrapassar o limite adicionar um scroll
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
               const Icon(
                Icons.person_outline,
                size: 120.0,
                color: Colors.green,
              ),
              TextFormField(
                validator:(value){//valida o campo de texto, verifica se ele esta vazio
                  if(value!.isEmpty){
                    return "Insira seu Peso!";
                  }
                },
                controller: weightController,
                keyboardType: TextInputType.number, //para o teclado ser numérico
                decoration: const InputDecoration(
                    labelText: "Peso (kg)",
                    labelStyle: TextStyle(
                      color: Colors.green,
                    )),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.green,
                  fontSize: 25,
                ),
              ),
              TextFormField(
                validator:(value){//valida o campo de texto, verifica se ele esta vazio
              if(value!.isEmpty){
              return "Insira sua Altura!";
              }
              },
                controller: heightController,
                keyboardType: TextInputType.number, //para o teclado ser numérico
                decoration: const InputDecoration(
                    labelText: "Altura (cm)",
                    labelStyle: TextStyle(
                      color: Colors.green,
                    )),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.green,
                  fontSize: 25,
                ),
              ),
              Padding(
                padding:  const EdgeInsets.symmetric(vertical: 20.0),
                child: Container(
                  height: 50.0,
                  child: ElevatedButton(
                    onPressed:(){
                      if(_formKey.currentState!.validate()){
                        calculate();
                      }

                    },
                    child: const Text("Calcular", style: TextStyle(fontSize: 25.0)),
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.green),
                    ),
                  ),
                ),
              ),
               Text(
                _infoText,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.green, fontSize: 25.0),
              )
            ],
          ),
        ),
      ),
    );
  }
}
