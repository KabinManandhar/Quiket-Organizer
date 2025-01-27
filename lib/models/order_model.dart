class OrderModel {
  int id;
  int ticketId;
  int userId;
  int status;
  String qrCode;
  String createdAt;
  String updatedAt;
  String userName;
  String ticketName;

  OrderModel(
      {this.id,
      this.ticketId,
      this.userId,
      this.status,
      this.qrCode,
      this.createdAt,
      this.updatedAt,
      this.userName,
      this.ticketName});

  OrderModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    ticketId = json['ticket_id'];
    userId = json['user_id'];
    status = json['status'];
    qrCode = json['qr_code'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    userName = json['User Name'];
    ticketName = json['Ticket Name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['ticket_id'] = this.ticketId;
    data['user_id'] = this.userId;
    data['status'] = this.status;
    data['qr_code'] = this.qrCode;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['User Name'] = this.userName;
    data['Ticket Name'] = this.ticketName;
    return data;
  }
}
