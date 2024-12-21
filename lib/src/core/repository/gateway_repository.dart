import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:upayza/src/core/models/gateway_json_response.dart';
import 'package:upayza/src/core/repository/base_repository.dart';
import 'package:upayza/src/shared/network/configurations/api_initializer.dart';

part 'gateway_repository.g.dart';


abstract class IGatewayRepository{
  Future<GatewayJSonResponse> gateways();
}

class GatewayRepository extends BaseRepository implements IGatewayRepository{
  GatewayRepository(super.api);

  @override
  Future<GatewayJSonResponse> gateways() {
    return this.api.gateways();
  }
}

@Riverpod(keepAlive: true)
GatewayRepository gatewayRepository (GatewayRepositoryRef ref) {
  return GatewayRepository(ref.watch(apiProvider));
}

@Riverpod(keepAlive: true)
Future<GatewayJSonResponse> gateways (GatewaysRef ref) async {
  return ref.watch(gatewayRepositoryProvider).gateways();
}