class AllCustomersListResponseModel {
  int? code;
  String? status;
  List<AllCustomersListResponseData>? data;

  AllCustomersListResponseModel({this.code, this.status, this.data});

  AllCustomersListResponseModel.fromJson(Map<String, dynamic> json) {
    if (json["code"] is num) {
      code = (json["code"] as num).toInt();
    }
    if (json["status"] is String) {
      status = json["status"];
    }
    if (json["data"] is List) {
      data = json["data"] == null
          ? null
          : (json["data"] as List)
              .map((e) => AllCustomersListResponseData.fromJson(e))
              .toList();
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["code"] = code;
    _data["status"] = status;
    if (data != null) {
      _data["data"] = data?.map((e) => e.toJson()).toList();
    }
    return _data;
  }
}

class AllCustomersListResponseData {
  int? id;
  String? name;
  String? email;
  String? mobile;
  String? dob;
  String? age;
  int? gender;
  int? marriageStatus;
  int? countryId;
  int? stateId;
  int? cityId;
  dynamic image;

  AllCustomersListResponseData(
      {this.id,
      this.name,
      this.email,
      this.mobile,
      this.dob,
      this.age,
      this.gender,
      this.marriageStatus,
      this.countryId,
      this.stateId,
      this.cityId,
      this.image});

  AllCustomersListResponseData.fromJson(Map<String, dynamic> json) {
    if (json["id"] is num) {
      id = (json["id"] as num).toInt();
    }
    if (json["name"] is String) {
      name = json["name"];
    }
    if (json["email"] is String) {
      email = json["email"];
    }
    if (json["mobile"] is String) {
      mobile = json["mobile"];
    }
    if (json["dob"] is String) {
      dob = json["dob"];
    }
    if (json["age"] is String) {
      age = json["age"];
    }
    gender = int.parse(json["gender"] as String);
    marriageStatus = int.parse(json["marriage_status"] as String);
    countryId = json["country_id"];
    stateId = json["state_id"];
    cityId = json["city_id"];
    image = json["image"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["name"] = name;
    _data["email"] = email;
    _data["mobile"] = mobile;
    _data["dob"] = dob;
    _data["age"] = age;
    _data["gender"] = gender;
    _data["marriage_status"] = marriageStatus;
    _data["country_id"] = countryId;
    _data["state_id"] = stateId;
    _data["city_id"] = cityId;
    _data["image"] = image;
    return _data;
  }
}
