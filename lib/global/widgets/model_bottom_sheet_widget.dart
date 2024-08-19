
import 'package:flutter/material.dart';
import 'package:pecockapp/global/utils/utils.dart';

class ModelBottomSheetWidget {
  static imagePicker(BuildContext context,
      {Function()? galleryFunc, Function()? cameraFunc}) {
    return showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      elevation: 20,
      isDismissible: true,
      showDragHandle: true,
      scrollControlDisabledMaxHeightRatio: 0.4,
      sheetAnimationStyle: AnimationStyle(curve: Curves.bounceInOut),
      builder: (context) {
        return Container(
          width: context.screenWidth,
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20)),
              gradient: LinearGradient(
                  colors: [Colors.deepPurple, Colors.blue],
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Select Image",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              const SizedBox(
                height: 10,
              ),
              ((galleryFunc != null) && (cameraFunc != null))
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            IconButton(
                                onPressed: galleryFunc,
                                icon: const Icon(
                                  Icons.image,
                                  color: Colors.green,
                                  size: 50,
                                )),
                            const SizedBox(
                              height: 10,
                            ),
                            const Text(
                              "Gallery",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                          ],
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                           mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            IconButton(
                                onPressed: cameraFunc,
                                icon: const Icon(
                                  Icons.camera,
                                  color: Colors.amber,
                                  size: 50,
                                )),
                            const SizedBox(
                              height: 10,
                            ),
                            const Text(
                              "Camera",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                          ],
                        ),
                      ],
                    )
                  : (((galleryFunc != null) && (cameraFunc == null))
                      ? Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            IconButton(
                                onPressed: galleryFunc,
                                icon: const Icon(
                                  Icons.image,
                                  color: Colors.green,
                                  size: 50,
                                )),
                            const SizedBox(
                              height: 10,
                            ),
                            const Text(
                              "Gallery",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                          ],
                        )
                      : Column(
                          mainAxisSize: MainAxisSize.min,
                           mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            IconButton(
                                onPressed: cameraFunc,
                                icon: const Icon(
                                  Icons.camera,
                                  color: Colors.amber,
                                  size: 50,
                                )),
                            const SizedBox(
                              height: 10,
                            ),
                            const Text(
                              "Camera",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                          ],
                        ))
            ],
          ),
        );
      },
    );
  }
}
