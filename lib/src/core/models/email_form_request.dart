class EmailFormRequest {
  EmailFormRequest({
    required this.email,
  });

  String email;

  factory EmailFormRequest.fromJson(Map<String, dynamic> json) =>
      EmailFormRequest(
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {"email": email};
}
