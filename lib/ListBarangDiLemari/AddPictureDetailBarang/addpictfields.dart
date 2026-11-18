import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddPictDetailBarangField extends StatelessWidget {
  final XFile? selectedImage;
  final String? imageUrl;
  final bool isUploading;
  final VoidCallback onCameraTap;
  final VoidCallback onGalleryTap;

  const AddPictDetailBarangField({
    super.key,
    required this.selectedImage,
    required this.imageUrl,
    required this.isUploading,
    required this.onCameraTap,
    required this.onGalleryTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 90,
      height: 90,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: isUploading ? null : () => _showSourceBottomSheet(context),
            child: _buildContent(),
          ),
        ),
      ),
    );
  }

  Widget _buildContent() {
    if (isUploading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (selectedImage != null) {
      return Image.file(
        File(selectedImage!.path),
        width: double.infinity,
        height: double.infinity,
        fit: BoxFit.cover,
      );
    }

    if (imageUrl != null && imageUrl!.isNotEmpty) {
      return Image.network(
        imageUrl!,
        width: double.infinity,
        height: double.infinity,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return const Center(
            child: Icon(Icons.inventory_2, size: 40, color: Colors.grey),
          );
        },
        loadingBuilder: (context, child, progress) {
          if (progress == null) return child;
          return const Center(child: CircularProgressIndicator());
        },
      );
    }

    return const Center(
      child: Icon(Icons.inventory_2, size: 40, color: Colors.grey),
    );
  }

  void _showSourceBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.camera_alt, color: Color(0xff17346E)),
                title: const Text('Ambil dari Kamera'),
                onTap: () {
                  Navigator.pop(context);
                  onCameraTap();
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library, color: Color(0xff17346E)),
                title: const Text('Pilih dari Galeri'),
                onTap: () {
                  Navigator.pop(context);
                  onGalleryTap();
                },
              ),
            ],
          ),
        );
      },
    );
  }
}