import 'package:complycube/helpers/complycube_event_codes.dart';
import 'package:complycube/models/events.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'complycube_method_channel.dart';

abstract class ComplycubePlatform extends PlatformInterface {
  /// Constructs a ComplycubePlatform.
  ComplycubePlatform() : super(token: _token);

  static final Object _token = Object();

  static ComplycubePlatform _instance = MethodChannelComplycube();

  /// The default instance of [ComplycubePlatform] to use.
  ///
  /// Defaults to [MethodChannelComplycube].
  static ComplycubePlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [ComplycubePlatform] when
  /// they register themselves.
  static set instance(ComplycubePlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  /// Can only be listened once. If have more than one subscription, only the last subscription can receive events.
  Stream<List<ComplyCubeError>> get onError => throw UnimplementedError();

  /// Can only be listened once. If have more than one subscription, only the last subscription can receive events.
  Stream<ComplyCubeResult> get onSuccess => throw UnimplementedError();

  /// Can only be listened once. If have more than one subscription, only the last subscription can receive events.
  Stream<ComplyCubeError> get onCancelled => throw UnimplementedError();

  /// Can only be listened once. If have more than one subscription, only the last subscription can receive events.
  Stream<ComplyCubeEvent> get onComplyCubeEvents => throw UnimplementedError();

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Future<String?> openCCubeNativeBuild({required Map<String, dynamic> settings}) {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
