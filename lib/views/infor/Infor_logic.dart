import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';

class InfoController extends GetxController {
  var versionInfo = "".obs;

  @override
  void onInit() {
    super.onInit();
    loadVersion();
  }

  Future<void> loadVersion() async {
    final info = await PackageInfo.fromPlatform();
    versionInfo.value = "v${info.version}+${info.buildNumber}";
  }
}
