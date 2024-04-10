import 'package:flutter_test/flutter_test.dart';
import 'package:tiktok_opensdk_flutter/tiktok_opensdk_flutter.dart';
import 'package:tiktok_opensdk_flutter/tiktok_opensdk_flutter_platform_interface.dart';
import 'package:tiktok_opensdk_flutter/tiktok_opensdk_flutter_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockTiktokOpensdkFlutterPlatform
    with MockPlatformInterfaceMixin
    implements TiktokOpensdkFlutterPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final TiktokOpensdkFlutterPlatform initialPlatform = TiktokOpensdkFlutterPlatform.instance;

  test('$MethodChannelTiktokOpensdkFlutter is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelTiktokOpensdkFlutter>());
  });

  test('getPlatformVersion', () async {
    TiktokOpensdkFlutter tiktokOpensdkFlutterPlugin = TiktokOpensdkFlutter();
    MockTiktokOpensdkFlutterPlatform fakePlatform = MockTiktokOpensdkFlutterPlatform();
    TiktokOpensdkFlutterPlatform.instance = fakePlatform;

    expect(await tiktokOpensdkFlutterPlugin.getPlatformVersion(), '42');
  });
}
