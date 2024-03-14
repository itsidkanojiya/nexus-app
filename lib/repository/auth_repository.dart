import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:nexus_app/module/auth/login/login_view.dart';
import 'package:nexus_app/module/home/home_page.dart';
import 'package:nexus_app/services/auth_service.dart';
import 'package:nexus_app/theme/loaderScreen.dart';
import 'package:nexus_app/utils/Base.dart';

class AuthRepository {
  Future<String> signIn(Map<String, dynamic> map) async {
    Loader().onLoading();
    try {
      final response = await http.post(
        Uri.parse('${Base.api}/login'),
        body: map,
      );
      final body = jsonDecode(response.body);
      debugPrint('signIn body: $body');
      if (response.statusCode == 200 || response.statusCode == 201) {
        var map = {'jwt': body['token']};
        Loader().onSuccess(msg: 'Login successfully');
        await AuthService.storage.write('token', map);
        print(AuthService.token);
        Get.offAll(const HomeView());
        return 'sucsess';
      } else {
        Loader().onError(msg: body['message'].toString());

        return body['message'].toString();
      }
    } catch (e) {
      Loader().onError(msg: 'something went wrong');
      debugPrint('Error While sigIn() ${e.toString()}');
      return Future.error(e);
    }
  }

  Future<String> signup(Map<String, dynamic> map) async {
    Loader().onLoading();
    try {
      final response = await http.post(
        Uri.parse('${Base.api}/register'),
        body: map,
      );
      final body = jsonDecode(response.body);
      debugPrint('signIn body: $body');
      if (response.statusCode == 200 || response.statusCode == 201) {
        var map = {'jwt': body['token']};
        Loader().onSuccess(msg: 'Registered successfully');
        await AuthService.storage.write('token', map);
        print(AuthService.token);
        Get.offAll(const HomeView());
        return 'sucsess';
      } else {
        Loader().onError(msg: body['message'].toString());

        return body['message'].toString();
      }
    } catch (e) {
      Loader().onError(msg: 'something went wrong');
      debugPrint('Error While sigIn() ${e.toString()}');
      return Future.error(e);
    }
  }

  Future<void> verifyToken() async {
    // print("add${AuthService.token}");
    try {
      final response = await http.post(Uri.parse('${Base.api}/verify-token'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UFT-8',
            HttpHeaders.authorizationHeader: "Bearer ${AuthService.token}"
          });

      print(AuthService.token);
      final body = jsonDecode(response.body);
      debugPrint('verifyToken body: $body');
      if (response.statusCode == 200 || response.statusCode == 201) {
        Get.to(()=>const HomeView());
      } else {
        Get.to(()=>LoginView());
      }
    } catch (e) {
      Get.to(()=>LoginView());
      debugPrint('Error While verifyToken() ${e.toString()}');
      return Future.error(e);
    }
  }
}
