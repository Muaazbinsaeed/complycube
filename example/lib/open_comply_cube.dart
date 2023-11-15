import 'package:complycube/helpers/complycube_event_codes.dart';
import 'package:complycube/models/settings.dart';
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
      settings: ComplyCubeSettings(
        clientId: "652faa46b387d60008afdb51",
        clientToken: "cmVmdGtuOjAxOjE3Mjk2OTk3OTQ6RHhjY3ZWdE1LVTdpOUI0aWhEVXBobDh5RWIz",
        stages: [
          WelcomeStage(
            name: "intro",
            title: "Green Bank ID verification",
            message: "We will now verify your identity so you can start trading.",
          ),
          ConsentStage(
            name: "consent",
            title: "Terms of Service",
            //message: "At My company, we are committed to protecting the privacy and security of our users. This privacy policy explains how we collect, use, and protect...",
          ),
          DocumentStage(
            name: "documentCapture",
            title: "Document Capture",
            enableNfc: false,
            showGuidance: true,
            useLiveCapture: true,
            useMlAssistance: true,
            // retryLimit: 1,
            // countries: ["DZ", "GB", "FR", "US"],
            documentTypes: DocumentTypes(
              passport: true,
              //selfie: false,
              //videoSelfie: false,
              drivingLicense: ["DZ", "GB", "FR", "US"],
              nationalIdentityCard: ["DZ", "GB", "FR", "US"],
              residencePermit: ["DZ", "GB", "FR", "US"],
              //bankStatement: ["DZ", "GB", "FR", "US"],
              //councilTaxBill: ["DZ", "GB", "FR", "US"],
              //utilityBill: ["DZ", "GB", "FR", "US"],
            ),
          ),
          BiometricStage(
            name: "faceCapture",
            type: BiometricType.video,
            showGuidance: false,
            useLiveCapture: false,
            useMlAssistance: true,
            retryLimit: 1,
          ),
          AddressStage(
            name: "poaCapture",
            showGuidance: false,
            useLiveCapture: false,
            useMlAssistance: true,
            retryLimit: 1,
          ),
        ],
        colorScheme: ComplyCubeColorScheme(primaryButtonBgColor: const Color(0xFF42A5F5)),
      ),
    );

    setState(() {});
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
