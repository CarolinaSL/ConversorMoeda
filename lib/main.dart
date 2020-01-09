import 'package:flutter/material.dart';
import 'package:http/http.dart' as http; // nos permite fazer requisiçoes
import 'dart:async'; // requisicoes assíncronas
import 'dart:convert';


const request = "https://api.hgbrasil.com/finance?format=json&key=be27f6ff";

void main() async {

  
 
  


  runApp(MaterialApp(
  home: Home(),
));
}

Future<Map> getData() async {

  http.Response response = await http.get(request);
  return  json.decode(response.body);// retorna objeto json
}