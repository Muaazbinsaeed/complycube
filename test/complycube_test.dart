import 'package:complycube/helpers/complycube_event_codes.dart';
import 'package:complycube/models/events.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:complycube/complycube.dart';
import 'package:complycube/complycube_platform_interface.dart';
import 'package:complycube/complycube_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockComplycubePlatform with MockPlatformInterfaceMixin implements ComplycubePlatform {
  @override
  Future<String?> getPlatformVersion() => Future.value('42');

  @override
  // TODO: implement onComplyCubeEvents
  Stream<ComplyCubeEvent> get onComplyCubeEvents => throw UnimplementedError();

  @override
  Future<String?> openCCubeNativeBuild({required Map<String, dynamic> settings}) {
    // TODO: implement openCCubeNativeBuild
    throw UnimplementedError();
  }

  @override
  // TODO: implement onCancelled
  Stream<ComplyCubeError> get onCancelled => throw UnimplementedError();

  @override
  // TODO: implement onError
  Stream<List<ComplyCubeError>> get onError => throw UnimplementedError();

  @override
  // TODO: implement onSuccess
  Stream<ComplyCubeResult> get onSuccess => throw UnimplementedError();
}

void main() {
  final ComplycubePlatform initialPlatform = ComplycubePlatform.instance;

  test('$MethodChannelComplycube is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelComplycube>());
  });

  test('getPlatformVersion', () async {
    //Complycube complycubePlugin = Complycube();
    MockComplycubePlatform fakePlatform = MockComplycubePlatform();
    ComplycubePlatform.instance = fakePlatform;

    expect(await Complycube.getPlatformVersion(), '42');
  });
}
