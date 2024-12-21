class OtpFormRequest {
  final String otp;
  final String email;

  OtpFormRequest({
    required this.otp,
    required this.email,
  });

  OtpFormRequest copyWith({
    String? otp,
    String? email,
  }) =>
      OtpFormRequest(
        otp: otp ?? this.otp,
        email: email ?? this.email,
      );

  factory OtpFormRequest.fromJson(Map<String, dynamic> json) => OtpFormRequest(
        email: json["email"],
        otp: json["otp"],
      );

  Map<String, dynamic> toJson() => {"email": email, "otp": otp};
}
