// ignore_for_file: must_be_immutable

import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:pecockapp/global/utils/utils.dart';
import 'package:pecockapp/main.dart';

class CameraScreen extends StatefulWidget {
  late Map<String, dynamic>? argus;
  CameraScreen({
    super.key,
    this.argus,
  });

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  late CameraController controller;
  XFile? capturedImage;
  @override
  void initState() {
    super.initState();
    putBackCamera();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  putFrontCamera() {
    controller = CameraController(listOfCameras[1], ResolutionPreset.max);
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    }).catchError((Object e) {
      if (e is CameraException) {
        switch (e.code) {
          case 'CameraAccessDenied':
            // Handle access errors here.
            break;
          default:
            // Handle other errors here.
            break;
        }
      }
    });
  }

  putBackCamera() {
    controller = CameraController(listOfCameras[0], ResolutionPreset.max);
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    }).catchError((Object e) {
      if (e is CameraException) {
        switch (e.code) {
          case 'CameraAccessDenied':
            // Handle access errors here.
            break;
          default:
            // Handle other errors here.
            break;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!controller.value.isInitialized) {
      return Container();
    }
    return (capturedImage != null)
        ? capturedPictureScreenWidget(context)
        : takePictureScreenWidget(context);
  }

  takePictureScreenWidget(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          SizedBox(
              height: context.screenHeight,
              width: context.screenWidth,
              child: CameraPreview(controller)),
        ],
      ),
      floatingActionButton: Container(
        margin: const EdgeInsets.all(20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            FloatingActionButton(
              shape: const CircleBorder(),
              foregroundColor: Colors.white,
              onPressed: () {
                if (controller.description.lensDirection ==
                    CameraLensDirection.back) {
                  putFrontCamera();
                } else {
                  putBackCamera();
                }
              },
              child: const Icon(Icons.change_circle),
            ),
            SizedBox(
              width: context.screenWidth * 0.3,
            ),
            FloatingActionButton(
              shape: const CircleBorder(),
              backgroundColor: Colors.red,
              onPressed: () {
                controller.takePicture().then((c) {
                  setState(() {
                    capturedImage = c;
                  });
                }).onError((e, k) {});
              },
            ),
          ],
        ),
      ),
    );
  }

  capturedPictureScreenWidget(BuildContext context) {
    return Scaffold(
      body: SizedBox(
          height: context.screenHeight,
          width: context.screenWidth,
          child: Image.file(
            File(capturedImage!.path),
          )),
      floatingActionButton: Container(
        margin: const EdgeInsets.all(20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FloatingActionButton(
              shape: const CircleBorder(),
              foregroundColor: Colors.white,
              onPressed: () {},
              child: const Icon(Icons.save),
            ),
            SizedBox(
              width: context.screenWidth * 0.3,
            ),
            FloatingActionButton(
              shape: const CircleBorder(),
              backgroundColor: Colors.red,
              onPressed: () {
                setState(() {
                  capturedImage = null;
                });
              },
              child: const Icon(Icons.cancel_outlined),
            ),
          ],
        ),
      ),
    );
  }
}
