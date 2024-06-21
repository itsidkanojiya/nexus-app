// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:nexus_app/models/question_model.dart';
import 'package:nexus_app/services/auth_service.dart';
import 'package:nexus_app/theme/loaderScreen.dart';
import 'package:nexus_app/utils/Base.dart';

class PaperRepository {
  Future<List<QuestionModel>> getQuestions() async {
    try {
      final response = await http.get(
        Uri.parse('${Base.api}/get-questions'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          HttpHeaders.authorizationHeader: "Bearer ${AuthService.token}"
        },
      );

      final body = jsonDecode(response.body);
      debugPrint('getQuestions body: $body');
      if (response.statusCode == 200) {
        // Parse the list of questions
        List<QuestionModel> questions = (body as List)
            .map((questionJson) => QuestionModel.fromJson(questionJson))
            .toList();
        return questions;
      } else {
        return [];
      }
    } catch (e) {
      debugPrint('Error While getQuestions() ${e.toString()}');
      return [];
    }
  }

  Future<bool> addPaperDetails(
      Map<String, dynamic> map, String logoPath) async {
    try {
      var headers = {
        'Content-Type': 'application/json; charset=UTF-8',
        HttpHeaders.authorizationHeader: "Bearer ${AuthService.token}"
      };
      var request = http.MultipartRequest(
          'POST', Uri.parse('${Base.api}/add-paper-details'));

      request.files.add(await http.MultipartFile.fromPath(
        'logo',
        logoPath,
      ));

      request.headers.addAll(headers);

      var stringMap = map.map((key, value) => MapEntry(key, value.toString()));

      // Add other form data to fields
      stringMap.forEach((key, value) {
        request.fields[key] = value;
      });

      http.StreamedResponse response = await request.send();
      var res = await response.stream.bytesToString();
      final body = jsonDecode(res);
      debugPrint('addPaperDetails body: $body');
      if (response.statusCode == 201) {
        return true;
      }
    } catch (e) {
      Loader().onError(msg: 'Something went wrong');
      debugPrint('Error While addPaperDetails() ${e.toString()}');
      return false;
    }

    return false;
  }
}
