// ignore_for_file: constant_identifier_names

enum ComplyCubeEvent {
  PROOF_OF_ADDRESS_STAGE_CAPTURE_GUIDANCE,
  CAMERA_ACCESS_PERMISSION,
  BIOMETRICS_STAGE_SELFIE_CAMERA_MANUAL_MODE,
  BIOMETRICS_STAGE_SELFIE_CAMERA,
  BIOMETRICS_STAGE_VIDEO_ACTION_ONE,
  BIOMETRICS_STAGE_VIDEO_ACTION_TWO,
  BIOMETRICS_STAGE_VIDEO_CAMERA,
  BIOMETRICS_STAGE_VIDEO_CAMERA_MANUAL_MODE,
  PROOF_OF_ADDRESS_STAGE_SELECT_COUNTRY,
  DOCUMENT_STAGE_SELECT_COUNTRY,
  DOCUMENT_STAGE_CAPTURE_GUIDANCE,
  PROOF_OF_ADDRESS_STAGE_TWO_SIDE_CHECK_QUALITY_FRONT,
  PROOF_OF_ADDRESS_STAGE_TWO_SIDE_CHECK_QUALITY_BACK,
  PROOF_OF_ADDRESS_STAGE_ONE_SIDE_CHECK_QUALITY,
  DOCUMENT_STAGE_TWO_SIDE_CHECK_QUALITY_FRONT,
  DOCUMENT_STAGE_TWO_SIDE_CHECK_QUALITY_BACK,
  DOCUMENT_STAGE_ONE_SIDE_CHECK_QUALITY,
  PROOF_OF_ADDRESS_STAGE_TWO_SIDE_CAMERA_FRONT_MANUAL_MODE,
  PROOF_OF_ADDRESS_STAGE_TWO_SIDE_CAMERA_FRONT,
  PROOF_OF_ADDRESS_STAGE_TWO_SIDE_CAMERA_BACK_MANUAL_MODE,
  PROOF_OF_ADDRESS_STAGE_TWO_SIDE_CAMERA_BACK,
  PROOF_OF_ADDRESS_STAGE_ONE_SIDE_CAMERA_MANUAL_MODE,
  PROOF_OF_ADDRESS_STAGE_ONE_SIDE_CAMERA,
  DOCUMENT_STAGE_TWO_SIDE_CAMERA_FRONT_MANUAL_MODE,
  DOCUMENT_STAGE_TWO_SIDE_CAMERA_FRONT,
  DOCUMENT_STAGE_TWO_SIDE_CAMERA_BACK_MANUAL_MODE,
  DOCUMENT_STAGE_TWO_SIDE_CAMERA_BACK,
  DOCUMENT_STAGE_ONE_SIDE_CAMERA_MANUAL_MODE,
  DOCUMENT_STAGE_ONE_SIDE_CAMERA,
  PROOF_OF_ADDRESS_STAGE_DOCUMENT_TYPE,
  DOCUMENT_STAGE_DOCUMENT_TYPE,
  BIOMETRICS_STAGE_SELFIE_CAPTURE_GUIDANCE,
  BIOMETRICS_STAGE_SELFIE_CHECK_QUALITY,
  BIOMETRICS_STAGE_VIDEO_CHECK_QUALITY,
  CONSENT_STAGE_WARNING,
  CONSENT_STAGE,
  COMPLETION_STAGE,
  INTRO,
}

class EventData {
  final int code;
  final String description;

  const EventData({required this.code, required this.description});
}

