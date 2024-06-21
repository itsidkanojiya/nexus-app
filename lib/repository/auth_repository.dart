import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:nexus_app/module/auth/login/login_view.dart';
import 'package:nexus_app/module/auth/login/otp_screen.dart';
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
        if (body['is_number_verified'] == 1) {
          Loader().onSuccess(msg: 'Login successfully');

          await AuthService.storage
              .write('token', body['token']); // Correctly store the token

          Get.offAll(() => const HomeView());
        } else {
          await AuthService.storage
              .write('id', body['id']); // Correctly store the id
          print("add${AuthService.id}");
          Loader().onSuccess(msg: 'OTP Sent');
          Get.offAll(() => OtpScreen());
        }

        return 'success';
      } else {
        Loader().onError(msg: body['message'].toString());
        return body['message'].toString();
      }
    } catch (e) {
      Loader().onError(msg: 'Something went wrong');
      debugPrint('Error While signIn() ${e.toString()}');
      return Future.error(e);
    }
  }

  Future<bool> signup(Map<String, dynamic> map) async {
    try {
      final response = await http.post(
        Uri.parse('${Base.api}/register'),
        body: map,
      );
      final body = jsonDecode(response.body);
      debugPrint('signIn body: $body');
      if (response.statusCode == 200 || response.statusCode == 201) {
        Loader().onSuccess(msg: 'OTP send successfully');
        await AuthService.storage
            .write('id', body['id']); // Correctly store the id

        return true;
      } else {
        Loader().onError(msg: body['message'].toString());

        return false;
      }
    } catch (e) {
      Loader().onError(msg: 'something went wrong');
      debugPrint('Error While sigIn() ${e.toString()}');
      return false;
    }
  }

  Future<bool> checkUser(Map<String, dynamic> map) async {
    try {
      final response = await http.post(
        Uri.parse('${Base.api}/check-user'),
        body: map,
      );

      final body = jsonDecode(response.body);
      debugPrint('checkUser body: $body');
      if (response.statusCode == 200) {
        if (body['exists'] == false) {
          return true;
        }
        if (body['exists'] == true) {
          Loader().onError(msg: body['message'].toString());
          return true;
        }

        return false;
      } else {
        Loader().onError(msg: 'Internal server error');
        return false;
      }
    } catch (e) {
      Loader().onError(msg: 'Internal server error');
      return false;
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

      final body = jsonDecode(response.body);
      debugPrint('verifyToken body: $body');
      if (response.statusCode == 200 || response.statusCode == 201) {
        Get.to(() => const HomeView());
      } else {
        Get.to(() => LoginView());
      }
    } catch (e) {
      Get.to(() => LoginView());
      debugPrint('Error While verifyToken() ${e.toString()}');
      return Future.error(e);
    }
  }

  Future<void> resendOtp() async {
    // print("add${AuthService.token}");
    try {
      final response =
          await http.post(Uri.parse('${Base.api}/resend-otp'), body: {
        "id": AuthService.id.toString()
      }, headers: <String, String>{
        'Content-Type': 'application/json; charset=UFT-8',
        HttpHeaders.authorizationHeader: "Bearer ${AuthService.token}"
      });

      final body = jsonDecode(response.body);
      debugPrint('resendOtp body: $body');
      if (response.statusCode == 200 || response.statusCode == 201) {
        Loader().onSuccess(msg: 'OTP Sent');
      } else {
        Loader().onError(msg: 'Something went wrong');
      }
    } catch (e) {
      Loader().onError(msg: 'Something went wrong');
      debugPrint('Error While resendOtp() ${e.toString()}');
      return Future.error(e);
    }
  }

  Future<bool> verifyOtp(Map<String, dynamic> map) async {
    // print("add${AuthService.id}");
    try {
      final response = await http.post(Uri.parse('${Base.api}/verify-otp'),
          body: map,
          headers: <String, String>{
            HttpHeaders.authorizationHeader: "Bearer ${AuthService.token}"
          });

      final body = jsonDecode(response.body);
      debugPrint('verifyOtp body: $body');
      if (response.statusCode == 200) {
        Loader().onSuccess(msg: body['message']);
        await AuthService.storage
            .write('token', body['token']); // Correctly store the token

        Get.offAll(() => const HomeView());
        return true;
      } else {
        Loader().onError(msg: body['message']);
        return false;
      }
    } catch (e) {
      Loader().onError(msg: 'Something went wrong');

      debugPrint('Error While verifyOtp() ${e.toString()}');
      return false;
    }
  }
}
