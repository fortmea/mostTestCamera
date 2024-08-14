import 'dart:async';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class CameraWidget extends StatefulWidget {
  final Function(XFile) onVideoRecorded;
  final int duration;
  final double? height;
  final double? width;
  const CameraWidget(
      {super.key,
      required this.onVideoRecorded,
      this.duration = 3,
      this.height,
      this.width});
  @override
  _CameraWidgetState createState() => _CameraWidgetState();
}

class _CameraWidgetState extends State<CameraWidget> {
  CameraController? _controller;
  bool _isRecording = false;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    final cameras = await availableCameras();
    final camera = (cameras).firstWhere(
        (element) => element.lensDirection == CameraLensDirection.front,
        orElse: () {
      return cameras.first;
    });

    _controller = CameraController(camera, ResolutionPreset.high);

    await _controller!.initialize();
    if (!mounted) return;
    setState(() {});
  }

  Future<void> _startRecording() async {
    if (!_controller!.value.isInitialized) return;

    await _controller!.startVideoRecording();
    setState(() {
      _isRecording = true;
    });

    Timer(Duration(seconds: widget.duration), () {
      _stopRecording();
    });
  }

  Future<void> _stopRecording() async {
    if (!_controller!.value.isRecordingVideo) return;

    final XFile videoFile = await _controller!.stopVideoRecording();

    setState(() {
      _isRecording = false;
    });

    widget.onVideoRecorded(videoFile);
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_controller == null || !_controller!.value.isInitialized) {
      return const Center(child: CircularProgressIndicator());
    }

    return SizedBox(
        height: widget.height,
        width: widget.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Stack(
              children: [
                AspectRatio(
                  aspectRatio: _controller!.value.previewSize!.height /
                      _controller!.value.previewSize!.width,
                  child: CameraPreview(_controller!),
                ),
                _isRecording
                    ? Positioned(
                        top: 10,
                        left: 10,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: const Padding(
                              padding: EdgeInsets.all(8),
                              child: Text(
                                'Sorria para a câmera',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              )),
                        ))
                    : Container(),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 100,
                  height: 100,
                  child: IconButton.outlined(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.white),
                      shape: MaterialStateProperty.all(const CircleBorder()),
                      elevation: MaterialStateProperty.all(4),
                    ),
                    icon: Icon(
                      size: 50,
                      _isRecording ? Icons.stop : Icons.videocam,
                      color: _isRecording ? Colors.red : Colors.green,
                    ),
                    onPressed: _isRecording ? _stopRecording : _startRecording,
                  ),
                )
              ],
            ),
          ],
        ));
  }
}
