import 'package:localstore/localstore.dart';

import '../../core/models/user.dart';

class AppLocaleStore {
  static AppLocaleStore? _instance;
  static Localstore? _db;

  factory AppLocaleStore() {
    if (_instance == null) {
      throw Exception('AppLocaleStore is not initialized. '
          'Please call AppLocaleStore.ensureInitialized before.');
    }
    return _instance!;
  }

  const AppLocaleStore._();

  static ensureInitialized() async {
    _db ??= Localstore.instance;
    _instance ??= const AppLocaleStore._();
  }

  Future<void> addLocalUser(User user) async {
    await _db
        ?.collection(_userCollectionName)
        .doc('${user.id}')
        .set(user.toJson());
  }

  Future<User?> getLocalUser() async {
    final Map<String, dynamic>? rawUser =
        await _db?.collection(_userCollectionName).get();
    if (rawUser != null) {
      return rawUser.values
          .cast<Map<String, dynamic>>()
          .map((e) => User.fromJson(e))
          .first;
    }
    return null;
  }

  Future<void> deleteLocalUser(User user) async {
    await _db
        ?.collection(_userCollectionName)
        .doc(user.id!.toString())
        .delete();
  }

  static const String _userCollectionName = "user";
}
