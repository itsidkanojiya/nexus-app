import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:nexus_app/models/boards_model.dart';
import 'package:nexus_app/models/books_model.dart';
import 'package:nexus_app/models/subject_model.dart';
import 'package:nexus_app/utils/Base.dart';

class BookRepository extends GetConnect {
  Future<SubjectModel?> getSubject() async {
    try {
      final response = await http
          .get(Uri.parse('${Base.api}/subject'), headers: <String, String>{
        'Content-Type': 'application/json; charset=UFT-8',
      });

      final body = jsonDecode(response.body);
      debugPrint('getSubject body: $body');
      if (response.statusCode == 200) {
        return SubjectModel.fromJson(body);
      }
    } catch (e) {
      debugPrint('Error While getSubject() ${e.toString()}');
      return Future.error(e);
    }
    return null;
  }

  Future<BookModel?> getBooks(String subject, String std) async {
    try {
      final response = await http.get(
          Uri.parse('${Base.api}/books?subject=$subject&std=$std'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UFT-8',
          });

      final body = jsonDecode(response.body);
      debugPrint('getBooks body: $body');

      if (response.statusCode == 200) {
        // page++;
        return BookModel.fromJson(body);
      }
    } catch (e) {
      debugPrint('Error While getBooks() ${e.toString()}');
      return Future.error(e);
    }

    return null;
  }

  Future<BookModel?> getSolution(
      String subject, String std, String boardId) async {
    try {
      final response = await http.get(
          Uri.parse(
              '${Base.api}/solutions?subject=$subject&std=$std&boardId=$boardId'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UFT-8',
          });

      final body = jsonDecode(response.body);
      debugPrint('getBooks body: $body');

      if (response.statusCode == 200) {
        // page++;
        return BookModel.fromJson(body);
      }
    } catch (e) {
      debugPrint('Error While getBooks() ${e.toString()}');
      return Future.error(e);
    }

    return null;
  }

  Future<BoardModel?> getBoards() async {
    try {
      final response = await http
          .get(Uri.parse('${Base.api}/board'), headers: <String, String>{
        'Content-Type': 'application/json; charset=UFT-8',
      });

      final body = jsonDecode(response.body);
      debugPrint('getBoards body: $body');

      if (response.statusCode == 200) {
        return BoardModel.fromJson(body);
      }
    } catch (e) {
      debugPrint('Error While getBoards() ${e.toString()}');
      return Future.error(e);
    }

    return null;
  }
}
