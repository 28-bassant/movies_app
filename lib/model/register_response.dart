class RegisterResponse {
  String? message;
  UserData? data;

  RegisterResponse({required this.message, required this.data});

  factory RegisterResponse.fromJson(Map<String, dynamic> json) {
    return RegisterResponse(
      message: json['message'],
      data: UserData.fromJson(json['data']),
    );
  }
}

class UserData {
  String? id;
  String? name;
  String? email;
  String? phone;
  int? avaterId;

  UserData({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.avaterId,
  });

  UserData.fromJson(dynamic json) {
    id = json['_id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    avaterId = json['avaterId'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['name'] = name;
    map['email'] = email;
    map['phone'] = phone;
    map['avaterId'] = avaterId;
    return map;
  }

  @override
  String toString() {
    return 'UserData{id: $id, name: $name, email: $email, phone: $phone, avaterId: $avaterId}';
  }
}

