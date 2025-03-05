import 'dart:async';import 'package:shared_preferences/shared_preferences.dart';/// Abstract class of LocalServiceabstract class LocalService {  void init();  bool get hasInitialized;  void setData({required String key, required Object data});  Future<Object?> getData({required String key});  void removeData({required String key});  void clearAll();  void setBoolData({required String key, required bool data});  Future<bool?> getBoolData({required String key});  void setStringList({required String key, required List<String> data});  Future<List<String>?> getStringList({required String key});}class LocalServiceImpl implements LocalService {  SharedPreferences? sharedPreferences;  @override  Future<void> init() async {    sharedPreferences = await SharedPreferences.getInstance();  }  @override  Future<void> setData({required String key, dynamic data}) async {    await sharedPreferences!.setString(key, data);  }  @override  Future<Object?> getData({required String key}) async {    if (!hasInitialized) {      await init();    }    final Object? data = sharedPreferences!.getString(key);    return data;  }  @override  Future<void> setStringList({required String key, dynamic data}) async {    await sharedPreferences!.setStringList(key, data);  }  @override  Future<void> setBoolData({required String key, required bool data}) async {    if (!hasInitialized) {      await init();    }    await sharedPreferences!.setBool(key, data);  }  @override  Future<bool?> getBoolData({required String key}) async {    if (!hasInitialized) {      await init();    }    final data = sharedPreferences!.getBool(key);    return data;  }  @override  Future<void> removeData({required String key}) async {    if (!hasInitialized) {      await init();    }    await sharedPreferences!.remove(key);  }  @override  Future<void> clearAll() async {    if (!hasInitialized) {      await init();    }    await sharedPreferences!.clear();  }  @override  bool get hasInitialized => sharedPreferences != null;  @override  Future<List<String>?> getStringList({required String key}) async {    if (!hasInitialized) {      await init();    }    final data = sharedPreferences!.getStringList(key);    return data;  }}