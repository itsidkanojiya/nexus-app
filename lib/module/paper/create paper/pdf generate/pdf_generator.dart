import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:nexus_app/models/paper_history.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

class PDFGenerator {
  final History paperHistory;
  final bool showAnswers;

  PDFGenerator(this.paperHistory, {this.showAnswers = false});

  Future<PdfDocument> generatePDF() async {
    final PdfDocument pdf = PdfDocument();
    final Uint8List fontData =
        await rootBundle.load('assets/font/Avantika.ttf').then((data) {
      return data.buffer.asUint8List();
    });

    // Create the font from the loaded data
    final PdfFont font = PdfTrueTypeFont(fontData, 12);

    // final PdfFont font = PdfTrueTypeFont(
    //   await rootBundle.load('assets/font/NotoSansGujarati.ttf').then((data) {
    //     return data.buffer.asUint8List();
    //   }),
    //   12,
    // );
    final PdfFont titleFont =
        PdfStandardFont(PdfFontFamily.helvetica, 20, style: PdfFontStyle.bold);

    PdfImage? logo;
    final tickBoxImage =
        await rootBundle.load('assets/checkbox.png').then((data) {
      return PdfBitmap(data.buffer.asUint8List());
    });

    // Fetch logo if available
    if (paperHistory.logo != null) {
      final response = await http.get(Uri.parse(paperHistory.logo!));
      if (response.statusCode == 200) {
        logo = PdfBitmap(response.bodyBytes);
      }
    }

    // Create a PDF page and add the content
    final PdfPage page = pdf.pages.add();
    final PdfGraphics graphics = page.graphics;

    // Add Header
    if (logo != null) {
      graphics.drawImage(logo, const Rect.fromLTWH(0, 0, 60, 60));
    }
    graphics.drawString(
      'બહુવિધ પસંદગીના પ્રશ્નો (MCQs)', font,
      bounds: const Rect.fromLTWH(70, 0, 500, 60),
      // 'બહુવિધ પસંદગીના પ્રશ્નો (MCQs).',
      // font,
      // bounds: const Rect.fromLTWH(70, 0, 500, 60),
    );

    // Add Paper Details
    graphics.drawString(
      'STD: ${paperHistory.std}',
      titleFont,
      bounds: const Rect.fromLTWH(0, 80, 500, 20),
    );
    graphics.drawString(
      'DATE: ${DateFormat('yyyy-MM-dd').format(DateTime.parse(paperHistory.date!))}',
      font,
      bounds: const Rect.fromLTWH(0, 100, 500, 20),
    );

    // Continue adding your content in a similar way

    // Sections & Questions
    final sections = {
      'mcq': 'Multiple Choice Questions (MCQs).',
      'blanks': 'Fill in the blanks.',
      // Add more sections as needed
    };

    double yOffset = 120;
    for (var section in sections.entries) {
      graphics.drawString(
        section.value,
        titleFont,
        bounds: Rect.fromLTWH(0, yOffset, 500, 20),
      );
      yOffset += 30;

      // Iterate over questions and add the tick box image for MCQs
      // for (var question in paperHistory.questions ?? <History>[]) {
      //   graphics.drawString(
      //     question.text ?? 'No question text available',
      //     font,
      //     bounds: Rect.fromLTWH(0, yOffset, 500, 20),
      //   );

      //   if (section.key == 'mcq') {
      //     // Add tick box image for MCQ
      //     graphics.drawImage(tickBoxImage, Rect.fromLTWH(500, yOffset, 12, 12));
      //   }

      //   yOffset += 30;
      // }
    }

    return pdf;
  }
}
