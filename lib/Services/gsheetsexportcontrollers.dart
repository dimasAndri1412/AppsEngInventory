import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:googleapis_auth/auth_io.dart';
import 'package:share_plus/share_plus.dart';

class GoogleSheetsExportService {

  static const String excelMimeType = 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet';
  static const List<String> scopes = ['https://www.googleapis.com/auth/drive.readonly',];

  static Future<String> exportAllSheetsToExcel({
    required String spreadsheetId,
    required String credentialAssetPath,
    bool shareFile = true,
  }) async {
    AutoRefreshingAuthClient? client;

    try {

      if (spreadsheetId.trim().isEmpty) {
        throw Exception(
          'Spreadsheet ID kosong.',
        );
      }

      final String credentialJson = await rootBundle.loadString(credentialAssetPath);

      if (credentialJson.trim().isEmpty) {
        throw Exception(
          'Credential JSON kosong.',
        );
      }


      final Map<String, dynamic> credentialMap = jsonDecode(credentialJson);
      final ServiceAccountCredentials credentials = ServiceAccountCredentials.fromJson(credentialMap,);

      client = await clientViaServiceAccount(
        credentials,
        scopes,
      );

      final Uri exportUri = Uri.https('www.googleapis.com',
        '/drive/v3/files/$spreadsheetId/export',
        {
          'mimeType': excelMimeType,
        },
      );


      final response = await client.get(
        exportUri,
      );

      if (response.statusCode != 200) {
        throw Exception('Gagal export Google Sheets ke Excel. '
              'HTTP ${response.statusCode}: ${response.body}',
        );
      }

      if (response.bodyBytes.isEmpty) {
        throw Exception('File Excel hasil export kosong.');
      }

      final now = DateTime.now();
      final String tanggal =
          '${now.year}-'
          '${now.month.toString().padLeft(2, '0')}-'
          '${now.day.toString().padLeft(2, '0')}';

      final String waktu =
          '${now.hour.toString().padLeft(2, '0')}-'
          '${now.minute.toString().padLeft(2, '0')}-'
          '${now.second.toString().padLeft(2, '0')}';

      final String fileName = 'Daftar_Alat_Lemari_Basment2_${tanggal}_$waktu.xlsx';
      final Directory directory = Directory('/storage/emulated/0/Download');

      if (!await directory.exists()) {
        await directory.create(
          recursive: true,
        );
      }


      final String filePath = '${directory.path}/$fileName';
      final File file = File(filePath);

      await file.writeAsBytes(
        response.bodyBytes,
        flush: true,
      );

      if (!await file.exists()) {
        throw Exception(
          'File Excel gagal dibuat.',
        );
      }

      final int fileSize = await file.length();
      if (fileSize <= 0) {
        throw Exception(
          'File Excel yang dibuat kosong.',
        );
      }

      if (shareFile) {
        await Share.shareXFiles(
          [
            XFile(file.path),
          ],
          text: 'Database Google Sheets',
        );
      }

      return file.path;
    } catch (e) {
      print('======================================');
      print('GOOGLE SHEETS EXPORT ERROR');
      print('ERROR : $e');
      print('======================================');
      rethrow;

    } finally {
      client?.close();
    }
  }
}