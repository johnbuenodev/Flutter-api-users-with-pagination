class User {
  String? gender;
  String? email;
  String? cell;

  User({this.gender, this.email, this.cell});

  User.fromJson(Map<String, dynamic> json) {
    gender = json['gender'];
    email = json['email'];
    cell = json['cell'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['gender'] = this.gender;
    data['email'] = this.email;
    data['cell'] = this.cell;
    return data;
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      gender: map['gender'] ?? '',
      cell: map['cell'] ?? '',
      email: map['email'] ?? '',
    );
  }
}
