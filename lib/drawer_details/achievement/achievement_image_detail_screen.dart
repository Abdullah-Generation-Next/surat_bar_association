import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class AchievementImgZoom extends StatefulWidget {
  String? imageIndex;

  AchievementImgZoom({super.key, required this.imageIndex});

  @override
  State<AchievementImgZoom> createState() => _AchievementImgZoomState();
}

class _AchievementImgZoomState extends State<AchievementImgZoom> {
  late final TransformationController Tcontroller;
  TapDownDetails? tapDownDetails;

  @override
  void initState() {
    super.initState();

    Tcontroller = TransformationController();
  }

  @override
  void dispose() {
    Tcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            tooltip: 'Back',
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
              size: 25.h,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          child: PhotoViewGallery.builder(
            itemCount: 1,
            builder: (context, index) {
              return PhotoViewGalleryPageOptions(
                imageProvider: NetworkImage(widget.imageIndex.toString()),
                minScale: PhotoViewComputedScale.contained * 1,
                maxScale: PhotoViewComputedScale.covered * 2,
              );
            },
            scrollPhysics: BouncingScrollPhysics(),
            backgroundDecoration: BoxDecoration(
              color: Colors.transparent,
            ),
            pageController: PageController(),
          ),
        ));

        // Center(
        //     child: Container(
        //       height: 550.h,
        //       width: double.infinity,
        //       child: GestureDetector(
        //         onTapDown: (details) => tapDownDetails = details,
        //         onTap: () {
        //           final position = tapDownDetails!.localPosition;
        //
        //           final double scale = 1.5;
        //           final x = -position.dx * (scale - 1);
        //           final y = -position.dy * (scale - 1);
        //           final zoomed = Matrix4.identity()
        //             ..translate(x, y)
        //             ..scale(scale);
        //
        //           final value = Tcontroller.value.isIdentity()
        //               ? zoomed
        //               : Matrix4.identity();
        //           Tcontroller.value = value;
        //         },
        //         child: InteractiveViewer(
        //             clipBehavior: Clip.none,
        //             transformationController: Tcontroller,
        //             panEnabled: false,
        //             scaleEnabled: false,
        //             constrained: true,
        //             child: AspectRatio(
        //               aspectRatio: 0.75,
        //               child: Ink(
        //                 decoration: BoxDecoration(
        //                   image: DecorationImage(
        //                     image: NetworkImage(widget.imageIndex.toString()),
        //                     fit: BoxFit.fill,
        //                   ),
        //                 ),
        //               ),
        //             )),
        //       ),
        //     )));
  }
}
