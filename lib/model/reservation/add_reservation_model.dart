class AddReservationRequestModel {
  int? id;
  int? customerId;
  int? employeeId;
  int? serviceId;
  String? date;
  bool? status;

  AddReservationRequestModel(
      {this.id,
      this.customerId,
      this.employeeId,
      this.serviceId,
      this.date,
      this.status});

  AddReservationRequestModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    customerId = json['customerId'];
    employeeId = json['employeeId'];
    serviceId = json['serviceId'];
  
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['customerId'] = this.customerId;
    data['employeeId'] = this.employeeId;
    data['serviceId'] = this.serviceId;
    data['date'] = this.date;
    data['status'] = this.status;
    return data;
  }
}
