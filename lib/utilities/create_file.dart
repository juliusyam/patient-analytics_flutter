import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:intl/intl.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:path_provider/path_provider.dart';
import 'package:patient_analytics_flutter/models/patient.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:universal_html/html.dart' as html;

String generatePatientReportFileName(Patient? patient) {
  final now = DateFormat('yyyy-MM-dd_HH-mm-ss').format(DateTime.now());

  final name = patient != null
      ? '${patient.firstName}-${patient.lastName}'
      : 'Unknown-Patient';

  return '${now}_$name-report.pdf';
}

Future<Result<String?, Exception>> createFile(
  Uint8List data,
  String fileName,
) async {
  if (kIsWeb) {
    _downloadFileForWeb(data, fileName);
    return const Success(null);
  }

  final baseDir = await _getBaseDirectory();

  if (baseDir == null) {
    return Error(Exception("Unable to find directory to download file"));
  }

  final path = '$baseDir/$fileName';

  File file = await File(path).create(recursive: true);

  await file.writeAsBytes(data);

  return Success(path);
}

void _downloadFileForWeb(Uint8List data, String fileName) {
  final base64Data = base64Encode(data);

  final anchor = html.AnchorElement(
    href: 'data:application/octet-stream;base64,$base64Data',
  );

  anchor.download = fileName;

  html.document.body?.append(anchor);

  anchor.click();

  anchor.remove();

  return;
}

Future<String?> _getBaseDirectory() async {
  if (Platform.isIOS) {
    final dir = await getApplicationDocumentsDirectory();

    return dir.path;
  } else if (Platform.isAndroid) {
    var status = await Permission.manageExternalStorage.status;

    if (status != PermissionStatus.granted) {
      status = await Permission.manageExternalStorage.request();
    } else {
      final dir = await getExternalStorageDirectory();

      return dir?.path;
    }
  }

  return null;
}
