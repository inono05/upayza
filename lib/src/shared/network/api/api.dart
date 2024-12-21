import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/http.dart';
import 'package:retrofit/retrofit.dart';
import 'package:upayza/src/core/models/deposit_number_json_response.dart';
import 'package:upayza/src/core/models/email_form_request.dart';
import 'package:upayza/src/core/models/json_response.dart';
import 'package:upayza/src/core/models/operator_json_response.dart';
import 'package:upayza/src/features/Authentications/domains/auth_json_response.dart';
import 'package:upayza/src/features/Authentications/domains/user_register_form_request.dart';
import 'package:upayza/src/features/Countries/domains/country_json_response.dart';
import 'package:upayza/src/features/Otp/domains/otp_form_request.dart';
import 'package:upayza/src/core/models/gateway_json_response.dart';
import 'package:upayza/src/features/Recipients/domain/recipient_form_request.dart';
import 'package:upayza/src/features/Recipients/domain/recipient_json_response.dart';
import 'package:upayza/src/features/Transactions/domains/deposit_number_form_request.dart';
import 'package:upayza/src/features/Transactions/domains/transaction_json_response.dart';
import 'package:upayza/src/features/Transactions/domains/transfer_form_request.dart';
import 'package:upayza/src/shared/network/configurations/api_routes.dart';

import '../../../features/Authentications/domains/reset_password_form_request.dart';

part 'api.g.dart';

@RestApi()
abstract class Api {
  factory Api(Dio dio, {String baseUrl}) = _Api;

  @GET(ApiRoutes.country)
  Future<CountriesJSonResponse> countries();

  @POST(ApiRoutes.login)
  Future<AuthJSonResponse> login(@Body()  dynamic request);

  @POST(ApiRoutes.register)
  Future<AuthJSonResponse> register(@Body()  UserRegisterFormRequest request);

  @POST(ApiRoutes.otpForResetPasswordEmail)
  Future<AuthJSonResponse> verifyEmailForResetPassword(@Body()  EmailFormRequest request);

  @POST(ApiRoutes.resetPassword)
  Future<AuthJSonResponse> resetPassword(@Body()  ResetPasswordRequest request);

  @POST(ApiRoutes.logout)
  Future<AuthJSonResponse> logout();

  @POST(ApiRoutes.verifiedEmail)
  Future<JSonResponse> emailVerify(@Body() OtpFormRequest request);

  @POST(ApiRoutes.resendOtpForEmailVerify)
  Future<JSonResponse> resendOtpForEmailVerify(@Body()  EmailFormRequest request);

  @GET(ApiRoutes.operators)
  Future<OperatorJSonResponse> operators();

  @GET(ApiRoutes.gateways)
  Future<GatewayJSonResponse> gateways();

  @GET(ApiRoutes.recipients)
  Future<RecipientJSonResponse> recipients(@Query("filter[user_id]") int userId);

  @POST(ApiRoutes.recipients)
  Future<RecipientObjectJSonResponse> recipient(@Body() RecipientFormRequest request);

  @GET(ApiRoutes.transfers)
  Future<TransactionJSonResponse> transfers(@Query("filter[user_id]") int userId);

  @GET(ApiRoutes.depositNumbers)
  Future<DepositNumberJSonResponse> depositNumbers(@Query("filter[user_id]") int userId);

  @POST(ApiRoutes.depositNumbers)
  Future<DepositNumberObjectJSonResponse> depositNumber(@Body() DepositNumberFormRequest request);

  @DELETE(ApiRoutes.depositNumberDelete)
  Future<DepositNumberObjectJSonResponse> depositNumberDeleted(@Path() int id);

  @POST(ApiRoutes.initTransfer)
  Future<TransactionObjectJSonResponse> transfer(@Body() TransferFormRequest request);
}
