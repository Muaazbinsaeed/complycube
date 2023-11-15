package com.complycube.flutter.complycube

import android.app.Activity
import android.content.Intent
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

/** ComplycubePlugin */

var mc: MethodChannel? = null
var ms: HashMap<String, Any>? = null
class ComplycubePlugin: FlutterPlugin, MethodCallHandler, ActivityAware {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  lateinit var channel : MethodChannel
  var act: Activity? = null

  // Make channel accessible from ComplyCubeComponent
  fun startComplyCube(activity: Activity, config: HashMap<String, Any>, callback: Result) {
    // Passing string to global variable
    ms = config
    val intent = Intent(activity, ComplyCubeComponent::class.java)
    intent.putExtra("settings", config.toString())
    activity.startActivity(intent)
  }

  override fun onAttachedToActivity(binding: ActivityPluginBinding) {
    this.act = binding.activity;
  }

  override fun onDetachedFromActivity(){

  }

  override fun onDetachedFromActivityForConfigChanges() {
    //this.activity = binding.activity;
  }
  override fun onReattachedToActivityForConfigChanges(p0: ActivityPluginBinding){

  }

  override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "complycube_widget")
    channel.setMethodCallHandler(this)
    mc = channel
  }

  override fun onMethodCall(call: MethodCall, result: Result) {
    println("onMethodCall -------------------------")
    // val stageConfig =  call.argument<String>("settings")
    println(call.method)
    if (call.method == "getPlatformVersion") {
      result.success("Android ${android.os.Build.VERSION.RELEASE}")
    } else if (call.method == "method") {
      if(act != null){
        // Get the settings from the call
        // Start argument as hashmap
        var settings = call.arguments as HashMap<String, Any>

        startComplyCube(act!!, settings, result)
      }

    } else {
      result.notImplemented()
    }
  }



  override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }
}
