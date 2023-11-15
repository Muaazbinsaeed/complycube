package com.complycube.flutter.complycube

import android.os.Bundle
import android.view.Window
import androidx.activity.ComponentActivity
import com.complycube.sdk.ComplyCubeSdk
import com.complycube.sdk.common.data.ClientAuth
import com.complycube.sdk.common.data.Result
import com.complycube.sdk.presentation.theme.SdkColors
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import org.json.JSONArray
import org.json.JSONObject


class ComplyCubeComponent : ComponentActivity() {
    private var flutterEngine: FlutterEngine? = null
    private var methodChannel: MethodChannel? = null

    override fun onCreate(savedInstanceState: Bundle?) {

        super.onCreate(savedInstanceState)
        var settings = intent.getStringExtra("settings") as String
        val s = ComplyCubeSettings(ms!!)

        // Event listener
        var builder = ComplyCubeSdk.Builder(this){
            if(it is Result.Canceled){
                // emitter.emit("ComplyCubeCancel", JSONObject().put("message", it).toString())
                mc?.invokeMethod("onCanceled", JSONObject().put("message", it).toString())
            }
            if(it is Result.Error){
                // emitter.emit("ComplyCubeError", JSONObject().put("message", it).toString())
                mc?.invokeMethod("onError", JSONObject().put("message", it).toString())
            }
            if(it is Result.Success){
                var poaResults = ArrayList<String>()
                var documents = ArrayList<String>()
                var selfievideo = ArrayList<String>()
                var selfiePhoto = ArrayList<String>()
                for(i in  it.stages){
                    ccLog("result: ${i}")
                    if(i is Result.StageResult.Document){
                        ccLog("am document: ${i.id}")
                        documents.add(i.id)
                    }
                    if(i is Result.StageResult.ProofOfAddress){
                        poaResults.add(i.id)
                    }
                    if(i is Result.StageResult.LivePhoto){
                        selfiePhoto.add(i.id)
                    }
                    if(i is Result.StageResult.LiveVideo){
                        selfievideo.add(i.id)
                    }
                }
                var result = JSONObject()
                result.put("documentIds", JSONArray(documents))
                result.put("livePhotoIds", JSONArray(selfiePhoto))
                result.put("liveVideoIds", JSONArray(selfievideo))
                result.put("poaIds", JSONArray(poaResults))
                ccLog("Emmiting success result ${result.toString()}")
                // emitter.emit("ComplyCubeSuccess", result.toString())
                mc?.invokeMethod("onSuccess", result.toString())
            }
        }
        // Prepare stages

        builder.withStages(s.stages[0], *s.stages.drop(1).toTypedArray())
        ccLog("Stages ====== : ${s.stages.size}")
        s.stages.map {
            ccLog("Stage: ${it}")
        }
        if(s.countries.size > 0){
            builder.withCountries(s.countries[0], *s.countries.drop(1).toTypedArray())
        }

        if(s.colorScheme != null){
            builder.withCustomColors(s.colorScheme as SdkColors)
        }
        builder.withCustomCallbacks(enable = true)

        builder.start(
            ClientAuth(
                s.clientToken
                ,s.clientID
            )
        )
        requestWindowFeature(Window.FEATURE_NO_TITLE)

        val intent = intent
        //val settings_ = intent.getStringExtra("settings")
        //Log.d("Flutter ComplyCube", "$settings_")
    }
}