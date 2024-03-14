import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nexus_app/module/view_page/view_page_controller.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class ViewBookPage extends StatefulWidget {
  const ViewBookPage({super.key, required this.docPath, required this.docName});
  final String docPath;
  final String docName;
  @override
  State<ViewBookPage> createState() => _ViewBookPageState();
}

class _ViewBookPageState extends State<ViewBookPage> {
  final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();

  ViewBookPageController viewController = Get.put(ViewBookPageController());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.docName),
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.bookmark,
              color: Colors.white,
              semanticLabel: 'Bookmark',
            ),
            onPressed: () {
              _pdfViewerKey.currentState?.openBookmarkView();
            },
          ),
        ],
      ),
      body: SfPdfViewer.network(
        widget.docPath,
        key: _pdfViewerKey,
      ),
    );
  }
}
