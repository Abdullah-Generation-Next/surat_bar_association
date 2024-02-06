import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';
import 'package:surat_district_bar_association/drawer_details/notice_board/noticeboard_tile_detail.dart';
import 'package:surat_district_bar_association/drawer_details/search/search_tile.dart';
import 'package:surat_district_bar_association/model/notice_board_model.dart';
import 'package:surat_district_bar_association/services/all_api_services.dart';
import '../../model/login_model.dart';
import '../../widgets/media_query_sizes.dart';
import 'package:html/parser.dart';
import '../../widgets/sharedpref.dart';

class NoticeBoardTileScreen extends StatefulWidget {
  const NoticeBoardTileScreen({super.key});

  @override
  State<NoticeBoardTileScreen> createState() => _NoticeBoardTileScreenState();
}

class _NoticeBoardTileScreenState extends State<NoticeBoardTileScreen> {

  LoginModel login = loginModelFromJson(SharedPref.get(prefKey: PrefKey.saveUser)!);
  final ScrollController _controller = ScrollController();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  String mainUrl = "https://vakalat-public.s3.ap-southeast-1.amazonaws.com/";

  List<noticeDatum?> data = [];

  Future<void> fetchDataFromAPI(id) async {
    Map<String, dynamic> parameter = {
      "user_id": id,
    };
    await noticeData(parameter: parameter).then((value) {
      setState(() {
        data = value.data;
      });
      // print(value);
    }).onError((error, stackTrace) {
      print(error);
    });
  }

  @override
  void initState() {
    super.initState();
    fetchDataFromAPI(login.parentId);
  }

  String _parseHtmlString(String htmlString) {
    final document = parse(htmlString);
    final String parsedString =
        parse(document.body!.text).documentElement!.text;

    return parsedString;
  }

  // DateTime now = DateTime.now();
  String formattedDate = DateFormat.YEAR_MONTH_DAY;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          'Notice Board',
          textScaleFactor: 0.9,
          style: TextStyle(
              color: Colors.black,
              // fontSize: 13.5.sp,
              fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: true,
      ),
      body: data.isNotEmpty
        ? ScrollConfiguration(
        behavior: MyBehavior(),
        child: data.length > 0
            ? Padding(
              padding: const EdgeInsets.only(right: 5),
              child: ListView.builder(
                  controller: _controller,
                  itemCount: data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      elevation: 5,
                      margin: EdgeInsets.all(10),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          side: BorderSide(color: Colors.grey, width: 0.15)),
                      child: InkWell(
                        radius: 0,
                        borderRadius: BorderRadius.all(Radius.circular(10.r)),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      NoticeBoardDetailScreen(
                                        allData: data[index],
                                      )));
                        },
                        hoverColor: Colors.white,
                        child: Padding(
                          padding: EdgeInsets.only(
                              left: 15, right: 15, top: 10, bottom: 5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Text(
                                      // 'Advertisement and Application form for Panel Advocate',
                                      // data[index]['title'],
                                      data[index]!.title,
                                      softWrap: true,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      textScaleFactor: 1.17,
                                      style: TextStyle(
                                          // fontSize: 10.6,
                                          fontWeight: FontWeight.w900),
                                    ),
                                  ),
                                ],
                              ),
                              Padding(padding: EdgeInsets.only(top: 5)),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Text(
                                      // 'Surat District court/office order no. 225/2022',
                                      // data[index]['description'],
                                      // HtmlTags.removeTag(
                                      //   htmlString: data[index]['description'],
                                      //   callback: (string) => print(string),
                                      // ),
                                      _parseHtmlString(
                                          data[index]!.description),
                                      softWrap: true,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      textScaleFactor: 1.05,
                                      style: TextStyle(
                                          // fontSize: 12,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ],
                              ),
                              Padding(padding: EdgeInsets.only(top: 5)),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Icon(
                                    Icons.calendar_month_outlined,
                                    size: 18.h,
                                    color: Colors.black,
                                  ),
                                  Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: screenwidth(context,
                                              dividedby: 150.w))),
                                  Text(
                                    // '14/02/2022',
                                    DateFormat("dd-MM-yyyy").format(DateTime.parse(data[index]!.startDate.toString())),
                                    // DateUtils.dateOnly(data[index]!.startDate).toString(),
                                    textScaleFactor: 1,
                                    style: TextStyle(
                                        // fontSize: 12,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ],
                              ),
                              Padding(padding: EdgeInsets.only(top: 5)),
                              // Container(
                              //     height: screenheight(context, dividedby: 3.h),
                              //     width: MediaQuery.of(context).size.width / 1.06,
                              //     child: Ink(
                              //       height: screenheight(context, dividedby: 4.h),
                              //       width: screenwidth(context, dividedby: 1.5.w),
                              //       decoration: BoxDecoration(
                              //         borderRadius: BorderRadius.circular(10),
                              //         image: DecorationImage(
                              //           // image: AssetImage(
                              //           //   "images/notice_detail_img.png",
                              //           // ),
                              //           image: NetworkImage(
                              //               mainUrl + data[index]!.image
                              //           ),
                              //           fit: BoxFit.fill,
                              //         ),
                              //       ),
                              //       // child: Image.asset(
                              //       //   'images/notice_detail_img.png',
                              //       //   fit: BoxFit.cover,
                              //       // ),
                              //     )
                              //   // Ink(
                              //   //   // height: screenheight(context, dividedby: 4.h),
                              //   //   // width: screenwidth(context, dividedby: 1.5.w),
                              //   //   decoration: BoxDecoration(
                              //   //     // boxShadow: [
                              //   //     //   BoxShadow(
                              //   //     //     color: Colors.white,
                              //   //     //     blurRadius: 10.r,
                              //   //     //     spreadRadius: 10.r,
                              //   //     //   ),
                              //   //     // ],
                              //   //     borderRadius: BorderRadius.circular(10),
                              //   //     image: DecorationImage(
                              //   //       image: AssetImage(
                              //   //         "images/notice_detail_img.png",
                              //   //       ),
                              //   //       // image: NetworkImage(
                              //   //       //   mainUrl + widget.imageData!.image,
                              //   //       // ),
                              //   //       fit: BoxFit.fill,
                              //   //     ),
                              //   //   ),
                              //   //   child: InkWell(
                              //   //     onTap: () {},
                              //   //     // hoverColor: Colors.white,
                              //   //     borderRadius:
                              //   //         BorderRadius.all(Radius.circular(10)),
                              //   //   ),
                              //   // ),
                              // ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
            ) : Center(
          child: Text(
            "No Result",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          ),
        ),
      )  : Shimmer.fromColors(
    baseColor: Colors.grey.shade400,
      highlightColor: Colors.grey.shade100,
      child: Padding(
        padding: EdgeInsets.only(
            left: 15, right: 15, top: 25, bottom: 20),
        child: ScrollConfiguration(
          behavior: MyBehavior(),
          child: ListView.builder(
            controller: _controller,
            itemCount: 15,
            itemBuilder: (_, __) => Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10,right: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            width: double.infinity,
                            height: 12,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(5.r)),
                              color: Colors.white,
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 7),
                          ),
                          Container(
                            width: double.infinity,
                            height: 12,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(5.r)),
                              color: Colors.white,
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 7),
                          ),
                          Container(
                            width: 100,
                            height: 12,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(5.r)),
                              color: Colors.white,
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 7),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    ),
    );
  }
}

