import 'package:flutter/material.dart';

class AddPictDetailBarangButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final bool isUploading;
  final bool canSave;

  const AddPictDetailBarangButton({
    super.key,
    required this.onPressed,
    required this.isUploading,
    this.canSave = true,
  });

  @override
  Widget build(BuildContext context) {
    final bool isEnabled = !isUploading && canSave && onPressed != null;

    return OutlinedButton.icon(
      onPressed: isEnabled ? onPressed : null,
      icon: isUploading ? const SizedBox(
        width: 14,
        height: 14,
        child: CircularProgressIndicator(strokeWidth: 2),
      )
          : const Icon(Icons.save, size: 14),
      label: Text(
          isUploading ? 'Menyimpan...' : 'Simpan Foto'
      ),
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
        textStyle: const TextStyle(fontSize: 12),
      ),
    );
  }
}