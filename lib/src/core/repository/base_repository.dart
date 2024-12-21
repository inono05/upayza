import 'package:upayza/src/shared/network/api/api.dart';

abstract class BaseRepository{
  final Api api;
  BaseRepository(this.api);
}