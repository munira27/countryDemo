import 'dart:convert';

class CountriesModel {
  bool? error;
  String? msg;
  List<Data>? data;

  CountriesModel({this.error, this.msg, this.data});

  CountriesModel.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    msg = json['msg'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['error'] = this.error;
    data['msg'] = this.msg;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? name;
  String? currency;
  String? unicodeFlag;
  String? flag;
  String? dialCode;

  Data({this.name, this.currency, this.unicodeFlag, this.flag, this.dialCode});

  Data.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    currency = json['currency'];
    unicodeFlag = json['unicodeFlag'];
    flag = json['flag'];
    dialCode = json['dialCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['currency'] = this.currency;
    data['unicodeFlag'] = this.unicodeFlag;
    data['flag'] = this.flag;
    data['dialCode'] = this.dialCode;
    return data;
  }

}