class EventModel {
  int id;
  String name;
  String description;
  String venue;
  String category;
  String type;
  String picture;
  int status;
  String startDatetime;
  String endDatetime;
  int organizerId;

  EventModel({
    this.id,
    this.name,
    this.description,
    this.venue,
    this.category,
    this.type,
    this.picture,
    this.status,
    this.startDatetime,
    this.endDatetime,
    this.organizerId,
  });

  EventModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    venue = json['venue'];
    category = json['category'];
    type = json['type'];
    picture = json['picture'];
    status = json['status'];
    startDatetime = json['start_datetime'];
    endDatetime = json['end_datetime'];
    organizerId = json['organizer_id'];
  }

  EventModel.fromDb(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    venue = json['venue'];
    category = json['category'];
    type = json['type'];
    picture = json['picture'];
    status = json['status'];
    startDatetime = json['start_datetime'];
    endDatetime = json['end_datetime'];
    organizerId = json['organizer_id'];
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['venue'] = this.venue;
    data['category'] = this.category;
    data['type'] = this.type;
    data['picture'] = this.picture;
    data['status'] = this.status;
    data['start_datetime'] = this.startDatetime;
    data['end_datetime'] = this.endDatetime;
    data['organizer_id'] = this.organizerId;
    return data;
  }
}
