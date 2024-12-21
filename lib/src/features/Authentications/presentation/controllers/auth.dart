import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:upayza/src/core/models/user.dart';
import 'package:upayza/src/shared/preferences/app_user_preferences.dart';

final  userProvider = StateProvider<User?>((ref) => AppUserPreferences().getUser());
