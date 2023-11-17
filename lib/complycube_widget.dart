import 'package:complycube/helpers/complycube_event_codes.dart';
import 'package:complycube/models/events.dart';
import 'package:flutter/material.dart';

import 'complycube.dart';

class ComplyCubeWidget extends StatefulWidget {
  final Map<String, dynamic> settings;
  // Declare callback functions
  final void Function(ComplyCubeEvent event)? onComplyCubeEvent;
  final void Function(ComplyCubeError error)? onCancelled;
  final void Function(ComplyCubeResult result)? onSuccess;
  final void Function(List<ComplyCubeError> errors)? onError;

  const ComplyCubeWidget({
    super.key,
    required this.settings,
    this.onCancelled,
    this.onSuccess,
    this.onError,
    this.onComplyCubeEvent,
  });

  @override
  State<ComplyCubeWidget> createState() => _ComplyCubeWidgetState();
}

class _ComplyCubeWidgetState extends State<ComplyCubeWidget> {
  @override
  void initState() {
    super.initState();
    init();

    Complycube.onComplyCubeEvents.listen((event) {
      widget.onComplyCubeEvent?.call(event);
    });

    Complycube.onError.listen((errors) {
      widget.onError?.call(errors);
    });

    Complycube.onSuccess.listen((result) {
      widget.onSuccess?.call(result);
    });

    Complycube.onCancelled.listen((error) {
      widget.onCancelled?.call(error);
    });
  }

  String? result;
  Future<void> init() async {
    result = await Complycube.openCCubeNativeBuild(
      settings: widget.settings,
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container();
    /*Center(
      child: Text(result ?? 'Opening sdk ....'),
    ); */
  }
}
