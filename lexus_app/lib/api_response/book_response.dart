import 'dart:convert';

import 'package:lexus_app/models/books_model.dart';


class Books {
  List<BookModel>? books;

  Books({this.books});

  Books.fromJson(Map<String, dynamic> json) {
    if (json['books'] != null) {
      books = <BookModel>[];
      json['books'].forEach((v) {
        books!.add(BookModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (books != null) {
      data['books'] = books!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}