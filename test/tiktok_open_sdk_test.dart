import 'package:flutter_test/flutter_test.dart';
import 'package:tiktok_open_sdk/tiktok_open_sdk.dart';
import 'package:tiktok_open_sdk/tiktok_open_sdk_platform_interface.dart';
import 'package:tiktok_open_sdk/tiktok_open_sdk_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockTiktokOpenSdkPlatform
    with MockPlatformInterfaceMixin
    implements TiktokOpenSdkPlatform {
  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final TiktokOpenSdkPlatform initialPlatform = TiktokOpenSdkPlatform.instance;

  test('$MethodChannelTiktokOpenSdk is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelTiktokOpenSdk>());
  });

  test('getPlatformVersion', () async {
    TiktokOpenSdk tiktokOpenSdkPlugin = TiktokOpenSdk();
    MockTiktokOpenSdkPlatform fakePlatform = MockTiktokOpenSdkPlatform();
    TiktokOpenSdkPlatform.instance = fakePlatform;

    expect(await tiktokOpenSdkPlugin.getPlatformVersion(), '42');
  });
  test('shareToTikTok', () async {
    TiktokOpenSdk tiktokOpenSdkPlugin = TiktokOpenSdk();
    MockTiktokOpenSdkPlatform fakePlatform = MockTiktokOpenSdkPlatform();
    TiktokOpenSdkPlatform.instance = fakePlatform;

    // expect(await tiktokOpenSdkPlugin.shareToTikTok('test'), '42');
  });
}
