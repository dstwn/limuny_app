class Place {
  final int id;
  final String name;
  final String uuid;
  final String place_image;
  final String type;
  final String qr_image;
  final int capacity;
  final int quantity;

  Place(this.id, this.name, this.uuid, this.place_image, this.type,
      this.qr_image, this.capacity, this.quantity);

  Place.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        uuid = json['uuid'],
        place_image = json['place_image'],
        type = json['type'],
        qr_image = json['qr_image'],
        capacity = json['capacity'],
        quantity = json['quantity'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'uuid': uuid,
        'place_image': place_image,
        'type': type,
        'qr_image': qr_image,
        'capacity': capacity,
        'quantity': quantity
      };
}
