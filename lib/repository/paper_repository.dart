// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:nexus_app/models/paper_history.dart';
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
          HttpHeaders.authorizationHeader: "Bearer ${AppService.token}"
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

  Future<PaperHistoryModel?> getPaper(int id) async {
    try {
      final response = await http.get(
          Uri.parse('${Base.api}/get-paper-history?paper_id=$id'),
          headers: <String, String>{
            HttpHeaders.authorizationHeader: "Bearer ${AppService.token}",
            'Content-Type': 'application/json; charset=UFT-8',
          });

      final body = jsonDecode(response.body);
      debugPrint('getPaper body: $body');
      if (response.statusCode == 200) {
        return PaperHistoryModel.fromJson(body);
      }
    } catch (e) {
      debugPrint('Error While getPaper() ${e.toString()}');
      return Future.error(e);
    }
    return null;
  }

  Future<PaperHistoryModel?> getPaperHistory() async {
    try {
      final response = await http.get(
          Uri.parse('${Base.api}/get-paper-history'),
          headers: <String, String>{
            HttpHeaders.authorizationHeader: "Bearer ${AppService.token}",
            'Content-Type': 'application/json; charset=UFT-8',
          });

      final body = jsonDecode(response.body);
      //   debugPrint('getPaperHistory body: $body');
      if (response.statusCode == 200) {
        return PaperHistoryModel.fromJson(body);
      }
    } catch (e) {
      debugPrint('Error While getPaperHistory() ${e.toString()}');
      return Future.error(e);
    }
    return null;
  }

  Future<bool> addPaperDetails(
      Map<String, dynamic> map, String logoPath) async {
    try {
      var headers = {
        'Content-Type': 'application/json; charset=UTF-8',
        HttpHeaders.authorizationHeader: "Bearer ${AppService.token}"
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
        await AppService.storage.write('paper_id', body['paper_details']['id']);
        return true;
      }
    } catch (e) {
      Loader().onError(msg: 'Something went wrong');
      debugPrint('Error While addPaperDetails() ${e.toString()}');
      return false;
    }

    return false;
  }

  Future<bool> editPaperDetails(
      Map<String, dynamic> map, String? logoPath) async {
    try {
      var headers = {
        'Content-Type': 'application/json; charset=UTF-8',
        HttpHeaders.authorizationHeader: "Bearer ${AppService.token}"
      };

      var request = http.MultipartRequest(
          'POST', Uri.parse('${Base.api}/edit-paper-details'));

      // Add the logo file if a path is provided
      if (logoPath != null) {
        request.files.add(await http.MultipartFile.fromPath('logo', logoPath));
      }

      request.headers.addAll(headers);

      // Convert map values to strings and add them to the request fields
      var stringMap = map.map((key, value) => MapEntry(key, value.toString()));
      stringMap.forEach((key, value) {
        request.fields[key] = value;
      });

      // Send the request and handle the response
      http.StreamedResponse response = await request.send();
      var res = await response.stream.bytesToString();
      final body = jsonDecode(res);
      debugPrint('editPaperDetails body: $body');

      if (response.statusCode == 200) {
        return true;
      }
    } catch (e) {
      Loader().onError(msg: 'Something went wrong');
      debugPrint('Error While editPaperDetails() ${e.toString()}');
      return false;
    }

    return false;
  }

  Future<bool> addQuestion(Map<String, dynamic> map) async {
    try {
      final response = await http.post(
        Uri.parse('${Base.api}/add-paper-questions'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          HttpHeaders.authorizationHeader: "Bearer ${AppService.token}"
        },
        body: jsonEncode(map),
      );

      final body = jsonDecode(response.body);
      debugPrint('addQuestion body: $body');
      if (response.statusCode == 201) {
        return true;
      }
    } catch (e) {
      debugPrint('Error While addQuestion() ${e.toString()}');
      return false;
    }
    return false;
  }
}
