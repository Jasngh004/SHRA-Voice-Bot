import 'package:easy_pdf_viewer/easy_pdf_viewer.dart';
import 'package:flutter/material.dart';

Future<Widget> pdfViewer(url) async {
  PDFDocument doc = await PDFDocument.fromURL(url);
  return PDFViewer(document: doc);
}
