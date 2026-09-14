import 'package:appsenginventory/MenuPages/navigationmenu.dart';
import 'package:appsenginventory/Reporting/reportingfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'reportingbuttons.dart';
import 'reportingwrapper.dart';

class ReportingBarangPages extends StatefulWidget {

  const ReportingBarangPages({
    super.key,
  });

  @override
  State<ReportingBarangPages> createState() =>
      _ReportingBarangPagesState();
}

class _ReportingBarangPagesState
    extends State<ReportingBarangPages> {

  String selectedJenisLaporan = 'Barang Masuk';
  String selectedPeriode = 'Bulan Ini';
  DateTime selectedDate = DateTime.now();
  ReportingResult? reportingResult;
  bool isLoading = false;


  Future<void> showReporting() async {

    setState(() {
      isLoading = true;
      reportingResult = null;
    });

    try {

      final result = await ReportingWrapper.getReporting(
        jenisLaporan: selectedJenisLaporan,
        periode: selectedPeriode,
        tanggal: selectedDate,
      );

      if (!mounted) {
        return;
      }

      setState(() {
        reportingResult = result;
        isLoading = false;
      });

    } catch (e) {

      if (!mounted) {
        return;
      }

      setState(() {
        isLoading =
        false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content:
          Text('Gagal mengambil data: $e'),
        ),
      );
    }
  }

  String formatNumber(double value,) {
    if (value == value.toInt()) {
      return value.toInt().toString();
    }
    return value.toStringAsFixed(2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'LAPORAN',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
        backgroundColor: const Color(0xff17346E),
      ),
      backgroundColor: const Color(0xffF5F6F8),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 30),

            ReportingTypeField(
              value: selectedJenisLaporan,
              onChanged: (value) {
                if (value == null) {
                  return;
                }

                setState(() {
                  selectedJenisLaporan = value;
                  reportingResult = null;
                });
              },
            ),

            const SizedBox(height: 10),

            ReportingPeriodField(
              value: selectedPeriode,
              onChanged: (value) {
                if (value == null) {
                  return;
                }

                setState(() {
                  selectedPeriode = value;
                  reportingResult = null;
                });
              },
            ),

            const SizedBox(height: 10),

            ReportingDateField(
              label: 'Tanggal',
              value: selectedDate,
              onChanged: (value) {
                setState(() {
                  selectedDate = value;
                  reportingResult = null;
                });
              },
            ),

            const SizedBox(height: 10),

            ReportingShowButton(
              onPressed: showReporting,
            ),

            const SizedBox(height: 15),

            if (isLoading)
              const Center(
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: CircularProgressIndicator(),
                ),
              ),

            if (!isLoading && reportingResult != null)
              _buildReporting(),

            const SizedBox(height: 15),

            if (reportingResult != null)
              Row(
                children: [
                  ReportingExportExcelButton(
                    onPressed: () {},
                  ),

                  const SizedBox(width: 8),

                 const ReportingExportPdfButton(
                    //onPressed: () {},
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildReporting() {

    final result = reportingResult!;

    final String labelBarang = selectedJenisLaporan == 'Barang Keluar'
        ? 'BARANG KELUAR'
        : 'BARANG MASUK';

    return Column(

      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: _summaryCard(
                icon: Icons.receipt_long,
                title: 'TRANSAKSI',
                value: result.totalTransaksi.toString(),
              ),
            ),

            const SizedBox(width: 8),

            Expanded(
              child: _summaryCard(
                icon: Icons.inventory_2,
                title: labelBarang,
                value: result.totalTransaksi.toString(),
              ),
            ),

            const SizedBox(width: 8),

            Expanded(
              child: _summaryCard(
                icon: Icons.storage,
                title: 'TOTAL JUMLAH',
                value: formatNumber(
                  result.totalStock,
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: 15),

        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(
            vertical: 11,
            horizontal: 10,
          ),

          decoration: BoxDecoration(
            color: const Color(0xff2457A6),
            borderRadius: BorderRadius.circular(5),
          ),

          child: Row(
            children: [
              const Expanded(
                flex: 3,
                child: Text('PERIODE',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              const Expanded(
                flex: 2,
                child: Text('TRANSAKSI',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              Expanded(
                flex: 2,
                child: Text(
                  labelBarang,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              const Expanded(
                flex: 2,
                child: Text('TOTAL JUMLAH',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 5),

        if (result.summaries.isEmpty)

          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
              border: Border.all(
                color: Colors.grey.shade300,
              ),
            ),
            child: const Center(
              child: Text(
                'Tidak ada data pada periode yang dipilih.',
                style: TextStyle(
                  fontSize: 11,
                  color: Colors.grey,
                ),
              ),
            ),
          )

        else
          ...result.summaries.map((item) {
              return Container(
                width: double.infinity,
                margin: const EdgeInsets.only(
                  bottom: 5,
                ),
                padding: const EdgeInsets.symmetric(
                  vertical: 11,
                  horizontal: 10,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(
                    color: Colors.grey.shade300,
                  ),
                ),
                child: Row(
                  children: [

                    Expanded(
                      flex: 3,
                      child: Text(
                        item.periode,
                        style: const TextStyle(
                          fontSize: 11,
                        ),
                      ),
                    ),

                    Expanded(
                      flex: 2,
                      child: Text(
                        item.jumlahTransaksi.toString(),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 11,
                        ),
                      ),
                    ),


                    Expanded(
                      flex: 2,
                      child: Text(
                        item.jumlahTransaksi.toString(),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 11,
                        ),
                      ),
                    ),

                    Expanded(
                      flex: 2,
                      child: Text(
                        formatNumber(item.totalStock),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 11,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
      ],
    );
  }


  Widget _summaryCard({
    required IconData icon,
    required String title,
    required String value,

  }) {

    return Container(

      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(
          color: Colors.grey.shade300,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                icon,
                size: 15,
                color: const Color(0xff2457A6),
              ),
              const SizedBox(width: 5),

              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 8,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          Text(
            value,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}