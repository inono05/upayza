class UserLoginWithEmailFormRequest {
  UserLoginWithEmailFormRequest({
    this.password,
    this.email,
  });

  String? password;
  String? email;

  factory UserLoginWithEmailFormRequest.fromJson(Map<String, dynamic> json) => UserLoginWithEmailFormRequest(
    password: json["password"],
    email: json["email"],
  );

  Map<String, dynamic> toJson() => {
    "password": password,
    "email": email,
  };
}

class UserLoginWithPhoneFormRequest {
  UserLoginWithPhoneFormRequest({
    this.phone,
    this.password,
  });

  String? phone;
  String? password;

  factory UserLoginWithPhoneFormRequest.fromJson(Map<String, dynamic> json) => UserLoginWithPhoneFormRequest(
    phone: json["phone"],
    password: json["password"],
  );

  Map<String, dynamic> toJson() => {
    "phone": phone,
    "password": password,
  };
}
