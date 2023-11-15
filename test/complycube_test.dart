import 'package:flutter_test/flutter_test.dart';
import 'package:complycube/complycube.dart';
import 'package:complycube/complycube_platform_interface.dart';
import 'package:complycube/complycube_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockComplycubePlatform
    with MockPlatformInterfaceMixin
    implements ComplycubePlatform {
  @override
  Future<String?> getPlatformVersion() => Future.value('42');

  @override
  void addMethodCallHandler() {
    // TODO: implement addMethodCallHandler
  }

  @override
  Future<String?> invoke() {
    // TODO: implement invoke
    throw UnimplementedError();
  }

  @override
  // TODO: implement onComplyCubeEvents
  Stream get onComplyCubeEvents => throw UnimplementedError();

  @override
  Future<String?> openCCubeNativeBuild(
      {required Map<String, dynamic> settings}) {
    // TODO: implement openCCubeNativeBuild
    throw UnimplementedError();
  }
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
