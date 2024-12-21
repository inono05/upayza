import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'action_controller.g.dart';

@riverpod
class ActionController extends _$ActionController {
  @override
  int build() {
    return 0;
  }

  void actionSelected(int index){
    state = index;
  }
}
