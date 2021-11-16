class Place {
  final String id;
  final String name;
  final String uuid;
  final String place_image;
  final String type;
  final String capacity;
  final String quantity;

  Place(this.id, this.name, this.uuid, this.place_image, this.type,
      this.capacity, this.quantity);

  Place.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        uuid = json['uuid'],
        place_image = json['place_image'],
        type = json['type'],
        capacity = json['capacity'],
        quantity = json['quantity'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'uuid': uuid,
        'place_image': place_image,
        'type': type,
        'capacity': capacity,
        'quantity': quantity
      };
}
