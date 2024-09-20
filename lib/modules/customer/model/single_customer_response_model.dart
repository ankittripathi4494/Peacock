class SingleCustomerResponseModel {
    int? code;
    String? status;
    SingleCustomerResponseData? data;

    SingleCustomerResponseModel({this.code, this.status, this.data});

    SingleCustomerResponseModel.fromJson(Map<String, dynamic> json) {
        if(json["code"] is num) {
            code = (json["code"] as num).toInt();
        }
        if(json["status"] is String) {
            status = json["status"];
        }
        if(json["data"] is Map) {
            data = json["data"] == null ? null : SingleCustomerResponseData.fromJson(json["data"]);
        }
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        _data["code"] = code;
        _data["status"] = status;
        if(data != null) {
            _data["data"] = data?.toJson();
        }
        return _data;
    }
}

class SingleCustomerResponseData {
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

    SingleCustomerResponseData({this.id, this.name, this.email, this.mobile, this.dob, this.age, this.gender, this.marriageStatus, this.countryId, this.stateId, this.cityId, this.image});

    SingleCustomerResponseData.fromJson(Map<String, dynamic> json) {
        if(json["id"] is num) {
            id = (json["id"] as num).toInt();
        }
        if(json["name"] is String) {
            name = json["name"];
        }
        if(json["email"] is String) {
            email = json["email"];
        }
        if(json["mobile"] is String) {
            mobile = json["mobile"];
        }
        if(json["dob"] is String) {
            dob = json["dob"];
        }
        if(json["age"] is String) {
            age = json["age"];
        }
        if(json["gender"] is num) {
            gender = (json["gender"] as num).toInt();
        }
        if(json["marriage_status"] is num) {
            marriageStatus = (json["marriage_status"] as num).toInt();
        }
        if(json["country_id"] is num) {
            countryId = (json["country_id"] as num).toInt();
        }
        if(json["state_id"] is num) {
            stateId = (json["state_id"] as num).toInt();
        }
        if(json["city_id"] is num) {
            cityId = (json["city_id"] as num).toInt();
        }
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