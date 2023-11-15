import 'package:complycube/helpers/complycube_error_codes.dart';

class ComplyCubeResult {
  String? liveVideoId;
  String? livePhotoId;
  String? ids;

  ComplyCubeResult({this.liveVideoId, this.livePhotoId, this.ids});

  ComplyCubeResult.fromJson(Map<String, dynamic> json) {
    liveVideoId = json["liveVideoId"];
    livePhotoId = json["livePhotoId"];
    ids = json["ids"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["liveVideoId"] = liveVideoId;
    data["livePhotoId"] = livePhotoId;
    data["ids"] = ids;
    return data;
  }
}

class ComplyCubeError {
  int? errorCode;
  String? message;
  String? description;
  ComplyCubeErrorCode? complyCubeErrorCode;

  ComplyCubeError({this.errorCode, this.message, this.description, this.complyCubeErrorCode});

  ComplyCubeError.fromJson(Map<String, dynamic> json) {
    errorCode = json["errorCode"];
    message = json["message"];
    description = json["description"];
    complyCubeErrorCode = ComplyCubeErrorCode.values[errorCode!];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["errorCode"] = errorCode;
    data["message"] = message;
    data["description"] = description;
    return data;
  }
}
