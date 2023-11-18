/// Start stream
//     .then((_) async {
//     await _controller.startImageStream(onLatestImageAvailable);
//     setState(() {});
//
//     /// previewSize is size of each image frame captured by controller
//     ///
//     /// 352x288 on iOS, 240p (320x240) on Android with ResolutionPreset.low
//     ScreenParams.previewSize = _controller.value.previewSize!;
//     })

/// Some UI for beauty
// // Stats
// _statsWidget(),
// // Bounding boxes
// AspectRatio(
// aspectRatio: aspect,
// child: _boundingBoxes(),
// ),


/// Stats usage
//  Widget _statsWidget() => (stats != null)
//       ? Align(
//           alignment: Alignment.bottomCenter,
//           child: Container(
//             color: Colors.white.withAlpha(150),
//             child: Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: stats!.entries
//                     .map((e) => StatsWidget(e.key, e.value))
//                     .toList(),
//               ),
//             ),
//           ),
//         )
//       : const SizedBox.shrink();

/// Streaming in detector widget
// void _initStateAsync() async {
//   // initialize preview and CameraImage stream
//   _initializeCamera();
//   // Spawn a new isolate
//   Detector.start().then((instance) {
//     setState(() {
//       _detector = instance;
//       _subscription = instance.resultsStream.stream.listen((values) {
//         setState(() {
//           results = values['recognitions'];
//           stats = values['stats'];
//         });
//       });
//     });
//   });
// }

/// Lifecycle listen
// with WidgetsBindingObserver
// WidgetsBinding.instance.addObserver(this);
//
// @override
// void didChangeAppLifecycleState(AppLifecycleState state) async {
//   switch (state) {
//     case AppLifecycleState.inactive:
//       _cameraController?.stopImageStream();
//       _detector?.stop();
//       _subscription?.cancel();
//       break;
//     case AppLifecycleState.resumed:
//       _initStateAsync();
//       break;
//     default:
//   }
// }

/// Dispose stuff
//    WidgetsBinding.instance.removeObserver(this);
//     _detector?.stop();
//     _subscription?.cancel();

/// Controllers
//  /// Object Detector is running on a background [Isolate]. This is nullable
//   /// because acquiring a [Detector] is an asynchronous operation. This
//   /// value is `null` until the detector is initialized.
//   Detector? _detector;
//   StreamSubscription? _subscription;
//
//   /// Results to draw bounding boxes
//   List<Recognition>? results;
//
//   /// Realtime stats
//   Map<String, String>? stats;

/// Processing and displaying
// // Returns Stack of bounding boxes
// Widget _boundingBoxes() {
//   if (results == null) {
//     return const SizedBox.shrink();
//   }
//   return Stack(
//       children: results!.map((box) => BoxWidget(result: box)).toList());
// }
//
// /// Callback to receive each frame [CameraImage] perform inference on it
// void onLatestImageAvailable(CameraImage cameraImage) async {
//   _detector?.processFrame(cameraImage);
// }

/// Configure detector part
//   static const String _modelPath = 'assets/models/ssd_mobilenet.tflite';
//   static const String _labelPath = 'assets/models/labelmap.txt';
//
//   Detector._(this._isolate, this._interpreter, this._labels);
//
//   final Isolate _isolate;
//   late final Interpreter _interpreter;
//   late final List<String> _labels;
//
//   // To be used by detector (from UI) to send message to our Service ReceivePort
//   late final SendPort _sendPort;
//
//   bool _isReady = false;
//
//   // // Similarly, StreamControllers are stored in a queue so they can be handled
//   // // asynchronously and serially.
//   final StreamController<Map<String, dynamic>> resultsStream =
//       StreamController<Map<String, dynamic>>();

/// Model/Labels loading for detection
//  static Future<Interpreter> _loadModel() async {
//     final interpreterOptions = InterpreterOptions();
//
//     // Use XNNPACK Delegate
//     if (Platform.isAndroid) {
//       interpreterOptions.addDelegate(XNNPackDelegate());
//     }
//
//     return Interpreter.fromAsset(
//       _modelPath,
//       options: interpreterOptions..threads = 4,
//     );
//   }
//
//   static Future<List<String>> _loadLabels() async {
//     return (await rootBundle.loadString(_labelPath)).split('\n');
//   }

/// Start detection in isolate
//    final ReceivePort receivePort = ReceivePort();
//     // sendPort - To be used by service Isolate to send message to our ReceiverPort
//     final Isolate isolate =
//         await Isolate.spawn(_DetectorServer._run, receivePort.sendPort);
//
//     final Detector result = Detector._(
//       isolate,
//       await _loadModel(),
//       await _loadLabels(),
//     );
//     receivePort.listen((message) {
//       result._handleCommand(message as _Command);
//     });

/// Image processing delegation to service
//    if (_isReady) {
//       _sendPort.send(_Command(_Codes.detect, args: [cameraImage]));
//     }

/// root isolate token for background init
//        _sendPort = command.args?[0] as SendPort;
//         RootIsolateToken rootIsolateToken = RootIsolateToken.instance!;
//         _sendPort.send(_Command(_Codes.init, args: [
//           rootIsolateToken,
//           _interpreter.address,
//           _labels,
//         ]));

/// Propagate results when ready
//         _isReady = true;
//         resultsStream.add(command.args?[0] as Map<String, dynamic>);

/// Detection is in progress here
//         _sendPort.send(const _Command(_Codes.busy));
//         _convertCameraImage(command.args?[0] as CameraImage);

/// Init service part
//         RootIsolateToken rootIsolateToken = command.args?[0] as RootIsolateToken;
//         BackgroundIsolateBinaryMessenger.ensureInitialized(rootIsolateToken);
//         _interpreter = Interpreter.fromAddress(command.args?[1] as int);
//         _labels = command.args?[2] as List<String>;
//         _sendPort.send(const _Command(_Codes.ready));