// class HtmlTags {
//   static void removeTag({htmlString, callback}) {
//     var document = parse(htmlString);
//     String parsedString = parse(document.body!.text).documentElement!.text;
//     callback(parsedString);
//   }
// }

// Center(
//         child: CircularProgressIndicator(
//           color: Colors.grey,
//           strokeWidth: 3,
//         ),
//       ),

//Card(
//               elevation: 5,
//               margin: EdgeInsets.all(10),
//               shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.all(Radius.circular(10)),
//                   side: BorderSide(color: Colors.grey, width: 0.15)),
//               child: InkWell(
//                 onTap: () {
//                   Navigator.pushNamed(context, '/noticeBoardDetail');
//                 },
//                 // splashColor: Colors.white,
//                 // highlightColor: Colors.transparent,
//                 hoverColor: Colors.white,
//                 borderRadius: BorderRadius.all(Radius.circular(10.r)),
//                 child: Padding(
//                   padding:
//                       EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Row(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Expanded(
//                             child: Text(
//                               'Advertisement and Application form for Panel Advocate',
//                               softWrap: true,
//                               maxLines: 1,
//                               overflow: TextOverflow.ellipsis,
//                               textScaleFactor: 1.17,
//                               style: TextStyle(
//                                   // fontSize: 10.6,
//                                   fontWeight: FontWeight.w900),
//                             ),
//                           ),
//                         ],
//                       ),
//                       Padding(padding: EdgeInsets.only(top: 5)),
//                       Row(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             'Surat District court/office order no. 225/2022',
//                             textScaleFactor: 1.05,
//                             style: TextStyle(
//                                 // fontSize: 12,
//                                 fontWeight: FontWeight.w500),
//                           ),
//                         ],
//                       ),
//                       Padding(padding: EdgeInsets.only(top: 5)),
//                       Row(
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         children: [
//                           Icon(
//                             Icons.calendar_month_outlined,
//                             size: 18.h,
//                             color: Colors.grey.shade600,
//                           ),
//                           Padding(
//                               padding: EdgeInsets.symmetric(
//                                   horizontal:
//                                       screenwidth(context, dividedby: 150.w))),
//                           Text(
//                             '14/02/2022',
//                             textScaleFactor: 1,
//                             style: TextStyle(
//                                 // fontSize: 12,
//                                 fontWeight: FontWeight.w400),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),

// FutureBuilder(
//     future: allApiServices.fetchNoticeRecords(),
//     builder: (context, AsyncSnapshot<NoticeBoardModel> snapshot) {
//       if (snapshot.hasData) {
//         return ;
//       } else {
//         return Center(
//           child: CircularProgressIndicator(),
//         );
//       }
//     })
