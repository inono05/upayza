class ApiRoutes {
  ApiRoutes._();
  static const String baseUrl = "https://services.upayza.com/api";
  static const String login = '/auth/login';
  static const String logout = '/auth/logout';
  static const String register = '/auth/register';
  static const String country = '/countries';
  static const String otpForResetPasswordEmail = '/auth/password/email';
  static const String resendOtpForEmailVerify= '/auth/otp/email';
  static const String resetPassword= '/auth/password/reset';
  static const String verifiedEmail= '/auth/confirm/email';
  static const String operators= '/operators';
  static const String gateways= '/gateways';
  static const String recipients= '/recipients';
  static const String transfers= '/transfers';
  static const String depositNumbers= '/deposit-numbers';
  static const String depositNumberDelete= '/deposit-numbers/{id}';
  static const String initTransfer= '/transactions/initTransfer';
}
