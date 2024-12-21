import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:upayza/src/core/models/operator_json_response.dart';
import 'package:upayza/src/core/repository/base_repository.dart';
import 'package:upayza/src/shared/network/configurations/api_initializer.dart';

part 'operator_repository.g.dart';

abstract class IOperatorRepository{
  Future<OperatorJSonResponse> operators() ;
}

class OperatorRepository extends BaseRepository implements IOperatorRepository{
  OperatorRepository(super.api);
  @override
  Future<OperatorJSonResponse> operators() {
    return this.api.operators();
  }
}

@Riverpod(keepAlive: true)
OperatorRepository operatorRepository (OperatorRepositoryRef ref){
return OperatorRepository(ref.watch(apiProvider));
}

@Riverpod(keepAlive: true)
Future<OperatorJSonResponse> operators(OperatorsRef ref) async {
  return ref.watch(operatorRepositoryProvider).operators();
}

