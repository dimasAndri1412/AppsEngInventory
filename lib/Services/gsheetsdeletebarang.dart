import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis/drive/v3.dart' as drive;
import 'package:http/http.dart' as http;
import 'package:gsheets/gsheets.dart';

import 'gsheetsservices.dart';

Future<bool> deleteBarangBerdasarkanKodeDanLemari({
  required String kodeBarang,
  required String lemari,
}) async {
  try {
    Worksheet? worksheetLemari;
    Worksheet? worksheetDaftarStock;
    Worksheet? worksheetPicture;

    final String cleanLemari = lemari.trim().toLowerCase();

    switch (cleanLemari) {
      case "lemari1":
        worksheetLemari = GSheetsServicesEmployees.sheetsLemari1;
        worksheetDaftarStock = GSheetsServicesEmployees.sheetDaftarStock;
        worksheetPicture = GSheetsServicesEmployees.sheetsPicture;
        break;

      case "lemari2":
        worksheetLemari = GSheetsServicesEmployees.sheetsLemari2;
        worksheetDaftarStock = GSheetsServicesEmployees.sheetDaftarStock2;
        worksheetPicture = GSheetsServicesEmployees.sheetsPicture;
        break;

      case "lemari3":
        worksheetLemari = GSheetsServicesEmployees.sheetsLemari3;
        worksheetDaftarStock = GSheetsServicesEmployees.sheetDaftarStock3;
        worksheetPicture = GSheetsServicesEmployees.sheetsPicture;
        break;

      default:
        throw Exception("Lemari tidak dikenali: $lemari");
    }

    if (worksheetLemari == null) {
      throw Exception("$lemari belum diinisialisasi.");
    }

    if (worksheetDaftarStock == null) {
      throw Exception("Worksheet Daftar Stock untuk $lemari belum diinisialisasi.");
    }

    final String kodeBarangDicari = kodeBarang.trim().toLowerCase();

    if (kodeBarangDicari.isEmpty) {
      throw Exception("Kode Barang tidak boleh kosong.");
    }

    final List<List<String>> rowsLemari = await worksheetLemari.values.allRows();

    if (rowsLemari.isEmpty || rowsLemari.length < 3) {
      debugPrint("Sheet $lemari kosong atau tidak memiliki header.");
      return false;
    }

    final List<String> headerLemari = rowsLemari[2];
    final int kodeBarangColumnIndexLemari = headerLemari.indexWhere(
          (String value) => value.trim().toLowerCase() == 'kode barang',
    );

    if (kodeBarangColumnIndexLemari == -1) {
      return false;
    }

    int targetRowIndexLemari = -1;

    for (int i = 3; i < rowsLemari.length; i++) {
      final List<String> row = rowsLemari[i];
      if (kodeBarangColumnIndexLemari >= row.length) continue;

      final String kodeDiSheet = row[kodeBarangColumnIndexLemari].trim().toLowerCase();
      if (kodeDiSheet == kodeBarangDicari) {
        targetRowIndexLemari = i;
        break;
      }
    }

    if (targetRowIndexLemari == -1) {
      return false;
    }

    final int targetGoogleSheetRowLemari = targetRowIndexLemari + 1;

    // =========================================================================
    // HAPUS FOTO DARI GOOGLE DRIVE & WORKSHEET PICTURE
    // =========================================================================
    if (worksheetPicture != null) {
      try {
        final List<List<String>> rowsPicture = await worksheetPicture.values.allRows();

        for (int i = 1; i < rowsPicture.length; i++) {
          final List<String> row = rowsPicture[i];
          if (row.length >= 6) {
            final String picLemari = row[2].trim().toLowerCase(); // PosisiLemari[cite: 1]
            final String picKode = row[3].trim().toLowerCase();     // KodeBarang[cite: 1]
            final String picUrl = row[5].trim();                   // Picture (URL)[cite: 1]

            if (picLemari == cleanLemari && picKode == kodeBarangDicari) {
              final int googleSheetRowPicture = i + 1;

              final String? fileId = _extractFileIdFromDriveUrl(picUrl);

              if (fileId != null && fileId.isNotEmpty) {
                await _deleteFileFromGoogleDrive(fileId);
              }

              await worksheetPicture.deleteRow(googleSheetRowPicture);
              debugPrint("FOTO & DATA PICTURE BERHASIL DIHAPUS DARI DRIVE DAN SHEETS.");
              break;
            }
          }
        }
      } catch (e) {
        debugPrint("GAGAL MENGHAPUS FOTO/PICTURE: $e");
      }
    }

    // =========================================================================
    // PROSES HAPUS DAFTAR STOCK & LEMARI UTAMA
    // =========================================================================
    final List<List<String>> rowsDaftarStock = await worksheetDaftarStock.values.allRows();

    int targetRowIndexDaftarStock = -1;
    int kodeBarangColumnIndexDaftarStock = -1;

    if (rowsDaftarStock.isEmpty) {
      await worksheetLemari.deleteRow(targetGoogleSheetRowLemari);
      return true;
    }

    for (int rowIndex = 0; rowIndex < rowsDaftarStock.length; rowIndex++) {
      final List<String> row = rowsDaftarStock[rowIndex];
      for (int columnIndex = 0; columnIndex < row.length; columnIndex++) {
        final String value = row[columnIndex].trim().toLowerCase();
        if (value == 'kode barang') {
          kodeBarangColumnIndexDaftarStock = columnIndex;
          break;
        }
      }
      if (kodeBarangColumnIndexDaftarStock != -1) break;
    }

    if (kodeBarangColumnIndexDaftarStock != -1) {
      for (int i = 0; i < rowsDaftarStock.length; i++) {
        final List<String> row = rowsDaftarStock[i];
        if (kodeBarangColumnIndexDaftarStock >= row.length) continue;

        final String kodeDiSheet = row[kodeBarangColumnIndexDaftarStock].trim().toLowerCase();
        if (kodeDiSheet == kodeBarangDicari) {
          targetRowIndexDaftarStock = i;
          break;
        }
      }
    }

    int targetGoogleSheetRowDaftarStock = targetRowIndexDaftarStock != -1 ? targetRowIndexDaftarStock + 1 : -1;

    await worksheetLemari.deleteRow(targetGoogleSheetRowLemari);

    if (targetGoogleSheetRowDaftarStock != -1) {
      await worksheetDaftarStock.deleteRow(targetGoogleSheetRowDaftarStock);
      debugPrint("Daftar Stock : 1 ROW DIHAPUS");
    } else {
      debugPrint("Daftar Stock : KODE TIDAK DITEMUKAN");
    }

    return true;
  } catch (e, stackTrace) {
    debugPrint("ERROR : $e");
    debugPrint("STACK : $stackTrace");
    return false;
  }
}

