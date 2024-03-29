
import 'package:tiktok_open_sdk/share_tiktok_param.dart';

import 'tiktok_open_sdk_platform_interface.dart';

class TiktokOpenSdk {
  Future<String?> getPlatformVersion() {
    return TiktokOpenSdkPlatform.instance.getPlatformVersion();
  }

  void shareToTikTok(ShareTiktokParam param) {
    TiktokOpenSdkPlatform.instance.shareToTikTok(param);
  }
}
