import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:lexus_app/models/books_model.dart';
import 'package:lexus_app/utils/Base.dart';

class BookRepository extends GetConnect {
  Future<BookModel?> getBooks(int page) async {
    try {
      final response = await http.get(Uri.parse('${Base.api}/books?page=$page'),
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
}
