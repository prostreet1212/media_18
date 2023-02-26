import 'dart:async';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../screens/media_screen.dart';

class CameraView extends StatefulWidget {
  const CameraView({Key? key}) : super(key: key);

  @override
  State<CameraView> createState() => _CameraViewState();
}

class _CameraViewState extends State<CameraView> with WidgetsBindingObserver {
  late List<CameraDescription> cameras;
  CameraController? controller;
 XFile? lastImage;

  @override
  void initState() {
    super.initState();
    unawaited(initCamera());
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    CameraController cameraController = controller!;
    if (cameraController == null || !cameraController.value.isInitialized) {
      return;
    }
    if (state == AppLifecycleState.inactive) {
      cameraController.dispose();
    } else if (state == AppLifecycleState.resumed) {
      onNewCameraSelected(cameraController.description);
    }
  }

  @override
  void dispose() {
    controller!.dispose();
    super.dispose();
  }

  Future<void>? initCamera() async {
    cameras = await availableCameras();
    controller = CameraController(cameras[0], ResolutionPreset.max,);
    await controller!.initialize(); //then
    setState(() {});
  }

  void onNewCameraSelected(CameraDescription description) async {
    if (controller != null) {
      await controller!.dispose();
    }
    CameraController cameraController = CameraController(
        description, ResolutionPreset.max,);
    controller = cameraController;
    cameraController.addListener(() {
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return controller?.value.isInitialized==true
        ? Stack(
      children: [
        LayoutBuilder(
          builder: (context, constraints) {
            return SizedBox(
              width: constraints.maxWidth,
              height: constraints.maxHeight,
              child: CameraPreview(controller!),
            );
          },
        ),
         //CameraPreview(controller!),
        Padding(padding: EdgeInsets.all(8),
        child: Align(
          alignment: Alignment.bottomRight,
          child: FloatingActionButton(
            child: Icon(Icons.camera),
            onPressed: ()async{
              lastImage= await controller?.takePicture();
              imageList.add(lastImage!);
              setState(() {});
            },
          ),
        ),)
      ],
    )
        : Center(
            child: CircularProgressIndicator(),
          );
  }
}
