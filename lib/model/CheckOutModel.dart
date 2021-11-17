class CheckOutModel {
  final String status;
  final String message;
  final String data;

  CheckOutModel(this.status, this.message, this.data);

  CheckOutModel.fromJson(Map<String, dynamic> json)
      : status = json['status'],
        message = json['message'],
        data = json['data'];

  Map<String, dynamic> toJson() =>
      {'status': status, 'message': message, 'data': data};
}
