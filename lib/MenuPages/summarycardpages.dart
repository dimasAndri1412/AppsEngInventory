import 'package:appsenginventory/Services/gsheetscardcontrollers.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../Controller/key.dart';
import 'summarycard.dart';

class SummaryCardPages extends StatefulWidget {
  final String lemari;

  const SummaryCardPages({
    super.key,
    required this.lemari,
  });

  @override
  State<SummaryCardPages> createState() => _SummaryCardPagesState();
}

class _SummaryCardPagesState extends State<SummaryCardPages> {
  bool isLoading = true;

  List<Map<String, dynamic>> dashboardData = [];

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  void didUpdateWidget(covariant SummaryCardPages oldWidget,) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.lemari != widget.lemari) {
      loadData();
    }
  }

  Future<void> loadData() async {
    setState(() {
      isLoading = true;
    });

    try {
      final data = await getDataDashboardStok();

      if (!mounted) return;

      setState(() {
        dashboardData = data;
        isLoading = false;
      });

      await loadDashboardStokToController();
    } catch (e) {
      print('Error load summary: $e');

      if (!mounted) return;

      setState(() {
        dashboardData = [];
        isLoading = false;
      });
    }
  }

  double getJumlah(String nama) {
    try {
      String targetLemari = '';

      if (widget.lemari.toLowerCase() == 'lemari1') {
        targetLemari = 'summary lemari 1';
      } else if (widget.lemari.toLowerCase() == 'lemari2') {
        targetLemari = 'summary lemari 2';
      } else if (widget.lemari.toLowerCase() == 'lemari3') {
        targetLemari = 'summary lemari 3';
      }

      final result = dashboardData.where((item) {
        final lemari = item['lemari']?.toString().trim().toLowerCase() ?? '';
        final namaData = item['nama']?.toString().trim().toLowerCase() ?? '';
        return lemari == targetLemari &&
            namaData == nama.toLowerCase();
      }).toList();

      if (result.isEmpty) {
        print(
          'DATA TIDAK DITEMUKAN -> ''$targetLemari | $nama',
        );
        return 0;
      }
      final value = result.first['jumlah']?.toString().trim() ?? '0';

      print(
        'DATA CHART -> '
            '$targetLemari | '
            '$nama | '
            '$value',
      );


      final cleanValue = value
          .replaceAll(',', '')
          .replaceAll('.', '');

      return double.tryParse(cleanValue) ?? 0;
    } catch (e) {
      print('Error getJumlah: $e');
      return 0;
    }
  }

  String getControllerValue(String nama) {
    final lemari = widget.lemari.toLowerCase();

    if (lemari == 'lemari1') {
      if (nama == 'jenis') {
        return jumlahJenisBarangLemari1Controller.text;
      }

      if (nama == 'awal') {
        return totalStokAwalLemari1Controller.text;
      }

      if (nama == 'masuk') {
        return totalBarangMasukLemari1Controller.text;
      }

      if (nama == 'keluar') {
        return totalBarangKeluarLemari1Controller.text;
      }

      if (nama == 'saatIni') {
        return totalStokSaatIniLemari1Controller.text;
      }

      if (nama == 'kurang') {
        return jumlahBarangKurangLemari1Controller.text;
      }
    }

    if (lemari == 'lemari2') {
      if (nama == 'jenis') {
        return jumlahJenisBarangLemari2Controller.text;
      }

      if (nama == 'awal') {
        return totalStokAwalLemari2Controller.text;
      }

      if (nama == 'masuk') {
        return totalBarangMasukLemari2Controller.text;
      }

      if (nama == 'keluar') {
        return totalBarangKeluarLemari2Controller.text;
      }

      if (nama == 'saatIni') {
        return totalStokSaatIniLemari2Controller.text;
      }

      if (nama == 'kurang') {
        return jumlahBarangKurangLemari2Controller.text;
      }
    }

    if (lemari == 'lemari3') {
      if (nama == 'jenis') {
        return jumlahJenisBarangLemari3Controller.text;
      }

      if (nama == 'awal') {
        return totalStokAwalLemari3Controller.text;
      }

      if (nama == 'masuk') {
        return totalBarangMasukLemari3Controller.text;
      }

      if (nama == 'keluar') {
        return totalBarangKeluarLemari3Controller.text;
      }

      if (nama == 'saatIni') {
        return totalStokSaatIniLemari3Controller.text;
      }

      if (nama == 'kurang') {
        return jumlahBarangKurangLemari3Controller.text;
      }
    }
    return '0';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        Text(
          "Summary ${widget.lemari}",
          style: const TextStyle(
            color: Colors.black26,
            fontWeight: FontWeight.bold,
            fontSize: 30,
          ),
        ),

        const SizedBox(height: 20),

        if (isLoading)

          const Padding(
            padding: EdgeInsets.all(30),
            child: CircularProgressIndicator(),
          )

        else ...[

          GridView.count(
            crossAxisCount: 2,
            crossAxisSpacing: 15,
            mainAxisSpacing: 15,
            childAspectRatio: 1.5,
            shrinkWrap: true,
            physics:
            const NeverScrollableScrollPhysics(),

            children: [

              SummaryCard(
                title: "Total Barang",
                value: getControllerValue('jenis'),
                unit: "Item",
                icon: Icons.inventory_2,
                color: Colors.blue,
              ),

              SummaryCard(
                title: "Total Stock Awal",
                value: getControllerValue('awal'),
                unit: "Item",
                icon: Icons.countertops,
                color: Colors.blue,
              ),

              SummaryCard(
                title: "Total Barang Masuk",
                value: getControllerValue('masuk'),
                unit: "Pcs",
                icon: Icons.login_sharp,
                color: Colors.green,
              ),

              SummaryCard(
                title: "Total Barang Keluar",
                value: getControllerValue('keluar'),
                unit: "Pcs",
                icon: Icons.logout_sharp,
                color: Colors.red,
              ),

              SummaryCard(
                title: "Stock Saat Ini",
                value: getControllerValue('saatIni'),
                unit: "Pcs",
                icon: Icons.countertops,
                color: Colors.blue,
              ),

              SummaryCard(
                title: "Jumlah Barang Kurang",
                value: getControllerValue('kurang'),
                unit: "Pcs",
                icon: Icons.all_inbox,
                color: Colors.red,
              ),
            ],
          ),

          const SizedBox(height: 20),

          _buildChart(),
        ],
      ],
    );
  }

  Widget _buildChart() {
    return Container(
      height: 300,
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),

      child: Column(
        crossAxisAlignment:
        CrossAxisAlignment.start,
        children: [

          Text(
            'Stok ${widget.lemari}',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xff17346E),
            ),
          ),

          const SizedBox(height: 4),

          const Text(
            'Informasi stok barang',
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey,
            ),
          ),

          const SizedBox(height: 15),

          Wrap(
            spacing: 15,
            runSpacing: 8,
            children: [
              _buildLegend(
                'Stok Awal',
                Colors.blue,
              ),
              _buildLegend(
                'Barang Masuk',
                Colors.green,
              ),
              _buildLegend(
                'Barang Keluar',
                Colors.orange,
              ),
              _buildLegend(
                'Stok Saat Ini',
                Colors.red,
              ),
            ],
          ),

          const SizedBox(height: 12),

          Expanded(
            child: LineChart(
              LineChartData(
                minY: 0,
                borderData: FlBorderData(
                  show: false,
                ),

                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: false,
                  horizontalInterval: _getInterval(),

                  getDrawingHorizontalLine: (value) {
                    return FlLine(
                      color: Colors.grey.withOpacity(
                        0.15,
                      ),
                      strokeWidth: 1,
                    );
                  },
                ),

                titlesData: FlTitlesData(
                  topTitles: const AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: false,
                    ),
                  ),

                  rightTitles: const AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: false,
                    ),
                  ),

                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 40,
                      interval: _getInterval(),

                      getTitlesWidget: (value, meta) {
                        return Text(
                          formatNumber(value),
                          style: const TextStyle(
                            fontSize: 10,
                            color: Colors.grey,
                          ),
                        );
                      },
                    ),
                  ),

                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 30,
                      interval: 1,
                      getTitlesWidget: (value, meta) {
                        String title = '';

                        switch (
                        value.toInt()) {
                          case 0:
                            title = 'Stok Awal';
                            break;

                          case 1:
                            title = 'Barang Masuk';
                            break;

                          case 2:
                            title = 'Barang Keluar';
                            break;

                          case 3:
                            title = 'Stok Saat Ini';
                            break;
                        }

                        return Padding(
                          padding: const EdgeInsets.only(
                            top: 6,
                          ),

                          child: Text(
                            title,
                            style: const TextStyle(
                              fontSize: 9,
                              color: Colors.grey,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),

                lineTouchData: LineTouchData(
                  enabled: true,
                  touchTooltipData: LineTouchTooltipData(
                    getTooltipItems: (touchedSpots) {
                      return touchedSpots.map((spot) {
                          String title = '';

                          switch (spot.x.toInt()) {
                            case 0:
                              title = 'Stok Awal';
                              break;

                            case 1:
                              title = 'Barang Masuk';
                              break;

                            case 2:
                              title = 'Barang Keluar';
                              break;

                            case 3:
                              title = 'Stok Saat Ini';
                              break;
                          }

                          return LineTooltipItem(
                            '$title\n'
                                '${formatNumber(spot.y)}',
                            const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 11,
                            ),
                          );
                        },
                      ).toList();
                    },
                  ),
                ),

                lineBarsData: [
                  LineChartBarData(
                    spots: [
                      FlSpot(0, getJumlah('total stok awal',),
                      ),
                      FlSpot(1, getJumlah('total barang masuk',),
                      ),
                      FlSpot(2, getJumlah('total barang keluar',),
                      ),
                      FlSpot(3, getJumlah('total stok saat ini',),
                      ),
                    ],

                    isCurved: true,
                    color: const Color(0xff17346E,),
                    barWidth: 3,
                    isStrokeCapRound: true,
                    dotData: FlDotData(
                      show: true,
                      getDotPainter: (spot, percent, barData, index,) {
                        return FlDotCirclePainter(
                          radius: 4,
                          color: const Color(0xff17346E,),
                          strokeWidth: 2,
                          strokeColor: Colors.white,
                        );
                      },
                    ),

                    belowBarData: BarAreaData(
                      show: true,
                      color: const Color(
                        0xff17346E,).withOpacity(0.08),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  double _getInterval() {
    final stokAwal = getJumlah('total stok awal');
    final barangMasuk = getJumlah('total barang masuk');
    final barangKeluar = getJumlah('total barang keluar');
    final stokSaatIni = getJumlah('total stok saat ini');

    final values = [
      stokAwal,
      barangMasuk,
      barangKeluar,
      stokSaatIni,
    ];

    double maxValue = 0;

    for (final value in values) {
      if (value > maxValue) {
        maxValue = value;
      }
    }
    if (maxValue <= 10) {
      return 1;
    }
    if (maxValue <= 100) {
      return 10;
    }
    if (maxValue <= 1000) {
      return 100;
    }
    if (maxValue <= 10000) {
      return 1000;
    }
    return maxValue / 5;
  }

  String formatNumber(double value) {
    if (value == value.roundToDouble()) {
      return value.toInt().toString();
    }
    return value.toStringAsFixed(1);
  }

  Widget _buildLegend(
      String title,
      Color color,
      ) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 8,
          height: 8,

          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),

        const SizedBox(width: 5),

        Text(
          title,
          style: const TextStyle(
            fontSize: 9,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}