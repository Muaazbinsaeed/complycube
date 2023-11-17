//
//  ViewController.swift
//  SampleApp
//

import UIKit
import ComplyCubeMobileSDK


class CCubeViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    
    func openComplyCubeNativeFormBuilder(args: [String: AnyObject]? = nil) {
        //var settingManager: SettingManager = SettingManager(request: args!)
        //settingManager.buildComplyCubeSDKFlow(controller: self)
        var stages = [ComplyCubeMobileSDKStage]()
        var cstages: [AnyObject] = []

        for stage in args!["stages"] as! Array<AnyObject> {
            if stage is String {
                switch stage as! String {
                case "intro": stages.append(WelcomeStageBuilder().build())
                     break
                case "conscent": stages.append(UserConsentStageBuilder().build())
                     break
                case "documentCapture": stages.append(DocumentStageBuilder().build())
                     break
                case "faceCapture": stages.append(BiometricStageBuilder().build())
                     break
                case "poaCapture": stages.append(AddressStageBuilder().build())
                     break
                default: break          
                }
            } 
            else if stage is [String: AnyObject] {
                let name = stage["name"] as! String
                switch name {
                case "intro":
                    let builder = WelcomeStageBuilder()

                    if let title = stage["title"] as? String {
                        builder.setTitle(title: title)
                    }

                    if let message = stage["message"] as? String {
                        builder.setMessage(message: message)
                    }
                    stages.append(builder.build())
                    break
                case "consent":
                    var builder = UserConsentStageBuilder()

                    if let title = stage["title"] as? String {
                        builder.setTitle(title: title)
                    }
                   
                    if let acceptTitle = stage["acceptTitle"] as? String {
                        builder.setAcceptTitle(title: acceptTitle)
                    }

                    if let doNotAcceptTitle = stage["doNotAcceptTitle"] as? String {
                        builder.setDoNotAcceptTitle(title: doNotAcceptTitle)
                    }
                    stages.append(builder.build())
                    break
                case "documentCapture":
                    let builder = DocumentStageBuilder()
                    // NFC settings
                    if let enableNFC = stage["enableNFC"] as? Bool{
                        builder.setEnableNFC(enable: enableNFC)
                    }
                    // ML settings
                    if let useMLAssistance = stage["useMLAssistance"] as? Bool{
                        builder.setEnableMLAssistant(enable: useMLAssistance)
                    }
                    // Guidance
                    if let showGuidance = stage["showGuidance"] as? Bool{
                        builder.setShowGuidance(enable: showGuidance)
                    }
                    // retry limits
                    if let retries = stage["retryLimit"] as? Int{
                        builder.setRetryLimit(count: retries)
                    }
                    // use nlive capture
                    if let liveCapture = stage["liveCapture"] as? Bool{
                        builder.useLiveCaptureOnly(enable: liveCapture)
                    }
                    // Countries
                    if let countries = stage["countries"] as? [String]{
                        builder.setCountries(countries: countries)
                    }
                    // Title
                    if let title = stage["title"] as? String{
                        builder.setTitle(title: title)
                    }
                    // Document types
                    if let documentTypes = stage["documentTypes"] as? [String: AnyObject]{
                        var documents: [DocumentTypes] = []
                        for (key, document) in documentTypes {
                            if document is Bool {
                                documents.append(getDocumentByType(key))
                            }
                            else if document is [String]{
                                let countries: [String] = document as! [String]
                                documents.append(getDocumentByType(key, countries: countries))
                            }
                        }
                        builder.setAllowedDocumentTypes(types: documents)
                    }
                    stages.append(builder.build())
                    break
                case "faceCapture":
                    let builder = BiometricStageBuilder()
                    // Biometric type
                    if let type = stage["mode"] as? String {
                        builder.setType(type: (type == "photo" ? BiometricType.photo : BiometricType.video))
                    }
                    // ML settings
                    if let useMLAssistance = stage["useMLAssistance"] as? Bool {
                        builder.setEnableMLAssistant(enable: useMLAssistance)
                    }
                    // Guidance
                    if let showGuidance = stage["showGuidance"] as? Bool{
                        builder.setShowGuidance(enable: showGuidance)
                    }
                    // retry limits
                    if let retries = stage["retryLimit"] as? Int{
                        builder.setRetryLimit(count: retries)
                    }

                    // use nlive capture
                    if let liveCapture = stage["liveCapture"] as? Bool{
                        builder.useLiveCaptureOnly(enable: liveCapture)
                    }
                    stages.append(builder.build())
                    break
                case "poaCapture":
                    let builder = AddressStageBuilder()
                    // ML settings
                    if let useMLAssistance = stage["useMLAssistance"] as? Bool {
                        builder.setEnableMLAssistant(enable: useMLAssistance)
                    }
                    // Guidance
                    if let showGuidance = stage["showGuidance"] as? Bool{
                        builder.setShowGuidance(enable: showGuidance)
                    }
                    // retry limits
                    if let retries = stage["retryLimit"] as? Int{
                        builder.setRetryLimit(count: retries)
                    }

                    // use nlive capture
                    if let liveCapture = stage["liveCapture"] as? Bool{
                        builder.useLiveCaptureOnly(enable: liveCapture)
                    }
                    stages.append(builder.build())
                    break
                default: return
                }
            }
        }

        var colorScheme: ComplyCubeColourScheme = ComplyCubeColourScheme()
        if let scheme = args!["scheme"] as? [String: AnyObject] {
            colorScheme = handleSchemes(scheme: scheme)
        }

        DispatchQueue.global().async (execute: {
            DispatchQueue.main.sync{
                do{
                    let _: () = try ComplyCubeMobileSDK.FlowBuilder()
                        .withEventHandler({ (event: Event) -> () in
                            // Custom user tracking code here
                            NSLog(event.rawValue)
                            CCubeEventDelegate.fireEvent(event.rawValue)
                        })
                        .withCallbackHandler(self)
                        .withClientId(args!["clientID"] as? String ?? "ClientID")
                        .withSDKToken(args!["clientToken"] as? String ?? "SDK_TOKEN")
                        .withStages(stages)
                        .withColorScheme(colorScheme)
                        .start(fromVc: self)
                }catch {
                    print("Error: \(error)")
                }
            }
        })
    }

    private func getDocumentByType(_ key: String, countries: [String] = []) -> DocumentTypes{
        switch key {
        case "passport":
            return DocumentTypes.passport
        case "selfie":
            return DocumentTypes.selfie
        case "videoSelfie":
            return DocumentTypes.videoSelfie
        case "driving_license":
            return DocumentTypes.drivingLicence(countries.count > 0 ? countries : ComplyUtils.allCountries())
        case "national_identity_card":
            return DocumentTypes.nationalIdentityCard(countries.count > 0 ? countries : ComplyUtils.allCountries())
        case "residence_permit":
            return DocumentTypes.residencePermitCard(countries.count > 0 ? countries : ComplyUtils.allCountries())
        case "bank_statement":
            return DocumentTypes.bankStatement(countries.count > 0 ? countries : ComplyUtils.allCountries())
        case "council_tax_bill":
            return DocumentTypes.councilTaxBill(countries.count > 0 ? countries : ComplyUtils.allCountries())
        case "utility_bill":
            return DocumentTypes.utilityBill(countries.count > 0 ? countries : ComplyUtils.allCountries())
        default:
            return DocumentTypes.passport
        }
    }

    public func handleSchemes(scheme: [String: AnyObject]) -> ComplyCubeColourScheme {
        var colorScheme: ComplyCubeColourScheme = ComplyCubeColourScheme()
        for (key, value) in scheme {
            switch key {
            case "headerTitle":
                colorScheme.headerTitle =  UIColor.fromHex(value as? String)
                break
            case "subheaderTitle":
                colorScheme.subheaderTitle =  UIColor.fromHex(value as? String)
                break
            case "textSecondary":
                colorScheme.textSecondary =  UIColor.fromHex(value as? String)
                break
            case "docTypeBgColor":
                colorScheme.docTypeBgColor =  UIColor.fromHex(value as? String)
                break
            case "docTypeTextColor":
                colorScheme.docTypeTextColor =  UIColor.fromHex(value as? String)
                break
            case "docTypeBorderColor":
                colorScheme.docTypeBorderColor =  UIColor.fromHex(value as? String)
                break
            case "textItemType":
                colorScheme.textItemType =  UIColor.fromHex(value as? String)
                break
            case "blueBigType":
                colorScheme.blueBigType =  UIColor.fromHex(value as? String)
                break
            case "primaryButtonBgColor":
                colorScheme.primaryButtonBgColor =  UIColor.fromHex(value as? String)
                break
            case "primaryButtonPressedBgColor":
                colorScheme.primaryButtonPressedBgColor =  UIColor.fromHex(value as? String)
                break
            case "primaryButtonBorderColor":
                colorScheme.primaryButtonBorderColor =  UIColor.fromHex(value as? String)
                break
            case "primaryButtonTextColor":
                colorScheme.primaryButtonTextColor =  UIColor.fromHex(value as? String)
                break
            case "secondaryButtonBgColor":
                colorScheme.secondaryButtonBgColor =  UIColor.fromHex(value as? String)
                break
            case "secondaryButtonPressedBgColor":
                colorScheme.secondaryButtonPressedBgColor =  UIColor.fromHex(value as? String)
                break
            case "secondaryButtonBorderColor":
                colorScheme.secondaryButtonBorderColor =  UIColor.fromHex(value as? String)
                break
            case "secondaryButtonTextColor":
                colorScheme.secondaryButtonTextColor =  UIColor.fromHex(value as? String)
                break
            case "linkButtonTextColor":
                colorScheme.linkButtonTextColor =  UIColor.fromHex(value as? String)
                break
            case "popUpBgColor":
                colorScheme.popUpBgColor =  UIColor.fromHex(value as? String)
                break
            case "popUpTitleColor":
                colorScheme.popUpTitleColor =  UIColor.fromHex(value as? String)
                break
            default: return colorScheme
            }
        }
        return colorScheme
    }

    private func errorToJson( error: ComplyCubeError) -> [String: Any]{
        return [
        "message": error.message,
        "errorCode": error.errorCode,
        "description": error.description
        ]
    }
  
    private func resultToJson( result: ComplyCubeResult) -> [String: Any]{
        return [
        "liveVideoId": result.liveVideoId,
        "livePhotoId": result.livePhotoId,
        "ids": result.ids
        ]
    }

    private func forceJSONBoolean(_ input: Any?) -> Bool{
        if(input is Bool){
            return input as! Bool
        }
        if(input is String){
            return input as! String == "true"
        }
        return false
    }

    private func forceJSONInt(_ input: Any?) -> Int {
        if(input is String){
            return Int(input as! String) ?? 0
        }
        if(input is Int){
            return input as! Int
        }
        return 0
    }
}

