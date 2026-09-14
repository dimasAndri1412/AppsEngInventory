import 'package:appsenginventory/SendingEmail/sendingemailfunctions.dart';
import 'package:flutter/material.dart';
import '../Services/gsheetsexportpdfcontorller.dart';

class ReportingShowButton extends StatelessWidget {
  final VoidCallback onPressed;

  const ReportingShowButton({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 38,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xff2457A6),
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        child: const Text(
          'TAMPILKAN',
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}


class ReportingExportExcelButton extends StatefulWidget {
  final VoidCallback onPressed;

  const ReportingExportExcelButton({
    super.key,
    required this.onPressed,
  });

  @override
  State<ReportingExportExcelButton> createState() =>
      _ReportingExportExcelButtonState();
}

class _ReportingExportExcelButtonState extends State<ReportingExportExcelButton> {

  bool isLoading = false;

  Future<void> _sendingExcel() async {

    if (isLoading) {
      return;
    }

    setState(() {
      isLoading = true;
    });


    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) {
        return  Center(
          child: Material(
            color: Colors.transparent,
            child: Container(
              width: 190,
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 20,
              ),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              child: const Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: 35,
                    height: 35,
                    child: CircularProgressIndicator(
                      strokeWidth: 3,
                      valueColor:
                      AlwaysStoppedAnimation<Color>(
                        Color(0xff2457A6),
                      ),
                    ),
                  ),
                  SizedBox(height: 15),
                  Text(
                    'Mengirim laporan...',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Mohon tunggu',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
    bool result = false;

    try {
      result = await const Sendingemailfunctions().sendingEmailExportExcel();
    } catch (e) {
      result = false;
    }

    if (mounted) {
      Navigator.of(context).pop();
    }

    if (mounted) {
      setState(() {
        isLoading = false;
      });
    }

    if (!mounted) {
      return;
    }

    if (result == true) {

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Laporan berhasil dikirim ke Email!',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: Colors.green,
        ),
      );

    } else {

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Laporan gagal dikirim ke Email!',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: Colors.red,
        ),
      );

    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox(
        height: 38,
        child: ElevatedButton.icon(
          onPressed: isLoading
              ? null
              : _sendingExcel,
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xff159447),
            foregroundColor: Colors.white,
            disabledBackgroundColor: Colors.grey,
            disabledForegroundColor: Colors.white,
            elevation: 0,
            padding: const EdgeInsets.symmetric(
              horizontal: 8,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          icon: isLoading ? const SizedBox(
            width: 15,
            height: 15,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor:
              AlwaysStoppedAnimation<Color>(
                Colors.white,
              ),
            ),
          ) : const Icon(
            Icons.table_chart,
            size: 17,
          ),

          label: Text( isLoading
                ? 'MENGIRIM...'
                : 'EXPORT EXCEL',
            style: const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}


class ReportingExportPdfButton extends StatefulWidget {
  const ReportingExportPdfButton({
    super.key,
  });

  @override
  State<ReportingExportPdfButton> createState() =>
      _ReportingExportPdfButtonState();
}

class _ReportingExportPdfButtonState
    extends State<ReportingExportPdfButton> {

  bool isLoading = false;

  // ==========================================================
  // EXPORT PDF
  // ==========================================================

  Future<void> _exportPdf() async {

    // ========================================================
    // CEGAH DOUBLE CLICK
    // ========================================================

    if (isLoading) {
      return;
    }

    setState(() {
      isLoading = true;
    });

    // ========================================================
    // TAMPILKAN LOADING
    // ========================================================

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) {

        return Center(
          child: Material(
            color: Colors.transparent,

            child: Container(
              width: 190,

              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 20,
              ),

              decoration: const BoxDecoration(
                color: Colors.white,

                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),

              child: const Column(
                mainAxisSize: MainAxisSize.min,

                children: [

                  // ==================================================
                  // LOADING
                  // ==================================================

                  SizedBox(
                    width: 35,
                    height: 35,

                    child: CircularProgressIndicator(
                      strokeWidth: 3,

                      valueColor:
                      AlwaysStoppedAnimation<Color>(
                        Color(0xff2457A6),
                      ),
                    ),
                  ),

                  SizedBox(height: 15),

                  // ==================================================
                  // TEXT UTAMA
                  // ==================================================

                  Text(
                    'Membuat laporan PDF...',
                    textAlign: TextAlign.center,

                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),

                  SizedBox(height: 5),

                  // ==================================================
                  // TEXT KETERANGAN
                  // ==================================================

                  Text(
                    'Mohon tunggu',
                    textAlign: TextAlign.center,

                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );

    bool result = false;

    // ========================================================
    // EXPORT
    // ========================================================

    try {

      result = await Sendingemailfunctions().sendingEmailExportPDF();

    } catch (e) {

      debugPrint(
        'EXPORT PDF ERROR: $e',
      );

      result = false;
    }

    // ========================================================
    // TUTUP LOADING
    // ========================================================

    if (mounted) {

      Navigator.of(context).pop();
    }

    // ========================================================
    // RESET LOADING
    // ========================================================

    if (mounted) {

      setState(() {
        isLoading = false;
      });
    }

    // ========================================================
    // CEK MOUNTED
    // ========================================================

    if (!mounted) {
      return;
    }

    // ========================================================
    // BERHASIL
    // ========================================================

    if (result == true) {

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'PDF berhasil dibuat!',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),

          backgroundColor: Colors.green,
        ),
      );

    }

    // ========================================================
    // GAGAL
    // ========================================================

    else {

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'PDF gagal dibuat!',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),

          backgroundColor: Colors.red,
        ),
      );
    }
  }

  // ==========================================================
  // BUILD
  // ==========================================================

  @override
  Widget build(
      BuildContext context,
      ) {

    return Expanded(
      child: SizedBox(
        height: 38,

        child: ElevatedButton.icon(

          onPressed: isLoading
              ? null
              : _exportPdf,

          style: ElevatedButton.styleFrom(

            backgroundColor:
            const Color(0xffdc2636),

            foregroundColor:
            Colors.white,

            disabledBackgroundColor:
            Colors.grey,

            disabledForegroundColor:
            Colors.white,

            elevation: 0,

            padding:
            const EdgeInsets.symmetric(
              horizontal: 8,
            ),

            shape:
            RoundedRectangleBorder(
              borderRadius:
              BorderRadius.circular(5),
            ),
          ),

          // ==================================================
          // ICON
          // ==================================================

          icon: isLoading

              ? const SizedBox(
            width: 15,
            height: 15,

            child:
            CircularProgressIndicator(
              strokeWidth: 2,

              valueColor:
              AlwaysStoppedAnimation<Color>(
                Colors.white,
              ),
            ),
          )

              : const Icon(
            Icons.picture_as_pdf,
            size: 17,
          ),

          // ==================================================
          // LABEL
          // ==================================================

          label: Text(

            isLoading
                ? 'MEMBUAT PDF...'
                : 'EXPORT PDF',

            style: const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}