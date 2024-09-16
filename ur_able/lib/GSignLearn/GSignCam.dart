import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

class GSignCam extends StatefulWidget {
  final VoidCallback onDone;

  GSignCam({required this.onDone});

  @override
  _GSignCamState createState() => _GSignCamState();
}

class _GSignCamState extends State<GSignCam> {
  CameraController? _cameraController;
  List<CameraDescription>? _cameras;
  int _selectedCameraIndex = 0;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    _cameras = await availableCameras();
    if (_cameras != null && _cameras!.isNotEmpty) {
      _cameraController = CameraController(
        _cameras![_selectedCameraIndex],
        ResolutionPreset.medium,
      );
      await _cameraController!.initialize();
      setState(() {});
    }
  }

  void _flipCamera() {
    if (_cameras != null && _cameras!.length > 1) {
      _selectedCameraIndex = (_selectedCameraIndex + 1) % _cameras!.length;
      _initializeCamera();
    }
  }

  @override
  void dispose() {
    _cameraController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Recognition'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Center(
        child: Stack(
          children: [
            // Camera input
            Center(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.75,
                height: MediaQuery.of(context).size.height * 0.75,
                child: _cameraController != null && _cameraController!.value.isInitialized
                    ? CameraPreview(_cameraController!)
                    : Center(child: CircularProgressIndicator()),
              ),
            ),
            // Flip camera button
            Positioned(
              top: 20,
              right: 20,
              child: ElevatedButton(
                onPressed: _flipCamera,
                style: ElevatedButton.styleFrom(
                  shape: CircleBorder(),
                  backgroundColor: Colors.deepPurple,
                  padding: EdgeInsets.all(12),
                ),
                child: Icon(
                  Icons.flip_camera_android,
                  color: Colors.white,
                ),
              ),
            ),
            // Done button
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: ElevatedButton(
                  onPressed: widget.onDone,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 15.0),
                  ),
                  child: Text(
                    'Done',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
