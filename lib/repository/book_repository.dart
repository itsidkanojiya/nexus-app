import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nexus_app/models/boards_model.dart';
import 'package:nexus_app/models/books_model.dart';
import 'package:nexus_app/models/subject_model.dart';
import 'package:nexus_app/utils/api_helper.dart';
import 'package:nexus_app/utils/base.dart';

class BookRepository {
  // Fetch Subject List
  Future<SubjectModel?> getSubject() async {
    final response = await ApiHelper.apiCall(
      url: '${Base.api}/subject',
      method: 'GET',
      headers: {
        'Content-Type': 'application/json; charset=UFT-8',
      },
    );

    if (response.isEmpty) return null;

    return SubjectModel.fromJson(response);
  }

  // Fetch Books by Subject and Standard
  Future<BookModel?> getBooks(String subject, String std) async {
    final response = await ApiHelper.apiCall(
      url: '${Base.api}/books?subject=$subject&std=$std',
      method: 'GET',
      headers: {
        'Content-Type': 'application/json; charset=UFT-8',
      },
    );

    if (response.isEmpty) return null;

    return BookModel.fromJson(response);
  }

  // Fetch Solutions by Subject, Standard, and Board ID
  Future<BookModel?> getSolution(
      String subject, String std, String boardId) async {
    final response = await ApiHelper.apiCall(
      url: '${Base.api}/solutions?subject=$subject&std=$std&boardId=$boardId',
      method: 'GET',
      headers: {
        'Content-Type': 'application/json; charset=UFT-8',
      },
    );

    if (response.isEmpty) return null;

    return BookModel.fromJson(response);
  }

  // Fetch Board List
  Future<BoardModel?> getBoards() async {
    final response = await ApiHelper.apiCall(
      url: '${Base.api}/board',
      method: 'GET',
      headers: {
        'Content-Type': 'application/json; charset=UFT-8',
      },
    );

    if (response.isEmpty) return null;

    return BoardModel.fromJson(response);
  }
}
