import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:image_picker/image_picker.dart'; // นำเข้า image_picker
import 'dart:io';

class CameraPage extends StatefulWidget {
  @override
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  CameraController? _cameraController;
  List<CameraDescription>? _cameras;
  XFile? _imageFile;
  int _currentCameraIndex = 0;
  final ImagePicker _picker = ImagePicker(); // สร้างตัวเลือกสำหรับแกลเลอรี

  @override
  void initState() {
    super.initState();
    _initCamera(_currentCameraIndex);
  }

  Future<void> _initCamera(int cameraIndex) async {
    _cameras = await availableCameras();
    _cameraController = CameraController(
      _cameras![cameraIndex],
      ResolutionPreset.high,
    );
    await _cameraController!.initialize();

    if (!mounted) return;
    setState(() {});
  }

  Future<void> _takePicture() async {
    if (_cameraController!.value.isInitialized) {
      _imageFile = await _cameraController!.takePicture();
      setState(() {});
    }
  }

  Future<void> _switchCamera() async {
    if (_cameras!.length > 1) {
      _currentCameraIndex = (_currentCameraIndex + 1) % _cameras!.length;
      await _initCamera(_currentCameraIndex); // สลับไปยังกล้องถัดไป
    }
  }

  Future<void> _pickImageFromGallery() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = XFile(pickedFile.path); // เลือกรูปจากแกลเลอรี
      });
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
        title: Text('Camera Page'),
      ),
      body: Column(
        children: [
         Container(
          height: 350,
           child:AspectRatio(
            aspectRatio: _cameraController!.value.aspectRatio,
            child: CameraPreview(_cameraController!),
          ),
         ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // ปุ่มเลือกภาพจากแกลเลอรี
              ElevatedButton(
                onPressed: _pickImageFromGallery,
                child: const Icon(Icons.photo),
              ),
              // ปุ่มถ่ายภาพ
              ElevatedButton(
                onPressed: _takePicture,
                child: const Icon(Icons.camera_alt),
              ),
              // ปุ่มสลับกล้อง
            ],
          ),
          if (_imageFile != null)
            Column(
              children: [
                const SizedBox(height: 30),
                Container(
                  width: 400,
                  child: Image.file(
                    File(_imageFile!.path),
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                )
              ],
            ),
        ],
      ),
    );
  }
}
