import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:upayza/src/core/models/gateway_json_response.dart';
import 'package:upayza/src/shared/extensions/app_context_extension.dart';
import 'package:upayza/src/shared/utils/app_helpers.dart';

import '../../../../shared/components/app_title.dart';
import '../../../../shared/constants/app_sizes.dart';
import '../controllers/state_controller.dart';

class GatewayWidget extends ConsumerWidget {
  const GatewayWidget({
    super.key,
    required this.gateway,
  });

  final mainAlignment = MainAxisAlignment.spaceBetween;
  final Gateway gateway;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedGateway = ref.watch(senderGatewayProvider);
    final isIdenticalGateway = identical(gateway, selectedGateway);
    final color = context.colorScheme.primary;
    final title = gateway.label!.toLowerCase();
    return Material(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          AppSize.borderRadius,
        ),
      ),
      elevation: 1.5,
      color: isIdenticalGateway ? color : Colors.white,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Container(
        height: AppSize.containerSize / 2,
        width: AppSize.containerSize * 1.5,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            AppSize.borderRadius,
          ),
          color: isIdenticalGateway ? color : Colors.white,
        ),
        foregroundDecoration: BoxDecoration(
          color: Colors.grey.withOpacity(isIdenticalGateway ? 0 : 1),
          backgroundBlendMode: BlendMode.saturation,
          border: const Border.fromBorderSide(BorderSide.none),
        ),
        child: AppTitle.h4(
          title: AppHelpers.gatewayTitle(gateway),
          fontWeight: FontWeight.w500,
          color: isIdenticalGateway
              ? context.colorScheme.surface
              : context.colorScheme.primary,
        ).toCenter(),
      ),
    ).paddingSymmetric(
      horizontal: AppSize.halfPadding,
      vertical: AppSize.halfPadding / 2,
    );
  }
}
