import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'transaction_stepper_controller.g.dart';

@riverpod
class TransactionStepperController extends _$TransactionStepperController {
  @override
   int build() {
    return 0;
  }

  void stepIncrement(){
    state++;
  }

  void stepDecrement(){
    state--;
  }
}
