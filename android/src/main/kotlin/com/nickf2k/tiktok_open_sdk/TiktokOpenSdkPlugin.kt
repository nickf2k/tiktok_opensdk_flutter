package com.nickf2k.tiktok_open_sdk

import android.app.Activity
import android.content.Intent
import android.widget.Toast
import androidx.annotation.NonNull
import androidx.annotation.Nullable
import com.tiktok.open.sdk.auth.AuthApi
import com.tiktok.open.sdk.auth.AuthRequest
import com.tiktok.open.sdk.auth.utils.PKCEUtils
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
import io.flutter.plugin.common.PluginRegistry

/** TiktokOpenSdkPlugin */
class TiktokOpenSdkPlugin : FlutterPlugin, MethodCallHandler, ActivityAware,
    PluginRegistry.NewIntentListener {

    private lateinit var channel: MethodChannel
    private var activity: Activity? = null
    private lateinit var shareApi: ShareApi
    private  var shareSuccessMsg = "Share success"
    private lateinit var errorToastMsg: String

    companion object {
        const val PLUGIN_METHOD_CHANNEL = "tiktok_open_sdk"
        const val METHOD_LOGIN_TO_TIKTOK = "loginToTiktok"
        const val METHOD_SHARE_TO_TIKTOK = "shareToTikTok"
        const val ARGUMENT_MEDIA_PATHS = "mediaPaths"
        const val ARGUMENT_MEDIA_TYPE = "mediaType"
        const val ARGUMENT_SHARE_FORMAT = "shareFormat"
        const val ARGUMENT_CLIENT_KEY = "clientKey"
        const val ARGUMENT_SHARE_SUCCESS_MSG = "shareSuccessMsg"
        const val DEFAULT_MEDIA_TYPE = "IMAGE"
        const val DEFAULT_SHARE_FORMAT = "DEFAULT"

    }

    /// The MethodChannel that will the communication between Flutter and native Android
    ///
    /// This local reference serves to register the plugin with the Flutter Engine and unregister it
    /// when the Flutter Engine is detached from the Activity
    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, PLUGIN_METHOD_CHANNEL)
        channel.setMethodCallHandler(this)
    }

    override fun onNewIntent(intent: Intent): Boolean {
        shareApi.getShareResponseFromIntent(intent).let {
            if (it != null) {
                if (it.isSuccess) {
                    Toast.makeText(
                        activity!!.applicationContext,
                        shareSuccessMsg,
                        Toast.LENGTH_SHORT
                    )
                        .show()
                } else {
                    android.util.Log.d("Tiktok error: ", it.errorMsg!!)
                    android.util.Log.d("Tiktok error code: ", "" + it.errorCode)
                    android.util.Log.d("Tiktok sub error code: ", "" + it.subErrorCode)
                    Toast.makeText(
                        activity!!.applicationContext,
                        "${it.errorCode}: ${it.errorMsg}",
                        Toast.LENGTH_SHORT
                    )
                        .show()
                }
            }
            return true
        }
    }


    override fun onMethodCall(call: MethodCall, result: Result) {
        when (call.method) {
            METHOD_LOGIN_TO_TIKTOK -> {
                assert(call.argument<String>(ARGUMENT_CLIENT_KEY) != null) { "$ARGUMENT_CLIENT_KEY is null" }

                // STEP 1: Create an instance of AuthApi
                val authApi = AuthApi(
                    activity = activity!!
                )

// STEP 2: Create an AuthRequest and set parameters
                val request = AuthRequest(
                    clientKey = call.argument(ARGUMENT_CLIENT_KEY)!!,
                    scope = "user.info.basic",
                    redirectUri = "www.your_domain.com",
                    codeVerifier = PKCEUtils.generateCodeVerifier(),
                )

// STEP 3: Invoke the authorize method
                authApi.authorize(
                    request = request,
                    authMethod = AuthApi.AuthMethod.TikTokApp
                )
            }

            METHOD_SHARE_TO_TIKTOK -> {
                shareSuccessMsg = call.argument(ARGUMENT_SHARE_SUCCESS_MSG) ?: shareSuccessMsg
                assert(activity != null) { "Activity is null" }
                // mediaPaths and mediaType are required
                // mediaPaths is a list of file paths
                assert(call.argument<List<String>>(ARGUMENT_MEDIA_PATHS) != null) { "$ARGUMENT_MEDIA_PATHS is null" }
                assert(call.argument<String>(ARGUMENT_SHARE_FORMAT) != null) { "$ARGUMENT_SHARE_FORMAT is null" }
                assert(call.argument<String>(ARGUMENT_CLIENT_KEY) != null) { "$ARGUMENT_CLIENT_KEY is null" }
                shareApi = ShareApi(activity = activity!!)
                val mediaContent = MediaContent(
                    mediaType = MediaType.valueOf(
                        call.argument(ARGUMENT_MEDIA_TYPE) ?: DEFAULT_MEDIA_TYPE
                    ), // default to IMAGE
                    mediaPaths = call.argument(ARGUMENT_MEDIA_PATHS)!!,
                    // default to IMAGE,
                )
                val shareFormat =
                    Format.valueOf(call.argument(ARGUMENT_SHARE_FORMAT) ?: DEFAULT_SHARE_FORMAT)
                val request = ShareRequest(
                    clientKey = call.argument(ARGUMENT_CLIENT_KEY)!!,
                    mediaContent = mediaContent,
                    shareFormat = shareFormat,
                    packageName = activity!!.packageName,
                    resultActivityFullPath = "${activity!!.packageName}.MainActivity",

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

