class UserLoginResponseModel {
  Data? data;
  String? message;
  bool? success;

  UserLoginResponseModel({this.data, this.message, this.success});

  UserLoginResponseModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    message = json['message'];
    success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = this.message;
    data['success'] = this.success;
    return data;
  }
}

class Data {
  int? id;
  String? firstName;
  String? lastName;
  String? email;
  String? password;
  String? imagePath;
  bool? isAdmin;
  bool? isEmployee;
  bool? isCustomer;

  Data(
      {this.id,
      this.firstName,
      this.lastName,
      this.email,
      this.password,
      this.imagePath,
      this.isAdmin,
      this.isEmployee,
      this.isCustomer});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    password = json['password'];
    imagePath = json['imagePath'];
    isAdmin = json['isAdmin'];
    isEmployee = json['isEmployee'];
    isCustomer = json['isCustomer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['email'] = this.email;
    data['password'] = this.password;
    data['imagePath'] = this.imagePath;
    data['isAdmin'] = this.isAdmin;
    data['isEmployee'] = this.isEmployee;
    data['isCustomer'] = this.isCustomer;
    return data;
  }
}
