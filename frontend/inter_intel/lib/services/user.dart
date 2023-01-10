import 'dart:convert';
import 'dart:io';
import 'package:inter_intel/models/models.dart';
import 'package:http/http.dart' as http;
import 'package:inter_intel/urls/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';


//Sign Up
Future<ApiResponse> register (String name, String email, String phone) async{
  ApiResponse apiResponse = ApiResponse();
  try{
    final response = await http.post(
        Uri.parse(registerUrl),
        headers: {'Accept': 'application/json'},
        body: {
          'name': name,
          'email': email,
          'phone': phone,
        }
    );


    switch(response.statusCode){
      case 200:
        apiResponse.data = User.fromJson(jsonDecode(response.body));
        break;

      case 422:
        final errors = jsonDecode(response.body)['errors'];
        apiResponse.error = errors[errors.keys.elementAt(0)][0];
        break;

      case 403:
        apiResponse.error = jsonDecode(response.body)['message'];
        break;

      default:
        apiResponse.error = somethingWentWrong;
        break;
    }
  }
  catch(e){
    apiResponse.error = serverError;
  }
  return apiResponse;
}

//Get user token details
Future<String> getToken() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  return pref.getString('token') ?? '';
}


