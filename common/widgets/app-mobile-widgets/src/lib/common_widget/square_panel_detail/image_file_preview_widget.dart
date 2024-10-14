import 'dart:io';

import 'package:core/utils/file/file_utils.dart';
import 'package:flutter/widgets.dart';
import 'package:pdf_render/pdf_render.dart';
import 'package:pdf_render/pdf_render_widgets.dart';

class ImageFilePreviewWidget extends StatelessWidget {
  final String filePath;

  const ImageFilePreviewWidget({Key? key, required this.filePath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final file = File(filePath);
    if (extractFileExtension(file).contains('.pdf')) {
      return _PdfViewerWrapper(filePath: filePath, key: Key('PdfViewerWrapper_$filePath'));
    } else {
      return Image.file(file);
    }
  }
}

class _PdfViewerWrapper extends StatefulWidget {
  final String filePath;

  const _PdfViewerWrapper({Key? key, required this.filePath}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _PdfViewerWrapperState();
}

class _PdfViewerWrapperState extends State<_PdfViewerWrapper> {
  late Future<PdfDocument> openFileFuture;

  @override
  void initState() {
    super.initState();
    openFileFuture = _isAsset() ? PdfDocument.openAsset(widget.filePath) : PdfDocument.openFile(widget.filePath);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<PdfDocument>(
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return PdfViewer(key: Key('pdf_viewer_${widget.filePath}'), doc: Future.value(snapshot.data));
        } else {
          return Container();
        }
      },
      future: openFileFuture,
    );
  }

  bool _isAsset() => widget.filePath.startsWith('assets/');
}
