import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'sender_widget_controller.g.dart';

@riverpod
class SenderWidgetController extends _$SenderWidgetController {
  @override
   int build() {
    return 0;
  }

  void senderStepIncrement(){
    state++;
  }
  void senderStepDecrement(){
    state--;
  }
}
