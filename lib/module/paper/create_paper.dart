import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:nexus_app/custome_widgets/question_widget.dart';
import 'package:nexus_app/custome_widgets/text_field_widget.dart';
import 'package:nexus_app/theme/style.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class CreatePaper extends StatefulWidget {
  const CreatePaper({super.key});

  @override
  State<CreatePaper> createState() => _CreatePaperState();
}

class _CreatePaperState extends State<CreatePaper>
    with SingleTickerProviderStateMixin {
  TextEditingController schoolNameController = TextEditingController();
  TextEditingController schoolAddressController = TextEditingController();
  TextEditingController gradeController = TextEditingController();
  TextEditingController paperTimingController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController divisionController = TextEditingController();

  String? selectedBoard = '';
  DateTime? dateSelected;
  List<String> boards = ['GSEB', 'NCERT', 'HSEB', 'PSEB'];

  @override
  void initState() {
    super.initState();

    // Initialize the TabController
  }

  @override
  void dispose() {
    // Dispose of the TabController when the widget is disposed

    super.dispose();
  }

  Future<Uint8List> _createPdf(PdfPageFormat format) async {
    final pdf = pw.Document(version: PdfVersion.pdf_1_4, compress: true);
    pdf.addPage(pw.Page(
        pageFormat: format,
        build: (context) {
          return pw.Container(
              width: double.infinity,
              child: pw.Column(children: [
                pw.Text('Testing First PDF'),
                pw.Container(
                  width: 250,
                  height: 1.5,
                ),
              ]));
        }));
    return pdf.save();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          backgroundColor: Style.secondary,
          appBar: AppBar(
            iconTheme: const IconThemeData(color: Style.secondary),
            elevation: 0,
            backgroundColor: Style.primary,
            title: const Text(
              'Generate Question Paper',
              style: TextStyle(color: Style.secondary),
            ),
            bottom: const TabBar(
              labelColor: Style.secondary,
              indicatorColor: Style.secondary,
              tabs: [
                Tab(text: 'Paper Details'),
                Tab(text: 'Add Questions'),
                Tab(text: 'Preview'),
              ],
            ),
          ),
          body: Builder(builder: (context) {
            TabController? tabController = DefaultTabController.of(context);
            return TabBarView(
              children: [
                Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: EdgeInsets.fromLTRB(2, 10, 0, 3.0),
                              child: Text(
                                'School Name',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 15),
                              ),
                            ),
                            AppTextField(
                              hintText: 'School Name',
                              controller: schoolNameController,
                              textsize: 12,
                              boxheight: 50,
                              maxLine: 1,
                            ),
                            const Padding(
                              padding: EdgeInsets.fromLTRB(2, 12, 0, 3.0),
                              child: Text(
                                'School Address',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 15),
                              ),
                            ),
                            AppTextField(
                              hintText: 'School Adress',
                              controller: schoolAddressController,
                              textsize: 12,
                              minLine: 2,
                              maxLine: 15,
                            ),
                            const Padding(
                              padding: EdgeInsets.fromLTRB(2, 12, 0, 3.0),
                              child: Text(
                                'Upload School Logo',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 15),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.only(left: 10),
                              height: 50,
                              width: MediaQuery.of(context).size.width * 0.9,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                      color: Colors.grey, width: 1.8),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Row(
                                children: [
                                  const Expanded(
                                      child: Text(
                                    'Upload File Here',
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w700),
                                  )),
                                  Container(
                                    height: 50,
                                    width: 75,
                                    decoration: BoxDecoration(
                                        color: Style.primary,
                                        border: Border.all(
                                            color: Colors.grey, width: 1.8),
                                        borderRadius: const BorderRadius.only(
                                            bottomRight: Radius.circular(8),
                                            topRight: Radius.circular(8))),
                                    child: const Icon(
                                      Icons.upload_file,
                                      color: Style.secondary,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.fromLTRB(2, 10, 0, 3.0),
                              child: Text(
                                'Grade',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 15),
                              ),
                            ),
                            AppTextField(
                              hintText: 'Ex: 2nd(Eng.Med.)',
                              controller: gradeController,
                              textsize: 12,
                              boxheight: 50,
                              maxLine: 1,
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(2, 10, 0, 3.0),
                              child: RichText(
                                  text: const TextSpan(
                                      text: 'Paper timing',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 15),
                                      children: <TextSpan>[
                                    TextSpan(
                                        text: ' (add with Hours or minutes)',
                                        style: TextStyle(
                                            color: Colors.black54,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 15),
                                        children: <TextSpan>[])
                                  ])),
                            ),
                            AppTextField(
                              hintText: 'Ex: 30 minutes',
                              controller: paperTimingController,
                              textsize: 12,
                              boxheight: 50,
                              maxLine: 1,
                            ),
                            const Padding(
                              padding: EdgeInsets.fromLTRB(2, 12, 0, 3.0),
                              child: Text(
                                'Date',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 15),
                              ),
                            ),
                            GestureDetector(
                              onTap: () async {
                                dateSelected = await showDatePicker(
                                  context: context,
                                  lastDate: DateTime(2050, 9, 7, 17, 30),
                                  firstDate: DateTime.now(),
                                  initialDate: DateTime.now(),
                                  // onDatePickerModeChange: (value) {
                                  //   setState(() {
                                  //     dateSelected = value.toString();
                                  //     dateSelected = '1';
                                  //   });
                                  // },
                                );

                                setState(() {});
                              },
                              child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  height: 50,
                                  width:
                                      MediaQuery.of(context).size.width * 0.9,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(
                                          color: Colors.grey, width: 1.8),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: (dateSelected == null)
                                      ? const Row(
                                          children: [
                                            Text(
                                              'dd/mm/yyyy',
                                              // dateSelected ?? '',
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 12.5),
                                            ),
                                          ],
                                        )
                                      : Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              DateFormat('dd/MM/yyyy')
                                                  .format(dateSelected ??
                                                      DateTime.now())
                                                  .toString(),
                                              style: const TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 12.5),
                                            ),
                                            GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    dateSelected = null;
                                                  });
                                                },
                                                child: const Icon(Icons.close))
                                          ],
                                        )),
                            ),
                            const Padding(
                              padding: EdgeInsets.fromLTRB(2, 12, 0, 3.0),
                              child: Text(
                                'Select Board',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 15),
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.9,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                      color: Colors.grey, width: 1.8),
                                  borderRadius: BorderRadius.circular(10)),
                              child: DropdownButton<String>(
                                // value: selectedBook,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 12),
                                isExpanded: true,
                                onChanged: (value) {
                                  selectedBoard = value;
                                  setState(() {});
                                },
                                elevation: 2,
                                hint: const Text(
                                  'select subject',
                                  style: TextStyle(fontSize: 15),
                                ),

                                menuMaxHeight: 350,
                                underline: const SizedBox(),
                                items: boards.map<DropdownMenuItem<String>>(
                                    (String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              ),
                            ),
                            const SizedBox(
                              height: 80,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: GestureDetector(
                        onTap: () {
                          tabController.index = 1;
                        },
                        child: Container(
                          margin: const EdgeInsets.only(
                              bottom: 25, right: 22, left: 15),
                          height: 50,
                          // width: MediaQuery.of(context).size.width * 0.9,
                          decoration: BoxDecoration(
                              color: Style.primary,
                              borderRadius: BorderRadius.circular(10)),
                          child: const Center(
                            child: Text(
                              'Submit',
                              style: TextStyle(
                                  color: Colors.white, // Set the text color
                                  fontSize: 16.0,
                                  fontWeight:
                                      FontWeight.w600 // Set the font size
                                  ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                //?? Tab No.2 ??//-------------------------------------------------------------------------
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
                  child: Stack(
                    children: [
                      SingleChildScrollView(
                        child: Column(children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.0),
                              border:
                                  Border.all(color: Colors.grey, width: 1.8),
                              color: Colors.white,
                            ),
                            child: const TextField(
                              decoration: InputDecoration(
                                hintText: 'Search',
                                prefixIcon: Icon(Icons.search),
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 50.0, vertical: 10.0),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.9,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border:
                                    Border.all(color: Colors.grey, width: 1.8),
                                borderRadius: BorderRadius.circular(10)),
                            child: DropdownButton<String>(
                              // value: selectedBook,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12),
                              isExpanded: true,
                              onChanged: (value) {
                                setState(() {
                                  selectedBoard = value;
                                });
                              },
                              elevation: 2,
                              hint: const Text(
                                'select question type',
                                style: TextStyle(fontSize: 15),
                              ),
                              menuMaxHeight: 350,
                              underline: const SizedBox(),
                              items: boards.map<DropdownMenuItem<String>>(
                                  (String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          ),
                          const Divider(
                            color: Colors.grey,
                            thickness: 1.7,
                            height: 30,
                          ),
                          ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: 30,
                              itemBuilder: (BuildContext context, int index) {
                                return const QuestionWidget();
                              }),
                          const SizedBox(
                            height: 75,
                          ),
                        ]),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: GestureDetector(
                          onTap: () {
                            tabController.index = 2;
                          },
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 20),
                            height: 50,
                            width: MediaQuery.of(context).size.width * 0.4,
                            decoration: BoxDecoration(
                                color: Style.primary,
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.black38,
                                    offset:
                                        Offset(1, 2), // Shadow position (x, y)
                                    blurRadius: 1.0, // Spread of the shadow
                                    spreadRadius: 1.0, // Offset of the shadow
                                  ),
                                ],
                                borderRadius: BorderRadius.circular(10)),
                            child: const Center(
                              child: Text(
                                'Next',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                // //?? Tab No.3 ??//-------------------------------------------------------------------------
                // GestureDetector(
                //   onTap: () {
                //     makePdf();
                //   },
                //   child: const Center(child: Text('generate')),
                // )
                PdfPreview(
                  pdfPreviewPageDecoration: const BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black38,
                        offset: Offset(1, 2), // Shadow position (x, y)
                        blurRadius: 1.0, // Spread of the shadow
                        spreadRadius: 1.0, // Offset of the shadow
                      ),
                    ],
                  ),
                  allowPrinting: true,
                  allowSharing: true,
                  build: (context) => _createPdf(PdfPageFormat.a4),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
