import 'package:flutter/cupertino.dart';

// RegistrationKey
final GlobalKey<FormState> formRegistKeys = GlobalKey<FormState>();

// LoginPageKey
final GlobalKey<FormState> loginkeys = GlobalKey<FormState>();

// BarangMasukKey
final GlobalKey<FormState> BarangMasukKey = GlobalKey<FormState>();

// BarangMasukKey
final GlobalKey<FormState> BarangKeluarKey = GlobalKey<FormState>();

// Revapm RegistrationKey
final GlobalKey<FormState> revampRegistrationsKey = GlobalKey<FormState>();

// Revapm Barang Masuk
final GlobalKey<FormState> revampBarangMasukKey = GlobalKey<FormState>();

// Revapm Barang Keluar
final GlobalKey<FormState> revampBarangKeluarkKey = GlobalKey<FormState>();

// Changes password key
final GlobalKey<FormState> changesPasswordKey = GlobalKey<FormState>();

// Changes password key
final GlobalKey<FormState> changesPasswordSettingKey = GlobalKey<FormState>();

// Changes Personal key
final GlobalKey<FormState> changesPersonalSettingKey = GlobalKey<FormState>();

// Forgot password key
final GlobalKey<FormState> forgotpasswordkey = GlobalKey<FormState>();

// OTP Key
final GlobalKey<FormState> otpveryficationskeys = GlobalKey<FormState>();

// OTP Key
final GlobalKey<FormState> otpveryficationsforgotkeys = GlobalKey<FormState>();

// emailOTPKey
final GlobalKey<FormState> otpEmailKeys = GlobalKey<FormState>();

// emailOTPKey
final GlobalKey<FormState> otpEmailForgotKeys = GlobalKey<FormState>();

//

// LoginPageController
final loginUserNameController = TextEditingController();
final loginPasswordController = TextEditingController();

//RevampRegist
final List<Map<String, TextEditingController>> revampResgistControllerss = [];
final FocusNode phoneFocusNode = FocusNode();

//RevampBarangMasukController
final List<Map<String, TextEditingController>> revampBarangMasukControllerss = [];

//RevampBarangMasukController
final List<Map<String, TextEditingController>> revampBarangKeluarControllerss = [];

// RegistrationController
final employeeIdController = TextEditingController();
final usernamecontroller = TextEditingController();
final frontNameController = TextEditingController();
final backNameController = TextEditingController();
final fullnamecontroller = TextEditingController();
final nipController = TextEditingController();
final addresscontroller = TextEditingController();
final phonenumberscontroller = TextEditingController();
final emailcontroller = TextEditingController();
final otpcontroller = TextEditingController();
final birthdatecontroller = TextEditingController();
final rolesController = TextEditingController();
final newpasswordcontorller = TextEditingController();
final newconfpasswordcontroller = TextEditingController();
final loginflagecontroller = TextEditingController();
final passcontroller = TextEditingController();
final positionscontrollers = TextEditingController();
final idController = TextEditingController();
final confPassController = TextEditingController();
final projectController = TextEditingController();
final userIdController = TextEditingController();
final faceImageController = TextEditingController();
final embeddingController = TextEditingController();
final idMemberControllers = TextEditingController();
final passwordValidateControllers = TextEditingController();
final loginPasswordValidateControllers = TextEditingController();
final loginUserNamesValidateControllers = TextEditingController();

//BarangMasuk
final TanggalBarangMasukContorller = TextEditingController();
final JenisBarangMasukContorller = TextEditingController();
final JumlahBarangMasukContorller = TextEditingController();
final SuplierBarangMasukContorller = TextEditingController();
final PICBarangMasukContorller = TextEditingController();
final KeteranganBarangMasukContorller = TextEditingController();

// BarangKeluar
final TanggalBarangKeluarContorller = TextEditingController();
final JenisBarangKeluarContorller = TextEditingController();
final JumlahBarangKeluarContorller = TextEditingController();
final SuplierBarangKeluarContorller = TextEditingController();
final PICBarangKeluarContorller = TextEditingController();
final KeteranganBarangKeluarContorller = TextEditingController();

//HompagesController
final HomePagesUserNames = TextEditingController();
final HomePagesPositions = TextEditingController();
final HomePagesTotalBarang = TextEditingController();
final HomePagesTotalStock = TextEditingController();
final HomePagesStockMinim = TextEditingController();
final HomePagesStockHabis = TextEditingController();

// Search Barang
final TextEditingController searchController = TextEditingController();

//Changes Password Controller
final changesPasswordConfirmPassword = TextEditingController();
final changesPasswordNewPassword = TextEditingController();
final changesPasswordUserName = TextEditingController();
final changesPasswordEmail = TextEditingController();

//Changes Password Controller Setting
final changesPasswordSettingConfirmPassword = TextEditingController();
final changesPasswordSettingNewPassword = TextEditingController();
final changesPasswordSettingUserName = TextEditingController();
final changesPasswordSettingEmail = TextEditingController();

//Changes Password Controller
final forgotPasswordConfirmPassword = TextEditingController();
final forgotPasswordNewPassword = TextEditingController();
final forgotPasswordUserName = TextEditingController();
final forgotPasswordEmail = TextEditingController();

// Changes Personal Setting Controller
final changesPersonalSettingUserName = TextEditingController();
final changesPersonalSettingEmail = TextEditingController();
final changesPersonalSettingNomerTelpon = TextEditingController();
final changesPersonalSettingAlamat = TextEditingController();

//otpemailcontrollers
final otpcontrollers = TextEditingController();
final otpforgotcontrollers = TextEditingController();
final otpemailcontroller = TextEditingController();
final otpemailforgotcontroller = TextEditingController();
final sendOTPControllers = TextEditingController();
final sendOTPForgotControllers = TextEditingController();
final otpFullNamesController = TextEditingController();
final otpCreateTimes = TextEditingController();
final emailscontroller = TextEditingController();

//SideBar Controller
final sideBarFullNameController = TextEditingController();
final sideBarJabatanController = TextEditingController();
final sideBarPosisiController = TextEditingController();
final sideBarEmployeeIDController = TextEditingController();
final sideBarUserNamesController = TextEditingController();
final sideBarEmailController = TextEditingController();

// card controller
final jumlahJenisBarangLemari1Controller = TextEditingController();
final totalStokAwalLemari1Controller = TextEditingController();
final totalBarangMasukLemari1Controller = TextEditingController();
final totalBarangKeluarLemari1Controller = TextEditingController();
final totalStokSaatIniLemari1Controller = TextEditingController();
final jumlahBarangKurangLemari1Controller = TextEditingController();

final jumlahJenisBarangLemari2Controller = TextEditingController();
final totalStokAwalLemari2Controller = TextEditingController();
final totalBarangMasukLemari2Controller = TextEditingController();
final totalBarangKeluarLemari2Controller = TextEditingController();
final totalStokSaatIniLemari2Controller = TextEditingController();
final jumlahBarangKurangLemari2Controller = TextEditingController();

final jumlahJenisBarangLemari3Controller = TextEditingController();
final totalStokAwalLemari3Controller = TextEditingController();
final totalBarangMasukLemari3Controller = TextEditingController();
final totalBarangKeluarLemari3Controller = TextEditingController();
final totalStokSaatIniLemari3Controller = TextEditingController();
final jumlahBarangKurangLemari3Controller = TextEditingController();

final loginEmployeeidController = TextEditingController();
final loginFullNameController = TextEditingController();
final loginUserNameControllers = TextEditingController();
final loginPosisiControllers = TextEditingController();
final loginDatesControllers = TextEditingController();
final loginTimeControllers = TextEditingController();

