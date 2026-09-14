import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import 'gsheetsservices.dart';

class NotificationController extends GetxController {
  final RxInt notificationCount = 0.obs;

  @override
  void onInit() {
    super.onInit();
    loadNotificationCount();
  }

  Future<void> loadNotificationCount() async {

    try {

      if (GSheetsServicesEmployees.sheetNotif == null) {
        await GSheetsServicesEmployees.init();
      }

      final rows = await GSheetsServicesEmployees.sheetNotif!.values.map.allRows();

      if (rows == null || rows.isEmpty) {
        notificationCount.value = 0;
        debugPrint("NOTIFIKASI: Tidak ada data");
        return;
      }

      if (rows.length <= 1) {
        notificationCount.value = 0;
        return;
      }


      final jumlahNotifikasi = rows.length - 1;
      notificationCount.value = jumlahNotifikasi;

      debugPrint(
        "JUMLAH NOTIFIKASI: $jumlahNotifikasi",
      );


    } catch (e) {
      debugPrint(
        "ERROR LOAD NOTIFIKASI: $e",
      );

    }
  }


  Future<void> refreshNotification() async {
    await loadNotificationCount();
  }


  void clearNotification() {
    notificationCount.value = 0;
  }
}