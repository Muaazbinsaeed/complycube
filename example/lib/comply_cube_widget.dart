import 'package:complycube/helpers/complycube_event_codes.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:complycube/complycube.dart';

class ComplyCubeWidgetBuilder extends StatefulWidget {
  const ComplyCubeWidgetBuilder({super.key});

  @override
  State<ComplyCubeWidgetBuilder> createState() => _ComplyCubeWidgetBuilderState();
}

class _ComplyCubeWidgetBuilderState extends State<ComplyCubeWidgetBuilder> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ComplyCubeSDK Widget'),
      ),
      body: ComplyCubeWidget(
        settings: const {
          "clientID": "652faa46b387d60008afdb51",
          "clientToken": "cmVmdGtuOjAxOjE3Mjk2OTk3OTQ6RHhjY3ZWdE1LVTdpOUI0aWhEVXBobDh5RWIz",
          "stages": [
            {
              "name": "intro",
              "title": "Green Bank ID verification",
              "message": "We will now verify your identity so you can start trading.",
            },
            {
              "name": "consent",
              "title": "Terms of Service",
            },
            {
              "name": "documentCapture",
              "title": "Document Capture",
              "enableNFC": false,
              "showGuidance": true,
              "liveCapture": false,
              "useMLAssistance": true,
              "retryLimit": 1,
              "countries": ["GB", "FR"],
              "documentTypes": {
                "passport": true,
                //"selfie": false,
                //"videoSelfie": true,
                "driving_license": ["GB", "FR"],
                "national_identity_card": ["GB", "FR"],
                "residence_permit": ["GB", "FR"],
                //"bank_statement": ["GB", "FR"],
                //"council_tax_bill": ["GB", "FR"],
                //"utility_bill": ["GB", "FR"]
              }
            },
            {
              "name": "faceCapture",
              "mode": "photo",
              "showGuidance": false,
              "liveCapture": false,
              "useMLAssistance": true,
              "retryLimit": 1,
            },
            {
              "name": "poaCapture",
              "showGuidance": false,
              "liveCapture": false,
              "useMLAssistance": true,
              "retryLimit": 1,
            }
          ],
          "scheme": {
            //"primaryButtonBgColor": "#FFC0CB",
            /* "headerTitle": "#ffffff",
            "subheaderTitle": "#ffffff",
            "textSecondary": "#ff0000",
            "docTypeBgColor": "#ffffff",
            "docTypeTextColor": "#ffffff",
            "docTypeBorderColor": "#ffffff",
            "textItemType": "#ffffff",
            "blueBigType": "#ffffff",
            "primaryButtonBgColor": "#0000ff",
            "primaryButtonPressedBgColor": "#00ff00",
            "primaryButtonBorderColor": "#ffffff",
            "primaryButtonTextColor": "#0000ff",
            "secondaryButtonBgColor": "#0000ff",
            "secondaryButtonPressedBgColor": "#0000ff",
            "secondaryButtonBorderColor": "#0000ff",
            "secondaryButtonTextColor": "#0000ff",
            "linkButtonTextColor": "#0000ff",
            "popUpBgColor": "#0000ff",
            "popUpTitleColor": "#0000ff" */
          }
        },
        //Handle callbacks
        onError: (errors) {
          if (kDebugMode) {
            print("CCube Errors:: ${errors.map((e) => e.toJson())}");
          }
        },
        onSuccess: (result) {
          if (kDebugMode) {
            print("CCube Result:: ${result.toJson()}");
          }
        },
        onCancelled: (error) {
          if (kDebugMode) {
            print("CCube Errors:: ${error.toJson()}");
          }
        },
        onComplyCubeEvent: (event) {
          if (kDebugMode) {
            print("CCube Event:: $event");
            print("${event.data.code}: ${event.data.description}");
          }
        },
      ),
    );
  }
}
