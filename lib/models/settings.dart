import 'package:flutter/material.dart';

class ComplyCubeSettings {
  String? clientId;
  String? clientToken;
  List<ComplyCubeStage>? stages = [WelcomeStage()];
  ComplyCubeColorScheme? colorScheme;

  ComplyCubeSettings({this.clientId, this.clientToken, this.stages, this.colorScheme});

  ComplyCubeSettings.fromJson(Map<String, dynamic> json) {
    var userStages = (json["stages"] as List).map((stage) => ComplyCubeStages.fromJson(stage)).where((e) => e != null).toList() as List<ComplyCubeStage>;
    clientId = json["clientID"];
    clientToken = json["clientToken"];
    colorScheme = json["scheme"] == null ? null : ComplyCubeColorScheme.fromJson(json["scheme"]);
    stages = json["stages"] == null
        ? null
        : userStages.isEmpty
            ? [WelcomeStage()]
            : userStages;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["clientID"] = clientId;
    data["clientToken"] = clientToken;
    if (stages != null) {
      data["stages"] = stages?.map((stage) => ComplyCubeStages.toJson(stage)).where((e) => e != null).toList() ?? [];
    }
    if (colorScheme != null) {
      data["scheme"] = colorScheme?.toJson();
    }
    return data;
  }
}

class ComplyCubeColorScheme {
  Color? headerTitle;
  Color? subheaderTitle;
  Color? textSecondary;
  Color? docTypeBgColor;
  Color? docTypeTextColor;
  Color? docTypeBorderColor;
  Color? textItemType;
  Color? blueBigType;
  Color? primaryButtonBgColor;
  Color? primaryButtonPressedBgColor;
  Color? primaryButtonBorderColor;
  Color? primaryButtonTextColor;
  Color? secondaryButtonBgColor;
  Color? secondaryButtonPressedBgColor;
  Color? secondaryButtonBorderColor;
  Color? secondaryButtonTextColor;
  Color? linkButtonTextColor;
  Color? popUpBgColor;
  Color? popUpTitleColor;

  ComplyCubeColorScheme(
      {this.headerTitle,
      this.subheaderTitle,
      this.textSecondary,
      this.docTypeBgColor,
      this.docTypeTextColor,
      this.docTypeBorderColor,
      this.textItemType,
      this.blueBigType,
      this.primaryButtonBgColor,
      this.primaryButtonPressedBgColor,
      this.primaryButtonBorderColor,
      this.primaryButtonTextColor,
      this.secondaryButtonBgColor,
      this.secondaryButtonPressedBgColor,
      this.secondaryButtonBorderColor,
      this.secondaryButtonTextColor,
      this.linkButtonTextColor,
      this.popUpBgColor,
      this.popUpTitleColor});

