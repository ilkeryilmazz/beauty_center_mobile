class GetAllReservationDetailResponseModel {
  List<Data>? data;
  String? message;
  bool? success;

  GetAllReservationDetailResponseModel({this.data, this.message, this.success});

  GetAllReservationDetailResponseModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    message = json['message'];
    success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    data['success'] = this.success;
    return data;
  }
}

class Data {
  int? id;
  String? employeeName;
  String? customerName;
  String? service;
  bool? status;
  String? date;

  Data(
      {this.id,
      this.employeeName,
      this.customerName,
      this.service,
      this.status,
      this.date});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    employeeName = json['employeeName'];
    customerName = json['customerName'];
    service = json['service'];
    status = json['status'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['employeeName'] = this.employeeName;
    data['customerName'] = this.customerName;
    data['service'] = this.service;
    data['status'] = this.status;
    data['date'] = this.date;
    return data;
  }
}
