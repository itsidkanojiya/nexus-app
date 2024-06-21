import 'dart:io';

import 'package:flutter/material.dart' as material;
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:nexus_app/models/question_model.dart';
import 'package:path_provider/path_provider.dart' as Path;
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
// Adjust this import to your actual file path

class PDFGenerator {
  final String schoolName;
  final String schoolAddress;
  final String grade;
  final String subject;
  final DateTime date;
  final material.TimeOfDay time;
  final String? schoolLogoUrl;
  final List<QuestionModel> questions;

  PDFGenerator({
    required this.schoolName,
    required this.schoolAddress,
    required this.grade,
    required this.subject,
    required this.date,
    required this.time,
    required this.questions,
    this.schoolLogoUrl,
  });

  Future<pw.Document> generatePDF() async {
    final pdf = pw.Document();
    final font = await PdfGoogleFonts.nunitoRegular();
    pw.MemoryImage? logo;

    if (schoolLogoUrl != null) {
      final response = await http.get(Uri.parse(schoolLogoUrl!));
      if (response.statusCode == 200) {
        logo = pw.MemoryImage(response.bodyBytes);
      }
    }
    final ByteData bytes = await rootBundle.load('assets/checkbox.png');
    final Uint8List byteList = bytes.buffer.asUint8List();
    final pw.MemoryImage assetImage = pw.MemoryImage(byteList);
    final sections = {
      'mcq': 'Multiple Choice Questions (MCQs). Tick the correct options.',
      'blanks': 'Fill in the blanks in each sentence with an appropriate word.',
      'true_false': 'Write (T) for True and (F) for False.',
      'one_two': 'Answer the following questions in one or two sentences.',
      'short': 'Short Answer Questions.',
      'long': 'Long Answer Questions.',
    };

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(32),
        build: (pw.Context context) {
          int alphabetIndex = 0;
          return [
            pw.Row(
              children: [
                if (logo != null) pw.Image(logo, width: 60, height: 60),
                pw.SizedBox(width: 80),
                pw.Column(
                  children: [
                    pw.Text(
                      schoolName,
                      style: pw.TextStyle(
                        font: font,
                        fontSize: 20,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                    pw.Center(
                      child: pw.Text(
                        schoolAddress,
                        style: pw.TextStyle(font: font, fontSize: 12),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            pw.SizedBox(height: 20),
            pw.Divider(),
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text('STD: $grade',
                        style: pw.TextStyle(font: font, fontSize: 12)),
                    pw.Text('DATE: ${DateFormat('yyyy-MM-dd').format(date)}',
                        style: pw.TextStyle(font: font, fontSize: 12)),
                  ],
                ),
                pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text('SUBJECT: $subject',
                        style: pw.TextStyle(font: font, fontSize: 12)),
                    pw.Text('DIV: 1st',
                        style: pw.TextStyle(font: font, fontSize: 12)),
                  ],
                ),
                pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text('DAY: ${DateFormat('EEEE').format(date)}',
                        style: pw.TextStyle(font: font, fontSize: 12)),
                    pw.Text('TIME: $time',
                        style: pw.TextStyle(font: font, fontSize: 12)),
                  ],
                ),
              ],
            ),
            pw.SizedBox(height: 20),
            ...sections.entries.map((entry) {
              final type = entry.key;
              final title = entry.value;
              final sectionQuestions =
                  questions.where((q) => q.type == type).toList();
              final alphabet =
                  String.fromCharCode(97 + alphabetIndex); // 'a' + index

              if (sectionQuestions.isEmpty) {
                return pw.SizedBox
                    .shrink(); // Do not display the section if there are no questions
              }
              alphabetIndex++;
              return pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Row(children: [
                    pw.Text(
                      '${alphabet.capitalize})  ',
                      style: pw.TextStyle(
                        font: font,
                        fontSize: 14,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                    pw.Text(
                      title,
                      style: pw.TextStyle(
                        font: font,
                        fontSize: 14,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                  ]),
                  pw.SizedBox(height: 10),
                  ...sectionQuestions.map((question) {
                    return pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text(
                          '${sectionQuestions.indexOf(question) + 1}. ${question.question}',
                          style: pw.TextStyle(
                            font: font,
                            fontSize: 14,
                            fontWeight: pw.FontWeight.bold,
                          ),
                        ),
                        if (type == 'mcq' && question.options != null) ...[
                          pw.SizedBox(height: 5),
                          pw.Row(
                            mainAxisAlignment: pw.MainAxisAlignment.start,
                            children: question.options!
                                .map(
                                  (option) => pw.Row(
                                    mainAxisAlignment:
                                        pw.MainAxisAlignment.start,
                                    children: [
                                      pw.Image(assetImage,
                                          width: 10, height: 10),
                                      pw.SizedBox(width: 5),
                                      pw.Text(
                                        option,
                                        style: pw.TextStyle(
                                            font: font, fontSize: 12),
                                      ),
                                      pw.SizedBox(width: 50),
                                    ],
                                  ),
                                )
                                .toList(),
                          ),
                        ],
                        if (type == 'blanks')
                          pw.Text('_________',
                              style: pw.TextStyle(font: font, fontSize: 12)),
                        pw.SizedBox(height: 10),
                      ],
                    );
                  }),
                  pw.SizedBox(height: 20),
                ],
              );
            }),
          ];
        },
      ),
    );
    return pdf;
  }

  Future<void> saveAndPrintPDF() async {
    final pdf = await generatePDF();
    final output = await Path.getTemporaryDirectory();
    final file = File("${output.path}/paper.pdf");
    await file.writeAsBytes(await pdf.save());

    await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => pdf.save(),
    );
  }
}
