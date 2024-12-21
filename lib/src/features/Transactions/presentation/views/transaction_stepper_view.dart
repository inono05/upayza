import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';
import 'package:upayza/src/features/Transactions/presentation/controllers/transaction_stepper_controller.dart';

import 'package:upayza/src/features/Transactions/presentation/widgets/stepper_widgets/preview_widget.dart';
import 'package:upayza/src/features/Transactions/presentation/widgets/receiver_widget.dart';
import 'package:upayza/src/features/Transactions/presentation/widgets/stepper_widgets/sender_widgets/sender_widget.dart';
import 'package:upayza/src/shared/components/app_title.dart';
import 'package:upayza/src/shared/constants/app_sizes.dart';
import 'package:upayza/src/shared/utils/app_translate.dart';

class TransactionStepperView extends ConsumerWidget {
  const TransactionStepperView({super.key});


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    final currentStep = ref.watch(transactionStepperControllerProvider);
    final transactionProvider = ref.read(
      transactionStepperControllerProvider.notifier,
    );

    List<Step> transactionSteps() {
      return <Step>[
        Step(
          state: currentStep > 0 ? StepState.complete : StepState.indexed,
          isActive: currentStep >= 0,
          title: const AppTitle(title: "Sender", fontWeight: FontWeight.w600,),
          content: const SenderWidget(),
        ),
        Step(
          state: currentStep > 1 ? StepState.complete : StepState.indexed,
          isActive: currentStep >= 1,
          title: const AppTitle(title: "Receiver", fontWeight: FontWeight.w600,),
          content:  ReceiverWidget(formKey: formKey),
        ),
        Step(
          state: currentStep >= 2 ? StepState.complete : StepState.indexed,
          isActive: currentStep >= 2,
          title: const AppTitle(title: "Preview", fontWeight: FontWeight.w600,),
          content: const PreviewWidget(),
        ),
      ];
    }

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            height: AppSize.lgContainerSize*3,
            child: Stepper(
              elevation: 0,
              steps: transactionSteps(),
              type: StepperType.horizontal,
              currentStep: currentStep,
              onStepContinue: () {
                (currentStep == 2) ? null : transactionProvider.stepIncrement();
              },
              onStepCancel: () {
                currentStep == 0 ? null : transactionProvider.stepDecrement();
              },
              controlsBuilder: (context, ControlsDetails details) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton.icon(
                      onPressed:
                      currentStep == 0 ? null : details.onStepCancel,
                      icon: const Icon(Icons.cancel_outlined),
                      label: const AppTitle(title: 'Cancel'),
                    ),
                    TextButton.icon(
                      onPressed: currentStep == 2 ? null : details.onStepContinue,
                      icon: const Icon(Iconsax.next),
                      label: AppTitle(title: T(context).next),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
