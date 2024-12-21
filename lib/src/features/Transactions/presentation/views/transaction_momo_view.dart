import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:upayza/src/features/Transactions/presentation/controllers/state_controller.dart';
import 'package:upayza/src/features/Transactions/presentation/widgets/confirm_transfer_widget.dart';
import 'package:upayza/src/features/Transactions/presentation/widgets/receiver_widget.dart';
import 'package:upayza/src/features/Transactions/presentation/widgets/stepper_momo_widgets/sender_momo_widget.dart';
import 'package:upayza/src/shared/components/app_title.dart';
import 'package:upayza/src/shared/components/buttons/app_button.dart';
import 'package:upayza/src/shared/constants/app_sizes.dart';
import 'package:upayza/src/shared/constants/app_string.dart';
import 'package:upayza/src/shared/utils/app_helpers.dart';

class TransactionMomoView extends ConsumerStatefulWidget {
  const TransactionMomoView({super.key});

  @override
  ConsumerState createState() => _TransactionMomoViewState();
}

class _TransactionMomoViewState extends ConsumerState<TransactionMomoView> {
  late GlobalKey<FormState> senderFormKey;
  late GlobalKey<FormState> recipientFormKey;
  @override
  void initState() {
    super.initState();
    senderFormKey = GlobalKey<FormState>();
    recipientFormKey = GlobalKey<FormState>();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> pages = [
      SenderMomoWidget(formKey: senderFormKey),
      ReceiverWidget(formKey: recipientFormKey),
      const ConfirmTransferWidget(),
    ];
    final pageIndex = ref.watch(pageIndexProvider);
    final pageController = PageController(initialPage: pageIndex);

    bool isSenderGateway = ref.watch(senderGatewayProvider) != null;
    bool isSenderOperator = ref.watch(senderOperatorProvider) != null;
    bool isRecipientCountry = ref.watch(recipientCountryProvider) != null;
    bool isRecipientOperator = ref.watch(recipientOperatorProvider) != null;

    bool isSenderValidated =
        (!isSenderGateway && !isSenderOperator && pageIndex == 0);
    bool isRecipientValidated =
        (!isRecipientCountry && !isRecipientOperator && pageIndex == 1);
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus!.unfocus();
      },
      child: RefreshIndicator(
        onRefresh: () async {
          AppHelpers.resetAllProviders(ref);
        },
        child: SingleChildScrollView(
          child: SizedBox(
            height:
                (pageIndex != 0) ? context.height * 1.5 : context.height * 1.3,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: AppSize.containerSize * 1.1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      AppSize.tripleSpacing.heightBox,
                      AppTitle.h4(
                        title: AppString.momoDescription.capitalize,
                        maxLines: 3,
                        textAlign: TextAlign.center,
                        fontWeight: FontWeight.w500,
                      ).paddingSymmetric(
                        vertical: AppSize.halfPadding,
                        horizontal: AppSize.padding,
                      )
                    ],
                  ),
                ),
                AppSize.tripleSpacing.heightBox,
                PageView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  controller: pageController,
                  itemCount: pages.length,
                  itemBuilder: (context, index) {
                    return pages[index];
                  },
                  onPageChanged: (index) {
                    ref
                        .read(pageIndexProvider.notifier)
                        .update((state) => index);
                  },
                ).expanded(
                  flex: pageIndex == 2 ? 10 : 7,
                ),
                PageViewNavigator(
                  pageController: pageController,
                  onPressed: isSenderValidated
                      ? null
                      : isRecipientValidated
                          ? null
                          : () {
                              if (pageIndex == 0 &&
                                  senderFormKey.currentState!.validate()) {
                                pageController.nextPage(
                                  duration: 50.ms,
                                  curve: Curves.easeInOut,
                                );
                              }
                              if (pageIndex == 1 &&
                                  recipientFormKey.currentState!.validate()) {
                                pageController.nextPage(
                                  duration: 50.ms,
                                  curve: Curves.easeInOut,
                                );
                              }
                            },
                ),
                if (pageIndex != 1) const Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class PageViewNavigator extends ConsumerWidget {
  const PageViewNavigator({
    super.key,
    required this.pageController,
    this.onPressed,
  });

  final PageController pageController;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageIndex = ref.watch(pageIndexProvider);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        if (pageIndex > 0)
          AppButton(
            title: 'Back',
            onPressed: () {
              if (pageIndex > 0) {
                ref
                    .read(pageIndexProvider.notifier)
                    .update((state) => state - 1);
                pageController.jumpToPage(ref.watch(pageIndexProvider));
              }
            },
          ).expanded(),
        if (pageIndex < 2)
          AppButton(
            title: 'Next',
            onPressed: onPressed,
          ).expanded(),
      ],
    ).paddingOnly(bottom: AppSize.padding);
  }
}
