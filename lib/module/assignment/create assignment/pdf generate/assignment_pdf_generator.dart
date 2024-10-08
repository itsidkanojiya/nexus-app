import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:nexus_app/models/paper_history.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class AssignmentPDFGenerator {
  final History paperHistory;
  final bool showAnswers;
  final tickEmoji = String.fromCharCode(0x2705);

  AssignmentPDFGenerator(this.paperHistory, {this.showAnswers = false});

  Future<pw.Document> generatePDF() async {
    final pdf = pw.Document();
    final font = await PdfGoogleFonts.arimoRegular();
    final titleFont = await PdfGoogleFonts.arimoBold();

    pw.MemoryImage? logo;
    final tickBoxImage = pw.MemoryImage(
      (await rootBundle.load('assets/checkbox.png')).buffer.asUint8List(),
    );

    // Fetch logo if available
    if (paperHistory.logo != null) {
      final response = await http.get(Uri.parse(paperHistory.logo!));
      if (response.statusCode == 200) {
        logo = pw.MemoryImage(response.bodyBytes);
      }
    }

    final sections = {
      'mcq': 'Multiple Choice Questions (MCQs). Tick the correct options.',
      'blanks': 'Fill in the blanks in each sentence with an appropriate word.',
      'long': 'Long Answer Questions.',
      'true_false': 'Write (T) for True and (F) for False.',
      'onetwo': 'Answer the following questions in one or two sentences.',
      'short': 'Short Answer Questions.',
    };

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(32),
        build: (pw.Context context) {
          int alphabetIndex = 0;
          return [
            pw.Container(
              decoration: pw.BoxDecoration(
                border: pw.Border.all(),
              ),
              child: pw.Padding(
                padding: const pw.EdgeInsets.all(20),
                child: pw.Column(children: [
                  pw.Row(
                    children: [
                      if (logo != null) pw.Image(logo, width: 60, height: 60),
                      pw.SizedBox(width: 80),
                      pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.center,
                        children: [
                          pw.Text(
                            paperHistory.schoolName ?? '',
                            style: pw.TextStyle(
                              font: titleFont,
                              fontSize: 20,
                              fontWeight: pw.FontWeight.bold,
                            ),
                          ),
                          pw.Text(
                            paperHistory.address ?? '',
                            style: pw.TextStyle(font: font, fontSize: 12),
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
                      pw.Text(
                        'Name: ',
                        style: pw.TextStyle(font: titleFont, fontSize: 12),
                      ),
                      pw.SizedBox(height: 10),
                      pw.Expanded(
                          child: pw.Padding(
                              padding:
                                  const pw.EdgeInsets.only(top: 20, bottom: 10),
                              child: pw.Container(
                                  decoration: const pw.BoxDecoration(
                                border: pw.Border(
                                  bottom: pw.BorderSide(
                                    width: 0.5, // Line thickness
                                  ),
                                ),
                              ))))
                    ],
                  ),
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Text(
                            'STD: ${paperHistory.std}',
                            style: pw.TextStyle(font: titleFont, fontSize: 12),
                          ),
                          pw.Text(
                            "DATE:_______________  ",
                            style: pw.TextStyle(font: titleFont, fontSize: 12),
                          ),
                        ],
                      ),
                      pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Text(
                            'SUBJECT: ${paperHistory.subject}',
                            style: pw.TextStyle(font: titleFont, fontSize: 12),
                          ),
                          pw.Text(
                            'DIV: _____________',
                            style: pw.TextStyle(font: titleFont, fontSize: 12),
                          ),
                        ],
                      ),
                    ],
                  ),
                ]),
              ),
            ),
            pw.SizedBox(height: 20),
            ...sections.entries.map((entry) {
              final type = entry.key;
              final title = entry.value;

              List<McqQuestion> sectionQuestions = [];
              if (type == 'mcq' && paperHistory.questions!.mcq != null) {
                sectionQuestions = paperHistory.questions!.mcq!.questions ?? [];
              } else if (type == 'blanks' &&
                  paperHistory.questions!.blanks != null) {
                sectionQuestions =
                    paperHistory.questions!.blanks!.questions ?? [];
              } else if (type == 'long' &&
                  paperHistory.questions!.long != null) {
                sectionQuestions =
                    paperHistory.questions!.long!.questions ?? [];
              } else if (type == 'true_false' &&
                  paperHistory.questions!.true_false != null) {
                sectionQuestions =
                    paperHistory.questions!.true_false!.questions ?? [];
              } else if (type == 'onetwo' &&
                  paperHistory.questions!.onetwo != null) {
                sectionQuestions =
                    paperHistory.questions!.onetwo!.questions ?? [];
              } else if (type == 'short' &&
                  paperHistory.questions!.short != null) {
                sectionQuestions =
                    paperHistory.questions!.short!.questions ?? [];
              }

              final alphabet = '${String.fromCharCode(65 + alphabetIndex)})';
              alphabetIndex++;

              if (sectionQuestions.isEmpty) {
                return pw.SizedBox.shrink();
              }

              return pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Row(
                    children: [
                      pw.Text(
                        alphabet.toUpperCase(),
                        style: pw.TextStyle(
                          font: titleFont,
                          fontSize: 14,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                      pw.Text(
                        ' $title',
                        style: pw.TextStyle(
                          font: titleFont,
                          fontSize: 14,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  pw.SizedBox(height: 10),
                  ...sectionQuestions.map((question) {
                    return pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        if (type != 'true_false')
                          pw.Text(
                            '${sectionQuestions.indexOf(question) + 1}. ${question.question}',
                            style: pw.TextStyle(
                              font: font,
                              fontSize: 14,
                              fontWeight: pw.FontWeight.bold,
                            ),
                          ),
                        if (type == 'true_false') ...[
                          pw.Row(children: [
                            pw.Text(
                              '${sectionQuestions.indexOf(question) + 1}. ${question.question}',
                              style: pw.TextStyle(
                                font: font,
                                fontSize: 14,
                                fontWeight: pw.FontWeight.bold,
                              ),
                            ),
                            pw.SizedBox(width: 7),
                            pw.Container(
                              width: 50,
                              height: 15,
                              decoration: pw.BoxDecoration(
                                border: pw.Border.all(),
                              ),
                            ),
                          ])
                        ],
                        if (type == 'mcq' && question.options != null) ...[
                          pw.SizedBox(height: 5),
                          pw.Row(
                            crossAxisAlignment: pw.CrossAxisAlignment.start,
                            children: question.options!
                                .map((option) => pw.Row(
                                      children: [
                                        pw.Image(tickBoxImage,
                                            width: 12, height: 12),
                                        pw.SizedBox(width: 5),
                                        pw.Text(
                                          option,
                                          style: pw.TextStyle(
                                            font: font,
                                            fontSize: 12,
                                          ),
                                        ),
                                        pw.SizedBox(width: 20),
                                      ],
                                    ))
                                .toList(),
                          ),
                          if (showAnswers && question.answer != null)
                            pw.Padding(
                              padding: const pw.EdgeInsets.only(top: 5),
                              child: pw.Text(
                                'Answer: ${question.answer}',
                                style: pw.TextStyle(
                                  font: font,
                                  fontSize: 12,
                                  color: PdfColors.green,
                                ),
                              ),
                            ),
                        ],
                        // Add answer lines based on question type
                        if (type == 'onetwo') ...[
                          pw.SizedBox(height: 10),
                          _drawLines(2),
                        ],
                        if (type == 'short') ...[
                          pw.SizedBox(height: 10),
                          _drawLines(4),
                        ],
                        if (type == 'long') ...[
                          pw.SizedBox(height: 10),
                          _drawLines(6),
                        ],
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

  // Helper method to draw answer lines
  pw.Widget _drawLines(int numLines) {
    return pw.Column(
      children: List.generate(numLines, (_) {
        return pw.Column(
          children: [
            pw.Divider(),
            pw.SizedBox(height: 5),
          ],
        );
      }),
    );
  }
}
