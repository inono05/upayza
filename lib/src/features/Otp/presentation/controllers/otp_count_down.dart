import 'package:flutter_riverpod/flutter_riverpod.dart';

final countdownProvider = StateNotifierProvider<CountdownNotifier, int>((ref) {
  return CountdownNotifier();
});

class CountdownNotifier extends StateNotifier<int> {
  CountdownNotifier() : super(60) {
    startCountdown();
  }


  void startCountdown() {
    Future.delayed(const Duration(seconds: 1), () {
      if (state > 0) {
        state--;
        startCountdown();
      }else{
        state = 60;
      }
    });
  }
}