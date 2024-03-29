import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:tiktok_open_sdk/share_tiktok_param.dart';
import 'package:tiktok_open_sdk/tiktok_open_sdk.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';
  final _tiktokOpenSdkPlugin = TiktokOpenSdk();

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      platformVersion = await _tiktokOpenSdkPlugin.getPlatformVersion() ??
          'Unknown platform version';
      _tiktokOpenSdkPlugin.shareToTikTok(ShareTiktokParam(
          mediaPaths: ["path 1", "path 2"],
          mediaType: "VIDEO",
          clientKey: "client key",
          shareFormat: "DEFAULT"));
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Column(
            children: [
              Text('Running on: $_platformVersion\n'),
              ElevatedButton(
                  onPressed: () {
                    _tiktokOpenSdkPlugin.shareToTikTok(ShareTiktokParam(
                        mediaPaths: ["path 1", "path 2"],
                        mediaType: "VIDEO",
                        clientKey: "client key",
                        shareFormat: "DEFAULT"));
                  },
                  child: Text(
                    'Share to Tiktok',
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
