import 'dart:async';

import '../../config/strings.dart';
import '../service/local_service.dart' show LocalService;

abstract class LocalRepository {
  String get authTokenStorageKey;
  String get refreshTokenStorageKey;
  String get firstLaunchStorageKey;

  void setData({required String key, required Object data});

  Future<Object?> getData({required String key});

  void removeData({required String key});

  void clearAll();

  void setBoolData({required String key, required bool data});

  Future<bool?> getBoolData({required String key});

  Future<bool> isFirstLaunch();
  Future<String?> getAuthToken();
  Future<String?> getRefreshToken();
  Future<void> saveAuthToken({required String token});
  Future<void> saveRefreshToken({required String token});
  Future<void> deleteToken();
}

class LocalRepositoryImpl implements LocalRepository {
  LocalRepositoryImpl({required this.localService});
  final LocalService localService;

  @override
  String get authTokenStorageKey => USER_TOKEN_STORAGE_KEY;
  @override
  String get refreshTokenStorageKey => REFRESH_TOKEN_STORAGE_KEY;
  @override
  String get firstLaunchStorageKey => FIRST_LAUNCH_KEY;

  @override
  void clearAll() {
    localService.clearAll();
  }

  @override
  Future<bool?> getBoolData({required String key}) async {
    return localService.getBoolData(key: key);
  }

  @override
  Future<Object?> getData({required String key}) async {
    return localService.getData(key: key);
  }

  @override
  void removeData({required String key}) {
    localService.removeData(key: key);
  }

  @override
  void setBoolData({required String key, required bool data}) {
    localService.setBoolData(key: key, data: data);
  }

  @override
  void setData({required String key, required Object data}) {
    localService.setData(key: key, data: data);
  }

  @override
  Future<void> deleteToken() async {
    localService.removeData(key: authTokenStorageKey);
  }

  @override
  Future<String?> getAuthToken() async {
    final data = await localService.getData(key: authTokenStorageKey);
    if (data == null) {
      return null;
    } else {
      return data as String;
    }
  }

  @override
  Future<bool> isFirstLaunch() async {
    final status = await localService.getBoolData(key: firstLaunchStorageKey);
    if (status == null || status == true) {
      localService.setBoolData(key: firstLaunchStorageKey, data: false);
      return true;
    } else {
      return false;
    }
  }

  @override
  Future<void> saveAuthToken({required String token}) async {
    localService.setData(key: authTokenStorageKey, data: token);
  }

  @override
  Future<String?> getRefreshToken() async {
    final data = await localService.getData(key: refreshTokenStorageKey);
    if (data == null) {
      return null;
    } else {
      return data as String;
    }
  }

  @override
  Future<void> saveRefreshToken({required String token}) async {
    localService.setData(key: refreshTokenStorageKey, data: token);
  }
}
