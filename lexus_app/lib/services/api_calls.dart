import 'dart:convert';

import 'package:lexus_app/api_response/book_response.dart';
import 'package:lexus_app/models/books_model.dart';
import 'package:http/http.dart' as http;

class ApiCalls {
  List<BookModel> bookList = [];
  Future<List<Books>?> getBooks() async {
    var client = http.Client();

    var uri = Uri.parse('https://backend.nexuspublication.com/api/books');

    try {
      var response = await client.get(uri);
      var data = jsonDecode(response.body);

      if (response.statusCode == 200) {
  
        for (Map<String, dynamic> e in data["books"]) {
          bookList.add(BookModel.fromJson(e));
        }
      } else {
        throw Exception('Api Get Call Failed');
      }
    } catch (e) {
      print("Error Fetching Books:$e");
    }
    return null;
  }
}
