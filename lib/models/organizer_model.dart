class OrganizerModel {
  int id;
  String name;
  String description;
  String picture;
  String email;
  String phoneNo;

  OrganizerModel({
    this.id,
    this.name,
    this.description,
    this.picture,
    this.email,
    this.phoneNo,
  });

  OrganizerModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    picture = json['picture'];
    email = json['email'];
    phoneNo = json['phone_no'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['picture'] = this.picture;
    data['email'] = this.email;
    data['phone_no'] = this.phoneNo;
    return data;
  }
}
