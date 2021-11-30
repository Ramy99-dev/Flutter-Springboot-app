import 'dart:convert';

import 'package:http/http.dart' as http ;
import 'package:http/http.dart';
import 'package:workshop7/entities/formation.dart';



Future getAllFormation() async{

  Response response =await  http.get(Uri.parse("http://10.0.2.2:8081/formation/all"));
  return jsonDecode(response.body);

}

Future addFormation(Formation formation)async
{
  Response response = await http.post(Uri.parse("http://10.0.2.2:8081/formation/add"),
      headers:{
        "Content-type":"Application/json"
      },body:jsonEncode(<String,dynamic>{
        "nom":formation.nom,
        "duree":formation.duree,
      }
      ));

  return response.body;
}
Future updateFormation(Formation formation)async
{
  Response response = await http.put(Uri.parse("http://10.0.2.2:8081/formation/update"),
      headers:{
        "Content-type":"Application/json"
      },body:jsonEncode(<String,dynamic>{
        "id":formation.id,
        "nom":formation.nom,
        "duree":formation.duree,
      }
      ));

  return response.body;
}


Future deleteFormation(int id){
  return http.delete(Uri.parse("http://10.0.2.2:8081/formation/delete?id=${id}"));
}


