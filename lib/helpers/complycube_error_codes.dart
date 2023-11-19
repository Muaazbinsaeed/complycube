// TODO: Add error codes, message and helper to set it

import '../models/events.dart';

enum ComplyCubeErrorCode {
  Unknown,
  Cancelled,
  DocumentMandatory,
  ExpiredToken,
  ConsentNotGranted,
  UploadsRequireGuidance,
  Jailbroken,
  NoDocumentTypes,
  BiometricStagesCount,
  AddressStagesCount,
  UserConsentsCount,
  UploadError,
  FlowError,
  NotAuthorized,
}

extension ComplyCubeErrorCodeData on ComplyCubeErrorCode {
  EventData get data {
    switch (this) {
      case ComplyCubeErrorCode.NotAuthorized:
        return EventData(code: ComplyCubeErrorCode.NotAuthorized.index, description: "The SDK has attempted a request to an endpoint you are not authorized to use.");
      case ComplyCubeErrorCode.ExpiredToken:
        return EventData(
            code: ComplyCubeErrorCode.ExpiredToken.index,
            description: "The token used to initialize the SDK has expired. Create a new SDK token and restart the flow.");
      case ComplyCubeErrorCode.DocumentMandatory:
        return EventData(code: ComplyCubeErrorCode.DocumentMandatory.index, description: "A Document stage is mandatory with the currently configured stages.");
      case ComplyCubeErrorCode.Jailbroken:
        return EventData(code: ComplyCubeErrorCode.Jailbroken.index, description: "The SDK cannot be launched on this device as it has been compromised.");
      case ComplyCubeErrorCode.NoDocumentTypes:
        return EventData(code: ComplyCubeErrorCode.NoDocumentTypes.index, description: "A Document stage has been initialized without setting document types.");
      case ComplyCubeErrorCode.BiometricStagesCount:
        return EventData(
            code: ComplyCubeErrorCode.BiometricStagesCount.index, description: "The configuration provided contains duplicate Selfie photo or Selfie video stages.");
      case ComplyCubeErrorCode.UploadError:
        return EventData(code: ComplyCubeErrorCode.UploadError.index, description: "An error occurred during the upload document or selfie upload process.");
      /* case ComplyCubeErrorCode.InvalidCountryCode:
        return const EventData(code: 1, description: "An invalid country code is provided.");
      case ComplyCubeErrorCode.UnsupportedCountryTypeCombination:
        return const EventData(code: 1, description: "An unsupported country code is provided for a specific document type."); */
      case ComplyCubeErrorCode.Cancelled:
        return EventData(code: ComplyCubeErrorCode.Cancelled.index, description: "Operation cancelled.");
      case ComplyCubeErrorCode.ConsentNotGranted:
        return EventData(code: ComplyCubeErrorCode.ConsentNotGranted.index, description: "Consent not granted, The user gave no consent");
      case ComplyCubeErrorCode.FlowError:
        return EventData(code: ComplyCubeErrorCode.FlowError.index, description: "An unrecoverable error occurred during the flow.");
      /* case ComplyCubeErrorCode.MissingToken:
        return const EventData(code: 1, description: "Attempted to launch the SDK without setting the SDK token.");
      case ComplyCubeErrorCode.DuplicateStages:
        return const EventData(code: 1, description: "Launch configuration contains duplicate stages."); */
      case ComplyCubeErrorCode.AddressStagesCount:
        return EventData(code: ComplyCubeErrorCode.AddressStagesCount.index, description: "The configuration provided contains duplicate address stages.");
      case ComplyCubeErrorCode.UserConsentsCount:
        return EventData(code: ComplyCubeErrorCode.UserConsentsCount.index, description: "The launch configuration provided contains duplicate consent stages.");
      case ComplyCubeErrorCode.UploadsRequireGuidance:
        return EventData(
            code: ComplyCubeErrorCode.UploadsRequireGuidance.index,
            description: "If liveCapture is set to false, enabling the guidance feature is required. This can be done by setting isGuidanceEnabled to true.");
      case ComplyCubeErrorCode.Unknown:
        return EventData(code: ComplyCubeErrorCode.Unknown.index, description: "An unexpected error has occurred. If this keeps occurring, let us know about it.");
      default:
        return const EventData(code: 19, description: "");
    }
  }
}