// Extension of ComplyCUbeEvent enum
extension ComplyCubeEventData on ComplyCubeEvent {
  EventData get data {
    switch (this) {
      case ComplyCubeEvent.BIOMETRICS_STAGE_SELFIE_CAMERA:
        return EventData(code: ComplyCubeEvent.BIOMETRICS_STAGE_SELFIE_CAMERA.index, description: "The client reached capture camera for a selfie.");
      case ComplyCubeEvent.BIOMETRICS_STAGE_SELFIE_CAMERA_MANUAL_MODE:
        return EventData(
            code: ComplyCubeEvent.BIOMETRICS_STAGE_SELFIE_CAMERA_MANUAL_MODE.index, description: "The client reached manual capture camera for a selfie.");
      case ComplyCubeEvent.BIOMETRICS_STAGE_SELFIE_CAPTURE_GUIDANCE:
        return EventData(
            code: ComplyCubeEvent.BIOMETRICS_STAGE_SELFIE_CAPTURE_GUIDANCE.index,
            description: "The client has reached the guidance screen showing how to take a good selfie.");
      case ComplyCubeEvent.BIOMETRICS_STAGE_SELFIE_CHECK_QUALITY:
        return EventData(
            code: ComplyCubeEvent.BIOMETRICS_STAGE_SELFIE_CHECK_QUALITY.index,
            description: "The client has reached the photo review screen after capturing a selfie photo..");
      case ComplyCubeEvent.BIOMETRICS_STAGE_VIDEO_ACTION_ONE:
        return EventData(code: ComplyCubeEvent.BIOMETRICS_STAGE_VIDEO_ACTION_ONE.index, description: "The client reached the first action in a video selfie");
      case ComplyCubeEvent.BIOMETRICS_STAGE_VIDEO_ACTION_TWO:
        return EventData(code: ComplyCubeEvent.BIOMETRICS_STAGE_VIDEO_ACTION_TWO.index, description: "The client reached the second action in a video selfie.");
      case ComplyCubeEvent.BIOMETRICS_STAGE_VIDEO_CAMERA:
        return EventData(code: ComplyCubeEvent.BIOMETRICS_STAGE_VIDEO_CAMERA.index, description: "The client reached capture camera for a video selfie.");
      case ComplyCubeEvent.BIOMETRICS_STAGE_VIDEO_CAMERA_MANUAL_MODE:
        return EventData(
            code: ComplyCubeEvent.BIOMETRICS_STAGE_VIDEO_CAMERA_MANUAL_MODE.index, description: "The client reached manual capture camera for a video selfie.");
      case ComplyCubeEvent.BIOMETRICS_STAGE_VIDEO_CHECK_QUALITY:
        return EventData(
            code: ComplyCubeEvent.BIOMETRICS_STAGE_VIDEO_CHECK_QUALITY.index,
            description: "The client has reached the video review screen after recording a video selfie.");
      case ComplyCubeEvent.CAMERA_ACCESS_PERMISSION:
        return EventData(
            code: ComplyCubeEvent.CAMERA_ACCESS_PERMISSION.index, description: "The client has reached the permission request screen for camera permissions.");
      case ComplyCubeEvent.COMPLETION_STAGE:
        return EventData(code: ComplyCubeEvent.COMPLETION_STAGE.index, description: "The client has reached the Completion screen.");
      case ComplyCubeEvent.CONSENT_STAGE:
        return EventData(code: ComplyCubeEvent.CONSENT_STAGE.index, description: "The client has reached the consent stage screen.");
      case ComplyCubeEvent.CONSENT_STAGE_WARNING:
        return EventData(
            code: ComplyCubeEvent.CONSENT_STAGE_WARNING.index,
            description: "The client has attempted to exit without giving consent and receive a confirmation prompt.");
      case ComplyCubeEvent.DOCUMENT_STAGE_TWO_SIDE_CHECK_QUALITY_BACK:
        return EventData(
            code: ComplyCubeEvent.DOCUMENT_STAGE_TWO_SIDE_CHECK_QUALITY_BACK.index,
            description: "The client reached quality preview screen for the back side of a two-sided ID document.");
      case ComplyCubeEvent.DOCUMENT_STAGE_TWO_SIDE_CHECK_QUALITY_FRONT:
        return EventData(
            code: ComplyCubeEvent.DOCUMENT_STAGE_TWO_SIDE_CHECK_QUALITY_FRONT.index,
            description: "The client reached quality preview screen for the front side of a two-sided ID document.");
      case ComplyCubeEvent.DOCUMENT_STAGE_ONE_SIDE_CHECK_QUALITY:
        return EventData(
            code: ComplyCubeEvent.DOCUMENT_STAGE_ONE_SIDE_CHECK_QUALITY.index,
            description: "The client reached image quality preview screen for one-sided ID document.");
      case ComplyCubeEvent.DOCUMENT_STAGE_TWO_SIDE_CAMERA_BACK:
        return EventData(
            code: ComplyCubeEvent.DOCUMENT_STAGE_TWO_SIDE_CAMERA_BACK.index, description: "The client reached camera for the back side of a two-sided ID document.");
      case ComplyCubeEvent.DOCUMENT_STAGE_TWO_SIDE_CAMERA_BACK_MANUAL_MODE:
        return EventData(
            code: ComplyCubeEvent.DOCUMENT_STAGE_TWO_SIDE_CAMERA_BACK_MANUAL_MODE.index,
            description: "The client reached manual capture camera for the back side of two-sided ID document.");
      case ComplyCubeEvent.DOCUMENT_STAGE_TWO_SIDE_CAMERA_FRONT:
        return EventData(
            code: ComplyCubeEvent.DOCUMENT_STAGE_TWO_SIDE_CAMERA_FRONT.index,
            description: "The client reached camera stage for the front side of two-sided ID document.");
      case ComplyCubeEvent.DOCUMENT_STAGE_TWO_SIDE_CAMERA_FRONT_MANUAL_MODE:
        return EventData(
            code: ComplyCubeEvent.DOCUMENT_STAGE_TWO_SIDE_CAMERA_FRONT_MANUAL_MODE.index,
            description: "The client reached manual capture camera for the back side of two-sided ID document.");
      case ComplyCubeEvent.DOCUMENT_STAGE_ONE_SIDE_CAMERA_MANUAL_MODE:
        return EventData(
            code: ComplyCubeEvent.DOCUMENT_STAGE_ONE_SIDE_CAMERA_MANUAL_MODE.index,
            description: "The client reached manual capture camera of one-sided ID document.");
      case ComplyCubeEvent.DOCUMENT_STAGE_ONE_SIDE_CAMERA:
        return EventData(
            code: ComplyCubeEvent.DOCUMENT_STAGE_ONE_SIDE_CAMERA.index, description: "The client reached the capture camera stage for a one-sided ID document.");
      case ComplyCubeEvent.DOCUMENT_STAGE_DOCUMENT_TYPE:
        return EventData(
            code: ComplyCubeEvent.DOCUMENT_STAGE_DOCUMENT_TYPE.index,
            description: "The client has reached the document type selection screen for an ID Document capture stage.");
      case ComplyCubeEvent.DOCUMENT_STAGE_SELECT_COUNTRY:
        return EventData(code: ComplyCubeEvent.DOCUMENT_STAGE_SELECT_COUNTRY.index, description: "The client reached country selection screen for ID document.");
      case ComplyCubeEvent.DOCUMENT_STAGE_CAPTURE_GUIDANCE:
        return EventData(code: ComplyCubeEvent.DOCUMENT_STAGE_CAPTURE_GUIDANCE.index, description: "The client reached capture guidance screen for ID document.");
      case ComplyCubeEvent.INTRO:
        return EventData(code: ComplyCubeEvent.INTRO.index, description: "The client has reached the intro screen.");
      case ComplyCubeEvent.PROOF_OF_ADDRESS_STAGE_TWO_SIDE_CHECK_QUALITY_FRONT:
        return EventData(
            code: ComplyCubeEvent.PROOF_OF_ADDRESS_STAGE_TWO_SIDE_CHECK_QUALITY_FRONT.index,
            description: "The client reached quality preview screen for the front side of a two-sided proof of address document.");
      case ComplyCubeEvent.PROOF_OF_ADDRESS_STAGE_CAPTURE_GUIDANCE:
        return EventData(
            code: ComplyCubeEvent.PROOF_OF_ADDRESS_STAGE_CAPTURE_GUIDANCE.index,
            description: "The client has reach capture guidance screen for proof of address document.");
      case ComplyCubeEvent.PROOF_OF_ADDRESS_STAGE_TWO_SIDE_CHECK_QUALITY_BACK:
        return EventData(
            code: ComplyCubeEvent.PROOF_OF_ADDRESS_STAGE_TWO_SIDE_CHECK_QUALITY_BACK.index,
            description: "The client reached quality preview screen for the back side of a two-sided proof of address document.");
      case ComplyCubeEvent.PROOF_OF_ADDRESS_STAGE_ONE_SIDE_CHECK_QUALITY:
        return EventData(
            code: ComplyCubeEvent.PROOF_OF_ADDRESS_STAGE_ONE_SIDE_CHECK_QUALITY.index,
            description: "The client reached quality preview screen for a one-sided proof of address document.");
      case ComplyCubeEvent.PROOF_OF_ADDRESS_STAGE_DOCUMENT_TYPE:
        return EventData(
            code: ComplyCubeEvent.PROOF_OF_ADDRESS_STAGE_DOCUMENT_TYPE.index,
            description: "The client has reached the document type selection screen for a Proof Of Address capture stage.");
      case ComplyCubeEvent.PROOF_OF_ADDRESS_STAGE_ONE_SIDE_CAMERA:
        return EventData(
            code: ComplyCubeEvent.PROOF_OF_ADDRESS_STAGE_ONE_SIDE_CAMERA.index,
            description: "The client reached capture camera stage for a one-sided proof of address.");
      case ComplyCubeEvent.PROOF_OF_ADDRESS_STAGE_TWO_SIDE_CAMERA_FRONT_MANUAL_MODE:
        return EventData(
            code: ComplyCubeEvent.PROOF_OF_ADDRESS_STAGE_TWO_SIDE_CAMERA_FRONT_MANUAL_MODE.index,
            description: "The client reached manual capture camera for the front side of a two-sided proof address document.");
      case ComplyCubeEvent.PROOF_OF_ADDRESS_STAGE_TWO_SIDE_CAMERA_FRONT:
        return EventData(
            code: ComplyCubeEvent.PROOF_OF_ADDRESS_STAGE_TWO_SIDE_CAMERA_FRONT.index,
            description: "The client reached capture camera for the front side of a two-sided proof address document.");
      case ComplyCubeEvent.PROOF_OF_ADDRESS_STAGE_TWO_SIDE_CAMERA_BACK_MANUAL_MODE:
        return EventData(
            code: ComplyCubeEvent.PROOF_OF_ADDRESS_STAGE_TWO_SIDE_CAMERA_BACK_MANUAL_MODE.index,
            description: "The client reached manual capture camera for the back side of a two-sided proof address document.");
      case ComplyCubeEvent.PROOF_OF_ADDRESS_STAGE_ONE_SIDE_CAMERA_MANUAL_MODE:
        return EventData(
            code: ComplyCubeEvent.PROOF_OF_ADDRESS_STAGE_ONE_SIDE_CAMERA_MANUAL_MODE.index,
            description: "The client reached manual capture camera for the front side of a one-sided proof address document.");
      case ComplyCubeEvent.PROOF_OF_ADDRESS_STAGE_SELECT_COUNTRY:
        return EventData(
            code: ComplyCubeEvent.PROOF_OF_ADDRESS_STAGE_SELECT_COUNTRY.index,
            description: "The client reached country selection screen for a proof of address document.");
      case ComplyCubeEvent.PROOF_OF_ADDRESS_STAGE_TWO_SIDE_CAMERA_BACK:
        return EventData(
            code: ComplyCubeEvent.PROOF_OF_ADDRESS_STAGE_TWO_SIDE_CAMERA_BACK.index,
            description: "The client reached camera for the back side of a two-sided proof address document.");
      default:
        return const EventData(
          code: 0,
          description: ".",
        );
    }
  }
}
