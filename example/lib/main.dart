import 'package:complycube_example/comply_cube_widget.dart';
import 'package:complycube_example/open_comply_cube.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: ComplyCubeWidetBuilderPage(),
    );
  }
}

class ComplyCubeWidetBuilderPage extends StatelessWidget {
  const ComplyCubeWidetBuilderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Plugin TestS'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('................Test...............'),
            const SizedBox(height: 16),
            TextButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) => const OpenComplyCubeExample(), //ComplyCubeWidgetBuilder
                  ),
                );
              },
              child: const Text("open by method call"),
            ),
            const SizedBox(height: 16),
            TextButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) => const ComplyCubeWidgetBuilder(), //ComplyCubeWidgetBuilder
                  ),
                );
              },
              child: const Text("open by widget builder"),
            )
          ],
        ),
      ),
    );
  }
}
