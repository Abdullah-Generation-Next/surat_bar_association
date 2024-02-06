import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:surat_district_bar_association/services/all_api_services.dart';

import '../../model/event_model.dart';
import '../../model/login_model.dart';
import '../../widgets/drawer.dart';
import '../../widgets/media_query_sizes.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../widgets/sharedpref.dart';
import 'event_tile_detail.dart';

class EventTileScreen extends StatefulWidget {
  const EventTileScreen({super.key});

  @override
  State<EventTileScreen> createState() => _EventTileScreenState();
}

class _EventTileScreenState extends State<EventTileScreen> {
  LoginModel login = loginModelFromJson(SharedPref.get(prefKey: PrefKey.saveUser)!);
  final ScrollController _controller = ScrollController();

  String mainUrl = "https://vakalat-public.s3.ap-southeast-1.amazonaws.com/";

  List<eventDatum?> data = [];

  Future<void> fetchDataFromAPI(id) async {
    Map<String, dynamic> parameter = {
      "app_user": id,
    };
    await eventData(parameter: parameter).then((value) {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          'Events',
          textScaleFactor: 0.9,
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
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
            ? ListView.builder(
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
                              builder: (context) => EventDetailScreen(
                                allData: data[index],
                              ),
                            ));
                      },
                      hoverColor: Colors.white,
                      child: Padding(
                        // padding: EdgeInsets.symmetric(
                        //     vertical:
                        //     screenheight(context, dividedby: 250.h),
                        //     horizontal: screenwidth(context,dividedby: 50.w)),
                        padding: EdgeInsets.only(
                            left: 10, right: 10, top: 10, bottom: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Visibility(
                            //   visible: _imageLoaded,
                            //   child: Container(
                            //     height:
                            //         screenheight(context, dividedby: 5.h),
                            //     width:
                            //         screenwidth(context, dividedby: 3.5.w),
                            //     child: Image(
                            //       // image: AssetImage(
                            //       //     'images/notice_detail_image.jpg'),
                            //       image: NetworkImage(
                            //           mainUrl + data[index]!.imageUrl),
                            //       fit: BoxFit.fill,
                            //       // errorBuilder:
                            //       //     (context, error, stackTrace) {
                            //       //   _handleImageError();
                            //       //   return Icon(Icons.error);
                            //       // },
                            //     ),
                            //   ),
                            // ),
                            CachedNetworkImage(
                              imageUrl: mainUrl + data[index]!.imageUrl,
                              imageBuilder: (context, imageProvider) =>
                                  Container(
                                height:
                                    screenheight(context, dividedby: 5.h),
                                width:
                                    screenwidth(context, dividedby: 3.5.w),
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: imageProvider,
                                    fit: BoxFit.fill,
                                    // colorFilter:
                                    // ColorFilter.mode(Colors.red, BlendMode.colorBurn)
                                  ),
                                ),
                              ),
                              placeholder: (context, url) => SizedBox(
                                  height:
                                      screenheight(context, dividedby: 5.h),
                                  width: screenwidth(context,
                                      dividedby: 3.5.w),
                                  child: Center(
                                      child: CircularProgressIndicator(
                                        color: Colors.grey,
                                        strokeWidth: 3,
                                      ))),
                              errorWidget: (context, url, error) =>
                                  Visibility(
                                      visible: false, child: Container()),
                            ),
                            Padding(padding: EdgeInsets.only(top: 10)),
                            Text(
                              // 'Demonstration - Dastaveg Registration Garvi 2.0 Software From Govt Of Gujarat (Seminar)',
                              // data[index]!.eventTitle,
                              data[index]!.eventTitle.isEmpty
                                  ? 'Event Title Not Availble'
                                  : data[index]!.eventTitle,
                              textScaleFactor: 1.05,
                              style: TextStyle(
                                  // fontSize: 8.5,
                                  fontWeight: FontWeight.w900),
                            ),
                            Padding(padding: EdgeInsets.only(top: 10)),
                            // Padding(padding: EdgeInsets.symmetric(vertical: screenheight(context,dividedby: 350.h))),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.location_on_rounded,
                                  size: screenheight(context,
                                      dividedby: 35.h),
                                  color: Colors.grey.shade600,
                                ),
                                Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: screenwidth(context,
                                            dividedby: 150.w))),
                                Expanded(
                                  child: Text(
                                    // 'Room No 5, Ground Floor New Court Bldg',
                                    data[index]!.location.isEmpty
                                        ? 'Location Not Available'
                                        : data[index]!.location,
                                    softWrap: true,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    textScaleFactor: 1.05,
                                    style: TextStyle(
                                        // fontSize: 10,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                              ],
                            ),
                            // Padding(padding: EdgeInsets.symmetric(vertical: screenheight(context,dividedby: 350.h))),
                            Padding(padding: EdgeInsets.only(top: 5)),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.calendar_month_outlined,
                                  size: screenheight(context,
                                      dividedby: 35.h),
                                  color: Colors.grey.shade600,
                                ),
                                Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: screenwidth(context,
                                            dividedby: 150.w))),
                                Text(
                                  // '24/09/2022 to 24/09/2022',
                                  data[index]!.fromDate +
                                      "  To  " +
                                      data[index]!.toDate,
                                  textScaleFactor: 1.05,
                                  style: TextStyle(
                                      // fontSize: 10,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                            Padding(padding: EdgeInsets.only(top: 5)),
                            // Padding(padding: EdgeInsets.symmetric(vertical: screenheight(context,dividedby: 350.h))),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  CupertinoIcons.clock,
                                  size: screenheight(context,
                                      dividedby: 35.h),
                                  color: Colors.grey.shade600,
                                ),
                                Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: screenwidth(context,
                                            dividedby: 150.w))),
                                Text(
                                  // '10:30 AM to 11:30 AM',
                                  data[index]!.fromTime +
                                      "  To  " +
                                      data[index]!.toTime,
                                  textScaleFactor: 1.05,
                                  style: TextStyle(
                                      // fontSize: 10,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                            Padding(padding: EdgeInsets.only(top: 5)),
                            // Padding(padding: EdgeInsets.symmetric(vertical: screenheight(context,dividedby: 350.h))),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  CupertinoIcons.phone_arrow_down_left,
                                  size: screenheight(context,
                                      dividedby: 35.h),
                                  color: Colors.grey.shade600,
                                ),
                                Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: screenwidth(context,
                                            dividedby: 150.w))),
                                Text(
                                  // '9824198152',
                                  data[index]!.contactNumber.isEmpty
                                      ? 'Contact Number Not Available'
                                      : data[index]!.contactNumber,
                                  textScaleFactor: 1.05,
                                  style: TextStyle(
                                      // fontSize: 10,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }) : Center(
          child: Text(
            "No Result",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          ),
        ),
      ) : Shimmer.fromColors(
    baseColor: Colors.grey.shade400,
      highlightColor: Colors.grey.shade100,
      child: ScrollConfiguration(
        behavior: MyBehavior(),
        child: ListView.builder(
          controller: _controller,
          itemCount: 15,
          itemBuilder: (_, __) => Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height:
                  screenheight(context, dividedby: 4.75.h),
                  width:
                  screenwidth(context, dividedby: 3.5.w),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10.r)),
                    color: Colors.white,
                  ),
                ),
                Padding(padding: EdgeInsets.only(top: 20),),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 20,
                      width: 170,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10.r)),
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                Padding(padding: EdgeInsets.only(top: 15),),
                ...List.generate(
                  4,
                      (index) => Padding(
                    padding: const EdgeInsets.only(top: 10, left: 25, right: 25),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Container(
                            height: 15,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(10.r)),
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // Padding(
                //   padding: const EdgeInsets.only(left: 25,right: 25),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.start,
                //     crossAxisAlignment: CrossAxisAlignment.center,
                //     mainAxisSize: MainAxisSize.max,
                //     children: [
                //       Center(
                //         child: Container(
                //           height: 15,
                //           width: 320,
                //           decoration: BoxDecoration(
                //             borderRadius: BorderRadius.all(Radius.circular(10.r)),
                //             color: Colors.white,
                //           ),
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
                // Padding(padding: EdgeInsets.only(top: 10),),
                // Padding(
                //   padding: const EdgeInsets.only(left: 25,right: 25),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.start,
                //     crossAxisAlignment: CrossAxisAlignment.center,
                //     children: [
                //       Center(
                //         child: Container(
                //           height: 15,
                //           width: 320,
                //           decoration: BoxDecoration(
                //             borderRadius: BorderRadius.all(Radius.circular(10.r)),
                //             color: Colors.white,
                //           ),
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
                // Padding(padding: EdgeInsets.only(top: 10),),
                // Padding(
                //   padding: const EdgeInsets.only(left: 25,right: 25),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.start,
                //     crossAxisAlignment: CrossAxisAlignment.center,
                //     children: [
                //       Center(
                //         child: Container(
                //           height: 15,
                //           width: 320,
                //           decoration: BoxDecoration(
                //             borderRadius: BorderRadius.all(Radius.circular(10.r)),
                //             color: Colors.white,
                //           ),
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
                // Padding(padding: EdgeInsets.only(top: 10),),
                // Padding(
                //   padding: const EdgeInsets.only(left: 25,right: 25),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.start,
                //     crossAxisAlignment: CrossAxisAlignment.center,
                //     children: [
                //       Center(
                //         child: Container(
                //           height: 15,
                //           width: 320,
                //           decoration: BoxDecoration(
                //             borderRadius: BorderRadius.all(Radius.circular(10.r)),
                //             color: Colors.white,
                //           ),
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    ),
      // drawer: MyDrawerWidget(),
    );
  }
}
