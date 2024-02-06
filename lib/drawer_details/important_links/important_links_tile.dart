import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shimmer/shimmer.dart';
import 'package:surat_district_bar_association/services/all_api_services.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../model/imp_links_model.dart';
import '../../model/login_model.dart';
import '../../widgets/drawer.dart';
import '../../widgets/sharedpref.dart';

class ImportantLinksTileScreen extends StatefulWidget {
  const ImportantLinksTileScreen({super.key});

  @override
  State<ImportantLinksTileScreen> createState() =>
      _ImportantLinksTileScreenState();
}

class _ImportantLinksTileScreenState extends State<ImportantLinksTileScreen> {
  final ScrollController _controller = ScrollController();
  LoginModel login = loginModelFromJson(SharedPref.get(prefKey: PrefKey.saveUser)!);

  Future<void> launchUrlStart({required String url}) async {
    if (await launch(url)) {
      throw 'Could Not Launch $url';
    }
  }

  List<linkDatum?> data = [];

  Future<void> fetchDataFromAPI(id) async {
    Map<String, dynamic> parameter = {
      "user_id": id,
    };
    await impLinksData(parameter: parameter).then((value) {
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
          'Important Links',
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
                      onTap: () async {
                        // Navigator.pushNamed(context, '/committeeDetail');
                        // launchUrlStart(
                        //     url:
                        //         "https://services.ecourts.gov.in/ecourtindia_v4_bilingual/cases/case_no.php?state=D&state_cd=17&dist_cd=14");
                        if (data[index]!.htmlLink.isNotEmpty) {
                          await launchUrl(Uri.parse(data[index]!.htmlLink),mode: LaunchMode.externalApplication);; //launch is from url_launcher package to launch URL
                          Fluttertoast.showToast(
                              msg: "Launching URL In Browser...",
                              fontSize: 12.sp,
                              backgroundColor: Colors.green);
                        } else {
                          Fluttertoast.showToast(
                              msg: "URL Launch Error !!!",
                              fontSize: 12.sp,
                              backgroundColor: Colors.green);
                        }
                      },
                      // splashColor: Colors.white,
                      // highlightColor: Colors.transparent,
                      hoverColor: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(10.r)),
                      child: Container(
                        constraints:
                            BoxConstraints(maxHeight: double.infinity),
                        child: Padding(
                          padding: EdgeInsets.only(
                              top: 10, bottom: 10, left: 10, right: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Text(
                                      // 'All India High Court & Supreme Court Causelist & Judgements',
                                      data[index]!.linkName,
                                      softWrap: true,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                      textScaleFactor: 1.10,
                                      style: TextStyle(
                                          // fontSize: 10.6,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                  // Padding(padding: EdgeInsets.symmetric(horizontal: screenwidth(context,dividedby: 50.w))),
                                  Image(
                                    image: AssetImage(
                                        "images/important-links.png"),
                                    width: 15.w,
                                    height: 20.h,
                                    color: Colors.grey.shade700,
                                  ),
                                ],
                              ),
                              /*Column(
                            children: [
                              InkWell(
                                onTap: () => {
                                  // launchUrlStart(
                                  //     url: "https://www.confonet.nic.in"),
                                  Fluttertoast.showToast(
                                      msg: "Launching Url...",
                                      fontSize: 12.sp,
                                      backgroundColor: Colors.green),
                                },
                                focusColor: Colors.blue,
                                highlightColor: Colors.white,
                                splashColor: Colors.white,
                                child: Tooltip(
                                  message: "Click Here To Launch Url",
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 35, top: 8),
                                    child: Text(
                                      // 'http://www.judicialacademy.nic.in',
                                      'https://services.ecourts.gov.in/ecourtindia_v4_bilingual/cases/case_no.php?state=D&state_cd=17&dist_cd=14',
                                      textScaleFactor: 0.75,
                                      style: TextStyle(
                                          // fontSize: 12,
                                          color: Colors.blue,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),*/
                            ],
                          ),
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
            padding: const EdgeInsets.only(left: 20,right: 20,bottom: 15,top: 20),
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
                      height: 20,
                      width: 20,
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
