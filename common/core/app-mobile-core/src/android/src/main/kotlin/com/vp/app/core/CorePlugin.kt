package com.vp.app.core

import androidx.annotation.NonNull

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import android.annotation.SuppressLint
import android.content.Context
import android.content.pm.PackageInfo
import android.content.pm.PackageManager
import android.content.pm.Signature
import android.os.Build
import android.util.Base64
import java.security.MessageDigest
import java.security.NoSuchAlgorithmException
import java.util.Locale

/** CorePlugin */
class CorePlugin: FlutterPlugin, MethodCallHandler {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private lateinit var channel : MethodChannel
  private lateinit var context: Context

  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "core")
    channel.setMethodCallHandler(this)
    context = flutterPluginBinding.applicationContext
  }

  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
    val arguments = call.arguments as? Map<String, Any>
    var sha = ""
    arguments.let {
        sha = it?.get("sha") as? String ?: ""
    }

     if (call.method == "appIntegrity") {
        val appIntegrityValid = verifyAppSignature(context, sha)
         result.success(appIntegrityValid)
     } else if (call.method == "exit") {
        android.os.Process.killProcess(android.os.Process.myPid())
        System.exit(1)
     } else {
      result.notImplemented()
    }
  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }

    private fun verifyAppSignature(context: Context, sha1: String): Boolean {
        //you should load approvedSignatures from a secure place not plain text
        //val sha1 = "03:3B:23:85:AC:E3:52:A3:C5:5B:BB:9F:5C:BB:50:07:74:50:83:F5"
        val approvedSignatures: MutableList<String> = ArrayList()
        approvedSignatures.add(sha1.replace(":", ""))
        val currentSignatures: List<String?>? = getSignatures(context.packageManager, context.packageName)

        if (currentSignatures != null && currentSignatures.size > 0) {
            //first checking if no unapproved signatures exist
            for (signatureHex in currentSignatures) {
                if (!approvedSignatures.contains(signatureHex)) {
                    return false
                }
            }
            //now checking if any of approved signatures exist
            for (signatureHex in currentSignatures) {
                if (approvedSignatures.contains(signatureHex)) {
                    return true
                }
            }
        }
        return false
    }

    fun bytesToHex(bytes: ByteArray): String {
        val builder = StringBuilder()
        for (aByte in bytes) {
            builder.append(String.format("%02x", aByte))
        }
        return builder.toString()
    }

    private fun signatureDigest(sig: Signature): String? {
        val signature: ByteArray = sig.toByteArray()
        return try {
            val md: MessageDigest = MessageDigest.getInstance("SHA1")
            val digest: ByteArray = md.digest(signature)
            bytesToHex(digest)?.uppercase(Locale.getDefault())
        } catch (e: NoSuchAlgorithmException) {
            null
        }
    }

    private fun signatureDigest(sigList: Array<Signature>): List<String?> {
        val signaturesList: MutableList<String> = ArrayList()
        for (signature in sigList) {
            if (signature != null) {
                signatureDigest(signature)?.let { signaturesList.add(it) }
            }
        }
        return signaturesList
    }

    private fun getSignatures(@NonNull pm: PackageManager, @NonNull packageName: String): List<String?>? {
        return try {
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.P) {
                val packageInfo: PackageInfo = pm.getPackageInfo(packageName, PackageManager.GET_SIGNING_CERTIFICATES)
                if (packageInfo == null
                        || packageInfo.signingInfo == null) {
                    return null
                }
                signatureDigest(packageInfo.signingInfo.apkContentsSigners)
            } else {
                @SuppressLint("PackageManagerGetSignatures") val packageInfo: PackageInfo = pm.getPackageInfo(packageName, PackageManager.GET_SIGNATURES)
                if (packageInfo == null || packageInfo.signatures == null || packageInfo.signatures.size === 0 || packageInfo.signatures.get(0) == null) {
                    null
                } else signatureDigest(packageInfo.signatures)
            }
        } catch (e: PackageManager.NameNotFoundException) {
            null
        }
    }
}
