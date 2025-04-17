// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:nexus_app/models/paper_history.dart';
import 'package:nexus_app/models/question_model.dart';
import 'package:nexus_app/services/app_service.dart';
import 'package:nexus_app/theme/loaderScreen.dart';
import 'package:nexus_app/utils/Base.dart';

class AssignmentRepository {
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

  Future<HistoryModel?> getAssignment(int id) async {
    try {
      final response = await http.get(
          Uri.parse('${Base.api}/get-assignment-history?assignment_id=$id'),
          headers: <String, String>{
            HttpHeaders.authorizationHeader: "Bearer ${AppService.token}",
            'Content-Type': 'application/json; charset=UFT-8',
          });

      final body = jsonDecode(response.body);
      debugPrint('getAssignment body: $body');
      if (response.statusCode == 200) {
        return HistoryModel.fromJson(body);
      }
    } catch (e) {
      debugPrint('Error While getAssignment() ${e.toString()}');
      return Future.error(e);
    }
    return null;
  }

  Future<Uint8List> getAssignmentPdf(Map<String, dynamic> requestData) async {
    try {
      final uri = Uri.parse('${Base.PDFapi}/generate-assignment');

      final headers = <String, String>{
        HttpHeaders.authorizationHeader: "Bearer ${AppService.token}",
        'Content-Type': 'application/json; charset=UTF-8',
      };

      final response = await http.post(
        uri,
        headers: headers,
        body: jsonEncode(requestData), // Passing request data
      );

      if (response.statusCode == 200) {
        var pdfBytes = response.bodyBytes;

        // Open or display the PDF (you can use any PDF viewer library)
        print("PDF received with byte size: ${pdfBytes.length}");
        return pdfBytes;
      } else {
        debugPrint('Failed to get PDF, status code: ${response.statusCode}');
        return Future.error('Failed to generate PDF');
      }
    } catch (e) {
      debugPrint('Error while getPaperPdf(): ${e.toString()}');
      return Future.error(e);
    }
  }

  Future<HistoryModel?> getAssignmentHistory() async {
    try {
      final response = await http.get(
          Uri.parse('${Base.api}/get-assignment-history'),
          headers: <String, String>{
            HttpHeaders.authorizationHeader: "Bearer ${AppService.token}",
            'Content-Type': 'application/json; charset=UFT-8',
          });

      final body = jsonDecode(response.body);
      //   debugPrint('getAssignmentHistory body: $body');
      if (response.statusCode == 200) {
        return HistoryModel.fromJson(body);
      }
    } catch (e) {
      debugPrint('Error While getAssignmentHistory() ${e.toString()}');
      return Future.error(e);
    }
    return null;
  }

  Future<bool> addAssignmentDetails(
      Map<String, dynamic> map, String logoPath) async {
    try {
      var headers = {
        'Content-Type': 'application/json; charset=UTF-8',
        HttpHeaders.authorizationHeader: "Bearer ${AppService.token}"
      };
      var request = http.MultipartRequest(
          'POST', Uri.parse('${Base.api}/add-assignment-details'));

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
      debugPrint('addAssignmentDetails body: $body');
      if (response.statusCode == 201) {
        await AppService.storage
            .write('assignment_id', body['assignment_details']['id']);
        return true;
      }
    } catch (e) {
      Loader().onError(msg: 'Something went wrong');
      debugPrint('Error While addAssignmentDetails() ${e.toString()}');
      return false;
    }

    return false;
  }

  Future<bool> editAssignmentDetails(
      Map<String, dynamic> map, String? logoPath) async {
    try {
      var headers = {
        'Content-Type': 'application/json; charset=UTF-8',
        HttpHeaders.authorizationHeader: "Bearer ${AppService.token}"
      };

      var request = http.MultipartRequest(
          'POST', Uri.parse('${Base.api}/edit-assignment-details'));

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
      debugPrint('editAssignmentDetails body: $body');

      if (response.statusCode == 200) {
        return true;
      }
    } catch (e) {
      Loader().onError(msg: 'Something went wrong');
      debugPrint('Error While editAssignmentDetails() ${e.toString()}');
      return false;
    }

    return false;
  }

  Future<bool> addQuestion(Map<String, dynamic> map) async {
    try {
      final response = await http.post(
        Uri.parse('${Base.api}/add-assignment-questions'),
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
