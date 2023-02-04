import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:todo/auth/secrets.dart';

class TODOService 
{

    static Future<bool> deleteById(String id) async{

    final url= api+id;

    final uri=Uri.parse(url);

    final response = await http.delete(uri);

    return response.statusCode == 200;

    }

    static Future<List?> fetchTodo() async{

    final url = api;

    final uri=Uri.parse(url);

    final response = await http.get(uri);

    if(response.statusCode == 200)
    {

      final result = jsonDecode(response.body) as List;

      return result;

    }else
    {

      return null;

    }

    }

    static Future<bool> updateData(String id,Map body) async
    {

    final url= api+id;

    final uri=Uri.parse(url);

    final response = await http.put(
      
      uri,
      
      body :jsonEncode(body),
      
      headers: {'Content-Type':'application/json'},
      
      );

    return response.statusCode == 200;

    }

    static Future<bool> submitData(Map body) async
    {

    final url= api;

    final uri=Uri.parse(url);

    final response = await http.post(
      
      uri,
      
      body :jsonEncode(body),
      
      headers: {'Content-Type':'application/json'},
      
      );

    return response.statusCode == 200;

    }

}