export 'complycube_widget.dart';
import 'package:complycube/models/events.dart';
import 'package:complycube/models/settings.dart';

import 'complycube_platform_interface.dart';
import 'helpers/complycube_event_codes.dart';

class Complycube {
  /// Can only be listened once. If have more than one subscription, only the last subscription can receive events.
  static Stream<List<ComplyCubeError>> get onError => ComplycubePlatform.instance.onError;

  /// Can only be listened once. If have more than one subscription, only the last subscription can receive events.
  static Stream<ComplyCubeResult> get onSuccess => ComplycubePlatform.instance.onSuccess;

  /// Can only be listened once. If have more than one subscription, only the last subscription can receive events.
  static Stream<ComplyCubeError> get onCancelled => ComplycubePlatform.instance.onCancelled;

  /// Can only be listened once. If have more than one subscription, only the last subscription can receive events.
  static Stream<ComplyCubeEvent> get onComplyCubeEvents => ComplycubePlatform.instance.onComplyCubeEvents;

  static Future<String?> getPlatformVersion() {
    return ComplycubePlatform.instance.getPlatformVersion();
  }

  static Future<String?> openCCubeNativeBuild({required ComplyCubeSettings settings}) {
    return ComplycubePlatform.instance.openCCubeNativeBuild(settings: settings.toJson());
  }
}
