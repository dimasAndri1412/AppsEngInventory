import 'package:appsenginventory/Controller/key.dart';
import 'package:flutter/material.dart';

class ClearControllerFunc {
  static void clearControllers() {
    // ============================================================
    // USER / MEMBER CONTROLLER
    // ============================================================

    employeeIdController.clear();
    usernamecontroller.clear();
    frontNameController.clear();
    backNameController.clear();
    fullnamecontroller.clear();
    nipController.clear();
    addresscontroller.clear();
    phonenumberscontroller.clear();
    emailcontroller.clear();
    otpcontroller.clear();
    birthdatecontroller.clear();
    rolesController.clear();
    newpasswordcontorller.clear();
    newconfpasswordcontroller.clear();
    loginflagecontroller.clear();
    passcontroller.clear();
    positionscontrollers.clear();
    idController.clear();
    confPassController.clear();
    projectController.clear();
    userIdController.clear();
    faceImageController.clear();
    embeddingController.clear();
    idMemberControllers.clear();
    passwordValidateControllers.clear();
    loginPasswordValidateControllers.clear();
    loginUserNamesValidateControllers.clear();

    // ============================================================
    // BARANG MASUK
    // ============================================================

    TanggalBarangMasukContorller.clear();
    JenisBarangMasukContorller.clear();
    JumlahBarangMasukContorller.clear();
    SuplierBarangMasukContorller.clear();
    PICBarangMasukContorller.clear();
    KeteranganBarangMasukContorller.clear();

    // ============================================================
    // BARANG KELUAR
    // ============================================================

    TanggalBarangKeluarContorller.clear();
    JenisBarangKeluarContorller.clear();
    JumlahBarangKeluarContorller.clear();
    SuplierBarangKeluarContorller.clear();
    PICBarangKeluarContorller.clear();
    KeteranganBarangKeluarContorller.clear();

    // ============================================================
    // HOMEPAGES
    // ============================================================

    HomePagesUserNames.clear();
    HomePagesPositions.clear();
    HomePagesTotalBarang.clear();
    HomePagesTotalStock.clear();
    HomePagesStockMinim.clear();
    HomePagesStockHabis.clear();

    // ============================================================
    // SEARCH BARANG
    // ============================================================

    searchController.clear();

    // ============================================================
    // CHANGE PASSWORD
    // ============================================================

    changesPasswordConfirmPassword.clear();
    changesPasswordNewPassword.clear();
    changesPasswordUserName.clear();
    changesPasswordEmail.clear();

    // ============================================================
    // CHANGE PASSWORD - SETTING
    // ============================================================

    changesPasswordSettingConfirmPassword.clear();
    changesPasswordSettingNewPassword.clear();
    changesPasswordSettingUserName.clear();
    changesPasswordSettingEmail.clear();

    // ============================================================
    // FORGOT PASSWORD
    // ============================================================

    forgotPasswordConfirmPassword.clear();
    forgotPasswordNewPassword.clear();
    forgotPasswordUserName.clear();
    forgotPasswordEmail.clear();

    otpforgotcontrollers.clear();
    otpemailforgotcontroller.clear();
    sendOTPForgotControllers.clear();

    // ============================================================
    // PERSONAL SETTING
    // ============================================================

    changesPersonalSettingUserName.clear();
    changesPersonalSettingEmail.clear();
    changesPersonalSettingNomerTelpon.clear();
    changesPersonalSettingAlamat.clear();

    // ============================================================
    // OTP EMAIL
    // ============================================================

    otpcontrollers.clear();
    otpemailcontroller.clear();
    sendOTPControllers.clear();
    otpFullNamesController.clear();
    otpCreateTimes.clear();
    emailscontroller.clear();

    // ============================================================
    // SIDEBAR
    // ============================================================

    sideBarFullNameController.clear();
    sideBarJabatanController.clear();
    sideBarPosisiController.clear();
    sideBarEmployeeIDController.clear();
    sideBarUserNamesController.clear();
    sideBarEmailController.clear();

    // ============================================================
    // CARD - LEMARI 1
    // ============================================================

    jumlahJenisBarangLemari1Controller.clear();
    totalStokAwalLemari1Controller.clear();
    totalBarangMasukLemari1Controller.clear();
    totalBarangKeluarLemari1Controller.clear();
    totalStokSaatIniLemari1Controller.clear();
    jumlahBarangKurangLemari1Controller.clear();

    // ============================================================
    // CARD - LEMARI 2
    // ============================================================

    jumlahJenisBarangLemari2Controller.clear();
    totalStokAwalLemari2Controller.clear();
    totalBarangMasukLemari2Controller.clear();
    totalBarangKeluarLemari2Controller.clear();
    totalStokSaatIniLemari2Controller.clear();
    jumlahBarangKurangLemari2Controller.clear();

    // ============================================================
    // CARD - LEMARI 3
    // ============================================================

    jumlahJenisBarangLemari3Controller.clear();
    totalStokAwalLemari3Controller.clear();
    totalBarangMasukLemari3Controller.clear();
    totalBarangKeluarLemari3Controller.clear();
    totalStokSaatIniLemari3Controller.clear();
    jumlahBarangKurangLemari3Controller.clear();
  }
}