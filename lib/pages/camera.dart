import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class CameraPage extends StatefulWidget {
  const CameraPage({super.key});

  @override
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  CameraController? _cameraController;
  List<CameraDescription>? _cameras;
  XFile? _imageFile;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _initCamera();
  }

  Future<void> _initCamera() async {
    try {
      // Get available cameras
      _cameras = await availableCameras();

      // Find the back camera
      final backCamera = _cameras!.firstWhere(
        (camera) => camera.lensDirection == CameraLensDirection.back,
        orElse: () => _cameras![0], // Fallback to the first camera
      );

      // Create the camera controller
      _cameraController = CameraController(
        backCamera,
        ResolutionPreset.high,
      );

      // Initialize the camera
      await _cameraController!.initialize();

      if (!mounted) return;

      setState(() {});
    } catch (e) {
      print("Error initializing camera: $e");
    }
  }

  Future<void> _takePicture() async {
    if (_cameraController!.value.isInitialized) {
      try {
        _imageFile = await _cameraController!.takePicture();
        setState(() {});
      } catch (e) {
        print("Error taking picture: $e");
      }
    }
  }

  Future<void> _pickImageFromGallery() async {
    try {
      final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        setState(() {
          _imageFile = XFile(pickedFile.path);
        });
      }
    } catch (e) {
      print("Error picking image from gallery: $e");
    }
  }
  

  @override
  void dispose() {
    _cameraController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_cameraController == null || !_cameraController!.value.isInitialized) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Camera Page'),
      ),
      body: Column(
        children: [
          // Show the camera preview
          SizedBox(
            height: 250,
            child: AspectRatio(
              aspectRatio: _cameraController!.value.aspectRatio,
              child: CameraPreview(_cameraController!),
            ),
          ),
          const SizedBox(height: 20),
          // Capture and gallery buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: _pickImageFromGallery,
                child: const Icon(Icons.photo),
              ),
              ElevatedButton(
                onPressed: _takePicture,
                child: const Icon(Icons.camera_alt),
              ),
            ],
          ),
          if (_imageFile != null) ...[
            const SizedBox(height: 30),
            // Show the captured image
            SizedBox(
              width: 400,
              child: Image.file(
                File(_imageFile!.path),
                height: 250,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 10),
            const Text("test"), // Display some text below the image
          ],
        ],
      ),
    );
  }
}
