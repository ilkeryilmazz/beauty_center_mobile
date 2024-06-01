class ServiceAddModel {
  int? id;
  String? name;
  String? imagePath;

  ServiceAddModel({this.id, this.name, this.imagePath});

  ServiceAddModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    imagePath = json['imagePath'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['imagePath'] = this.imagePath;
    return data;
  }
}
