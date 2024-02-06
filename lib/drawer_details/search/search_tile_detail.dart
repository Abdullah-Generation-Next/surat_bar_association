import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:surat_district_bar_association/drawer_details/search/search_tile.dart';
import 'package:surat_district_bar_association/model/search_model.dart';
import 'package:surat_district_bar_association/services/AppConfig.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../model/user_about_model.dart';
import '../../widgets/media_query_sizes.dart';

class SearchDetailScreen extends StatefulWidget {
  UserAboutModel? allData;
  final List<UserAboutDatum?> allUserData;
  final searchDatum? searchData;
  SearchDetailScreen({
    super.key,
    this.allData,
    required this.allUserData,
    this.searchData,
  });

  @override
  State<SearchDetailScreen> createState() => _SearchDetailScreenState();
}

class _SearchDetailScreenState extends State<SearchDetailScreen> {
  final ScrollController _controller = ScrollController();
  String mainUrl = "https://vakalat-public.s3.ap-southeast-1.amazonaws.com/";

  @override
  Widget build(BuildContext context) {
    // // Print all data for debugging
    // print('All Data:');
    // widget.allUserData.forEach((user) {
    //   print('${user?.firstName} ${user?.middleName} ${user?.lastName}');
    // });
    //
    // UserAboutDatum? userDetail = widget.allUserData.firstWhere(
    //       (user) => user?.firstName == widget.selectedUserData?.firstName,
    //   orElse: () => null,
    // );

    // print('Selected User: ${widget.selectedUserData?.firstName} ${widget.selectedUserData?.middleName} ${widget.selectedUserData?.lastName}');
    // print('All Data:');
    // widget.allUserData.forEach((user) {
    //   print('${user?.firstName} ${user?.middleName} ${user?.lastName}');
    // });


    String practiceAreas = widget.allUserData.first!.categoryName;
    List<String> uniquePracticeAreas = practiceAreas.split(',').toSet().toList();
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
            color: Colors.black, size: screenheight(context, dividedby: 25.h)),
        backgroundColor: Colors.transparent,
        title: Text(
          'Lawyer Detail',
          textScaleFactor: 0.9,
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
        elevation: 0,
        automaticallyImplyLeading: true,
      ),
      body:
      // userDetail != null
      //     ?
      ScrollConfiguration(
        behavior: MyBehavior(),
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          controller: _controller,
          children: [
            Center(
              child: Padding(
                padding: EdgeInsets.symmetric(
                    vertical: screenheight(context, dividedby: 45.h)),
                child: CachedNetworkImage(
                  imageUrl: mainUrl + widget.searchData!.profilePic,
                  imageBuilder: (context, imageProvider) => Material(
                    elevation: 10,
                    shape: CircleBorder(
                        side: BorderSide(width: 0.3, color: Colors.grey)),
                    clipBehavior: Clip.antiAlias,
                    color: Colors.transparent,
                    child: Ink.image(
                      // image: AssetImage('images/avatarlogos.jpg'),
                      // image: NetworkImage(mainUrl + widget.searchData!.profilePic),
                      image: imageProvider,
                      fit: BoxFit.cover,
                      width: 140.w,
                      height: 140.h,
                      child: InkWell(
                        radius: 0,
                        onTap: () async {
                          await showDialog(
                            context: context,
                            builder: (_) => Center(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 50,right: 50),
                                child: Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                        image: NetworkImage("${mainUrl + widget.searchData!.profilePic}"),
                                        fit: BoxFit.contain
                                    ),
                                  ),
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  placeholder: (context, url) =>
                      CircleAvatar(
                        radius: 70.r,
                        backgroundColor: Colors.grey.shade300,
                      ),
                  errorWidget: (context, url, error) => Visibility(
                    visible: true,
                    child: Material(
                      elevation: 0,
                      shape: CircleBorder(
                        side: BorderSide(width: 0.3, color: Colors.grey),
                      ),
                      clipBehavior: Clip.antiAlias,
                      color: Colors.transparent,
                      child: Ink.image(
                        width: 140.w,
                        height: 140.h,
                        image: AssetImage('images/avatarlogos.jpg'), // Provide a default image
                        child: InkWell(
                          radius: 0,
                          onTap: () async {
                            await showDialog(
                              context: context,
                              builder: (_) => Center(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 50, right: 50),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                        image: AssetImage('images/avatarlogos.jpg'),
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ),
                // errorWidget: (context, url, error) =>
                //     Visibility(
                //     visible: true,
                //     child: Material(
                //       elevation: 0,
                //       shape: CircleBorder(
                //           side: BorderSide(width: 0.3, color: Colors.grey)),
                //       clipBehavior: Clip.antiAlias,
                //       color: Colors.transparent,
                //       child: Ink.image(
                //         width: 140.w,
                //         height: 140.h,
                //         image: AssetImage('images/avatarlogos.jpg'),
                //         // fit: BoxFit.cover,
                //         child: InkWell(
                //           radius: 0,
                //           onTap: () async {
                //             await showDialog(
                //               context: context,
                //               builder: (_) => Center(
                //                 child: Padding(
                //                   padding: const EdgeInsets.only(left: 50,right: 50),
                //                   child: Container(
                //                     decoration: BoxDecoration(
                //                       shape: BoxShape.circle,
                //                       image: DecorationImage(
                //                           image: AssetImage('images/avatarlogos.jpg'),
                //                           fit: BoxFit.contain
                //                       ),
                //                     ),
                //                     child: GestureDetector(
                //                       onTap: () {
                //                         Navigator.pop(context);
                //                       },
                //                     ),
                //                   ),
                //                 ),
                //               ),
                //             );
                //           },
                //         ),
                //       ),
                //     ),),
                // CircleAvatar(
                // radius: 30.r,
                // backgroundColor: Colors.grey.shade400,
                // child: CircleAvatar(
                //   radius: 27.r,
                //   backgroundColor: Colors.grey,
                //   child: Center(
                //     child: CircularProgressIndicator(
                //       color: Colors.grey,
                //       strokeWidth: 3,
                //     ),
                //   ),
                // )),
                // Material(
                //   elevation: 10,
                //   shape: CircleBorder(
                //       side: BorderSide(width: 0.3, color: Colors.grey)),
                //   clipBehavior: Clip.antiAlias,
                //   color: Colors.transparent,
                //   child: Ink.image(
                //     // image: AssetImage('images/avatarlogos.jpg'),
                //     image: NetworkImage(widget.allData!.profilePic),
                //     // fit: BoxFit.cover,
                //     width: 140.w,
                //     height: 140.h,
                //     child: InkWell(
                //       radius: 0,
                //       onTap: () {},
                //     ),
                //   ),
                // )
              ),
            ),
            Padding(padding: EdgeInsets.only(top: 15)),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  // 'AJAZHUSSAIN IMTIYAZ BHAI MOMIN',
                  "${widget.allUserData.first!.firstName} ${widget.allUserData.first!.middleName} ${widget.allUserData.first!.lastName}",
                  textAlign: TextAlign.center,
                  textScaleFactor: 1.1,
                  // style: TextStyle(fontSize: 15.sp),
                ),
                Padding(padding: EdgeInsets.only(top: 10)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.phone,
                      color: Colors.grey.shade600,
                      size: screenheight(context, dividedby: 35.h),
                    ),
                    Padding(padding: EdgeInsets.only(left: 10)),
                    InkWell(
                      onTap: () async {
                        if(widget.allUserData.first!.mobile.isNotEmpty) {
                          launch("tel:${widget.allUserData.first!.mobile}");
                        }
                        // String url = "tel:${widget.allData!.mobile}";
                        // var urllaunchable = await canLaunch(
                        //     url);
                        // if (urllaunchable) {
                        //   await launch(
                        //       url);
                        //   Fluttertoast.showToast(
                        //       msg: "Opening Phone Call Log",
                        //       fontSize: 12.sp,
                        //       backgroundColor: Colors.green);
                        // }
                      },
                      child: Text(
                        // '9824198197',
                        // widget.allData!.mobile.isEmpty ?
                        widget.allUserData.first!.mobile.isEmpty ?
                        'Mobile Number Not Available' :
                        widget.allUserData.first!.mobile,
                        textScaleFactor: 0.95,
                        // style: TextStyle(fontSize: 15.sp),
                      ),
                    ),
                  ],
                ),
                Padding(padding: EdgeInsets.only(top: 10)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.cake_outlined,
                      color: Colors.grey.shade600,
                      size: 22,
                    ),
                    Padding(padding: EdgeInsets.only(left: 10)),
                    Padding(
                      padding: const EdgeInsets.only(top: 2.5),
                      child: Text(
                        // '26/11/2001',
                        widget.allUserData.first!.dateOfBirth.isEmpty ? "-- Not provided --" : widget.allUserData.first!.dateOfBirth,
                        // widget.allData!.mobile.isEmpty ?
                        // 'Mobile Number Not Available' :
                        // widget.allData!.mobile,
                        textScaleFactor: 0.95,
                        // style: TextStyle(fontSize: 15.sp),
                      ),
                    ),
                  ],
                ),
                Padding(padding: EdgeInsets.only(top: 12)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                    Icons.bloodtype_rounded,
                      color: Colors.grey.shade600,
                      size: screenheight(context, dividedby: 35.h),
                    ),
                    Padding(padding: EdgeInsets.only(left: 7)),
                    Text(
                      // '--',
                      widget.allUserData.first!.bloodGroup.isEmpty ? "--" : widget.allUserData.first!.bloodGroup,
                      // widget.allData!.mobile.isEmpty ?
                      // 'Mobile Number Not Available' :
                      // widget.allData!.mobile,
                      textScaleFactor: 0.95,
                      // style: TextStyle(fontSize: 15.sp),
                    ),
                    Padding(padding: EdgeInsets.only(left: 7)),
                    Icon(
                      // Icons.male,
                      widget.allUserData.first!.gender == 'M' ? Icons.male_rounded : Icons.female_rounded,
                      color: Colors.grey.shade600,
                      size: screenheight(context, dividedby: 35.h),
                    ),
                    Padding(padding: EdgeInsets.only(left: 7)),
                    Text(
                      // 'Male',
                      widget.allUserData.first!.gender == 'M' ? "Male" : "Female",
                      textScaleFactor: 0.95,
                      // style: TextStyle(fontSize: 15.sp),
                    ),
                  ],
                ),
              ],
            ),
            Padding(padding: EdgeInsets.only(top: 15)),
            Material(
              elevation: 2,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.r)),
                  side: BorderSide(color: Colors.grey, width: 0.15)),
              child: InkWell(
                radius: 0,
                onTap: () {
                  if(widget.allUserData.first!.email.isNotEmpty) {
                    launch("mailto:${widget.allUserData.first!.email}");
                  }
                },
                hoverColor: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10.r)),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 20, top: 10, bottom: 10, right: 20),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.email_rounded,
                        size: screenheight(context, dividedby: 25.h),
                        color: Colors.grey.shade600,
                      ),
                      Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal:
                                  screenwidth(context, dividedby: 35.w))),
                      Text(
                        // 'kalpeshahire@gmail.com',
                        widget.allUserData.first!.email.isEmpty ?
                        '-- Not provided --' :
                        widget.allUserData.first!.email,
                        textScaleFactor: 1.1,
                        // style: TextStyle(fontSize: 15.sp),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(padding: EdgeInsets.only(top: 20)),
            Material(
              elevation: 2,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.r)),
                  side: BorderSide(color: Colors.grey, width: 0.15)),
              child: InkWell(
                radius: 0,
                onTap: () {
                  if(widget.allUserData.first!.websiteUrl.isNotEmpty) {
                    launch("${widget.allUserData.first!.websiteUrl}");
                  }
                },
                hoverColor: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10.r)),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 20, top: 10, bottom: 10, right: 20),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        CupertinoIcons.globe,
                        size: screenheight(context, dividedby: 25.h),
                        color: Colors.grey.shade600,
                      ),
                      Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal:
                                  screenwidth(context, dividedby: 35.w))),
                      Text(
                        widget.allUserData.first!.websiteUrl.isEmpty ? '-- Not provided --' :
                        widget.allUserData.first!.websiteUrl,
                        textScaleFactor: 1.1,
                        // style: TextStyle(fontSize: 15.sp),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Padding(padding: EdgeInsets.only(top: 20)),
            Material(
              elevation: 2,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.r)),
                  side: BorderSide(color: Colors.grey, width: 0.15)),
              child: InkWell(
                radius: 0,
                onTap: () {},
                hoverColor: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10.r)),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 20, top: 10, bottom: 10, right: 20),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            '${AppConfig.sortName} Details',
                            textScaleFactor: 1.17,
                            style: TextStyle(
                              fontWeight: FontWeight.w900,
                              // fontSize: 15.sp
                            ),
                          ),
                        ],
                      ),
                      Padding(padding: EdgeInsets.only(top: 10)),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Membership No. :',
                            textScaleFactor: 1.1,
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              // fontSize: 15.sp
                            ),
                          ),
                          Text(
                            // '0',
                            widget.allUserData.first!.assoMemberNo.isEmpty ? "-- Not provided --" : widget.allUserData.first!.assoMemberNo,
                            textScaleFactor: 1.1,
                            // style: TextStyle(fontSize: 15.sp),
                          ),
                        ],
                      ),
                      Padding(padding: EdgeInsets.only(top: 5)),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Joining Date :',
                            textScaleFactor: 1.1,
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              // fontSize: 15.sp
                            ),
                          ),
                          Text(
                            widget.allUserData.first!.assoMemberDate.isEmpty ? "-- Not provided --" : widget.allUserData.first!.assoMemberDate,
                            textScaleFactor: 1.1,
                            // style: TextStyle(fontSize: 15.sp),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(padding: EdgeInsets.only(top: 20)),
            Material(
              elevation: 2,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.r)),
                  side: BorderSide(color: Colors.grey, width: 0.15)),
              child: InkWell(
                radius: 0,
                onTap: () {},
                hoverColor: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10.r)),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 20, top: 10, bottom: 10, right: 20),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Sanad Details',
                            textScaleFactor: 1.17,
                            style: TextStyle(
                              fontWeight: FontWeight.w900,
                              // fontSize: 15.sp
                            ),
                          ),
                        ],
                      ),
                      Padding(padding: EdgeInsets.only(top: 10)),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Sanad Reg. No. :',
                            textScaleFactor: 1.1,
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              // fontSize: 15.sp
                            ),
                          ),
                          Text(
                            // 'G/248/2018',
                            widget.allUserData.first!.sanadRegNo.isEmpty ? "-- Not provided --" : widget.allUserData.first!.sanadRegNo,
                            textScaleFactor: 1.1,
                            // style: TextStyle(fontSize: 15.sp),
                          ),
                        ],
                      ),
                      Padding(padding: EdgeInsets.only(top: 5)),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Sanad Reg. Date :',
                            textScaleFactor: 1.1,
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              // fontSize: 15.sp
                            ),
                          ),
                          Text(
                            // '-- Not provided --',
                            widget.allUserData.first!.sanadRegDate.isEmpty ? "-- Not provided --" : widget.allUserData.first!.sanadRegDate,
                            textScaleFactor: 1.1,
                            // style: TextStyle(fontSize: 15.sp),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(padding: EdgeInsets.only(top: 20)),
            Material(
              elevation: 2,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.r)),
                  side: BorderSide(color: Colors.grey, width: 0.15)),
              child: InkWell(
                radius: 0,
                onTap: () {},
                hoverColor: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10.r)),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 20, top: 10, bottom: 10, right: 20),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'District Court Details',
                            textScaleFactor: 1.17,
                            style: TextStyle(
                              fontWeight: FontWeight.w900,
                              // fontSize: 15.sp
                            ),
                          ),
                        ],
                      ),
                      Padding(padding: EdgeInsets.only(top: 10)),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'District Court No. :',
                            textScaleFactor: 1.1,
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              // fontSize: 15.sp
                            ),
                          ),
                          Text(
                            // '-- Not provided --',
                            widget.allUserData.first!.distCourtRegiNo.isEmpty ? "-- Not provided --" : widget.allUserData.first!.distCourtRegiNo,
                            textScaleFactor: 1.1,
                            // style: TextStyle(fontSize: 15.sp),
                          ),
                        ],
                      ),
                      Padding(padding: EdgeInsets.only(top: 5)),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Reg. Date :',
                            textScaleFactor: 1.1,
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              // fontSize: 15.sp
                            ),
                          ),
                          Text(
                            // '-- Not provided --',
                            widget.allUserData.first!.distCourtRegiDate.isEmpty ? "-- Not provided --" : widget.allUserData.first!.distCourtRegiDate,
                            textScaleFactor: 1.1,
                            // style: TextStyle(fontSize: 15.sp),
                          ),
                        ],
                      ),
                      Padding(padding: EdgeInsets.only(top: 5)),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Welfare No. :',
                            textScaleFactor: 1.1,
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              // fontSize: 15.sp
                            ),
                          ),
                          Text(
                            // '-- Not provided --',
                            widget.allUserData.first!.welfareNo.isEmpty ? "-- Not provided --" : widget.allUserData.first!.welfareNo,
                            textScaleFactor: 1.1,
                            // style: TextStyle(fontSize: 15.sp),
                          ),
                        ],
                      ),
                      Padding(padding: EdgeInsets.only(top: 5)),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Welfare Expiry Date :',
                            textScaleFactor: 1.1,
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              // fontSize: 15.sp
                            ),
                          ),
                          Text(
                            // '-- Not provided --',
                            widget.allUserData.first!.welfareDate.isEmpty ? "-- Not provided --" : widget.allUserData.first!.welfareDate,
                            textScaleFactor: 1.1,
                            // style: TextStyle(fontSize: 15.sp),
                          ),
                        ],
                      ),
                      Padding(padding: EdgeInsets.only(top: 5)),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Notry No. :',
                            textScaleFactor: 1.1,
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              // fontSize: 15.sp
                            ),
                          ),
                          Text(
                            // '-- Not provided --',
                            widget.allUserData.first!.notaryNo.isEmpty ? "-- Not provided --" : widget.allUserData.first!.notaryNo,
                            textScaleFactor: 1.1,
                            // style: TextStyle(fontSize: 15.sp),
                          ),
                        ],
                      ),
                      Padding(padding: EdgeInsets.only(top: 5)),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Qualification :',
                            textScaleFactor: 1.1,
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              // fontSize: 15.sp
                            ),
                          ),
                          Container(
                            width: 150,
                            child: Text(
                              // '-- Not provided --',
                              widget.allUserData.first!.qualification.isEmpty ? "-- Not provided --" : widget.allUserData.first!.qualification,
                              textAlign: TextAlign.end,
                              textScaleFactor: 1.1,
                              maxLines: 3,
                              // style: TextStyle(fontSize: 15.sp),
                            ),
                          ),
                        ],
                      ),
                      Padding(padding: EdgeInsets.only(top: 5)),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Experience :',
                            textScaleFactor: 1.1,
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              // fontSize: 15.sp
                            ),
                          ),
                          Text(
                            // '-- Not provided --',
                            widget.allUserData.first!.experience.isEmpty ? "-- Not provided --" : widget.allUserData.first!.experience,
                            textScaleFactor: 1.1,
                            // style: TextStyle(fontSize: 15.sp),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // Padding(padding: EdgeInsets.only(top: 20)),
            // Material(
            //   elevation: 2,
            //   shape: RoundedRectangleBorder(
            //       borderRadius: BorderRadius.all(Radius.circular(10.r)),
            //       side: BorderSide(color: Colors.grey, width: 0.15)),
            //   child: InkWell(
            //     radius: 0,
            //     onTap: () {},
            //     hoverColor: Colors.white,
            //     borderRadius: BorderRadius.all(Radius.circular(10.r)),
            //     child: Padding(
            //       padding: const EdgeInsets.only(
            //           left: 20, top: 10, bottom: 10, right: 20),
            //       child: Column(
            //         children: [
            //           Row(
            //             crossAxisAlignment: CrossAxisAlignment.center,
            //             children: [
            //               Text(
            //                 'About',
            //                 textScaleFactor: 1.17,
            //                 style: TextStyle(
            //                   fontWeight: FontWeight.w900,
            //                   // fontSize: 15.sp
            //                 ),
            //               ),
            //             ],
            //           ),
            //           Padding(padding: EdgeInsets.only(top: 5)),
            //           Column(
            //             mainAxisAlignment: MainAxisAlignment.start,
            //             crossAxisAlignment: CrossAxisAlignment.start,
            //             children: [
            //               Align(
            //                 alignment: AlignmentDirectional.topStart,
            //                 child: Text(
            //                   // '-- Not provided --',
            //                   widget.allUserData.first!.aboutUser.isEmpty ? "-- Not provided --" : widget.allUserData.first!.aboutUser,
            //                   textScaleFactor: 1.1,
            //                   textAlign: TextAlign.start,
            //                   style: TextStyle(
            //                     fontWeight: FontWeight.w400,
            //                     // fontSize: 15.sp
            //                   ),
            //                 ),
            //               ),
            //             ],
            //           ),
            //         ],
            //       ),
            //     ),
            //   ),
            // ),
            // Padding(padding: EdgeInsets.only(top: 20)),
            // Material(
            //   elevation: 2,
            //   shape: RoundedRectangleBorder(
            //       borderRadius: BorderRadius.all(Radius.circular(10.r)),
            //       side: BorderSide(color: Colors.grey, width: 0.15)),
            //   child: InkWell(
            //     radius: 0,
            //     onTap: () {},
            //     hoverColor: Colors.white,
            //     borderRadius: BorderRadius.all(Radius.circular(10.r)),
            //     child: Padding(
            //       padding: const EdgeInsets.only(
            //           left: 20, top: 10, bottom: 10, right: 20),
            //       child: Column(
            //         children: [
            //           Row(
            //             mainAxisAlignment: MainAxisAlignment.start,
            //             children: [
            //               Text(
            //                 'Practise Area',
            //                 textScaleFactor: 1.17,
            //                 style: TextStyle(
            //                   fontWeight: FontWeight.w900,
            //                   // fontSize: 15.sp
            //                 ),
            //               ),
            //             ],
            //           ),
            //           Padding(padding: EdgeInsets.only(top: 5)),
            //           Column(
            //             mainAxisAlignment: MainAxisAlignment.start,
            //             crossAxisAlignment: CrossAxisAlignment.start,
            //             children: [
            //               Align(
            //                 alignment: AlignmentDirectional.topStart,
            //                 child: Text(
            //                   // '-- Not provided --',
            //                   // widget.allData.first!.categoryName.isEmpty ? "-- Not provided --" : widget.allData.first!.categoryName,
            //                   uniquePracticeAreas.isEmpty ? "-- Not provided --" : uniquePracticeAreas.join(', '),
            //                   textScaleFactor: 1.1,textAlign: TextAlign.start,
            //                   style: TextStyle(
            //                     fontWeight: FontWeight.w400,
            //                     // fontSize: 15.sp
            //                   ),
            //                 ),
            //               ),
            //             ],
            //           ),
            //         ],
            //       ),
            //     ),
            //   ),
            // ),
            Padding(padding: EdgeInsets.only(top: 20)),
            Material(
              elevation: 2,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.r)),
                  side: BorderSide(color: Colors.grey, width: 0.15)),
              child: InkWell(
                radius: 0,
                onTap: () {},
                hoverColor: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10.r)),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 20, top: 10, bottom: 10, right: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            CupertinoIcons.building_2_fill,
                            size: screenheight(context, dividedby: 30.h),
                            color: Colors.grey.shade600,
                          ),
                          Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: screenwidth(context,
                                      dividedby: 50.w))),
                          Text(
                            'Office Address',
                            textScaleFactor: 1.17,
                            style: TextStyle(
                              fontWeight: FontWeight.w900,
                              // fontSize: 15.sp
                            ),
                          ),
                        ],
                      ),
                      Padding(padding: EdgeInsets.only(top: 10)),
                      Column(
                        children: [
                          Text(
                            // '301 - balaji enclave near manpura police chowki, nanpura surat',
                            widget.allUserData.first!.officeAddress.isEmpty ? "-- Not provided --" : widget.allUserData.first!.officeAddress,
                            textScaleFactor: 1.1,
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              // fontSize: 15.sp
                            ),
                          ),
                        ],
                      ),
                      Padding(padding: EdgeInsets.only(top: 5)),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.phone,
                            size: screenheight(context, dividedby: 30.h),
                            color: Colors.grey.shade600,
                          ),
                          Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: screenwidth(context,
                                      dividedby: 50.w))),
                          InkWell(
                            onTap: () async {
                              if(widget.allUserData.first!.companyMobile.isNotEmpty) {
                                launch("tel:${widget.allUserData.first!.companyMobile}");
                              }
                              // String url = "tel:${widget.allData!.mobile}";
                              // var urllaunchable = await canLaunch(
                              //     url);
                              // if (urllaunchable) {
                              //   await launch(
                              //       url);
                              //   Fluttertoast.showToast(
                              //       msg: "Opening Phone Call Log",
                              //       fontSize: 12.sp,
                              //       backgroundColor: Colors.green);
                              // }
                            },
                            child: Text(
                              // '9824198195',
                              widget.allUserData.first!.companyMobile.isEmpty ? "Mobile Number Not Available" : widget.allUserData.first!.companyMobile,
                              textScaleFactor: 1.1,
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                // fontSize: 15.sp
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(padding: EdgeInsets.only(top: 20)),
            Material(
              elevation: 2,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.r)),
                  side: BorderSide(color: Colors.grey, width: 0.15)),
              child: InkWell(
                radius: 0,
                onTap: () {},
                hoverColor: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10.r)),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 20, top: 10, bottom: 10, right: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.home,
                            size: screenheight(context, dividedby: 30.h),
                            color: Colors.grey.shade600,
                          ),
                          Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: screenwidth(context,
                                      dividedby: 50.w))),
                          Text(
                            'Residence Address',
                            textScaleFactor: 1.17,
                            style: TextStyle(
                              fontWeight: FontWeight.w900,
                              // fontSize: 15.sp
                            ),
                          ),
                        ],
                      ),
                      Padding(padding: EdgeInsets.only(top: 10)),
                      // Column(
                      //   children: [
                      //     Text(
                      //       'old address : 60 karmyogi soc - 2 near police line, bamroli road, pandesara, surat',
                      //       textScaleFactor: 1.1,
                      //       style: TextStyle(
                      //           fontWeight: FontWeight.w400,
                      //           // fontSize: 15.sp
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      // RichText(
                      //   textScaleFactor: 1.1,
                      //   text: TextSpan(
                      //     text: 'Old Address : ',
                      //     style: GoogleFonts.nunito(
                      //       textStyle: TextStyle(
                      //           fontWeight: FontWeight.w500,
                      //           color: Colors.black),
                      //     ),
                      //     children: <TextSpan>[
                      //       TextSpan(
                      //         text:
                      //             '60 karmyogi soc - 2 near police line, bamroli road, pandesara, surat',
                      //         style: GoogleFonts.nunito(
                      //           textStyle: TextStyle(
                      //             color: Colors.black,
                      //             // decoration: TextDecoration.underline,
                      //             // decorationStyle: TextDecorationStyle.wavy,
                      //             fontWeight: FontWeight.w300,
                      //           ),
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      // Column(
                      //   children: [
                      //     Text(
                      //       'NEW ADDRESS : 80 DEVNANDANI RESIDENCY, NEAR DEEP DARSHAN VIDHYA SANKUL, DELADVA GAM, DINDOLI KHARWASA ROAD, TA : CHORASI, DIST : SURAT',
                      //       textScaleFactor: 1.1,
                      //       style: TextStyle(
                      //         fontWeight: FontWeight.w400,
                      //         // fontSize: 15.sp
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      // RichText(
                      //   textScaleFactor: 1.01,
                      //   text: TextSpan(
                      //     text: 'New Address : ',
                      //     style: GoogleFonts.nunito(
                      //       textStyle: TextStyle(
                      //           fontWeight: FontWeight.w500,
                      //           color: Colors.black),
                      //     ),
                      //     children: <TextSpan>[
                      //       TextSpan(
                      //         text:
                      //             '80 DEVNANDANI RESIDENCY, NEAR DEEP DARSHAN VIDHYA SANKUL, DELADVA GAM, DINDOLI KHARWASA ROAD, TA : CHORASI, DIST : SURAT',
                      //         style: GoogleFonts.nunito(
                      //           textStyle: TextStyle(
                      //             color: Colors.black,
                      //             // decoration: TextDecoration.underline,
                      //             // decorationStyle: TextDecorationStyle.wavy,
                      //             fontWeight: FontWeight.w300,
                      //           ),
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      Column(
                        children: [
                          Text(
                            // '301 - balaji enclave near manpura police chowki, nanpura surat',
                            widget.allUserData.first!.address.isEmpty ? "-- Not provided --" : widget.allUserData.first!.address,
                            textScaleFactor: 1.1,
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              // fontSize: 15.sp
                            ),
                          ),
                        ],
                      ),
                      Padding(padding: EdgeInsets.only(top: 5)),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.phone,
                            size: screenheight(context, dividedby: 30.h),
                            color: Colors.grey.shade600,
                          ),
                          Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: screenwidth(context,
                                      dividedby: 50.w))),
                          InkWell(
                            onTap: () async {
                              if(widget.allUserData.first!.mobile.isNotEmpty) {
                                launch(
                                    "tel:${widget.allUserData.first!.mobile}");
                              }
                              // String url = "tel:${widget.allData!.mobile}";
                              // var urllaunchable = await canLaunch(
                              //     url);
                              // if (urllaunchable) {
                              //
                              //   await launch(
                              //       url);
                              //   Fluttertoast.showToast(
                              //       msg: "Opening Phone Call Log",
                              //       fontSize: 12.sp,
                              //       backgroundColor: Colors.green);
                              // }
                            },
                            child: Text(
                              // '6355054870',
                              widget.allUserData.first!.mobile.isEmpty ? "Mobile Number Not Available" : widget.allUserData.first!.mobile,
                              textScaleFactor: 1.1,
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                // fontSize: 15.sp
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(padding: EdgeInsets.only(top: 20)),
          ],
        ),
      )
      //     : Center(
      //   child: Text('User details not found.',style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600),),
      // ),
    );
  }
}

//=========================Rough Work================================
/*Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 10.r,
                              color: Colors.grey,
                              spreadRadius: 3.r)
                        ],
                      ),
                      child: InkWell(
                        onTap: () {},
                        hoverColor: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(50.r)),
                        child: CircleAvatar(
                          radius: 65.r,
                          backgroundImage: AssetImage('images/avatarlogos.jpg'),
                        ),
                      ),
                    ),*/
