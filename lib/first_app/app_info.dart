import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'components/info_header.dart';

class FirstAppInfoPage extends StatefulWidget {
  const FirstAppInfoPage({super.key, required this.link});
  final String link;

  @override
  State<FirstAppInfoPage> createState() => _FirstAppInfoPageState();
}

class _FirstAppInfoPageState extends State<FirstAppInfoPage> {
  final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();
  final PdfViewerController _controller = PdfViewerController();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppInfoHeaderBar(
        backPage: '',
        onClickNext: (cb) {
          _controller.zoomLevel = _controller.zoomLevel + 0.2;
        },
        onClickPrev: (cb) {
          _controller.zoomLevel = _controller.zoomLevel - 0.2;
        },
      ),
      body: SfPdfViewer.asset(
        widget.link,
        key: _pdfViewerKey,
        canShowScrollStatus: true,
        enableTextSelection: true,
        enableDoubleTapZooming: true,
        canShowScrollHead: true,
        canShowPaginationDialog: true,
        initialZoomLevel: 1.5,
        controller: _controller,
        interactionMode: PdfInteractionMode.pan,
      ),
    );
  }
}
