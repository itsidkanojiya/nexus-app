import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:lexus_app/theme/style.dart';
import 'package:pdfx/pdfx.dart';

class ViewBookPage extends StatefulWidget {
  const ViewBookPage({super.key, required this.docPath, required this.docName});
  final String docPath;
  final String docName;
  @override
  State<ViewBookPage> createState() => _ViewBookPageState();
}

class _ViewBookPageState extends State<ViewBookPage> {
  late PdfControllerPinch pdfControllerPinch;
  String pageNumber = '0', totalpages = '-';

  @override
  void initState() {
    super.initState();
    pdfControllerPinch =
        PdfControllerPinch(document: PdfDocument.openAsset(widget.docPath));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Style.secondary,
      appBar: AppBar(
        title: const Text("Book Name"),
      ),
      body: Column(children: [
        Expanded(
            child: PdfViewPinch(
          onPageChanged: (page) {
            setState(() {
              pageNumber = page.toString();
            });
          },
          onDocumentLoaded: (page) {
            setState(() {
              totalpages = page.pagesCount.toString();
            });
          },
          controller: pdfControllerPinch,
        )),
      ]),
      bottomSheet: Container(
        height: 35,
        color: Style.primary,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          children: [
            Text(
              'Current Page:- $pageNumber',
              style: const TextStyle(fontSize: 13, color: Style.secondary),
            ),
            const Expanded(
              flex: 1,
              child: SizedBox(
                height: 20,
                child: VerticalDivider(
                  thickness: 1.7,
                  color: Colors.grey,
                ),
              ),
            ),
            Text(
              'Total Pages:- $totalpages',
              style: const TextStyle(fontSize: 13, color: Style.secondary),
            ),
          ],
        ),
      ),
    );
  }
}
