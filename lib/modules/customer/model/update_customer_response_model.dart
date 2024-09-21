// ignore_for_file: no_leading_underscores_for_local_identifiers

class UpdateCustomerResponseModel {
    int? code;
    String? status;
    String? message;

    UpdateCustomerResponseModel({this.code, this.status, this.message});

    UpdateCustomerResponseModel.fromJson(Map<String, dynamic> json) {
        if(json["code"] is num) {
            code = (json["code"] as num).toInt();
        }
        if(json["status"] is String) {
            status = json["status"];
        }
        if(json["message"] is String) {
            message = json["message"];
        }
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        _data["code"] = code;
        _data["status"] = status;
        _data["message"] = message;
        return _data;
    }
}