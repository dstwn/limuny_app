class User {
  final String name;
  final String email;
  final String nim;
  final String nik;
  final String phone;
  final String major;

  User(this.name, this.email, this.nim, this.nik, this.phone, this.major);

  User.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        email = json['email'],
        nim = json['nim'],
        nik = json['nik'],
        phone = json['phone'],
        major = json['major'];

  Map<String, dynamic> toJson() => {
        'name': name,
        'email': email,
        'nim': nim,
        'nik': nik,
        'phone': phone,
        'major': major
      };
}
