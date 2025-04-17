import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:nexus_app/theme/loaderScreen.dart';

class ApiHelper {
  /// Generic API call helper method to handle GET, POST, and Multipart requests.
  static Future<Map<String, dynamic>> apiCall({
    required String url,
    required String method,
    Map<String, String>? headers,
    Map<String, dynamic>? body,
    bool isMultipart = false,
    String? filePath,
  }) async {
    try {
      final uri = Uri.parse(url);
      http.Response response;

      // Multipart handling (for file uploads)
      if (isMultipart) {
        var request = http.MultipartRequest(method, uri);
        request.headers.addAll(headers ?? {});

        if (filePath != null) {
          request.files
              .add(await http.MultipartFile.fromPath('file', filePath));
        }

        body?.forEach((key, value) {
          request.fields[key] = value.toString();
        });

        response = await http.Response.fromStream(await request.send());
      } else {
        // Regular GET or POST request handling
        if (method == 'POST') {
          response = await http.post(uri,
              headers: headers, body: body != null ? jsonEncode(body) : null);
        } else if (method == 'GET') {
          response = await http.get(uri, headers: headers);
        } else {
          throw Exception('Unsupported method: $method');
        }
      }

      final Map<String, dynamic> bodyData = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return bodyData;
      } else {
        Loader().onError(msg: bodyData['message'] ?? 'Unknown Error');
        return {};
      }
    } catch (e) {
      debugPrint('API error: ${e.toString()}');
      Loader().onError(msg: 'Something went wrong');
      return {};
    }
  }
}
