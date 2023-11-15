import 'package:complycube/helpers/complycube_event_codes.dart';
import 'package:complycube/models/settings.dart';
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
                bankStatement: ["DZ", "GB", "FR", "US"],
                councilTaxBill: ["DZ", "GB", "FR", "US"],
                utilityBill: ["DZ", "GB", "FR", "US"],
              ),
            ),
            BiometricStage(
              name: "faceCapture",
              type: BiometricType.photo,
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
