class UserRegisterFormRequest {
  UserRegisterFormRequest({
    this.countryId,
    this.password,
    this.email,
    this.firstName
  });

  int? countryId;
  String? password;
  String? email;
  String? firstName;

  factory UserRegisterFormRequest.fromJson(Map<String, dynamic> json) => UserRegisterFormRequest(
    countryId: json["country_id"],
    password: json["password"],
    email: json["email"],
    firstName: json["first_name"],
  );

  Map<String, dynamic> toJson() => {
    "country_id": countryId,
    "password": password,
    "email": email,
    "first_name": firstName,
  };
}