/// Helper untuk mengekstrak File ID dari berbagai format URL Google Drive
String? _extractFileIdFromDriveUrl(String url) {
  if (url.isEmpty) return null;

  final RegExp regExp = RegExp(r'/d/([a-zA-Z0-9_-]+)');
  final match = regExp.firstMatch(url);
  if (match != null && match.groupCount >= 1) {
    return match.group(1);
  }

  final RegExp idRegExp = RegExp(r'id=([a-zA-Z0-9_-]+)');
  final idMatch = idRegExp.firstMatch(url);
  if (idMatch != null && idMatch.groupCount >= 1) {
    return idMatch.group(1);
  }

  return null;
}

/// Helper untuk melakukan panggilan API Google Drive menghapus file
Future<void> _deleteFileFromGoogleDrive(String fileId) async {
  http.Client? client;
  try {
    // Instance GoogleSignIn tanpa modifier static yang ilegal di luar class
    final GoogleSignIn googleSignIn = GoogleSignIn(
      scopes: <String>[drive.DriveApi.driveFileScope],
    );

    final GoogleSignInAccount? account = await googleSignIn.signInSilently() ?? await googleSignIn.signIn();

    if (account == null) {
      debugPrint("Penghapusan Google Drive dibatalkan karena akun tidak aktif.");
      return;
    }

    final GoogleSignInAuthentication authentication = await account.authentication;
    final String? accessToken = authentication.accessToken;

    if (accessToken == null || accessToken.isEmpty) {
      debugPrint("Access token Google Drive tidak tersedia untuk menghapus file.");
      return;
    }

    client = _GoogleDriveAuthClient(accessToken);
    final drive.DriveApi driveApi = drive.DriveApi(client);

    await driveApi.files.delete(fileId);
    debugPrint("File ID: $fileId BERHASIL DIHAPUS dari Google Drive.");
  } catch (e) {
    debugPrint("Gagal menghapus file dari Google Drive: $e");
  } finally {
    client?.close();
  }
}

/// Helper Auth Client untuk Google Drive API
class _GoogleDriveAuthClient extends http.BaseClient {
  final String accessToken;
  final http.Client _inner = http.Client();

  _GoogleDriveAuthClient(this.accessToken);

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) {
    request.headers['Authorization'] = 'Bearer $accessToken';
    return _inner.send(request);
  }

  @override
  void close() {
    _inner.close();
  }
}