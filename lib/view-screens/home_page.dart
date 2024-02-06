import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:surat_district_bar_association/widgets/drawer.dart';
import 'package:url_launcher/url_launcher.dart';
import '../widgets/media_query_sizes.dart';
import '../widgets/sharedpref.dart';
import 'login_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _controller = ScrollController();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  Future<bool> logoutPopup() async {
    return await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Logout'),
            content: Text('Are you sure you want to Logout?'),
            actions: [
              ElevatedButton(
                style: ButtonStyle(
                  elevation: MaterialStateProperty.all(0),
                  backgroundColor: MaterialStateProperty.all(Colors.black),
                ),
                onPressed: () => Navigator.of(context).pop(),
                //return false when click on "NO"
                child: Text(
                  'No',
                ),
              ),
              ElevatedButton(
                style: ButtonStyle(
                  elevation: MaterialStateProperty.all(0),
                  backgroundColor: MaterialStateProperty.all(Colors.black),
                ),
                onPressed: () {
                  Navigator.pop(context);
                  SharedPref.deleteSpecific(prefKey: PrefKey.saveUser);
                  Navigator.of(context).push(_createRoute());
                },
                //return true when click on "Yes"
                child: Text('Yes'),
              ),
            ],
          ),
        ) ??
        false; //if showDialouge had returned null, then return false
  }

  Future<bool> showExitPopup() async {
    if (scaffoldKey.currentState!.isDrawerOpen) {
      scaffoldKey.currentState!.closeDrawer();
    }
    return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Exit App'),
        content: Text('Do you want to exit an App?'),
        actions: [
          ElevatedButton(
            style: ButtonStyle(
              elevation: MaterialStateProperty.all(0),
              backgroundColor: MaterialStateProperty.all(Colors.black),
            ),
            onPressed: () => Navigator.of(context).pop(),
            //return false when click on "NO"
            child: Text(
              'No',
            ),
          ),
          ElevatedButton(
            style: ButtonStyle(
              elevation: MaterialStateProperty.all(0),
              backgroundColor: MaterialStateProperty.all(Colors.black),
            ),
            onPressed: () => SystemNavigator.pop(),
            //return true when click on "Yes"
            child: Text('Yes'),
          ),
        ],
      ),
    ) ??
        false;
    //if showDialouge had returned null, then return false
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: showExitPopup,
      child: Scaffold(
        key: scaffoldKey,
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          title: Text(
            'Home',
            textScaleFactor: 0.9,
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        // Padding(
        // padding: EdgeInsets.symmetric(
        // vertical: screenheight(context, dividedby: 100.h),
        // horizontal: screenwidth(context, dividedby: 25.w)),
        body: Scrollbar(
          controller: _controller,
          interactive: true,
          thickness: 7.5.r,
          radius: Radius.circular(5.r),
          child:
          Column(
            // controller: _controller,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: screenheight(context, dividedby: 200.h))),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Material(
                    elevation: 7,
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.r))),
                    child: InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, '/searchTile');
                      },
                      // splashColor: Colors.white,
                      // highlightColor: Colors.transparent,
                      hoverColor: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(10.r)),
                      radius: 0,
                      child: Container(
                        height: screenheight(context, dividedby: 6.h),
                        width: screenheight(context, dividedby: 6.h),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10.r)),
                          border: Border.all(
                              color: Colors.grey.shade400, width: 0.01),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(4),
                              child: Icon(
                                CupertinoIcons.search,
                                size: 45.h,
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              'Search',
                              textScaleFactor: 0.8,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                // fontSize: 10.sp
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Material(
                    elevation: 7,
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.r))),
                    child: InkWell(
                      radius: 0,
                      onTap: () {
                        Navigator.pushNamed(context, '/noticeBoardTile');
                      },
                      // splashColor: Colors.white,
                      // highlightColor: Colors.transparent,
                      hoverColor: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(10.r)),
                      child: Container(
                        height: screenheight(context, dividedby: 6.h),
                        width: screenheight(context, dividedby: 6.h),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10.r)),
                          border: Border.all(
                              color: Colors.grey.shade400, width: 0.01),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(4),
                              child: Icon(
                                CupertinoIcons.captions_bubble,
                                size: 45.h,
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              'Notice Board',
                              textScaleFactor: 0.8,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                // fontSize: 10.sp
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Material(
                    elevation: 7,
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.r))),
                    child: InkWell(
                      radius: 0,
                      onTap: () {
                        Navigator.pushNamed(context, '/eventTile');
                      },
                      // splashColor: Colors.white,
                      // highlightColor: Colors.transparent,
                      hoverColor: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(10.r)),
                      child: Container(
                        height: screenheight(context, dividedby: 6.h),
                        width: screenheight(context, dividedby: 6.h),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10.r)),
                          border: Border.all(
                              color: Colors.grey.shade400, width: 0.01),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(4),
                              child: Icon(
                                CupertinoIcons.calendar_badge_plus,
                                size: 45.h,
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              'Events',
                              textScaleFactor: 0.8,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: screenheight(context, dividedby: 100.h))),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Material(
                    elevation: 7,
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.r))),
                    child: InkWell(
                      radius: 0,
                      onTap: () {
                        Navigator.pushNamed(context, '/committeeTile');
                      },
                      // splashColor: Colors.white,
                      // highlightColor: Colors.transparent,
                      hoverColor: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(10.r)),
                      child: Container(
                        height: screenheight(context, dividedby: 6.h),
                        width: screenheight(context, dividedby: 6.h),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10.r)),
                          border: Border.all(
                              color: Colors.grey.shade400, width: 0.01),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(4),
                              child: Icon(
                                CupertinoIcons.group_solid,
                                size: 45.h,
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              'Committee',
                              textScaleFactor: 0.8,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  // Padding(
                  //     padding: EdgeInsets.symmetric(horizontal: screenwidth(context,dividedby: 50.w))),
                  // Material(
                  //   elevation: 7,
                  //   color: Colors.white,
                  //   shape: RoundedRectangleBorder(
                  //       borderRadius: BorderRadius.all(Radius.circular(10.r))),
                  //   child: InkWell(
                  //     radius: 0,
                  //     onTap: () {
                  //       Navigator.pushNamed(context, '/blogTile');
                  //     },
                  //     // splashColor: Colors.white,
                  //     // highlightColor: Colors.transparent,
                  //     hoverColor: Colors.white,
                  //     borderRadius: BorderRadius.all(Radius.circular(10.r)),
                  //     child: Container(
                  //       height: screenheight(context, dividedby: 6.h),
                  //       width: screenheight(context, dividedby: 6.h),
                  //       decoration: BoxDecoration(
                  //         borderRadius: BorderRadius.all(Radius.circular(10.r)),
                  //         border: Border.all(
                  //             color: Colors.grey.shade400, width: 0.01),
                  //       ),
                  //       child: Column(
                  //         mainAxisAlignment: MainAxisAlignment.center,
                  //         crossAxisAlignment: CrossAxisAlignment.center,
                  //         children: [
                  //           Padding(
                  //             padding: const EdgeInsets.all(4),
                  //             child: Icon(
                  //               CupertinoIcons.bookmark_solid,
                  //               size: 45.h,
                  //               color: Colors.black,
                  //             ),
                  //           ),
                  //           Text(
                  //             'Blog',
                  //             textScaleFactor: 0.8,
                  //             style: TextStyle(
                  //                 fontWeight: FontWeight.bold),
                  //           ),
                  //         ],
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  // Padding(
                  //     padding: EdgeInsets.symmetric(horizontal: screenwidth(context,dividedby: 50.w))),
                  Material(
                    elevation: 7,
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.r))),
                    child: InkWell(
                      radius: 0,
                      onTap: () {
                        Navigator.pushNamed(context, '/importantLinksTile');
                      },
                      // splashColor: Colors.white,
                      // highlightColor: Colors.transparent,
                      hoverColor: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(10.r)),
                      child: Container(
                        height: screenheight(context, dividedby: 6.h),
                        width: screenheight(context, dividedby: 6.h),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10.r)),
                          border: Border.all(
                              color: Colors.grey.shade400, width: 0.01),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(4),
                              child: Icon(
                                CupertinoIcons.link,
                                size: 45.h,
                                color: Colors.black,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 7,right: 7),
                              child: Text(
                                'Important Links',
                                textScaleFactor: 0.8,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Material(
                    elevation: 7,
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.r))),
                    child: InkWell(
                      radius: 0,
                      onTap: () {
                        Navigator.pushNamed(context, '/publicDocumentsTile');
                      },
                      // splashColor: Colors.white,
                      // highlightColor: Colors.transparent,
                      hoverColor: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(10.r)),
                      child: Container(
                        height: screenheight(context, dividedby: 6.h),
                        width: screenheight(context, dividedby: 6.h),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10.r)),
                          border: Border.all(
                              color: Colors.grey.shade400, width: 0.01),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(4),
                              child: Icon(
                                CupertinoIcons.doc_chart_fill,
                                size: 45.h,
                                color: Colors.black,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 5,right: 5),
                              child: FittedBox(
                                child: Text(
                                  'Public Documents',
                                  textScaleFactor: 0.8,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: screenheight(context, dividedby: 100.h))),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Padding(
                  //     padding: EdgeInsets.symmetric(horizontal: screenwidth(context,dividedby: 50.w))),
                  Material(
                    elevation: 7,
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.r))),
                    child: InkWell(
                      radius: 0,
                      onTap: () {
                        Navigator.pushNamed(context, '/achievementTile');
                      },
                      // splashColor: Colors.white,
                      // highlightColor: Colors.transparent,
                      hoverColor: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(10.r)),
                      child: Container(
                        height: screenheight(context, dividedby: 6.h),
                        width: screenheight(context, dividedby: 6.h),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10.r)),
                          border: Border.all(
                              color: Colors.grey.shade400, width: 0.01),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(4),
                              child: Icon(
                                Icons.verified_user_rounded,
                                size: 45.h,
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              'Achievement',
                              textScaleFactor: 0.8,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  // Padding(
                  //     padding: EdgeInsets.symmetric(horizontal: screenwidth(context,dividedby: 50.w))),
                  Material(
                    elevation: 7,
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.r))),
                    child: InkWell(
                      radius: 0,
                      onTap: () {
                        Navigator.pushNamed(context, '/participationTile');
                      },
                      // splashColor: Colors.white,
                      // highlightColor: Colors.transparent,
                      hoverColor: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(10.r)),
                      child: Container(
                        height: screenheight(context, dividedby: 6.h),
                        width: screenheight(context, dividedby: 6.h),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10.r)),
                          border: Border.all(
                              color: Colors.grey.shade400, width: 0.01),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(4),
                              child: Icon(
                                Icons.school_rounded,
                                size: 45.h,
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              'Participation',
                              textScaleFactor: 0.8,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Material(
                    elevation: 7,
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.r))),
                    child: InkWell(
                      radius: 0,
                      onTap: () {
                        Navigator.pushNamed(context, '/newsTile');
                      },
                      // splashColor: Colors.white,
                      // highlightColor: Colors.transparent,
                      hoverColor: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(10.r)),
                      child: Container(
                        height: screenheight(context, dividedby: 6.h),
                        width: screenheight(context, dividedby: 6.h),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10.r)),
                          border: Border.all(
                              color: Colors.grey.shade400, width: 0.01),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(4),
                              child: Icon(
                                CupertinoIcons.globe,
                                size: 45.h,
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              'News',
                              textScaleFactor: 0.8,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: screenheight(context, dividedby: 100.h))),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Padding(
                  //     padding: EdgeInsets.symmetric(horizontal: screenwidth(context,dividedby: 50.w))),
                  Material(
                    elevation: 7,
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.r))),
                    child: InkWell(
                      radius: 0,
                      onTap: () {
                        Navigator.pushNamed(context, '/contactUsTile');
                      },
                      // splashColor: Colors.white,
                      // highlightColor: Colors.transparent,
                      hoverColor: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(10.r)),
                      child: Container(
                        height: screenheight(context, dividedby: 6.h),
                        width: screenheight(context, dividedby: 6.h),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10.r)),
                          border: Border.all(
                              color: Colors.grey.shade400, width: 0.01),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(4),
                              child: Icon(
                                CupertinoIcons.phone_fill_badge_plus,
                                size: 45.h,
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              'Contact Us',
                              textScaleFactor: 0.8,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  // Padding(
                  //     padding: EdgeInsets.symmetric(horizontal: screenwidth(context,dividedby: 50.w))),
                  Material(
                    elevation: 7,
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.r))),
                    child: InkWell(
                      radius: 0,
                      onTap: () {
                        logoutPopup();
                      },
                      // splashColor: Colors.white,
                      // highlightColor: Colors.transparent,
                      hoverColor: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(10.r)),
                      child: Container(
                        height: screenheight(context, dividedby: 6.h),
                        width: screenheight(context, dividedby: 6.h),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10.r)),
                          border: Border.all(
                              color: Colors.grey.shade400, width: 0.01),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(4),
                              child: Icon(
                                CupertinoIcons.square_arrow_left_fill,
                                size: 45.h,
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              'Logout',
                              textScaleFactor: 0.8,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    radius: 0,
                    // onTap: () {
                    //   logoutPopup();
                    // },
                    // splashColor: Colors.white,
                    // highlightColor: Colors.transparent,
                    hoverColor: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(10.r)),
                    child: Container(
                      height: screenheight(context, dividedby: 6.h),
                      width: screenheight(context, dividedby: 6.h),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10.r)),
                        border: Border.all(
                            color: Colors.transparent, width: 0.01),
                      ),
                      // child: Column(
                      //   mainAxisAlignment: MainAxisAlignment.center,
                      //   crossAxisAlignment: CrossAxisAlignment.center,
                      //   children: [
                      //     Padding(
                      //       padding: const EdgeInsets.all(4),
                      //       child: Icon(
                      //         CupertinoIcons.square_arrow_left_fill,
                      //         size: 45.h,
                      //         color: Colors.black,
                      //       ),
                      //     ),
                      //     Text(
                      //       'Logout',
                      //       textScaleFactor: 0.8,
                      //       style: TextStyle(
                      //           fontWeight: FontWeight.bold),
                      //     ),
                      //   ],
                      // ),
                    ),
                  ),
                ],
              ),
              Spacer(),
              Align(
                alignment: Alignment.topCenter,
                child: InkWell(
                  onTap: () async {
                    launch("https://www.vakalat.com/");
                    Fluttertoast.showToast(
                        msg: "Launching URL In Browser...",
                        fontSize: 12.sp,
                        backgroundColor: Colors.green);
                    // String url = "https://www.vakalat.com/";
                    // var urllaunchable = await canLaunch(url); //canLaunch is from url_launcher package
                    // if(urllaunchable){
                    //   await launch(url); //launch is from url_launcher package to launch URL
                    //   Fluttertoast.showToast(
                    //       msg: "Launching URL 'Vakalat.com' ...",
                    //       fontSize: 12.sp,
                    //       backgroundColor: Colors.green);
                    // }else{
                    //   Fluttertoast.showToast(
                    //       msg: "URL Launch Error !!!",
                    //       fontSize: 12.sp,
                    //       backgroundColor: Colors.green);
                    // }
                  },
                  child: Container(
                    padding: EdgeInsets.only(right: 20),
                    height: screenheight(context, dividedby: 32.h),
                    color: Colors.black,
                    child: Align(
                      alignment: AlignmentDirectional.centerEnd,
                      child: Text(
                        "Powered By : Vakalat.com",
                        textScaleFactor: 1,
                        textAlign: TextAlign.end,
                        style: TextStyle(
                          // fontSize: 12.sp,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
          // Column(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: [
          //     Expanded(
          //       child: Padding(
          //         padding: const EdgeInsets.all(10),
          //         child: GridView.count(
          //           crossAxisCount: 3,
          //           mainAxisSpacing: 10,
          //           crossAxisSpacing: 10,
          //           childAspectRatio: 25 / 19,
          //           controller: ScrollController(keepScrollOffset: false),
          //           shrinkWrap: true,
          //           scrollDirection: Axis.vertical,
          //           children: List.generate(Utils.stringList.length, (index) {
          //             return Material(
          //               elevation: 7,
          //               color: Colors.white,
          //               shape: RoundedRectangleBorder(
          //                   borderRadius: BorderRadius.all(Radius.circular(10.r))),
          //               child: InkWell(
          //                 onTap: () {
          //                   if(index == 0){
          //                     Navigator.pushNamed(context, '/searchTile');
          //                   }
          //                   else if(index == 1) {
          //                     Navigator.pushNamed(context, '/noticeBoardTile');
          //                   }
          //                   else if(index == 2) {
          //                     Navigator.pushNamed(context, '/eventTile');
          //                   }
          //                   else if(index == 3) {
          //                     Navigator.pushNamed(context, '/committeeTile');
          //                   }
          //                   else if(index == 4) {
          //                     Navigator.pushNamed(context, '/blogTile');
          //                   }
          //                   else if(index == 5) {
          //                     Navigator.pushNamed(context, '/importantLinksTile');
          //                   }
          //                   else if(index == 6) {
          //                     Navigator.pushNamed(context, '/publicDocumentsTile');
          //                   }
          //                   else if(index == 7) {
          //                     Navigator.pushNamed(context, '/achievementTile');
          //                   }
          //                   else if(index == 8) {
          //                     Navigator.pushNamed(context, '/participationTile');
          //                   }
          //                   else if(index == 9) {
          //                     Navigator.pushNamed(context, '/newsTile');
          //                   }
          //                   else if(index == 10) {
          //                     Navigator.pushNamed(context, '/contactUsTile');
          //                   }
          //                   else if(index == 11) {
          //                     showExitPopup();
          //                   }
          //                 },
          //                 radius: 0,
          //                 hoverColor: Colors.white,
          //                 borderRadius: BorderRadius.all(Radius.circular(10.r)),
          //                 child: Container(
          //                   // height: screenheight(context,dividedby: 8.5.h),
          //                   // width: screenheight(context,dividedby: 6.75.h),
          //                   margin: EdgeInsets.all(5),
          //                   constraints: BoxConstraints(),
          //                   decoration: BoxDecoration(
          //                     borderRadius: BorderRadius.all(Radius.circular(10.r)),
          //                     // border: Border.all(color: Colors.grey.shade400,width: 0.01),
          //                   ),
          //                   child: Column(
          //                     mainAxisAlignment: MainAxisAlignment.center,
          //                     crossAxisAlignment: CrossAxisAlignment.center,
          //                     children: [
          //                       Icon(Utils.iconList[index].icon,size: 45,),
          //                       Padding(padding: EdgeInsets.symmetric(vertical: screenheight(context,dividedby: 150.h))),
          //                       Align(alignment: Alignment.bottomCenter,child: Text(Utils.stringList[index],textScaleFactor: 0.80,style: TextStyle(fontWeight: FontWeight.w700),))
          //                     ],
          //                   ),
          //                 ),
          //               ),
          //             );
          //           }),
          //         ),
          //       ),
          //     ),
          //     Align(
          //       alignment: Alignment.topCenter,
          //       child: InkWell(
          //         onTap: () async{
          //           String url = "https://www.vakalat.com/";
          //           var urllaunchable = await canLaunch(url); //canLaunch is from url_launcher package
          //           if(urllaunchable){
          //             await launch(url); //launch is from url_launcher package to launch URL
          //             Fluttertoast.showToast(
          //                 msg: "Launching URL 'Vakalat.com' ...",
          //                 fontSize: 12.sp,
          //                 backgroundColor: Colors.green);
          //           }else{
          //             Fluttertoast.showToast(
          //                 msg: "URL Launch Error !!!",
          //                 fontSize: 12.sp,
          //                 backgroundColor: Colors.green);
          //           }
          //         },
          //         child: Container(
          //           height: screenheight(context, dividedby: 32.h),
          //           color: Colors.black,
          //           child: Center(
          //             child: Text(
          //               "Vakalat.com",
          //               textScaleFactor: 1,
          //               textAlign: TextAlign.start,
          //               style: TextStyle(
          //                 // fontSize: 12.sp,
          //                   color: Colors.white),
          //             ),
          //           ),
          //         ),
          //       ),
          //     )
          //   ],
          // ),
        ),
        /*Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: Colors.orange[100], // background color
            child: ListView(
              children: [
                Container(
                  height: 200,
                  child: Row(
                    children: [
                      Container(
                        height: 200,
                        width: MediaQuery.of(context).size.width / 2 - 32, // minus 32 due to the margin
                        margin: EdgeInsets.all(16.0),
                        padding: EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          color: Colors.yellow[100], // background color of the cards
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                          boxShadow: [
                            // this is the shadow of the card
                            BoxShadow(
                              color: Colors.black,
                              spreadRadius: 0.5,
                              offset: Offset(2.0, 2.0),
                              blurRadius: 5.0,
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end, // posion the everything to the bottom
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // place here your image
                            Text("Bed room", style: TextStyle(fontSize: 20.0, color: Colors.brown, fontWeight: FontWeight.bold)),
                            Text("4 Lights", style: TextStyle(fontSize: 18.0, color: Colors.orange)),
                          ],
                        ),
                      ),
                      Container(
                        height: 200,
                        width: MediaQuery.of(context).size.width / 2 - 32, // minus 32 due to the margin
                        margin: EdgeInsets.all(16.0),
                        padding: EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          color: Colors.yellow[100], // background color of the cards
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                          boxShadow: [
                            // this is the shadow of the card
                            BoxShadow(
                              color: Colors.black,
                              spreadRadius: 0.5,
                              offset: Offset(2.0, 2.0),
                              blurRadius: 5.0,
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end, // posion the everything to the bottom
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // place here your image
                            Text("Living room", style: TextStyle(fontSize: 20.0, color: Colors.brown, fontWeight: FontWeight.bold)),
                            Text("2 Lights", style: TextStyle(fontSize: 18.0, color: Colors.orange)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 200,
                  child: Row(
                    children: [
                      Container(
                        height: 200,
                        width: MediaQuery.of(context).size.width / 2 - 32, // minus 32 due to the margin
                        margin: EdgeInsets.all(16.0),
                        padding: EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          color: Colors.yellow[100], // background color of the cards
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                          boxShadow: [
                            // this is the shadow of the card
                            BoxShadow(
                              color: Colors.black,
                              spreadRadius: 0.5,
                              offset: Offset(2.0, 2.0),
                              blurRadius: 5.0,
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end, // posion the everything to the bottom
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // place here your image
                            Text("Kitchen", style: TextStyle(fontSize: 20.0, color: Colors.brown, fontWeight: FontWeight.bold)),
                            Text("5 Lights", style: TextStyle(fontSize: 18.0, color: Colors.orange)),
                          ],
                        ),
                      ),
                      Container(
                        height: 200,
                        width: MediaQuery.of(context).size.width / 2 - 32, // minus 32 due to the margin
                        margin: EdgeInsets.all(16.0),
                        padding: EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          color: Colors.yellow[100], // background color of the cards
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                          boxShadow: [
                            // this is the shadow of the card
                            BoxShadow(
                              color: Colors.black,
                              spreadRadius: 0.5,
                              offset: Offset(2.0, 2.0),
                              blurRadius: 5.0,
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end, // posion the everything to the bottom
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // place here your image
                            Text("Bathroom", style: TextStyle(fontSize: 20.0, color: Colors.brown, fontWeight: FontWeight.bold)),
                            Text("1 Lights", style: TextStyle(fontSize: 18.0, color: Colors.orange)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 200,
                  child: Row(
                    children: [
                      Container(
                        height: 200,
                        width: MediaQuery.of(context).size.width / 2 - 32, // minus 32 due to the margin
                        margin: EdgeInsets.all(16.0),
                        padding: EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          color: Colors.yellow[100], // background color of the cards
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                          boxShadow: [
                            // this is the shadow of the card
                            BoxShadow(
                              color: Colors.black,
                              spreadRadius: 0.5,
                              offset: Offset(2.0, 2.0),
                              blurRadius: 5.0,
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end, // posion the everything to the bottom
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // place here your image
                            Text("Bed room", style: TextStyle(fontSize: 20.0, color: Colors.brown, fontWeight: FontWeight.bold)),
                            Text("4 Lights", style: TextStyle(fontSize: 18.0, color: Colors.orange)),
                          ],
                        ),
                      ),
                      Container(
                        height: 200,
                        width: MediaQuery.of(context).size.width / 2 - 32, // minus 32 due to the margin
                        margin: EdgeInsets.all(16.0),
                        padding: EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          color: Colors.yellow[100], // background color of the cards
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                          boxShadow: [
                            // this is the shadow of the card
                            BoxShadow(
                              color: Colors.black,
                              spreadRadius: 0.5,
                              offset: Offset(2.0, 2.0),
                              blurRadius: 5.0,
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end, // posion the everything to the bottom
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // place here your image
                            Text("Living room", style: TextStyle(fontSize: 20.0, color: Colors.brown, fontWeight: FontWeight.bold)),
                            Text("2 Lights", style: TextStyle(fontSize: 18.0, color: Colors.orange)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),*/
        drawer: MyDrawerWidget(),
      ),
    );
  }
}

class Utils {
  static List<String> stringList = [
    'Search',
    'Notice Board',
    'Events',
    'Committee',
    'Blog',
    'Important links',
    'Public Documents',
    'Achievement',
    'Participation',
    'News',
    'Contact Us',
    'Logout'
  ];

  static List<Icon> iconList = [
    Icon(
      CupertinoIcons.search,
      size: 45.h,
      color: Colors.black,
    ),
    Icon(
      CupertinoIcons.captions_bubble,
      size: 45.h,
      color: Colors.black,
    ),
    Icon(
      CupertinoIcons.calendar_badge_plus,
      size: 45.h,
      color: Colors.black,
    ),
    Icon(
      CupertinoIcons.group_solid,
      size: 45.h,
      color: Colors.black,
    ),
    Icon(
      CupertinoIcons.bookmark_solid,
      size: 45.h,
      color: Colors.black,
    ),
    Icon(
      CupertinoIcons.link,
      size: 45.h,
      color: Colors.black,
    ),
    Icon(
      CupertinoIcons.doc_chart_fill,
      size: 45.h,
      color: Colors.black,
    ),
    Icon(
      Icons.verified_user_rounded,
      size: 45.h,
      color: Colors.black,
    ),
    Icon(
      Icons.school_rounded,
      size: 45.h,
      color: Colors.black,
    ),
    Icon(
      CupertinoIcons.globe,
      size: 45.h,
      color: Colors.black,
    ),
    Icon(
      CupertinoIcons.phone_fill_badge_plus,
      size: 45.h,
      color: Colors.black,
    ),
    Icon(
      CupertinoIcons.square_arrow_left_fill,
      size: 45.h,
      color: Colors.black,
    ),
  ];
}

Route _createRoute() {
  return PageRouteBuilder(
    transitionDuration: Duration(milliseconds: 600),
    pageBuilder: (context, animation, secondaryAnimation) => LoginAgain(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(0.0, 2.5);
      const end = Offset.zero;
      const curve = Curves.easeOutSine;
      // easeInOutExpo
      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}