// import 'package:app_diy/utils/jwt.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../configs/constants/storage_key.dart';
import '../interfaces/storage_interface.dart';

class StorageService extends GetxService implements IStorage {

  late final GetStorage _storage;

  Future<StorageService> init() async {
    //GetStorage.init() khởi tạo hệ thống lưu trữ của GetStorage.
    await GetStorage.init();
    //Sau khi khởi tạo, tạo một instance của GetStorage để lưu và lấy dữ liệu.
    _storage = GetStorage();
    //Cả _storage1 và _storage2 đều dùng chung một bộ nhớ đã được khởi tạo bởi GetStorage.init().
    //Chúng không phải là hai bộ nhớ độc lập. Nếu bạn lưu dữ liệu bằng _storage1, thì _storage2 cũng có thể đọc được dữ liệu đó.
    return this;
  }

  @override
  Future<bool> clear() async {
    await _storage.erase();
    return true;
  }

  @override
  Future<String?> delete<T>(String key) async {
    final value = _storage.read(key);
    await _storage.remove(key);
    return value;
  }

  @override
  Future<String?> get<T>(String key) async {
    return _storage.read<String>(key);
  }

  @override
  Future<bool> set<T>(String key, String value) async {
    await _storage.write(key, value);
    return true;
  }


  // //decodeToken() → Giải mã token thành JSON.
  // Future<dynamic> decodeToken() async {
  //   try {
  //     var token = await get(StorageKey.token);
  //     if (token == null) throw Exception("Token is null");
  //     return Jwt.parseJwtPayLoad(token);
  //   } catch (error) {
  //     return Future.error(error);
  //   }
  // }

  //sDùng StorageKey.token để tránh lỗi chính tả khi đặt key.
  Future<bool> setToken(String token) async {
    //dùng storageKey để tránh gõ sai, dễ sửa chữa
    await set(StorageKey.token, token);
    return true;
  }

  Future<dynamic> getToken() async {
    try {
      return await get(StorageKey.token);
    } catch (error) {
      return Future.error(error);
    }
  }
}
