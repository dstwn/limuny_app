class UserStatusModel {
  final int id_place;
  final String name;
  final String uuid;
  final String activity_category;
  final String checkin_date;
  final int quantity;
  final int capacity;

  UserStatusModel(this.id_place, this.name, this.uuid, this.activity_category,
      this.checkin_date, this.capacity, this.quantity);

  UserStatusModel.fromJson(Map<String, dynamic> json)
      : id_place = json['id'],
        name = json['name'],
        uuid = json['uuid'],
        activity_category = json['activity_category'],
        checkin_date = json['checkin_date'],
        capacity = json['capacity'],
        quantity = json['quantity'];

  Map<String, dynamic> toJson() => {
        'id': id_place,
        'name': name,
        'uuid': uuid,
        'activity_category': activity_category,
        'checkin_date': checkin_date,
        'capacity': capacity,
        'quantity': quantity
      };
}
