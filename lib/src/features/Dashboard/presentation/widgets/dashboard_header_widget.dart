import 'package:flutter/material.dart';
import 'package:upayza/src/features/Dashboard/presentation/widgets/avatar_name_widget.dart';
import 'package:upayza/src/shared/components/app_notification_badge.dart';
import 'package:upayza/src/shared/preferences/app_user_preferences.dart';


class DashboardHeaderWidget extends StatelessWidget {
   DashboardHeaderWidget({super.key});
  final user = AppUserPreferences().getUser();
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        AvatarNameWidget(username: user?.firstName),
        const AppNotificationBadge()
      ],
    );
  }
}
