import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../auth/model/user_model.dart';
import '../../utills/api_config.dart';

class ApiServices {
  // Future<http.Response> registerUserToApi(UserModel data) async {
  //   final response = await http.post(
  //     ApiConfig.register,
  //     body: json.encode(data.toRegister()),
  //     headers: {
  //       'Content-Type': 'application/json',
  //     },
  //   );
  //   return response;
  // }
}