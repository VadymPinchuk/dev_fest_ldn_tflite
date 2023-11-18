import 'package:flutter/material.dart';
import 'package:dev_fest_2023/models/screen_params.dart';
import 'package:dev_fest_2023/ui/detector_widget.dart';

/// [HomeView] stacks [DetectorWidget]
class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    ScreenParams.screenSize = MediaQuery.sizeOf(context);
    return Scaffold(
      key: GlobalKey(),
      appBar: AppBar(
        title: const Text('devFest LDN 2023'),
      ),
      body: const DetectorWidget(),
    );
  }
}
