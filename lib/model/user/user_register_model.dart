class UserRegisterModel {
  int? id;
  String? email;
  String? name;
  String? surname;
  String? password;

  UserRegisterModel({this.id,this.email, this.name, this.surname, this.password});

  UserRegisterModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    name = json['name'];
    surname = json['surname'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['id'] = this.id;
    data['name'] = this.name;
    data['surname'] = this.surname;
    data['password'] = this.password;

    return data;
  }
}