extension UIColor {
    static func fromHex(_ hexString: String?) -> UIColor? {
        guard let hexString = hexString else { return nil }
        var cleanedHexString = hexString
        if cleanedHexString.hasPrefix("#") {
            cleanedHexString.removeFirst()
        }
        
        var hexValue: UInt64 = 0
        Scanner(string: cleanedHexString).scanHexInt64(&hexValue)
        
        let red = CGFloat((hexValue & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((hexValue & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(hexValue & 0x0000FF) / 255.0
        let alpha = hexString.count == 6 ? 1.0 : CGFloat((hexValue & 0xFF000000) >> 24) / 255.0
        
        return UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }
}

extension UIViewController {
    public func getAppViewController() -> UIViewController {
        var top: UIViewController? = self
        // look for the viewController that's shown right now
        while top!.presentedViewController != nil {
            top = top!.presentedViewController!
        }
        return top!
    }
}

extension CCubeViewController: ComplyCubeMobileSDKDelegate {
    public func onError(_ errors: [ComplyCubeError]){
        var errors_: [[String: Any]] = []
        errors_ = errors.map { cce in
            return self.errorToJson(error: cce)
        }
        // use errors_ as dictionary
        CCubeEventErrorsDelegate.fireEvent(errors_)
    }

    public func onCancelled(_ error: ComplyCubeError){
        let cancel_error = self.errorToJson(error: error)
         // use cancel_error as dictionary
         CCubeEventErrorDelegate.fireEvent(cancel_error)
    }
    
    public func onSuccess(_ result: ComplyCubeResult){
        let result_ = self.resultToJson(result: result)
         // use result_ as dictionary
          CCubeEventResultDelegate.fireEvent(result_)
    }
}
