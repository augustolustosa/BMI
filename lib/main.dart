


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void main()=>runApp(Home());

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "App IMC",
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController pesoController = new TextEditingController();
  TextEditingController alturaController = new TextEditingController();
  String info="Preencha os campos";

  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("App IMC"),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        actions: <Widget>[
          IconButton(icon: Icon(Icons.refresh), onPressed: _limpar),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Icon(Icons.person, size: 190, color: Colors.deepPurple,),
              label_reutilizado("Peso (KG)", pesoController),
              label_reutilizado("Altura (CM)", alturaController),
              Padding(
                padding: EdgeInsets.only(top: 10.0, bottom: 20.0),
                child: Container(
                  height: 50.0,
                  child: RaisedButton(onPressed: (){
                    if(_formKey.currentState.validate()){
                      _calcular();
                    }
                  },
                    color: Colors.white12,
                    padding: EdgeInsets.all(10),
                    child: Text("Enviar", style: TextStyle(color: Colors.deepPurple, fontSize: 23), ),
                  ),
                ),
              ),

              Text(info,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black, fontSize: 16, fontStyle: FontStyle.italic),
              ),
            ],
          ),
        ),

      ),
    );
  }

  void _calcular(){
    setState(() {
      String imc;
      double peso = double.parse(pesoController.text)*0.01;
      double altura = double.parse(alturaController.text)*0.01;
      imc=(peso/(altura*altura)).toStringAsPrecision(2);
      info="IMC: $imc";
    });

  }

  void _limpar(){
    setState(() {
      pesoController.text="";
      alturaController.text="";
      info="Preencha os campos";
    });
  }
}

Widget label_reutilizado(String descricao, TextEditingController ctr){
  return TextFormField(
    keyboardType: TextInputType.number,
    decoration: InputDecoration(
        labelText: descricao,
        labelStyle: TextStyle(color: Colors.blueAccent),
    ),
    textAlign: TextAlign.left,
    style: TextStyle(color: Colors.deepPurple, fontSize: 23),
    controller: ctr,
    validator: (value){
      if(value.isEmpty)
        return "Digite seu $descricao";
    },
  );
}

