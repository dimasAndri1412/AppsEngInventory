import 'package:appsenginventory/Services/gsheetsinsertPictureBarangMasuk.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'addpictbuttons.dart';
import 'addpictfields.dart';

class AddPictDetailBarangWrapper extends StatefulWidget {
  final Map<String, String> barang;
  final Function(String newUrl) onImageUpdated;

  const AddPictDetailBarangWrapper({
    super.key,
    required this.barang,
    required this.onImageUpdated,
  });

  @override
  State<AddPictDetailBarangWrapper> createState() => _AddPictDetailBarangWrapperState();
}

class _AddPictDetailBarangWrapperState extends State<AddPictDetailBarangWrapper> {
  XFile? _selectedImage;
  bool _isUploading = false;

  final GSheetsPictureBarangMasukLemari _uploader = GSheetsPictureBarangMasukLemari();

  // 1. Hanya memilih gambar untuk pratinjau
  Future<void> _pickImage(ImageSource source) async {
    if (_isUploading) return;

    try {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(source: source, imageQuality: 80);

      if (image == null || !mounted) return;

      setState(() {
        _selectedImage = image;
      });
    } catch (e) {
      debugPrint('Gagal memilih gambar: $e');
      Get.snackbar(
        'Gagal',
        'Tidak dapat mengambil gambar: $e',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  // 2. Mengunggah & menyimpan foto yang sudah dipilih saat tombol Simpan ditekan
  Future<void> _uploadAndSaveImage() async {
    if (_selectedImage == null || _isUploading) return;

    setState(() {
      _isUploading = true;
    });

    try {
      final now = DateTime.now();
      final String tanggal = "${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}";
      final String waktu = "${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}:${now.second.toString().padLeft(2, '0')}";

      // Masukkan parameter ke service uploader
      _uploader.revampTanggalPictureBarangMasuk = tanggal;
      _uploader.revampWaktuPictureBarangMasuk = waktu;
      _uploader.revampPosisiLemariBarangMasuk = widget.barang["Lokasi"] ?? 'Lemari 1';
      _uploader.revampKodePictureBarangMasuk = widget.barang["Kode Barang"] ?? '';
      _uploader.revampNamaPictureBarangMasuk = widget.barang["Nama Barang"] ?? '';
      _uploader.revampPathPictureBarangMasuk = _selectedImage!.path;

      // Panggil metode gabungan uploader
      final String downloadUrl = await _uploader.revampUploaderMethodCombined();

      // Callback ke parent/page bahwa URL foto berhasil diperbarui
      widget.onImageUpdated(downloadUrl);

      if (mounted) {
        setState(() {
          _selectedImage = null; // Bersihkan pratinjau lokal karena URL baru sudah tersimpan
        });
      }

      Get.snackbar(
        'Berhasil',
        'Foto berhasil diperbarui dan diunggah!',
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } catch (e) {
      debugPrint('Gagal upload: $e');
      Get.snackbar(
        'Gagal',
        'Terjadi kesalahan: $e',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      if (mounted) {
        setState(() {
          _isUploading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Field sekarang hanya untuk memilih & pratinjau foto
        AddPictDetailBarangField(
          selectedImage: _selectedImage,
          imageUrl: widget.barang["Url Foto"],
          isUploading: _isUploading,
          onCameraTap: () => _pickImage(ImageSource.camera),
          onGalleryTap: () => _pickImage(ImageSource.gallery),
        ),
        const SizedBox(width: 15),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.barang["Nama Barang"] ?? "",
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                widget.barang["Kode Barang"] ?? "",
                style: TextStyle(color: Colors.grey.shade600),
              ),
              const SizedBox(height: 8),
              // Button aktif jika _selectedImage sudah dipilih, dan langsung menyimpan saat ditekan
              AddPictDetailBarangButton(
                onPressed: _uploadAndSaveImage,
                isUploading: _isUploading,
                canSave: _selectedImage != null,
              ),
            ],
          ),
        ),
      ],
    );
  }
}