package com.complycube.flutter.complycube

import android.content.Context
import android.content.Intent
import android.graphics.Color
import android.os.Handler
import android.os.Looper
import android.util.Log
import android.view.View
import android.widget.TextView
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.platform.PlatformView


var methodChannel: MethodChannel? = null

internal class ComplyCubeNativeView(context: Context, id: Int, creationParams: Map<String?, Any?>?) : PlatformView,
    FlutterActivity() {
    private val textView: TextView


    override fun getView(): View {
        return textView
    }

    override fun dispose() {}

    init {
        val fe = FlutterEngine(context)

        methodChannel = MethodChannel(fe.dartExecutor.binaryMessenger, "complycube_widget");
        /// Invoke method with callback
        Handler(Looper.getMainLooper()).post {
            // Call the desired channel message here.
            methodChannel?.invokeMethod("onCanceled", null, object : MethodChannel.Result {
                override fun success(result: Any?) {
                    Log.i("MethodInvokeSuccess","success--------")
                }

                override fun error(errorCode: String, errorMessage: String?, errorDetails: Any?) {
                    Log.e("MethodError","error $errorCode $errorMessage $errorDetails")
                }

                override fun notImplemented() {
                    println("notImplemented")
                }
            })
            Log.i("Withhandlers", "onCanceled on main thread")
        }



        textView = TextView(context)
        textView.textSize = 72f
        textView.setBackgroundColor(Color.rgb(255, 255, 255))
        textView.text = ""

        val intent = Intent(context, ComplyCubeComponent::class.java)
        intent.putExtra("Hello", "World")
        context.startActivity(intent)
    }
}
