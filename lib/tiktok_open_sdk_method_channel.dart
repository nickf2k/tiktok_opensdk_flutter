import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:tiktok_open_sdk/constants.dart';

import 'share_tiktok_param.dart';
import 'tiktok_open_sdk_platform_interface.dart';

/// An implementation of [TiktokOpenSdkPlatform] that uses method channels.
class MethodChannelTiktokOpenSdk extends TiktokOpenSdkPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel(kPluginMethodChannel);

  @override
  Future<String?> getPlatformVersion() async {
    final version =
        await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }

  @override
  void shareToTikTok(ShareTiktokParam param) {
    methodChannel.invokeMethod<String>(kShareToTiktokMethod, param.toJson());
  }

  @override
  void loginToTiktok(String clientKey) {
    methodChannel.invokeMethod<String>(kLoginToTiktokMethod, {
      'clientKey': clientKey,
    });
  }
}