  ComplyCubeColorScheme.fromJson(Map<String, dynamic> json) {
    headerTitle = HexColor.fromHex(json["headerTitle"]);
    subheaderTitle = HexColor.fromHex(json["subheaderTitle"]);
    textSecondary = HexColor.fromHex(json["textSecondary"]);
    docTypeBgColor = HexColor.fromHex(json["docTypeBgColor"]);
    docTypeTextColor = HexColor.fromHex(json["docTypeTextColor"]);
    docTypeBorderColor = HexColor.fromHex(json["docTypeBorderColor"]);
    textItemType = HexColor.fromHex(json["textItemType"]);
    blueBigType = HexColor.fromHex(json["blueBigType"]);
    primaryButtonBgColor = HexColor.fromHex(json["primaryButtonBgColor"]);
    primaryButtonPressedBgColor = HexColor.fromHex(json["primaryButtonPressedBgColor"]);
    primaryButtonBorderColor = HexColor.fromHex(json["primaryButtonBorderColor"]);
    primaryButtonTextColor = HexColor.fromHex(json["primaryButtonTextColor"]);
    secondaryButtonBgColor = HexColor.fromHex(json["secondaryButtonBgColor"]);
    secondaryButtonPressedBgColor = HexColor.fromHex(json["secondaryButtonPressedBgColor"]);
    secondaryButtonBorderColor = HexColor.fromHex(json["secondaryButtonBorderColor"]);
    secondaryButtonTextColor = HexColor.fromHex(json["secondaryButtonTextColor"]);
    linkButtonTextColor = HexColor.fromHex(json["linkButtonTextColor"]);
    popUpBgColor = HexColor.fromHex(json["popUpBgColor"]);
    popUpTitleColor = HexColor.fromHex(json["popUpTitleColor"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["headerTitle"] = headerTitle?.toHex();
    data["subheaderTitle"] = subheaderTitle?.toHex();
    data["textSecondary"] = textSecondary?.toHex();
    data["docTypeBgColor"] = docTypeBgColor?.toHex();
    data["docTypeTextColor"] = docTypeTextColor?.toHex();
    data["docTypeBorderColor"] = docTypeBorderColor?.toHex();
    data["textItemType"] = textItemType?.toHex();
    data["blueBigType"] = blueBigType?.toHex();
    data["primaryButtonBgColor"] = primaryButtonBgColor?.toHex();
    data["primaryButtonPressedBgColor"] = primaryButtonPressedBgColor?.toHex();
    data["primaryButtonBorderColor"] = primaryButtonBorderColor?.toHex();
    data["primaryButtonTextColor"] = primaryButtonTextColor?.toHex();
    data["secondaryButtonBgColor"] = secondaryButtonBgColor?.toHex();
    data["secondaryButtonPressedBgColor"] = secondaryButtonPressedBgColor?.toHex();
    data["secondaryButtonBorderColor"] = secondaryButtonBorderColor?.toHex();
    data["secondaryButtonTextColor"] = secondaryButtonTextColor?.toHex();
    data["linkButtonTextColor"] = linkButtonTextColor?.toHex();
    data["popUpBgColor"] = popUpBgColor?.toHex();
    data["popUpTitleColor"] = popUpTitleColor?.toHex();
    return data;
  }
}

extension HexColor on Color {
  /// String is in the format "aabbcc" or "ffaabbcc" with an optional leading "#".
  static Color? fromHex(String? hexString) {
    if (hexString == null) return null;
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  /// Prefixes a hash sign if [leadingHashSign] is set to `true` (default is `true`).
  String toHex({bool leadingHashSign = true}) => '${leadingHashSign ? '#' : ''}'
      '${alpha.toRadixString(16).padLeft(2, '0')}'
      '${red.toRadixString(16).padLeft(2, '0')}'
      '${green.toRadixString(16).padLeft(2, '0')}'
      '${blue.toRadixString(16).padLeft(2, '0')}';
}

class ComplyCubeStage extends Object {}

extension ComplyCubeStages on ComplyCubeStage {
  static ComplyCubeStage? fromJson(dynamic stage) {
    if (stage is String) return _getStringStage(stage);
    if (stage is Map<String, dynamic>) return _getMappedStage(stage);
    return null;
  }

  static Map<String, dynamic>? toJson(ComplyCubeStage stage) {
    if (stage is WelcomeStage) return stage.toJson();
    if (stage is ConsentStage) return stage.toJson();
    if (stage is DocumentStage) return stage.toJson();
    if (stage is BiometricStage) return stage.toJson();
    if (stage is AddressStage) return stage.toJson();
    return null;
  }

  static ComplyCubeStage? _getStringStage(String stage) {
    switch (stage) {
      case "intro":
        return WelcomeStage(name: "intro");
      case "consent":
        return ConsentStage(name: "consent");
      case "documentCapture":
        return DocumentStage(name: "documentCapture");
      case "faceCapture":
        return BiometricStage(name: "faceCapture");
      case "poaCapture":
        return AddressStage(name: "poaCapture");
      default:
        return null;
    }
  }

  static ComplyCubeStage? _getMappedStage(Map<String, dynamic> stage) {
    switch (stage["name"]) {
      case "intro":
        return WelcomeStage.fromJson(stage);
      case "consent":
        return ConsentStage.fromJson(stage);
      case "documentCapture":
        return DocumentStage.fromJson(stage);
      case "faceCapture":
        return BiometricStage.fromJson(stage);
      case "poaCapture":
        return AddressStage.fromJson(stage);
      default:
        return null;
    }
  }
}

class WelcomeStage extends ComplyCubeStage {
  String? name = "intro";
  String? title;
  String? message;

  WelcomeStage({this.name, this.title, this.message});

  WelcomeStage.fromJson(Map<String, dynamic> json) {
    name = json["name"];
    title = json["title"];
    message = json["message"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["name"] = name;
    data["title"] = title;
    data["message"] = message;
    return data;
  }
}

class ConsentStage extends ComplyCubeStage {
  String? name = "consent";
  String? title;
  String? message;

  ConsentStage({this.name, this.title, this.message});

  ConsentStage.fromJson(Map<String, dynamic> json) {
    name = json["name"];
    title = json["title"];
    message = json["message"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["name"] = name;
    data["title"] = title;
    data["message"] = message;
    return data;
  }
}

class DocumentStage extends ComplyCubeStage {
  String? name = "documentCapture";
  String? title;
  bool? enableNfc;
  bool? showGuidance;
  bool? useLiveCapture;
  bool? useMlAssistance;
  int? retryLimit;
  List<String>? countries;
  DocumentTypes? documentTypes;

  DocumentStage(
      {this.name, this.title, this.enableNfc, this.showGuidance, this.useLiveCapture, this.useMlAssistance, this.retryLimit, this.countries, this.documentTypes});

  DocumentStage.fromJson(Map<String, dynamic> json) {
    name = json["name"];
    title = json["title"];
    enableNfc = json["enableNFC"];
    showGuidance = json["showGuidance"];
    useLiveCapture = json["liveCapture"];
    useMlAssistance = json["useMLAssistance"];
    retryLimit = json["retryLimit"];
    countries = json["countries"] == null ? null : List<String>.from(json["countries"]);
    documentTypes = json["documentTypes"] == null ? null : DocumentTypes.fromJson(json["documentTypes"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["name"] = name;
    data["title"] = title;
    data["enableNFC"] = enableNfc;
    data["showGuidance"] = showGuidance;
    data["liveCapture"] = useLiveCapture;
    data["useMLAssistance"] = useMlAssistance;
    data["retryLimit"] = retryLimit;
    if (countries != null) {
      data["countries"] = countries;
    }
    if (documentTypes != null) {
      data["documentTypes"] = documentTypes?.toJson();
    }
    return data;
  }
}

class DocumentTypes {
  bool? passport;
  bool? selfie;
  bool? videoSelfie;
  List<String>? drivingLicense;
  List<String>? nationalIdentityCard;
  List<String>? residencePermit;
  List<String>? bankStatement;
  List<String>? councilTaxBill;
  List<String>? utilityBill;

  DocumentTypes({
    this.passport,
    this.selfie,
    this.videoSelfie,
    this.drivingLicense,
    this.nationalIdentityCard,
    this.residencePermit,
    this.bankStatement,
    this.councilTaxBill,
    this.utilityBill,
  });

  DocumentTypes.fromJson(Map<String, dynamic> json) {
    passport = json["passport"];
    selfie = json["selfie"];
    videoSelfie = json["videoSelfie"];
    drivingLicense = json["driving_license"] == null ? null : List<String>.from(json["driving_license"]);
    nationalIdentityCard = json["national_identity_card"] == null ? null : List<String>.from(json["national_identity_card"]);
    residencePermit = json["residence_permit"] == null ? null : List<String>.from(json["residence_permit"]);
    bankStatement = json["bank_statement"] == null ? null : List<String>.from(json["bank_statement"]);
    councilTaxBill = json["council_tax_bill"] == null ? null : List<String>.from(json["council_tax_bill"]);
    utilityBill = json["utility_bill"] == null ? null : List<String>.from(json["utility_bill"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["passport"] = passport;
    data["selfie"] = selfie;
    data["videoSelfie"] = videoSelfie;
    if (drivingLicense != null) {
      data["driving_license"] = drivingLicense;
    }
    if (nationalIdentityCard != null) {
      data["national_identity_card"] = nationalIdentityCard;
    }
    if (residencePermit != null) {
      data["residence_permit"] = residencePermit;
    }
    if (bankStatement != null) {
      data["bank_statement"] = bankStatement;
    }
    if (councilTaxBill != null) {
      data["council_tax_bill"] = councilTaxBill;
    }
    if (utilityBill != null) {
      data["utility_bill"] = utilityBill;
    }
    return data;
  }
}

class BiometricStage extends ComplyCubeStage {
  String? name = "faceCapture";
  BiometricType? type;
  bool? showGuidance;
  bool? useLiveCapture;
  bool? useMlAssistance;
  int? retryLimit;

  BiometricStage({this.name, this.type, this.showGuidance, this.useLiveCapture, this.useMlAssistance, this.retryLimit});

  BiometricStage.fromJson(Map<String, dynamic> json) {
    name = json["name"];
    type = Type.getType(json["type"]);
    showGuidance = json["showGuidance"];
    useLiveCapture = json["liveCapture"];
    useMlAssistance = json["useMLAssistance"];
    retryLimit = json["retryLimit"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["name"] = name;
    data["type"] = Type.getBiometricType(type);
    data["showGuidance"] = showGuidance;
    data["liveCapture"] = useLiveCapture;
    data["useMLAssistance"] = useMlAssistance;
    data["retryLimit"] = retryLimit;
    return data;
  }
}

enum BiometricType {
  photo,
  video,
}

class Type {
  static const photo = 'photo';
  static const video = 'video';

  static BiometricType? getType(String? type) {
    switch (type) {
      case Type.photo:
        return BiometricType.photo;
      case Type.video:
        return BiometricType.video;
      default:
        return null;
    }
  }

  static String? getBiometricType(BiometricType? type) {
    switch (type) {
      case BiometricType.photo:
        return Type.photo;
      case BiometricType.video:
        return Type.video;
      default:
        return null;
    }
  }
}

class AddressStage extends ComplyCubeStage {
  String? name = "poaCapture";
  bool? showGuidance;
  bool? useLiveCapture;
  bool? useMlAssistance;
  int? retryLimit;

  AddressStage({this.name, this.showGuidance, this.useLiveCapture, this.useMlAssistance, this.retryLimit});

  AddressStage.fromJson(Map<String, dynamic> json) {
    name = json["name"];
    showGuidance = json["showGuidance"];
    useLiveCapture = json["liveCapture"];
    useMlAssistance = json["useMLAssistance"];
    retryLimit = json["retryLimit"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["name"] = name;
    data["showGuidance"] = showGuidance;
    data["liveCapture"] = useLiveCapture;
    data["useMLAssistance"] = useMlAssistance;
    data["retryLimit"] = retryLimit;
    return data;
  }
}
