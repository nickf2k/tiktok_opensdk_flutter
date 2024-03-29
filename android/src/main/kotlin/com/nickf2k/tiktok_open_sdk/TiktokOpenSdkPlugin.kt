package com.nickf2k.tiktok_open_sdk

import android.app.Activity
import androidx.annotation.NonNull
import androidx.annotation.Nullable
import com.tiktok.open.sdk.share.Format
import com.tiktok.open.sdk.share.MediaType
import com.tiktok.open.sdk.share.ShareApi
import com.tiktok.open.sdk.share.ShareRequest
import com.tiktok.open.sdk.share.model.MediaContent

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

/** TiktokOpenSdkPlugin */
class TiktokOpenSdkPlugin: FlutterPlugin, MethodCallHandler, ActivityAware {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private lateinit var channel : MethodChannel
  private var activity: Activity? = null

  override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "tiktok_open_sdk")
    channel.setMethodCallHandler(this)
  }

  override fun onMethodCall(call: MethodCall, result: Result) {
    when (call.method) {
        "getPlatformVersion" -> result.success("Android ${android.os.Build.VERSION.RELEASE}")
        "shareToTikTok" -> {
          assert(activity != null) { "Activity is null" }
          // mediaPaths and mediaType are required
          // mediaPaths is a list of file paths
          assert(call.argument<List<String>>("mediaPaths") != null) { "mediaPaths is null" }
          assert(call.argument<String>("mediaType") != null) { "mediaType is null" }
          assert(call.argument<String>("shareFormat") != null) { "shareFormat is null" }
          assert(call.argument<String>("clientKey") != null) { "clientKey is null" }
          val shareApi = ShareApi(activity = activity!!)
          val mediaContent = MediaContent(
            mediaType = MediaType.valueOf(call.argument("mediaType") ?: "IMAGE"), // default to IMAGE
            mediaPaths = call.argument("mediaPaths")!!,
            // default to IMAGE,
          )
          val shareFormat = Format.valueOf(call.argument("shareFormat") ?: "DEFAULT")
          val request = ShareRequest(
            clientKey = call.argument("clientKey")!!,
            mediaContent = mediaContent,
            shareFormat = shareFormat,
            packageName = activity!!.packageName,
            resultActivityFullPath = "com.nickf2k.tiktok_open_sdk.TiktokOpenSdkActivity",

            )
          shareApi.share(request = request)
          result.success("SUCCESS")

        }
        else -> {
          result.notImplemented()
        }
    }
  }

  override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }

  override fun onAttachedToActivity(binding: ActivityPluginBinding) {
    activity = binding.activity
  }

  override fun onDetachedFromActivityForConfigChanges() {
    activity = null
  }

  override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
    activity = binding.activity
  }

  override fun onDetachedFromActivity() {
    activity = null
  }
}
