import 'package:flutter/material.dart';
import 'package:http/http.dart' as http; // nos permite fazer requisiçoes
import 'dart:async'; // requisicoes assíncronas
import 'dart:convert';


const request = "https://api.hgbrasil.com/finance?format=json&key=be27f6ff";

void main() async {

  runApp(MaterialApp(
  home: Home(),
  theme: ThemeData(
    hintColor: Colors.amber,
    primaryColor: Colors.white
  )
));
}

//retorna um mapa no futuro
Future<Map> getData() async {

  http.Response response = await http.get(request);
  return  json.decode(response.body);// retorna objeto json da resposta
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  double dolar;
  double euro;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("\$ Conversor \$"),
        backgroundColor: Colors.amber,
        centerTitle: true,
      ),
      body: FutureBuilder<Map>(
        future: getData(),
        builder: (context, snapshot){
          switch(snapshot.connectionState){
           
            case ConnectionState.none:
              
            case ConnectionState.waiting:
              return Center(
                child: Text(
                  "Carregando Dados...",
                  style: TextStyle(
                    color: Colors.amber,
                    fontSize: 25.0
                    ),
                  textAlign: TextAlign.center,
                  ),
                );
              
            default:
              if(snapshot.hasError){
                return Center(
                  child: Text(
                    "Erro ao carregar Dados! :(",
                    style: TextStyle(
                      color: Colors.amber,
                      fontSize: 25.0
                      ),
                    textAlign: TextAlign.center,
                  ),
                );
              }else{
                dolar = snapshot.data["results"]["currencies"]["USD"]["buy"];
                euro = snapshot.data["results"]["currencies"]["EUR"]["buy"];
                return SingleChildScrollView(
                  padding: EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Icon(Icons.monetization_on, size: 150.0, color: Colors.amber),
                      TextField(
                        decoration: InputDecoration(
                          labelText: "Reais",
                          labelStyle: TextStyle(color: Colors.amber),
                          border:OutlineInputBorder(),
                          prefixText: "R\$"
                        ),
                        style: TextStyle(
                          color: Colors.amber,
                          fontSize: 25.0
                        ),
                      ),
                      Divider(),
                      TextField(
                        decoration: InputDecoration(
                          labelText: "Dolarea",
                          labelStyle: TextStyle(color: Colors.amber),
                          border:OutlineInputBorder(),
                          prefixText: "US\$"
                        ),
                        style: TextStyle(
                          color: Colors.amber,
                          fontSize: 25.0
                        ),
                      ),
                      Divider(),
                      TextField(
                        decoration: InputDecoration(
                          labelText: "Euros",
                          labelStyle: TextStyle(color: Colors.amber),
                          border:OutlineInputBorder(),
                          prefixText: "E"
                        ),
                        style: TextStyle(
                          color: Colors.amber,
                          fontSize: 25.0
                        ),
                      )
                    ]
                  ) ,
                );
              }
          }
        },
      ),
    );
  }
}