mixin ApiList {
  //! API -> V1
  static String mainDomainV1 = "dashapp.financepe.in";
  static String apiSubFolderV1 = "/masterApi/";
  static String countryListAPI = "${apiSubFolderV1}countryList";
  static String stateListAPI = "${apiSubFolderV1}stateList";
  static String cityListAPI = "${apiSubFolderV1}cityList";
  //! API -> V2
  static String mainDomainV2 = "192.168.1.5";
  static String apiSubFolderV2 = "/api/";
  static String customerListAPI = "${apiSubFolderV2}read_all_customer.php";
  static String customerAddAPI = "${apiSubFolderV2}create_customer.php";
  static String customerUpdateAPI = "${apiSubFolderV2}update_customer.php";
  static String customerDeleteAPI = "${apiSubFolderV2}delete_customer.php";
}
