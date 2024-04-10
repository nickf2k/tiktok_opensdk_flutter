
import 'tiktok_opensdk_flutter_platform_interface.dart';

class TiktokOpensdkFlutter {
  Future<String?> getPlatformVersion() {
    return TiktokOpensdkFlutterPlatform.instance.getPlatformVersion();
  }
}
