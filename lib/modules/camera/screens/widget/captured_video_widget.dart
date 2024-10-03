// ignore_for_file: must_be_immutable, unnecessary_null_comparison

import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:media_store_plus/media_store_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pecockapp/global/utils/logger_util.dart';
import 'package:pecockapp/main.dart';
import 'package:video_player/video_player.dart';

class CapturedVideoWidget extends StatefulWidget {
  const CapturedVideoWidget({
    super.key,
    required this.capturedVideo,
  });

  final XFile? capturedVideo;

  @override
  State<CapturedVideoWidget> createState() => _CapturedVideoWidgetState();
}

class _CapturedVideoWidgetState extends State<CapturedVideoWidget> {
  late VideoPlayerController _controller;
  bool isPlaying = false;
  @override
  void initState() {
    _controller = VideoPlayerController.file(File(widget.capturedVideo!.path),
        videoPlayerOptions: VideoPlayerOptions(
            webOptions: const VideoPlayerWebOptions(
                controls: VideoPlayerWebOptionsControls.enabled())))
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });

    _controller.addListener(() {
      _controller.position.then((c) {
        if (c == _controller.value.position) {
          setState(() {
            isPlaying = false;
          });
        }
      });
    });

    super.initState();
  }

  @override
  void dispose() {
    setState(() {
      isPlaying = false;
    });
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.capturedVideo != null
          ? Center(
              child: AspectRatio(
                aspectRatio: 9 / 16,
                child: Center(
                  child: RotatedBox(
                      quarterTurns: 45, child: VideoPlayer(_controller)),
                ),
              ),
            )
          : const Center(
              child: Text('No video captured'),
            ),
      floatingActionButton: Container(
        margin: const EdgeInsets.all(20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            FloatingActionButton(
              shape: const CircleBorder(),
              foregroundColor: Colors.blue,
              onPressed: () async {
                if (widget.capturedVideo != null) {
                  Directory mainDirectory =
                      await getApplicationSupportDirectory();

                  File tempFile = File("${mainDirectory.path}/xyz.mp4");
                  File(widget.capturedVideo!.path).copy(tempFile.path);
                  mediaStorePlugin
                      .saveFile(
                          tempFilePath: tempFile.path,
                          dirType: DirType.video,
                          dirName: DirType.video.defaults)
                      .then((c) {
                    if (c != null && c.saveStatus != null) {
                      LoggerUtil().debugData("Save:- ${c.saveStatus}");
                    } else {
                      LoggerUtil().errorData("Save failed");
                    }
                  }).onError((e, k) {
                    LoggerUtil().errorData("Error:- $e");
                  });
                } else {
                  LoggerUtil().errorData("No video to save");
                }
              },
              child: const Icon(Icons.save),
            ),
            (isPlaying == false)
                ? FloatingActionButton(
                    shape: const CircleBorder(),
                    foregroundColor: Colors.green,
                    onPressed: () async {
                      _controller.play().then((c) {
                        setState(() {
                          isPlaying = true;
                        });
                      });
                    },
                    child: const Icon(Icons.play_arrow),
                  )
                : FloatingActionButton(
                    shape: const CircleBorder(),
                    foregroundColor: Colors.red,
                    onPressed: () async {
                      _controller.pause().then((c) {
                        setState(() {
                          isPlaying = false;
                        });
                      });
                    },
                    child: const Icon(Icons.pause),
                  ),
          ],
        ),
      ),
    );
  }
}
