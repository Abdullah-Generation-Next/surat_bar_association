import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:surat_district_bar_association/drawer_details/blog_tile/blog_image_detail_screen.dart';
import 'package:surat_district_bar_association/model/blog_model.dart';

import '../../widgets/drawer.dart';
import '../../widgets/media_query_sizes.dart';

class BlogTileDetailScreen extends StatefulWidget {
  blogDatum? allData;

  BlogTileDetailScreen({
    super.key,
    this.allData,
  });

  @override
  State<BlogTileDetailScreen> createState() => _BlogTileDetailScreenState();
}

class _BlogTileDetailScreenState extends State<BlogTileDetailScreen> {
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
          'Blog Details',
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
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    // 'JUVENILE DELINQUENCY OR SOCIAL MALIGNANCY',
                    widget.allData!.title,
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    textScaleFactor: 1.17,
                    style: TextStyle(
                        // fontSize: 10.6,
                        color: Colors.black,
                        fontWeight: FontWeight.w600),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'By : ',
                          softWrap: true,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          textScaleFactor: 1,
                          style: TextStyle(
                              // fontSize: 10.6,
                              fontWeight: FontWeight.w600),
                        ),
                        Text(
                          // 'Ravi Mathur',
                          widget.allData!.authorName,
                          softWrap: true,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          textScaleFactor: 1,
                          style: TextStyle(
                              // fontSize: 10.6,
                              fontWeight: FontWeight.w400),
                        ),
                        Spacer(),
                        Text(
                          'Comment : ',
                          softWrap: true,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          textScaleFactor: 1,
                          style: TextStyle(
                              // fontSize: 10.6,
                              fontWeight: FontWeight.w600),
                        ),
                        Text(
                          // '0',
                          " " + widget.allData!.totalComment.toString(),
                          softWrap: true,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          textScaleFactor: 1,
                          style: TextStyle(
                              // fontSize: 10.6,
                              fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Row(
                      children: [
                        Text(
                          // '21/12/2021',
                          widget.allData!.blogDate,
                          softWrap: true,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          textScaleFactor: 1,
                          style: TextStyle(
                              // fontSize: 10.6,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(top: 10)),
                  // Material(
                  //   elevation: 0,
                  //   shape: RoundedRectangleBorder(),
                  //   clipBehavior: Clip.antiAlias,
                  //   color: Colors.transparent,
                  //   child: ClipRRect(
                  //     borderRadius: BorderRadius.all(Radius.circular(10)),
                  //     child: Ink(
                  //       height: screenheight(context, dividedby: 3.5.h),
                  //       width: double.infinity,
                  //       decoration: BoxDecoration(
                  //         boxShadow: [
                  //           BoxShadow(
                  //             color: Colors.white,
                  //             blurRadius: 10.r,
                  //             spreadRadius: 10.r,
                  //           ),
                  //         ],
                  //         borderRadius: BorderRadius.circular(10),
                  //         image: DecorationImage(
                  //           image: AssetImage(
                  //             "images/blogpost.png",
                  //           ),
                  //           fit: BoxFit.cover,
                  //         ),
                  //       ),
                  //       child: InkWell(
                  //         onTap: () {},
                  //         // hoverColor: Colors.white,
                  //         borderRadius:
                  //             BorderRadius.all(Radius.circular(10)),
                  //       ),
                  //     ),
                  //
                  //     // Ink.image(
                  //     //   image: AssetImage('images/blogpost.png'),
                  //     //   fit: BoxFit.cover,
                  //     //   height: screenheight(context,dividedby: 3.5.h),
                  //     //   width: screenwidth(context,dividedby: 1.10.w),
                  //     //
                  //     //   child:
                  //     // ),
                  //   ),
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
                          height: screenheight(context, dividedby: 3.5.h),
                          width: double.infinity,
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
                                                    BlogImgZoom(
                                                      imageIndex: mainUrl + widget.allData!.imageUrl,
                                                    )));
                                      },
                                    ),
                                  ),
                                ),
                          //     ),
                          //   ),
                          // ),
                        ),
                      ),
                    ),
                    placeholder: (context, url) => SizedBox(
                        height: screenheight(context, dividedby: 3.5.h),
                        width: double.infinity,
                        child: Center(child: CircularProgressIndicator(
                          color: Colors.grey,
                          strokeWidth: 3,
                        ))),
                    errorWidget: (context, url, error) =>
                        Visibility(visible: false, child: Container()),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Text(
                      // "On a cold January night in 1876, two weary travellers knocked at Mohammed Khan's house in Delhi's Sabzi Mandi - a thriving labyrinth of narrow alleys in India's capital - and asked if they could stay the night." +
                      //     "Khan graciously decided to let the guests sleep in his room. But the next morning, he found that the men had disappeared. Also missing, was Khan's bedroll which he had given the men to rest. Khan had been robbed, he realised, in a way like no other." +
                      //     "Nearly 150 years on, the story of Khan's ordeal now features in a list of the earliest crimes reported in Delhi, records for which were uploaded on the city police's website last month." +
                      //     "The 'antique FIRs' provide details into some 29 other similar cases that were registered at the city's five main police stations - Sabzi Mandi, Mehrauli, Kotwali, Sadar Bazar and Nangloi - between 1861 to the early 1900s. In Khan's case, the police caught the men and sent them to three months in jail on charges of theft." +
                      //     "Originally filed in the tenacious Urdu shikastah script - which also uses words in Arabic and Persian - the FIRs were translated and compiled by a team led by Assistant Commissioner of Delhi Police Rajendra Singh Kalkal, he also illustrated each of the cases himself.'," +
                      //     "Mr Kalkal told the BBC the records 'spoke to him' because of the fascinating insights they offered into the lives of people in a city which has survived waves of conquests and change. 'The files are a window to the past as well as the present,' he says." +
                      //     "Most of the complaints involve petty crimes of theft - of stolen oranges, bedsheets and ice cream - and carry a comical lightness to them. There's a gang of men who ambushed a shepherd, slapped him and took away his 110 goats; a man who nearly stole a bedsheet but got caught 'at a distance of 40 steps'; and the sad case of Darshan, the guardian of gunny bags, who gets beaten black and blue by thugs before they snatch his quilt and a shoe - just one of the pair - and run away.",
                      widget.allData!.description,
                      softWrap: true,
                      textScaleFactor: 1,
                      style: TextStyle(
                          // fontSize: 10.6,
                          color: Colors.black,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: Row(
                      children: [
                        Icon(
                          CupertinoIcons.hand_thumbsup,
                          size: 20,
                          color: Colors.grey.shade600,
                        ),
                        Text(
                          // ' 0',
                          " " + widget.allData!.totalLike.toString(),
                          textScaleFactor: 1.17,
                          style: TextStyle(
                              // fontSize: 10.6,
                              fontWeight: FontWeight.w400),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Icon(
                            CupertinoIcons.hand_thumbsdown,
                            size: 20,
                            color: Colors.grey.shade600,
                          ),
                        ),
                        Text(
                          // ' 0',
                          " " + widget.allData!.totalDislike.toString(),
                          textScaleFactor: 1.17,
                          style: TextStyle(
                              // fontSize: 10.6,
                              fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Divider(
                      thickness: 1,
                      color: Colors.black,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Row(
                      children: [
                        Text(
                          'Comments',
                          softWrap: true,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          textScaleFactor: 1.17,
                          style: TextStyle(
                              // fontSize: 10.6,
                              fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(top: 25)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
