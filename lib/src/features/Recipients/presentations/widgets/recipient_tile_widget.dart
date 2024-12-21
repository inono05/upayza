import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../shared/components/app_title.dart';
import '../../../../shared/constants/app_sizes.dart';
import '../../../../shared/utils/app_constants.dart';
import '../../domain/recipient_json_response.dart';

class RecipientTileWidget extends ConsumerStatefulWidget {
  const RecipientTileWidget({
    super.key,
    required this.splashColor,
    required this.recipient,
    required this.name,
  });

  final Color splashColor;
  final Recipient recipient;
  final String name;

  @override
  ConsumerState createState() => _RecipientTileWidgetState();
}

class _RecipientTileWidgetState extends ConsumerState<RecipientTileWidget> {

  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    final recipient = widget.recipient;
    final operatorLabel = recipient.operator?.label?.split(' ').first;
    final operatorCountryCode = recipient.operator?.country?.code;
    return Material(
        elevation: 1.0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppSize.borderRadius/3)),
        child: ListTile(
          splashColor: widget.splashColor.withOpacity(.2),
          minTileHeight: 70,
          title: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AppTitle.h4(title: recipient.lastName!.capitalize),
              AppSize.halfSpacing.widthBox,
              AppTitle.h4(title: recipient.firstName!.capitalize),
            ],
          ),
          isThreeLine: true,
          subtitle: AppTitle.h5(title: "${recipient.number!} ($operatorLabel $operatorCountryCode)"),
          leading: CircleAvatar(
            radius: AppSize.doubleBorderRadius * 1.4,
            child: AppTitle.h4(
              title: widget.name,
              fontWeight: FontWeight.w700,
              color: AppConstants.appColors.surface,
            ).toCenter(),
          ),
        ),
      ).paddingOnly(bottom: AppSize.halfPadding);
  }
}