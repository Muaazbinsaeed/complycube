import 'package:complycube/helpers/complycube_event_codes.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:complycube/complycube.dart';

class OpenComplyCubeExample extends StatefulWidget {
  const OpenComplyCubeExample({super.key});

  @override
  State<OpenComplyCubeExample> createState() => _OpenComplyCubeExampleState();
}

class _OpenComplyCubeExampleState extends State<OpenComplyCubeExample> {
  @override
  void initState() {
    super.initState();
    initPlatformState();
    Complycube.onComplyCubeEvents.listen((event) {
      if (kDebugMode) {
        print("CCube Event:: $event");
        print("${event.data.code}: ${event.data.description}");
      }
    });

    Complycube.onError.listen((errors) {
      if (kDebugMode) {
        print("CCube Errors:: ${errors.map((e) => e.toJson())}");
      }
    });

    Complycube.onSuccess.listen((result) {
      if (kDebugMode) {
        print("CCube Errors:: ${result.toJson()}");
      }
    });

    Complycube.onCancelled.listen((error) {
      if (kDebugMode) {
        print("CCube Errors:: ${error.toJson()}");
      }
    });
  }

  String? result;
  Future<void> initPlatformState() async {
    result = await Complycube.openCCubeNativeBuild(
      settings: {
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
          //"primaryButtonBgColor": "#0000ff00",
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
    );

    if (result?.contains("popped!") ?? false) {
      pop();
    } else {
      setState(() {});
    }
    if (kDebugMode) {
      print("popped!");
    }
  }

  pop() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Plugin example app'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          initPlatformState();
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
      body: Center(
        child: Text(result ?? 'Opening sdk through method calling'),
      ),
    );
  }
}
