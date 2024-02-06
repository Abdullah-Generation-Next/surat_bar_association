import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:html/parser.dart';
import 'package:surat_district_bar_association/widgets/media_query_sizes.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../model/event_model.dart';
import '../../widgets/drawer.dart';
import 'event_image_detail_screen.dart';

class EventDetailScreen extends StatefulWidget {
  eventDatum? allData;
  EventDetailScreen({
    super.key,
    this.allData,
  });

  @override
  State<EventDetailScreen> createState() => _EventDetailScreenState();
}

class _EventDetailScreenState extends State<EventDetailScreen> {
  final ScrollController _controller = ScrollController();
  String mainUrl = "https://vakalat-public.s3.ap-southeast-1.amazonaws.com/";

  late final TransformationController Tcontroller;
  TapDownDetails? tapDownDetails;

  @override
  void initState() {
    super.initState();

    Tcontroller = TransformationController();
    // animationController = AnimationController(vsync: this,duration: Duration(milliseconds: 300))..addListener(() {
    //   Tcontroller.value = animation!.value;
    // });
  }

  String _parseHtmlString(String htmlString) {
    final document = parse(htmlString);
    final String parsedString = parse(document.body!.text).documentElement!.text;

    return parsedString;
  }

  @override
  void dispose() {
    Tcontroller.dispose();
    // animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          'Event Detail',
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
                    widget.allData!.eventTitle.isEmpty
                        ? 'Event Title Not Availble'
                        : widget.allData!.eventTitle,
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      // fontSize: 12
                    ),
                  ),
                  // Padding(
                  //     padding: EdgeInsets.symmetric(
                  //         vertical: screenheight(context, dividedby: 150.h))),
                  Padding(padding: EdgeInsets.only(top: 10)),
                  // Material(
                  //   elevation: 0,
                  //   shape: RoundedRectangleBorder(),
                  //   clipBehavior: Clip.antiAlias,
                  //   color: Colors.transparent,
                  //   child: ClipRRect(
                  //     borderRadius: BorderRadius.all(Radius.circular(10)),
                  //     child: Container(
                  //       height: screenheight(context, dividedby: 1.5.h),
                  //       width: MediaQuery.of(context).size.width / 1.06,
                  //       child: Ink(
                  //         decoration: BoxDecoration(
                  //           boxShadow: [
                  //             BoxShadow(
                  //               color: Colors.white,
                  //               blurRadius: 10.r,
                  //               spreadRadius: 10.r,
                  //             ),
                  //           ],
                  //           borderRadius: BorderRadius.circular(10),
                  //           image: DecorationImage(
                  //             // image: AssetImage(
                  //             //   "images/event_detail_img.jpg",
                  //             // ),
                  //             image: NetworkImage(
                  //               mainUrl+widget.data!.imageUrl,
                  //             ),
                  //             fit: BoxFit.fill,
                  //           ),
                  //         ),
                  //         child: InkWell(
                  //           onTap: () {},
                  //           // hoverColor: Colors.white,
                  //           borderRadius:
                  //               BorderRadius.all(Radius.circular(10)),
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  //
                  //   // Ink.image(
                  //   //   image: AssetImage('images/event_detail_img.jpg'),
                  //   //   fit: BoxFit.cover,
                  //   //   height: screenheight(context,dividedby: 1.5.h),
                  //   //   width: screenwidth(context,dividedby: 1.10.w),
                  //   //   child: InkWell(
                  //   //     onTap: () {},
                  //   //   ),
                  //   // ),
                  // ),
                  CachedNetworkImage(
                    imageUrl: mainUrl + widget.allData!.imageUrl,
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
                                            mainUrl + widget.allData!.imageUrl
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
                                                    EventImgZoom(
                                                      imageIndex: mainUrl + widget.allData!.imageUrl,
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
                  // Padding(
                  //     padding: EdgeInsets.symmetric(
                  //         vertical: screenheight(context, dividedby: 150.h))),
                  Padding(padding: EdgeInsets.only(top: 10)),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Start Date : ',
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          // fontSize: 12
                        ),
                      ),
                      Text(
                          // '24/09/2022 - 10:30 AM',
                          widget.allData!.fromDate +
                              "  -  " +
                              widget.allData!.fromTime),
                    ],
                  ),
                  // Padding(
                  //     padding: EdgeInsets.symmetric(
                  //         vertical: screenheight(context, dividedby: 150.h))),
                  Padding(padding: EdgeInsets.only(top: 10)),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'End Date : ',
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      Text(
                          // '24/09/2022 - 11:30 AM',
                          widget.allData!.toDate +
                              "  -  " +
                              widget.allData!.toTime),
                    ],
                  ),
                  // Padding(
                  //     padding: EdgeInsets.symmetric(
                  //         vertical: screenheight(context, dividedby: 150.h))),
                  Padding(padding: EdgeInsets.only(top: 10)),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        CupertinoIcons.location_solid,
                        size: 18.h,
                        color: Colors.grey.shade600,
                      ),
                      Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal:
                                  screenwidth(context, dividedby: 150.w))),
                      Expanded(
                        child: Text(
                          // 'Room No 5, Ground Floor New Court Bldg.',
                          widget.allData!.location.isEmpty
                              ? 'Location Not Availble'
                              : widget.allData!.location,
                          maxLines: 2,
                          softWrap: true,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                  ),
                  // Padding(
                  //     padding: EdgeInsets.symmetric(
                  //         vertical: screenheight(context, dividedby: 150.h))),
                  Padding(padding: EdgeInsets.only(top: 10)),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Description :',
                        style: TextStyle(fontWeight: FontWeight.w900),
                      ),
                    ],
                  ),
                  // Padding(
                  //     padding: EdgeInsets.symmetric(
                  //         vertical: screenheight(context, dividedby: 150.h))),
                  Padding(padding: EdgeInsets.only(top: 10)),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: AlignmentDirectional.centerStart,
                        child: Text(
                          _parseHtmlString(
                            // widget.allData!.description.isEmpty
                            //     ? 'Description Not Availble'
                            //     : widget.allData!.description,
                            widget.allData!.description.isNotEmpty && widget.allData!.description.length < 6500
                                ? _parseHtmlString(widget.allData!.description)
                                : 'File.Obj',
                          ),
                          textAlign: TextAlign.start,
                          // 'Room No 5, Ground Floor New Court Bldg.',
                          // widget.allData!.description.isEmpty
                          //     ? 'Description Not Availble'
                          //     : widget.allData!.description,
                          softWrap: true,
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                      ),
                      // Container(
                      //   decoration: BoxDecoration(
                      //     border: Border.all(
                      //       color: Colors.grey,
                      //     ),
                      //   ),
                      //   child: Text(
                      //     ' File.Obj ',
                      //   ),
                      // ),
                    ],
                  ),
                  // Padding(
                  //     padding: EdgeInsets.symmetric(
                  //         vertical: screenheight(context, dividedby: 150.h))),
                  Padding(padding: EdgeInsets.only(top: 10)),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        CupertinoIcons.phone_arrow_down_left,
                        size: 18.h,
                        color: Colors.grey.shade600,
                      ),
                      Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal:
                                  screenwidth(context, dividedby: 150.w))),
                      InkWell(
                        onTap: () async {
                          if(widget.allData!.contactNumber.isNotEmpty) {
                            launch("tel:${widget.allData!.contactNumber}");
                          }
                        },
                        child: Text(
                          // '6355059424',
                          widget.allData!.contactNumber.isEmpty
                              ? 'Contact Number Not Availble'
                              : widget.allData!.contactNumber,
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
