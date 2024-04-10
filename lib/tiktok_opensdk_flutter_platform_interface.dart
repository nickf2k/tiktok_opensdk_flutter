import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'tiktok_opensdk_flutter_method_channel.dart';

abstract class TiktokOpensdkFlutterPlatform extends PlatformInterface {
  /// Constructs a TiktokOpensdkFlutterPlatform.
  TiktokOpensdkFlutterPlatform() : super(token: _token);

  static final Object _token = Object();

  static TiktokOpensdkFlutterPlatform _instance = MethodChannelTiktokOpensdkFlutter();

  /// The default instance of [TiktokOpensdkFlutterPlatform] to use.
  ///
  /// Defaults to [MethodChannelTiktokOpensdkFlutter].
  static TiktokOpensdkFlutterPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [TiktokOpensdkFlutterPlatform] when
  /// they register themselves.
  static set instance(TiktokOpensdkFlutterPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
