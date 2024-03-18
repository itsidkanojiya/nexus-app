import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:nexus_app/models/question_model.dart';
import 'package:nexus_app/services/auth_service.dart';
import 'package:nexus_app/utils/Base.dart';

class PaperRepository {
  Future<QuestionModel?> getMcq() async {
    try {
      final response = await http.get(Uri.parse('${Base.api}/get-questions'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UFT-8',
          });

      final body = jsonDecode(response.body);
      debugPrint('getMcq body: $body');
      if (response.statusCode == 200) {
        return QuestionModel.fromJson(body);
      }
    } catch (e) {
      debugPrint('Error While getMcq() ${e.toString()}');
      return Future.error(e);
    }
    return null;
  }

  Future<bool> addPaperDetails(Map<String, dynamic> map) async {
    try {
      final response = await http.post(
        Uri.parse('${Base.api}/add-paper-details'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          HttpHeaders.authorizationHeader: "Bearer ${AuthService.token}"
        },
        body: jsonEncode(map),
      );

      final body = jsonDecode(response.body);
      debugPrint('addPaperDetails body: $body');
      if (response.statusCode == 201) {
        return true;
      }
    } catch (e) {
      debugPrint('Error While editQuestion() ${e.toString()}');
      return false;
    }
    Get.rawSnackbar(
        message: 'Question edited failed!', backgroundColor: Colors.redAccent);
    return false;
  }
}
