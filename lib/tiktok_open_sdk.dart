
import 'tiktok_open_sdk_platform_interface.dart';

class TiktokOpenSdk {
  Future<String?> getPlatformVersion() {
    return TiktokOpenSdkPlatform.instance.getPlatformVersion();
  }
}
