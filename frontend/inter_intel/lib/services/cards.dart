import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:inter_intel/urls/constants.dart';
import 'package:inter_intel/models/models.dart';
import 'package:inter_intel/services/services.dart';
import 'package:http/http.dart' as http;

Future<ApiResponse> getCards() async{
  ApiResponse apiResponse = ApiResponse();
  try{
    String token = await getToken();
    final response = await http.get(
        Uri.parse(cardUrl),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        });

    switch(response.statusCode){
      case 200:
        apiResponse.data = jsonDecode(response.body)['cards'].map((k) => User.fromJson(k)).toList();
        apiResponse.data as List<dynamic>;
        break;

      case 401:
        apiResponse.error = unauthorized;
        break;

      default:
        apiResponse.error = somethingWentWrong;
        break;
    }
  }
  catch(e){
    apiResponse.error = serverError;
    //print('shit show');
  }
  return apiResponse;
}

Future<ApiResponse> getTodo() async{
  ApiResponse apiResponse = ApiResponse();
  try{
    String token = await getToken();
    final response = await http.get(
        Uri.parse(todoUrl),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        });

    switch(response.statusCode){
      case 200:
        apiResponse.data = jsonDecode(response.body).map((k) => ToDo.fromJson(k)).toList();
        apiResponse.data as List<dynamic>;
        //print(response.body);
        break;

      case 401:
        apiResponse.error = unauthorized;
        break;

      default:
        apiResponse.error = somethingWentWrong;
        break;
    }
  }
  catch(e){
    apiResponse.error = serverError;
    //print('shit show');
  }
  return apiResponse;
}