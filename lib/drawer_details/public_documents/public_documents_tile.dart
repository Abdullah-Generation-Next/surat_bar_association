import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shimmer/shimmer.dart';
import 'package:surat_district_bar_association/model/document_model.dart';
import 'package:surat_district_bar_association/services/AppConfig.dart';
import 'package:surat_district_bar_association/services/all_api_services.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../widgets/drawer.dart';

class PublicDocumentsTileScreen extends StatefulWidget {
  const PublicDocumentsTileScreen({super.key});

  @override
  State<PublicDocumentsTileScreen> createState() =>
      _PublicDocumentsTileScreenState();
}

class _PublicDocumentsTileScreenState extends State<PublicDocumentsTileScreen> {
  final ScrollController _controller = ScrollController();

  List<documentDatum>? data = [];

  Future<void> fetchDataFromAPI() async {
    Map<String, dynamic> parameter = {
      "app_user" : AppConfig.APP_USER,
    };
    await documentsData(parameter: parameter).then((value) {
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
    fetchDataFromAPI();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          'Public Documents',
          textScaleFactor: 0.9,
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: true,
      ),
      body: data!.isNotEmpty
        ? ScrollConfiguration(
        behavior: MyBehavior(),
        child: data!.length > 0
            ? ListView.builder(
                controller: _controller,
                itemCount: data!.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    elevation: 5,
                    margin: EdgeInsets.all(10),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        side: BorderSide(color: Colors.grey, width: 0.15)),
                    child: InkWell(
                      radius: 0,
                      onTap: () async {
                        launch(data![index].documentUrl ?? "");
                        Fluttertoast.showToast(
                            msg: "Opening Document",
                            fontSize: 12.sp,
                            backgroundColor: Colors.green);
                        // String url = data[index]!.documentUrl;
                        // var urllaunchable = await canLaunch(
                        //     url); //canLaunch is from url_launcher package
                        // if (urllaunchable) {
                        //   await launch(
                        //       url); //launch is from url_launcher package to launch URL
                        //   Fluttertoast.showToast(
                        //       msg: "Launching URL In Browser...",
                        //       fontSize: 12.sp,
                        //       backgroundColor: Colors.green);
                        // } else {
                        //   Fluttertoast.showToast(
                        //       msg: "URL Launch Error !!!",
                        //       fontSize: 12.sp,
                        //       backgroundColor: Colors.green);
                        // }
                      },
                      // splashColor: Colors.white,
                      // highlightColor: Colors.transparent,
                      hoverColor: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(10.r)),
                      child: Container(
                        constraints:
                            BoxConstraints(maxHeight: double.infinity),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      // 'E_Stamping Suvidha Kendra',
                                      data![index].documentTitle ?? "",
                                      softWrap: true,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                      textScaleFactor: 1.17,
                                      style: TextStyle(
                                          // fontSize: 10.6,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                  Icon(
                                    Icons.file_download_outlined,
                                    size: 30.h,
                                    color: Colors.black,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                })  : Center(
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
              padding: const EdgeInsets.only(left: 20,right: 20,bottom: 15,top: 25),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Container(
                          height: 15,
                          decoration: BoxDecoration(
                            borderRadius:
                            BorderRadius.all(Radius.circular(10.r)),
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(width: 25,),
                      Container(
                        height: 25,
                        width: 30,
                        decoration: BoxDecoration(
                          borderRadius:
                          BorderRadius.all(Radius.circular(2.5.r)),
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
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
