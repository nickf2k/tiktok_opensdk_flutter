import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'share_tiktok_param.dart';
import 'tiktok_open_sdk_platform_interface.dart';

/// An implementation of [TiktokOpenSdkPlatform] that uses method channels.
class MethodChannelTiktokOpenSdk extends TiktokOpenSdkPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('tiktok_open_sdk');

  @override
  Future<String?> getPlatformVersion() async {
    final version =
        await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }

  @override
  void shareToTikTok(ShareTiktokParam param) {
    final result =
        methodChannel.invokeMethod<String>('shareToTikTok', param.toJson());
  }
}
