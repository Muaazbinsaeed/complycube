import 'package:complycube/helpers/complycube_event_codes.dart';
import 'package:complycube/models/events.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'complycube_platform_interface.dart';

/// An implementation of [ComplycubePlatform] that uses method channels.
class MethodChannelComplycube extends ComplycubePlatform {
  /// The method channel is used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('complycube_methods');

  /// The event channel is used to receive state change events.
  @visibleForTesting
  final eventChannel = const EventChannel('complycube_events');

  /// The event channel is used to receive state change events.
  @visibleForTesting
  final errorChannel = const EventChannel('complycube_error');

  /// The event channel is used to receive state change events.
  @visibleForTesting
  final errorsChannel = const EventChannel('complycube_errors');

  /// The event channel is used to receive state change events.
  @visibleForTesting
  final resultChannel = const EventChannel('complycube_result');

  /// Can only be listened once. If have more than one subscription, only the last subscription can receive events.
  @override
  Stream<List<ComplyCubeError>> get onError => errorsChannel
      .receiveBroadcastStream()
      .map((events) => List.from(events).map((event) => ComplyCubeError.fromJson(Map.castFrom<Object?, Object?, String, dynamic>(event))).toList());

  /// Can only be listened once. If have more than one subscription, only the last subscription can receive events.
  @override
  Stream<ComplyCubeResult> get onSuccess => resultChannel.receiveBroadcastStream().map((event) => ComplyCubeResult.fromJson(event));

  /// Can only be listened once. If have more than one subscription, only the last subscription can receive events.
  @override
  Stream<ComplyCubeError> get onCancelled =>
      errorChannel.receiveBroadcastStream().map((event) => ComplyCubeError.fromJson(Map.castFrom<Object?, Object?, String, dynamic>(event)));

  /// Can only be listened once. If have more than one subscription, only the last subscription can receive events.
  @override
  Stream<ComplyCubeEvent> get onComplyCubeEvents =>
      eventChannel.receiveBroadcastStream().map((event) => ComplyCubeEvent.values.firstWhere((e) => e.toString().contains(event)));

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }

  @override
  Future<String?> openCCubeNativeBuild({required Map<String, dynamic> settings}) async {
    final version = await methodChannel.invokeMethod<String>('openCCubeNativeBuild', settings);
    return version;
  }
}
