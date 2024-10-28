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
    // ดึงรายการกล้องที่มีอยู่
    _cameras = await availableCameras();

    // ค้นหากล้องหลัง
    final backCamera = _cameras!.firstWhere(
      (camera) => camera.lensDirection == CameraLensDirection.back,
      orElse: () => _cameras![0], // หากไม่พบกล้องหลังให้ใช้กล้องแรก
    );

    // สร้าง CameraController ด้วยกล้องหลัง
    _cameraController = CameraController(
      backCamera,
      ResolutionPreset.high,
    );

    // เริ่มต้นกล้อง
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
          // แสดงภาพตัวอย่างจากกล้อง
          SizedBox(
            height: 350,
            child: AspectRatio(
              aspectRatio: _cameraController!.value.aspectRatio,
              child: CameraPreview(_cameraController!),
            ),
          ),
          const SizedBox(height: 20),
          // ปุ่มถ่ายภาพ
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
          if (_imageFile != null)
            Column(
              children: [
                const SizedBox(height: 30),
                // แสดงภาพที่ถ่ายได้
                SizedBox(
                  width: 400,
                  child: Image.file(
                    File(_imageFile!.path),
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
