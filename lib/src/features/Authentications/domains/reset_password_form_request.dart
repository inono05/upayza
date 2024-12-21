class ResetPasswordRequest {
  ResetPasswordRequest({
    required this.code,
    required this.password,
  });

  final String? code;
  final String? password;

  ResetPasswordRequest copyWith({
    String? code,
    String? password,
  }) {
    return ResetPasswordRequest(
      code: code ?? this.code,
      password: password ?? this.password,
    );
  }

  factory ResetPasswordRequest.fromJson(Map<String, dynamic> json){
    return ResetPasswordRequest(
      code: json["code"],
      password: json["password"],
    );
  }

  Map<String, dynamic> toJson() => {
    "code": code,
    "password": password,
  };

  @override
  String toString(){
    return "$code, $password";
  }
}
