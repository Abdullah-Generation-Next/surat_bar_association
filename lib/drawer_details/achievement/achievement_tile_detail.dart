import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:html/parser.dart';
import 'package:surat_district_bar_association/model/achievement_model.dart';
import 'package:surat_district_bar_association/widgets/media_query_sizes.dart';
import '../../widgets/drawer.dart';
import 'achievement_image_detail_screen.dart';

class AchievementDetailScreen extends StatefulWidget {
  achievementDatum? allData;
  AchievementDetailScreen({
    super.key,
    this.allData,
  });

  @override
  State<AchievementDetailScreen> createState() => _AchievementDetailScreenState();
}

class _AchievementDetailScreenState extends State<AchievementDetailScreen> {
  final ScrollController _controller = ScrollController();
  String mainUrl = "https://vakalat-public.s3.ap-southeast-1.amazonaws.com/";

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
    // animationController.dispose();
    super.dispose();
  }

  String _parseHtmlString(String htmlString) {
    final document = parse(htmlString);
    final String parsedString = parse(document.body!.text).documentElement!.text;

    return parsedString;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          'Achievement Detail',
          textScaleFactor: 0.9,
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: ScrollConfiguration(
        behavior: MyBehavior(),
        child: ListView(
          controller: _controller,
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Text(
                    // 'Demonstration - Dastaveg Registration Garvi 2.0 Software From Govt Of Gujarat',
                    widget.allData!.body.isEmpty
                        ? 'Achievement Title Not Availble'
                        : widget.allData!.body,
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      // fontSize: 12
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(top: 10)),
                  CachedNetworkImage(
                    imageUrl: mainUrl + widget.allData!.coverImage,
                    imageBuilder: (context, imageProvider) => Material(
                      elevation: 0,
                      shape: RoundedRectangleBorder(),
                      clipBehavior: Clip.antiAlias,
                      color: Colors.transparent,
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        child: Container(
                          height: screenheight(context, dividedby: 1.5.h),
                          width: MediaQuery.of(context).size.width / 1.06,
                          child: InkWell(
                            onTap: () {},
                            radius: 0,
                            borderRadius:
                            BorderRadius.all(Radius.circular(10)),
                            // child: GestureDetector(
                            //   onTapDown: (details) =>
                            //   tapDownDetails = details,
                            //   onTap: () {
                            //     final position =
                            //         tapDownDetails!.localPosition;
                            //
                            //     final double scale = 1.5;
                            //     final x = -position.dx * (scale - 1);
                            //     final y = -position.dy * (scale - 1);
                            //     final zoomed = Matrix4.identity()
                            //       ..translate(x, y)
                            //       ..scale(scale);
                            //
                            //     final value = Tcontroller.value.isIdentity()
                            //         ? zoomed
                            //         : Matrix4.identity();
                            //     Tcontroller.value = value;

                                // final end = Tcontroller.value.isIdentity() ? zoomed : Matrix4.identity();

                                // animation = Matrix4Tween(
                                //   begin: Tcontroller.value,
                                //   end: end,
                                // ).animate(CurveTween(curve: Curves.easeOut).animate(animationController));
                                //
                                // animationController.forward(from: -1);
                              // },
                              // child: InteractiveViewer(
                              //   clipBehavior: Clip.none,
                              //   transformationController: Tcontroller,
                              //   panEnabled: false,
                              //   scaleEnabled: false,
                              //   constrained: true,
                              //   child: AspectRatio(
                              //     aspectRatio: 1,
                                  child: Ink(
                                    height: screenheight(context, dividedby: 4.h),
                                    width: screenwidth(context, dividedby: 1.5.w),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      image: DecorationImage(
                                        // image: AssetImage(
                                        //   "images/notice_detail_img.png",
                                        // ),
                                        image: NetworkImage(
                                            mainUrl + widget.allData!.coverImage
                                        ),
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    AchievementImgZoom(
                                                      imageIndex: mainUrl + widget.allData!.coverImage,
                                                    )));
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                    //     ),
                    //   ),
                    // ),
                    placeholder: (context, url) => SizedBox(
                        height: screenheight(context, dividedby: 1.5.h),
                        width: MediaQuery.of(context).size.width / 1.06,
                        child: Center(child: CircularProgressIndicator(
                          color: Colors.grey,
                          strokeWidth: 3,
                        ))),
                    errorWidget: (context, url, error) =>
                        Visibility(visible: false, child: Container()),
                  ),
                  Padding(padding: EdgeInsets.only(top: 10)),
                  Divider(
                    thickness: 2.5,
                    color: Colors.black,
                    indent: 100,
                    endIndent: 100,
                  ),
                  Padding(padding: EdgeInsets.only(top: 10)),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Month : ',
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          // fontSize: 12
                        ),
                      ),
                      Text(
                          // '24/09/2022 - 10:30 AM',
                        "Month: ${widget.allData!.monthDigit} " " ${widget.allData!.monthText}"),
                    ],
                  ),
                  Padding(padding: EdgeInsets.only(top: 10)),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        CupertinoIcons.calendar_today,
                        size: 18.h,
                        color: Colors.grey.shade600,
                      ),
                      Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal:
                                  screenwidth(context, dividedby: 150.w))),
                      Text(
                        // 'Room No 5, Ground Floor New Court Bldg.',
                        "Year : ",
                        style: TextStyle(fontWeight: FontWeight.w700),
                      ),
                      Text(
                        // 'Room No 5, Ground Floor New Court Bldg.',
                        "${widget.allData!.year}",
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  Padding(padding: EdgeInsets.only(top: 10)),
                  Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: RichText(
                      textAlign: TextAlign.start,
                      textScaleFactor: 1.1,
                      text: TextSpan(
                        text: 'Detail : ',
                        style: GoogleFonts.nunito(
                          textStyle: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: Colors.black),
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text:
                            _parseHtmlString('${widget.allData!.detail.isNotEmpty
                                ? widget.allData!.detail
                                : 'Not Available'}'),
                            style: GoogleFonts.nunito(
                              textStyle: TextStyle(
                                color: Colors.black,
                                // decoration: TextDecoration.underline,
                                // decorationStyle: TextDecorationStyle.wavy,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Row(
                  //   crossAxisAlignment: CrossAxisAlignment.center,
                  //   children: [
                  //     Text(
                  //       'Detail :',
                  //       style: TextStyle(fontWeight: FontWeight.w900),
                  //     ),
                  //   ],
                  // ),
                  // Padding(padding: EdgeInsets.only(top: 10)),
                  // Column(
                  //   crossAxisAlignment: CrossAxisAlignment.start,
                  //   children: [
                  //     Align(
                  //       alignment: AlignmentDirectional.centerStart,
                  //       child: Text(
                  //         widget.allData!.detail.isNotEmpty
                  //             ? widget.allData!.detail
                  //             : 'Not Available',
                  //         textAlign: TextAlign.start,
                  //         // 'Room No 5, Ground Floor New Court Bldg.',
                  //         // widget.allData!.description.isEmpty
                  //         //     ? 'Description Not Availble'
                  //         //     : widget.allData!.description,
                  //         softWrap: true,
                  //         style: TextStyle(fontWeight: FontWeight.w500),
                  //       ),
                  //     ),
                  //   ],
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
