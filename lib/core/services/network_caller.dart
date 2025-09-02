import 'dart:convert';
import 'dart:io';
import 'package:chat_app/core/services/shared_prefarence.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

class NetworkResponse {
  final int statusCode;
  final Map<String, dynamic>? responseData;
  final bool isSuccess;
  final String errorMessage;

  NetworkResponse({
    required this.statusCode,
    required this.isSuccess,
    this.responseData,
    this.errorMessage = 'Something went wrong',
  });
}

class NetworkCaller {
  final Logger _logger = Logger();

  // ===================== 🔹 GET REQUEST =====================
  Future<NetworkResponse> getRequest({required String url}) async {
    try {
      Uri uri = Uri.parse(url);
      final token = await SharedPreferencesHelper.getAccessToken();
      Map<String, String> headers = {
        'Authorization': token != null && token.isNotEmpty ? 'Bearer $token' : '',
        'Accept': 'application/json',
      };

      _logRequest(url, headers);
      final response = await http.get(uri, headers: headers);
      _logResponse(url, response);

      final decode = _tryDecode(response.body);
      if (response.statusCode == 200) {
        return NetworkResponse(
            statusCode: 200, isSuccess: true, responseData: decode);
      } else {
        return NetworkResponse(
          statusCode: response.statusCode,
          isSuccess: false,
          errorMessage: decode?['message'] ?? 'Request failed',
        );
      }
    } catch (e) {
      return NetworkResponse(
          statusCode: -1, isSuccess: false, errorMessage: e.toString());
    }
  }

  // ===================== 🔹 POST REQUEST =====================
  Future<NetworkResponse> postRequest({
    required String url,
    Map<String, dynamic>? body,
  }) async {
    try {
      Uri uri = Uri.parse(url);
      final token = await SharedPreferencesHelper.getAccessToken();
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Authorization': token != null && token.isNotEmpty ? 'Bearer $token' : '',
      };

      _logRequest(url, headers, requestBody: body);
      final response =
      await http.post(uri, headers: headers, body: jsonEncode(body));
      _logResponse(url, response);

      final decode = _tryDecode(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return NetworkResponse(
            statusCode: response.statusCode,
            isSuccess: true,
            responseData: decode);
      } else {
        return NetworkResponse(
          statusCode: response.statusCode,
          isSuccess: false,
          errorMessage: decode?['message'] ?? 'Request failed',
        );
      }
    } catch (e) {
      return NetworkResponse(
          statusCode: -1, isSuccess: false, errorMessage: e.toString());
    }
  }

  // ===================== 🔹 PUT REQUEST =====================
  Future<NetworkResponse> putRequest({
    required String url,
    required Map<String, dynamic> body,
    File? file,
    String fileFieldName = 'file',
  }) async {
    try {
      Uri uri = Uri.parse(url);
      final token = await SharedPreferencesHelper.getAccessToken() ?? '';

      final headers = {
        'Authorization': token.isNotEmpty ? 'Bearer $token' : '',
        'Accept': 'application/json',
      };

      _logRequest(url, headers, requestBody: body);

      http.Response response;

      if (file != null) {
        var request = http.MultipartRequest('PUT', uri);
        request.headers.addAll(headers);

        body.forEach((key, value) {
          request.fields[key] = value.toString();
        });

        request.files
            .add(await http.MultipartFile.fromPath(fileFieldName, file.path));

        final streamed = await request.send();
        response = await http.Response.fromStream(streamed);
      } else {
        headers['Content-Type'] = 'application/json';
        response =
        await http.put(uri, headers: headers, body: jsonEncode(body));
      }

      _logResponse(url, response);
      final decode = _tryDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return NetworkResponse(
            statusCode: response.statusCode,
            isSuccess: true,
            responseData: decode);
      } else {
        return NetworkResponse(
          statusCode: response.statusCode,
          isSuccess: false,
          errorMessage: decode?['message'] ?? 'PUT request failed',
        );
      }
    } catch (e) {
      return NetworkResponse(
          statusCode: -1, isSuccess: false, errorMessage: e.toString());
    }
  }

  // ===================== 🔹 PATCH REQUEST =====================
  Future<NetworkResponse> patchRequest({
    required String url,
    required Map<String, dynamic> body,
    File? file,
    String fileFieldName = 'file',
  }) async {
    try {
      Uri uri = Uri.parse(url);
      final token = await SharedPreferencesHelper.getAccessToken() ?? '';

      final headers = {
        'Authorization': token.isNotEmpty ? 'Bearer $token' : '',
        'Accept': 'application/json',
      };

      _logRequest(url, headers, requestBody: body);

      http.Response response;

      if (file != null) {
        var request = http.MultipartRequest('PATCH', uri);
        request.headers.addAll(headers);
        body.forEach((key, value) {
          request.fields[key] = value.toString();
        });
        request.files
            .add(await http.MultipartFile.fromPath(fileFieldName, file.path));
        final streamed = await request.send();
        response = await http.Response.fromStream(streamed);
      } else {
        headers['Content-Type'] = 'application/json';
        response =
        await http.patch(uri, headers: headers, body: jsonEncode(body));
      }

      _logResponse(url, response);
      final decode = _tryDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return NetworkResponse(
            statusCode: response.statusCode,
            isSuccess: true,
            responseData: decode);
      } else {
        return NetworkResponse(
          statusCode: response.statusCode,
          isSuccess: false,
          errorMessage: decode?['message'] ?? 'Patch request failed',
        );
      }
    } catch (e) {
      return NetworkResponse(
          statusCode: -1, isSuccess: false, errorMessage: e.toString());
    }
  }

  // ===================== 🔹 DELETE REQUEST =====================
  Future<NetworkResponse> deleteRequest({
    required String url,
    Map<String, dynamic>? body,
  }) async {
    try {
      Uri uri = Uri.parse(url);
      final token = await SharedPreferencesHelper.getAccessToken();
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Authorization': token != null && token.isNotEmpty ? 'Bearer $token' : '',
      };

      _logRequest(url, headers, requestBody: body);
      final response = await http.delete(
        uri,
        headers: headers,
        body: body != null ? jsonEncode(body) : null,
      );

      _logResponse(url, response);
      final decode = _tryDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 204) {
        return NetworkResponse(
            statusCode: response.statusCode,
            isSuccess: true,
            responseData: decode);
      } else {
        return NetworkResponse(
          statusCode: response.statusCode,
          isSuccess: false,
          errorMessage: decode?['message'] ?? 'Delete failed',
        );
      }
    } catch (e) {
      return NetworkResponse(
          statusCode: -1, isSuccess: false, errorMessage: e.toString());
    }
  }

  // ===================== 🔹 Helpers =====================
  Map<String, dynamic>? _tryDecode(String body) {
    try {
      return jsonDecode(body) as Map<String, dynamic>;
    } catch (_) {
      return null;
    }
  }

  void _logRequest(String url, Map<String, dynamic> headers,
      {Map<String, dynamic>? requestBody}) {
    _logger.i('🔹 REQUEST\nURL: $url\nHeaders: $headers\nBody: $requestBody');
  }

  void _logResponse(String url, http.Response response) {
    _logger.i(
        '🔸 RESPONSE\nURL: $url\nStatus: ${response.statusCode}\nBody: ${response.body}');
  }
}
