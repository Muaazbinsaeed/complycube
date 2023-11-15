package com.complycube.flutter.complycube

import android.graphics.Color
import android.util.Log
import com.complycube.sdk.common.data.Country
import com.complycube.sdk.common.data.IdentityDocumentType
import com.complycube.sdk.common.data.ProofOfAddressDocumentType
import com.complycube.sdk.common.data.Stage
import com.complycube.sdk.presentation.theme.SdkColors


fun ccLog(message: String) {
    Log.i("ComplyCube", message)
}



// Gson get array or map from json string



class ComplyCubeSettings {
    /**
     *
     */
    var clientID: String = ""
    var clientToken: String = ""
    var stages = arrayOf<Stage>() // Can be an array
    var colorScheme: SdkColors? = null
    var sCountries = mutableListOf<String>()
    var countries = arrayOf<Country>()

    public constructor(settings: HashMap<String, Any>){
        // TODO Make it more using if haskey to manage errorrs
        // convert struing to Hashmap

        var gson = settings
        ccLog("ComplyCube settings: ${gson.get("clientID") as String}")
        clientID = gson.get("clientID") as String ?: ""
        clientToken = gson.get("clientToken") as String ?: ""
        var stages = gson.get("stages") as ArrayList<Any>
        var scheme: Map<String, Any>? = null
        if(gson.containsKey("scheme")){
            scheme = gson.get("scheme") as Map<String, Any>
            this.buildScheme(scheme as Map<String, String>)
        }
        ccLog(scheme.toString())
        buildStages(stages)
        // Convert string countries to Country
        ccLog("Countries: ${sCountries.size}")
        for(country in sCountries.distinct()){
            countries += Country.valueOf(country)
        }
        ccLog("Stages: ${colorScheme.toString()}")
    }
    //
    private fun stageStringToCCStage(stage: String): Stage {
        print("ComplyCube: $stage")
        return when (stage) {
            "welcome" -> Stage.DefaultStage.Welcome()
            "consent" -> Stage.DefaultStage.UserConsent()
            "complete" -> Stage.DefaultStage.Complete()
            "face_capture" -> Stage.CustomStage.SelfiePhoto()
            "faceCapture" -> Stage.CustomStage.SelfiePhoto()
            "videoCapture" -> Stage.CustomStage.SelfieVideo()
            // Still the video capture and consent
            else -> Stage.DefaultStage.Complete()
        }
    }
    private fun extractCountries(countries: Array<String>): MutableList<String> {
        val countriesList = mutableListOf<String>()
        for (i in 0 until countries.size) {
            countriesList.add(countries.get(i) as String  ?: "")
        }
        return countriesList
    }
    private fun documentStageMapToCCStage(stage: Map<String, Any>): Stage{
        var ccStage: Stage? = null
        val stageName: String = stage.get("name") as String ?: ""
        // Check if the stages for more information
        val useMLAssistance = if ( stage.containsKey("useMLAssistance") ) stage.get("useMLAssistance") as Boolean ?: false else false
        val showGuidance = if( stage.containsKey("showGuidance") ) stage.get("showGuidance") as Boolean ?: false else false
        val retryLimit = if( stage.containsKey("retryLimit") ) stage.get("retryLimit") as Int ?: 0 else 0
        val liveCapture = if(stage.containsKey("liveCapture")) stage.get("liveCapture") as Boolean ?: false else false
        val title = if(stage.containsKey("title")) stage.get("title") as String ?: "" else ""
        ccLog("useMLAssistace ${useMLAssistance}")
        ccLog("showGuidance ${showGuidance}")
        ccLog("retryLimit ${retryLimit}")
        ccLog("liveCapture ${liveCapture}")

        when (stageName){
            "welcome" -> {
                // Get the other properties
                val heading: String = stage.get("heading") as String ?: ""
                val message: String = stage.get("message") as String ?: ""
                ccStage = Stage.DefaultStage.Welcome(heading,message)

            }
            "consent" -> {
                // Get the other properties
                val heading: String = stage.get("title") as String ?: ""
                val message: String = stage.get("text") as String ?: ""
                ccStage = Stage.DefaultStage.UserConsent(heading, message)
            }
            "documentCapture" -> {
                // Extract document types
                val documentTypes: Map<String, Any> = stage.get("documentTypes") as Map<String, Any>
                // Get keys

                // Get readableMap keys in array form

//                var keyIter: ReadableMapKeySetIterator = documentTypes.keySetIterator()
//                var keys: MutableList<String> = mutableListOf()
//                while (keyIter.hasNextKey()){
//                    keys.add(keyIter.nextKey())
//                }
                val keys = documentTypes.keys
                // Iterate through keys and get the values
                var ccDocumentTypes = arrayOf<IdentityDocumentType>()
                for (key in keys){
                    when (key){
                        "passport" -> {
                            // Get document type status
                            val documentQ = documentTypes.get(key)
                            if(documentQ is Boolean){
                                ccDocumentTypes += IdentityDocumentType.Passport()
                            }else if (documentQ is Array<*>){
                                val countries: Array<String> = documentTypes.get(key) as Array<String>
                                // Convert ReadableArray to MutableList
                                val ccCountries = this.extractCountries(countries)
                                this.sCountries.addAll(ccCountries)
                                ccDocumentTypes += IdentityDocumentType.Passport()
                            }
                        }
                        "residence_permit" -> {
                            // Get document type status
                            val documentQ = documentTypes.get(key)
                            if(documentQ is Boolean){
                                ccDocumentTypes += IdentityDocumentType.ResidencePermit()
                            }else if (documentQ is Array<*>){
                                val countries: Array<String> = documentTypes.get(key) as Array<String>
                                // Convert ReadableArray to MutableList
                                val ccCountries = this.extractCountries(countries)
                                this.sCountries.addAll(ccCountries)
                                ccDocumentTypes += IdentityDocumentType.ResidencePermit()
                            }
                        }
                        "driving_license" -> {
                            // Get document type status
                            val documentQ = documentTypes.get(key)
                            if(documentQ is Boolean){
                                ccDocumentTypes += IdentityDocumentType.DrivingLicence()
                            }else if (documentQ is Array<*>){
                                val countries: Array<String> = documentTypes.get(key) as Array<String>
                                // Convert ReadableArray to MutableList
                                val ccCountries = this.extractCountries(countries)
                                this.sCountries.addAll(ccCountries)
                                ccDocumentTypes += IdentityDocumentType.DrivingLicence()
                            }
                        }
                        "national_identity_card" -> {
                            // Get document type status
                            val documentQ = documentTypes.get(key)
                            if(documentQ is Boolean){
                                ccDocumentTypes += IdentityDocumentType.NationalIdentityCard()
                            }else if (documentQ is Array<*>){
                                val countries: Array<String> = documentTypes.get(key) as Array<String>
                                // Convert ReadableArray to MutableList
                                val ccCountries = this.extractCountries(countries)
                                this.sCountries.addAll(ccCountries)
                                ccDocumentTypes += IdentityDocumentType.NationalIdentityCard()
                            }
                        }
                        else -> {
                            // Fire an error
                        }
                    }
                }
                // get other properties for the document capture
                // useMLAssistance, showGuidance, retryLimit, liveCapture, title
                ccLog("MLAss $useMLAssistance")
                ccStage = Stage.CustomStage.Document(
                    ccDocumentTypes[0],
                    *ccDocumentTypes.drop(0).toTypedArray(),
                    isGuidanceEnabled = showGuidance,
                    useLiveCaptureOnly = false,
                    isMLAssistantEnabled = useMLAssistance,
                    retryLimit = retryLimit
                )
            }
            "face_capture", "faceCapture" -> {
                // Get the mode property
                val mode: String = if(stage.get("mode") == null) "" else stage.get("mode") as String
                when (mode){
                    "video" -> {
                        ccStage = Stage.CustomStage.SelfieVideo(
                            showGuidance,
                            isMLAssistantEnabled = useMLAssistance,
                            retryLimit,
                        )
                        print("Complycube Video $ccStage")
                    }
                    "photo" -> {
                        ccLog("MLAss Photo $useMLAssistance")
                        ccStage = Stage.CustomStage.SelfiePhoto(
                            showGuidance,
                            liveCapture,
                            useMLAssistance,
                            retryLimit,
                        )
                    }
                    else -> {
                        // Fire an error
                    }
                }
            }
            "poaCapture" -> {
                // Extract document types
                val documentTypes: Map<String, Any> = stage.get("documentTypes") as Map<String, Any>
                // Get keys
                // Get readableMap keys in array form
//                var keyIter: ReadableMapKeySetIterator = documentTypes.keySetIterator()
//                var keys: MutableList<String> = mutableListOf()
//                while (keyIter.hasNextKey()){
//                    keys.add(keyIter.nextKey())
//                }
                val keys = documentTypes.keys
                // Iterate through keys and get the values
                var ccDocumentTypes = arrayOf<ProofOfAddressDocumentType>()
                for (key in keys) {
                    when (key) {
                        "utility_bill" -> {
                            // Get document type status
                            val documentQ = documentTypes.get(key)
                            if(documentQ is Boolean){
                                ccDocumentTypes += ProofOfAddressDocumentType.UtilityBill()
                            }else if (documentQ is Array<*>){
                                val countries: Array<String> = documentTypes.get(key) as Array<String>
                                // Convert ReadableArray to MutableList
                                val ccCountries = this.extractCountries(countries)
                                this.sCountries.addAll(ccCountries)
                                ccDocumentTypes += ProofOfAddressDocumentType.UtilityBill()
                            }
                        }
                        "bank_statement" -> {
                            // Get document type status
                            val documentQ = documentTypes.get(key)
                            if(documentQ is Boolean){
                                ccDocumentTypes += ProofOfAddressDocumentType.BankStatement()
                            }else if (documentQ is Array<*>){
                                val countries: Array<String> = documentTypes.get(key) as Array<String>
                                // Convert ReadableArray to MutableList
                                val ccCountries = this.extractCountries(countries)
                                this.sCountries.addAll(ccCountries)
                                ccDocumentTypes += ProofOfAddressDocumentType.BankStatement()
                            }

                        }
                    }
                }
                ccStage = Stage.CustomStage.ProofOfAddress(
                    ccDocumentTypes[0],
                    *ccDocumentTypes.drop(1).toTypedArray(),
                    isGuidanceEnabled = showGuidance,
                    useLiveCaptureOnly = true,
                    isMLAssistantEnabled = useMLAssistance,
                    retryLimit = retryLimit
                )
            }
            "conscent" -> {
                // Get the concent property
                // NO Concent
            }
            else -> {
                // Error trigger
            }

        }
        if (ccStage == null){
            return Stage.DefaultStage.Welcome()
        }else
            return ccStage as Stage
    }
    private fun buildStages(stages: ArrayList<Any>) {
        if (stages == null) {
            //TODO: fire up an error
        }
        var ccStages: Array<Stage> = arrayOf()
        for (i in 0 until stages.size) {
            if (stages.get(i) is String) {
                ccStages += stageStringToCCStage(stages.get(i) as String ?: "")
            }else if (stages.get(i) is Map<*, *>){
                val stage: Map<String, Any> = stages.get(i) as Map<String, Any> ?: return
                ccStages += this.documentStageMapToCCStage(stage)
            }
        }
        this.stages = ccStages
    }
    private fun buildScheme(scheme: Map<String, String>) {
        // Get the stages property
        var schemeColour: SdkColors = SdkColors(
            if(scheme.containsKey("primaryButtonBgColor") && scheme.get("primaryButtonBgColor") as String != null) this.colorHexToColor(scheme.get("primaryButtonBgColor") as String) else null,
            if(scheme.containsKey("primaryButtonTextColor") && scheme.get("primaryButtonTextColor") as String != null) this.colorHexToColor(scheme.get("primaryButtonTextColor") as String) else null,
            if(scheme.containsKey("primaryButtonBorderColor") && scheme.get("primaryButtonBorderColor") as String != null) this.colorHexToColor(scheme.get("primaryButtonBorderColor") as String) else null,
            if(scheme.containsKey("secondaryButtonBgColor") && scheme.get("secondaryButtonBgColor") as String != null) this.colorHexToColor(scheme.get("secondaryButtonBgColor") as String) else null,
            if(scheme.containsKey("secondaryButtonTextColor") && scheme.get("secondaryButtonTextColor") as String != null) this.colorHexToColor(scheme.get("secondaryButtonTextColor") as String) else null,
            if(scheme.containsKey("secondaryButtonBorderColor") && scheme.get("secondaryButtonBorderColor") as String != null) this.colorHexToColor(scheme.get("secondaryButtonBorderColor") as String) else null,
            if(scheme.containsKey("docTypeBgColor") && scheme.get("docTypeBgColor") as String != null) this.colorHexToColor(scheme.get("docTypeBgColor") as String) else null,
            if(scheme.containsKey("docTypeBorderColor") && scheme.get("docTypeBorderColor") as String != null) this.colorHexToColor(scheme.get("docTypeBorderColor") as String) else null,
            null, // documentSelectorIconColor = if(scheme.hasKey("documentSelectorIconColor") && scheme.getString("documentSelectorIconColor") != null) this.colorHexToColor(scheme.getString("documentSelectorIconColor") as String) else null,
            null, // documentSelectorTitleTextColor = if(scheme.hasKey("documentSelectorTitleTextColor") && scheme.getString("documentSelectorTitleTextColor") != null) this.colorHexToColor(scheme.getString("documentSelectorTitleTextColor") as String) else null,
            null, // documentSelectorDescriptionTextColor = if(scheme.hasKey("documentSelectorDescriptionTextColor") && scheme.getString("documentSelectorDescriptionTextColor") != null) this.colorHexToColor(scheme.getString("documentSelectorDescriptionTextColor") as String) else null,
            if(scheme.containsKey("popUpBgColor") && scheme.get("popUpBgColor") as String != null) this.colorHexToColor(scheme.get("popUpBgColor") as String) else null,
            null, // infoPopupIconColor = if(scheme.hasKey("infoPopupIconColor") && scheme.getString("infoPopupIconColor") != null) this.colorHexToColor(scheme.getString("infoPopupIconColor") as String) else null,
            if(scheme.containsKey("popUpTitleColor") && scheme.get("popUpTitleColor") as String != null) this.colorHexToColor(scheme.get("popUpTitleColor") as String) else null,
            null,// infoPopupDescriptionTextColor = if(scheme.hasKey("infoPopupDescriptionTextColor") && scheme.getString("infoPopupDescriptionTextColor") != null) this.colorHexToColor(scheme.getString("infoPopupDescriptionTextColor") as String) else null,
            null, // errorPopupColor = if(scheme.hasKey("errorPopupColor") && scheme.getString("errorPopupColor") != null) this.colorHexToColor(scheme.getString("errorPopupColor") as String) else null,
            null,// errorPopupIconColor = if(scheme.hasKey("errorPopupIconColor") && scheme.getString("errorPopupIconColor") != null) this.colorHexToColor(scheme.getString("errorPopupIconColor") as String) else null,
            null, // errorPopupTitleTextColor = if(scheme.hasKey("errorPopupTitleTextColor") && scheme.getString("errorPopupTitleTextColor") != null) this.colorHexToColor(scheme.getString("errorPopupTitleTextColor") as String) else null,
            null, // errorPopupDescriptionTextColor = if(scheme.hasKey("errorPopupDescriptionTextColor") && scheme.getString("errorPopupDescriptionTextColor") != null) this.colorHexToColor(scheme.getString("errorPopupDescriptionTextColor") as String) else null,
            null, // cameraButtonColor = if(scheme.hasKey("cameraButtonColor") && scheme.getString("cameraButtonColor") != null) this.colorHexToColor(scheme.getString("cameraButtonColor") as String) else null,
            if(scheme.containsKey("headerTitle") && scheme.get("headerTitle") as String != null) this.colorHexToColor(scheme.get("headerTitle") as String) else null,
            if(scheme.containsKey("subheaderTitle") && scheme.get("subheaderTitle") as String != null) this.colorHexToColor(scheme.get("subheaderTitle") as String) else null,
            if(scheme.containsKey("textSecondary") && scheme.get("textSecondary") as String != null) this.colorHexToColor(scheme.get("textSecondary") as String) else null,
            null, // backgroundColor = if(scheme.hasKey("backgroundColor") && scheme.getString("backgroundColor") != null) this.colorHexToColor(scheme.getString("backgroundColor") as String) else null,
            null, // backgroundContentColor = if(scheme.hasKey("backgroundContentColor") && scheme.getString("backgroundContentColor") != null) this.colorHexToColor(scheme.getString("backgroundContentColor") as String) else null,
            null,// backgroundContentContrastColor = if(scheme.hasKey("backgroundContentContrastColor") && scheme.getString("backgroundContentContrastColor") != null) this.colorHexToColor(scheme.getString("backgroundContentContrastColor") as String) else null,
            null,// backgroundDividerColor = if(scheme.hasKey("backgroundDividerColor") && scheme.getString("backgroundDividerColor") != null) this.colorHexToColor(scheme.getString("backgroundDividerColor") as String) else null,
            null// editTextColor = if(scheme.hasKey("editTextColor") && scheme.getString("editTextColor") != null) this.colorHexToColor(scheme.getString("editTextColor") as String) else null,
        )
        this.colorScheme = schemeColour
    }
    private fun colorHexToColor(color: String): Long {
        return Color.parseColor(color).toLong()
    }
}