class Ticket {
  int id;
  String name;
  String description;
  int price;
  int maxTicketAllowedPerPerson;
  int minTicketAllowedPerPerson;
  String ticketType;
  String promoCode;
  int status;
  int eventId;

  Ticket({
    this.id,
    this.name,
    this.description,
    this.price,
    this.maxTicketAllowedPerPerson,
    this.minTicketAllowedPerPerson,
    this.ticketType,
    this.promoCode,
    this.status,
    this.eventId,
  });

  Ticket.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    price = json['price'];
    maxTicketAllowedPerPerson = json['max_ticket_allowed_per_person'];
    minTicketAllowedPerPerson = json['min_ticket_allowed_per_person'];
    ticketType = json['ticket_type'];
    promoCode = json['promo_code'];
    status = json['status'];
    eventId = json['event_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['price'] = this.price;
    data['max_ticket_allowed_per_person'] = this.maxTicketAllowedPerPerson;
    data['min_ticket_allowed_per_person'] = this.minTicketAllowedPerPerson;
    data['ticket_type'] = this.ticketType;
    data['promo_code'] = this.promoCode;
    data['status'] = this.status;
    data['event_id'] = this.eventId;
    return data;
  }
}
