class OrderModel {
  int id;
  int ticketId;
  int userId;
  int status;
  String qrCode;

  OrderModel({
    this.id,
    this.ticketId,
    this.userId,
    this.status,
    this.qrCode,
  });

  OrderModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    ticketId = json['ticket_id'];
    userId = json['user_id'];
    status = json['status'];
    qrCode = json['qr_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['ticket_id'] = this.ticketId;
    data['user_id'] = this.userId;
    data['status'] = this.status;
    data['qr_code'] = this.qrCode;
    return data;
  }
}
