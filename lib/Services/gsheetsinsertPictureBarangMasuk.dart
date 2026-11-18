import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis/drive/v3.dart' as drive;
import 'package:http/http.dart' as http;

import 'gsheetsservices.dart';

class GSheetsPictureBarangMasukLemari {
  String? revampTanggalPictureBarangMasuk;
  String? revampWaktuPictureBarangMasuk;
  String? revampPosisiLemariBarangMasuk;
  String? revampKodePictureBarangMasuk;
  String? revampNamaPictureBarangMasuk;
  String? revampPathPictureBarangMasuk;
  String? revampUrlPictureBarangMasuk;

  // Flag untuk mencegah double execution / double submit
  bool _isProcessing = false;

  static const String folderId = '12ut-oH8TtGGdvpZoINblZ9D72qe6K51S';

  static final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: <String>[
      drive.DriveApi.driveFileScope,
    ],
  );

  /// Fungsi untuk mengunggah foto ke Google Drive
  Future<String> revampUploadPictureBarangMasuk() async {
    final String kodeBarang = revampKodePictureBarangMasuk?.trim() ?? '';
    final String fotoPath = revampPathPictureBarangMasuk?.trim() ?? '';

    if (kodeBarang.isEmpty) {
      throw Exception('Kode barang tidak boleh kosong.');
    }

    if (fotoPath.isEmpty) {
      throw Exception('Foto barang belum dipilih.');
    }

    final File fotoFile = File(fotoPath);

    if (!await fotoFile.exists()) {
      throw Exception('File foto tidak ditemukan: $fotoPath');
    }

    final String extension = fotoPath.contains('.')
        ? fotoPath.split('.').last.toLowerCase()
        : 'jpg';

    final String safeKode = kodeBarang.replaceAll(
      RegExp(r'[^a-zA-Z0-9_-]'),
      '_',
    );

    final String fileName =
        '${safeKode}_${DateTime.now().microsecondsSinceEpoch}.$extension';

    final String mimeType;

    switch (extension) {
      case 'png':
        mimeType = 'image/png';
        break;
      case 'webp':
        mimeType = 'image/webp';
        break;
      case 'heic':
        mimeType = 'image/heic';
        break;
      default:
        mimeType = 'image/jpeg';
    }

    http.Client? client;

    try {
      debugPrint('MEMULAI LOGIN GOOGLE DRIVE');

      final GoogleSignInAccount? account = await _googleSignIn.signIn();

      if (account == null) {
        throw Exception('Login Google dibatalkan. Foto belum diunggah.');
      }

      debugPrint('LOGIN GOOGLE BERHASIL: ${account.email}');

      final GoogleSignInAuthentication authentication =
      await account.authentication;

      final String? accessToken = authentication.accessToken;

      if (accessToken == null || accessToken.isEmpty) {
        throw Exception(
          'Access token Google tidak tersedia. Periksa konfigurasi OAuth Android.',
        );
      }

      client = _GoogleDriveAuthClient(accessToken);
      final drive.DriveApi driveApi = drive.DriveApi(client);

      final drive.File metadata = drive.File()
        ..name = fileName
        ..mimeType = mimeType
        ..parents = <String>[folderId];

      final drive.File uploadedFile = await driveApi.files.create(
        metadata,
        uploadMedia: drive.Media(
          fotoFile.openRead(),
          await fotoFile.length(),
          contentType: mimeType,
        ),
        $fields: 'id,name,mimeType,webViewLink',
      );

      final String? fileId = uploadedFile.id;

      if (fileId == null || fileId.isEmpty) {
        throw Exception('Google Drive tidak mengembalikan ID file.');
      }

      revampUrlPictureBarangMasuk = uploadedFile.webViewLink ?? '';

      debugPrint('UPLOAD FOTO BERHASIL');
      debugPrint('NAMA FILE: ${uploadedFile.name}');
      debugPrint('ID FILE: $fileId');
      debugPrint('URL FOTO: $revampUrlPictureBarangMasuk');

      return revampUrlPictureBarangMasuk!;
    } catch (e, stackTrace) {
      debugPrint('ERROR UPLOAD FOTO DRIVE: $e');
      debugPrint('$stackTrace');
      rethrow;
    } finally {
      client?.close();
    }
  }

  /// Fungsi utama untuk upload foto (jika belum ada) dan simpan ke Google Sheets
  Future<void> revampInsertPictureBarangMasukLemari1() async {
    // Mencegah eksekusi ganda jika tombol diklik berkali-kali secara cepat
    if (_isProcessing) {
      debugPrint('Proses simpan sedang berjalan, mengabaikan klik ganda.');
      return;
    }

    _isProcessing = true;

    try {
      await GSheetsServicesEmployees.init();

      final pictureSheet = GSheetsServicesEmployees.sheetsPicture;

      if (pictureSheet == null) {
        throw Exception(
          'Worksheet foto tidak ditemukan. Periksa konfigurasi GsheetsConfigs.workSheetsPicture.',
        );
      }

      final String tanggal = revampTanggalPictureBarangMasuk?.trim() ?? '';
      final String waktu = revampWaktuPictureBarangMasuk?.trim() ?? '';
      final String lemari = revampPosisiLemariBarangMasuk?.trim() ?? '';
      final String kode = revampKodePictureBarangMasuk?.trim() ?? '';
      final String nama = revampNamaPictureBarangMasuk?.trim() ?? '';

      if (tanggal.isEmpty ||
          waktu.isEmpty ||
          lemari.isEmpty ||
          kode.isEmpty ||
          nama.isEmpty) {
        throw Exception(
          'Tanggal, waktu, lemari, kode, dan nama barang wajib diisi.',
        );
      }

      if ((revampPathPictureBarangMasuk ?? '').trim().isEmpty) {
        throw Exception('Foto barang belum dipilih.');
      }

      // Cek apakah urlFoto sudah ada. Jika belum, lakukan upload sekali saja.
      final String urlFoto =
      (revampUrlPictureBarangMasuk ?? '').trim().isNotEmpty
          ? revampUrlPictureBarangMasuk!.trim()
          : await revampUploadPictureBarangMasuk();

      final List<String> row = <String>[
        tanggal,
        waktu,
        lemari,
        kode,
        nama,
        urlFoto,
      ];

      await pictureSheet.values.appendRow(row);

      debugPrint('URL FOTO BERHASIL DISIMPAN: $kode');
      debugPrint('DATA FOTO BERHASIL DITAMBAHKAN KE GOOGLE SHEETS');

      // RESET STATE SETELAH BERHASIL (Mencegah duplikasi data jika objek dipakai lagi)
      _resetData();

    } catch (e, stackTrace) {
      debugPrint('ERROR SIMPAN FOTO BARANG MASUK: $e');
      debugPrint('$stackTrace');
      rethrow;
    } finally {
      // Selalu kembalikan flag _isProcessing menjadi false baik sukses maupun gagal
      _isProcessing = false;
    }
  }

  Future<String> revampUploaderMethodCombined() async {
    final String url = await revampUploadPictureBarangMasuk();
    await revampInsertPictureBarangMasukLemari1();
    return url;
  }

  /// Helper untuk mereset variabel setelah sukses
  void _resetData() {
    revampTanggalPictureBarangMasuk = null;
    revampWaktuPictureBarangMasuk = null;
    revampPosisiLemariBarangMasuk = null;
    revampKodePictureBarangMasuk = null;
    revampNamaPictureBarangMasuk = null;
    revampPathPictureBarangMasuk = null;
    revampUrlPictureBarangMasuk = null;
  }
}

class _GoogleDriveAuthClient extends http.BaseClient {
  final String accessToken;
  final http.Client _inner = http.Client();

  _GoogleDriveAuthClient(this.accessToken);

  @override
  Future<http.StreamedResponse> send(
      http.BaseRequest request,
      ) {
    request.headers['Authorization'] = 'Bearer $accessToken';
    return _inner.send(request);
  }

  @override
  void close() {
    _inner.close();
  }
}