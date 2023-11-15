package com.complycube.flutter.complycube

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

var globalEngine: MethodChannel? = null
class ComplyCubeActivity : FlutterActivity() {
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        globalEngine = MethodChannel(flutterEngine.dartExecutor.binaryMessenger, "complycube_widget")
        // Register the channel so that the native code can invoke the dart code
        flutterEngine
            .platformViewsController
            .registry
            .registerViewFactory("ComplyCubeWidget",
                ComplyCubeNativeViewFactory())
    }
}