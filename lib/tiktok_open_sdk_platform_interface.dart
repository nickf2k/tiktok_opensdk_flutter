import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'package:tiktok_open_sdk/share_tiktok_param.dart';

import 'tiktok_open_sdk_method_channel.dart';

abstract class TiktokOpenSdkPlatform extends PlatformInterface {
  /// Constructs a TiktokOpenSdkPlatform.
  TiktokOpenSdkPlatform() : super(token: _token);

  static final Object _token = Object();

  static TiktokOpenSdkPlatform _instance = MethodChannelTiktokOpenSdk();

  /// The default instance of [TiktokOpenSdkPlatform] to use.
  ///
  /// Defaults to [MethodChannelTiktokOpenSdk].
  static TiktokOpenSdkPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [TiktokOpenSdkPlatform] when
  /// they register themselves.
  static set instance(TiktokOpenSdkPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  void shareToTikTok(ShareTiktokParam param) {
    throw UnimplementedError('shareToTiktok() has not been implemented.');
  }
}
