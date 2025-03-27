import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:ecomercy_app_flutter/interfaces/connectivity_interface.dart';
import 'package:get/get.dart';

class ConnectivityService extends GetxService implements IConnectivity {
  @override
  //kiểm tra kết nối internet
  Future<bool> checkConnected() async{
    final connectivityResult = await Connectivity().checkConnectivity(); //Lấy trạng thái mạng hiện tại.
    //Nếu không phải none, nghĩa là có mạng (WiFi hoặc mobile).
    return connectivityResult != ConnectivityResult.none;
  }

}