import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:nexus_app/models/user_model.dart';
import 'package:nexus_app/services/app_service.dart';
import 'package:nexus_app/theme/loaderScreen.dart';
import 'package:nexus_app/utils/Base.dart';

class ProfileRepository {
  Future<User?> getUser() async {
    try {
      final response = await http.get(
        Uri.parse('${Base.api}/get-user'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          HttpHeaders.authorizationHeader: "Bearer ${AppService.token}",
        },
      );

      // Decode the response body
      final body = jsonDecode(response.body);
      debugPrint('getUser body: $body');

      if (response.statusCode == 200) {
        // Pass the entire body to the User.fromJson(), which will handle the 'user' key
        return User.fromJson(body);
      } else {
        debugPrint('Failed to get user: ${response.statusCode}');
        return Future.error(
            'Error: ${response.statusCode}, ${response.reasonPhrase}');
      }
    } catch (e) {
      debugPrint('Error while getUser(): ${e.toString()}');
      return Future.error(e);
    }
  }

  Future<bool> editProfile(Map<String, dynamic> map) async {
    try {
      var headers = {
        'Content-Type': 'application/json; charset=UTF-8',
        HttpHeaders.authorizationHeader: "Bearer ${AppService.token}"
      };
      var request =
          http.MultipartRequest('POST', Uri.parse('${Base.api}/edit-profile'));

      request.headers.addAll(headers);

      var stringMap = map.map((key, value) => MapEntry(key, value.toString()));

      // Add other form data to fields
      stringMap.forEach((key, value) {
        request.fields[key] = value;
      });

      http.StreamedResponse response = await request.send();
      var res = await response.stream.bytesToString();
      final body = jsonDecode(res);
      debugPrint('editProfile body: $body');
      if (response.statusCode == 201) {
        return true;
      }
    } catch (e) {
      Loader().onError(msg: 'Something went wrong');
      debugPrint('Error While editProfile() ${e.toString()}');
      return false;
    }

    return false;
  }
}
