import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'tiktok_opensdk_flutter_platform_interface.dart';

/// An implementation of [TiktokOpensdkFlutterPlatform] that uses method channels.
class MethodChannelTiktokOpensdkFlutter extends TiktokOpensdkFlutterPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('tiktok_opensdk_flutter');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
