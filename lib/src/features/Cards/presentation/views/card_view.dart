import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:go_router/go_router.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:u_credit_card/u_credit_card.dart';
import 'package:upayza/generated/assets.gen.dart';
import 'package:upayza/src/core/routing/app_router.dart';
import 'package:upayza/src/shared/components/app_title.dart';
import 'package:upayza/src/shared/constants/app_sizes.dart';
import 'package:upayza/src/shared/constants/app_string.dart';
import 'package:upayza/src/shared/extensions/app_context_extension.dart';
import 'package:upayza/src/shared/utils/app_constants.dart';

class CardView extends StatelessWidget {
  CardView({super.key});

  final List cards = [
    CreditCardUi(
      cardHolderFullName: 'John Doe',
      cardNumber: '1234567812345678',
      validFrom: '01/23',
      validThru: '01/28',
      topLeftColor: AppConstants.appColors.secondary,
      doesSupportNfc: true,
      placeNfcIconAtTheEnd: true,
      cardType: CardType.debit,
      cardProviderLogo: Assets.images.visa.image(),
      cardProviderLogoPosition: CardProviderLogoPosition.right,
      showBalance: true,
      balance: 128.32434343,
      autoHideBalance: true,
      enableFlipping: true,
      cvvNumber: '123',
    ).paddingSymmetric(horizontal: AppSize.halfSpacing),
    CreditCardUi(
      cardHolderFullName: 'John Doe',
      cardNumber: '1234567812345678',
      validFrom: '01/23',
      validThru: '01/28',
      topLeftColor: AppConstants.appColors.secondary,
      doesSupportNfc: true,
      placeNfcIconAtTheEnd: true,
      cardType: CardType.debit,
      cardProviderLogo: Assets.images.mastercard.image(),
      cardProviderLogoPosition: CardProviderLogoPosition.right,
      showBalance: true,
      balance: 128.32434343,
      autoHideBalance: true,
      enableFlipping: true,
      cvvNumber: '123',
    ).paddingSymmetric(horizontal: AppSize.halfSpacing),
    CreditCardUi(
      cardHolderFullName: 'John Doe',
      cardNumber: '1234567812345678',
      validFrom: '01/23',
      validThru: '01/28',
      topLeftColor: AppConstants.appColors.secondary,
      doesSupportNfc: true,
      placeNfcIconAtTheEnd: true,
      cardType: CardType.debit,
      cardProviderLogo: Assets.images.visa.image(),
      cardProviderLogoPosition: CardProviderLogoPosition.right,
      showBalance: true,
      balance: 128.32434343,
      autoHideBalance: true,
      enableFlipping: true,
      cvvNumber: '123',
    ).paddingSymmetric(horizontal: AppSize.halfSpacing),
    CreditCardUi(
      cardHolderFullName: 'John Doe',
      cardNumber: '1234567812345678',
      validFrom: '01/23',
      validThru: '01/28',
      topLeftColor: AppConstants.appColors.secondary,
      doesSupportNfc: true,
      placeNfcIconAtTheEnd: true,
      cardType: CardType.debit,
      cardProviderLogo: Assets.images.mastercard.image(),
      cardProviderLogoPosition: CardProviderLogoPosition.right,
      showBalance: true,
      balance: 128.32434343,
      autoHideBalance: true,
      enableFlipping: true,
      cvvNumber: '123',
    ).paddingSymmetric(horizontal: AppSize.halfSpacing),
    CreditCardUi(
      cardHolderFullName: 'John Doe',
      cardNumber: '1234567812345678',
      validFrom: '01/23',
      validThru: '01/28',
      topLeftColor: AppConstants.appColors.secondary,
      doesSupportNfc: true,
      placeNfcIconAtTheEnd: true,
      cardType: CardType.debit,
      cardProviderLogo: Assets.images.visa.image(),
      cardProviderLogoPosition: CardProviderLogoPosition.right,
      showBalance: true,
      balance: 128.32434343,
      autoHideBalance: true,
      enableFlipping: true,
      cvvNumber: '123',
    ).paddingSymmetric(horizontal: AppSize.halfSpacing),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /*const AppTitle.h2(
              title: AppString.transfer,
              fontWeight: FontWeight.bold,
            ),
            const AppTitle.h4(title: AppString.transferDescription),
            TransactionPanelWidget(color: color),
            const Divider(),*/
              AppSize.spacing.heightBox,
              const AppTitle.h2(
                title: AppString.cardTitle,
                fontWeight: FontWeight.w700,
              ),
              const AppTitle.h5(title: AppString.cardDescription),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const AppTitle(
                    title: "Filter",
                    fontWeight: FontWeight.w800,
                  ),
                  AppSize.halfSpacing.widthBox,
                  Assets.icons.preferences.svg(),
                ],
              ),
              SizedBox(
                height: AppSize.mdContainerSize * 1.28,
                child: PageView(
                  controller: PageController(
                    initialPage: 0,
                    viewportFraction: .85,
                  ),
                  children: [...cards],
                ),
              ).paddingSymmetric(vertical: AppSize.tripleSpacing),
              const AppTitle(title: 'Active Cards')
                  .paddingSymmetric(vertical: AppSize.doubleSpacing),
              Container(
                height: AppSize.mdContainerSize / 1.1,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppSize.borderRadius),
                  border: Border.all(
                    color: context.colorScheme.primary,
                    width: .5,
                  ),
                  color: context.colorScheme.primary.withOpacity(.5),
                ),
                child: Row(
                  children: [
                    SizedBox(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const AppTitle(
                                title: 'RBC',
                                fontWeight: FontWeight.bold,
                              ),
                              const AppTitle.h4(title: '****************5678'),
                              AppSize.doubleSpacing.heightBox,
                              const AppTitle.h4(title: 'Loïc NSILI B.'),
                            ],
                          ),
                          AppSize.doubleSpacing.widthBox,
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              AppSize.tripleSpacing.heightBox,
                              AppSize.doubleSpacing.heightBox,
                              const AppTitle.h4(title: 'Validity'),
                              const AppTitle.h4(title: '04/25'),
                            ],
                          ),
                        ],
                      ),
                    ).expanded(flex: 3),
                    CreditCardUi(
                      cardHolderFullName: 'John Doe',
                      cardNumber: '1234567812345678',
                      validFrom: '01/23',
                      validThru: '01/28',
                      topLeftColor: context.colorScheme.secondary,
                      doesSupportNfc: true,
                      placeNfcIconAtTheEnd: true,
                      cardType: CardType.debit,
                      cardProviderLogo: const FlutterLogo(),
                      cardProviderLogoPosition: CardProviderLogoPosition.right,
                      showBalance: true,
                      balance: 128.32434343,
                      autoHideBalance: true,
                      enableFlipping: true,
                      cvvNumber: '123',
                    ).expanded()
                  ],
                ).paddingSymmetric(
                  horizontal: AppSize.padding,
                  vertical: AppSize.padding,
                ),
              ),
              AppSize.tripleSpacing.heightBox,
              DottedBorder(
                borderType: BorderType.RRect,
                radius: const Radius.circular(AppSize.borderRadius),
                padding: const EdgeInsets.all(AppSize.halfSpacing),
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(AppSize.borderRadius),
                  ),
                  child: SizedBox(
                    height: AppSize.mdContainerSize,
                    width: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FloatingActionButton(
                          onPressed: () => GoRouter.of(context)
                              .pushNamed(AppRoutes.addCard.name),
                          shape: const StadiumBorder(),
                          child: const Icon(
                            Iconsax.add,
                            color: Colors.white70,
                          ),
                        ),
                        AppSize.padding.heightBox,
                        const AppTitle(title: 'Add a card'),
                      ],
                    ),
                  ),
                ),
              ).paddingSymmetric(vertical: AppSize.doubleSpacing),
            ],
          ).paddingSymmetric(horizontal: AppSize.halfSpacing),
        ).paddingSymmetric(horizontal: AppSize.padding),
      ),
    );
  }
}
