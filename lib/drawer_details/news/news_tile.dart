import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shimmer/shimmer.dart';
import 'package:surat_district_bar_association/services/all_api_services.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../model/news_model.dart';
import '../../widgets/drawer.dart';
import '../../widgets/media_query_sizes.dart';

class ImageData {
  final String imagePath;
  final String opacityText;
  final String imageLinkUrl;

  ImageData({
    required this.imageLinkUrl,
    required this.imagePath,
    required this.opacityText,
  });
}

class NewsTileScreen extends StatefulWidget {
  const NewsTileScreen({super.key});

  @override
  State<NewsTileScreen> createState() => _NewsTileScreenState();
}

class _NewsTileScreenState extends State<NewsTileScreen> {
  final ScrollController _controller = ScrollController();
  /*List<ImageData> imageDataList = [
    ImageData(
      // navigate: Navigator.pushNamed(context, ''),
        imagePath: "images/legal_news/News1.jpg",
        opacityText:
            "Supreme Court Collegium has recommended appointment of one judicial",
        imageLinkUrl: 'https://news.abplive.com/news/india/govt-to-increase-lok-sabha-strength-to-1-000-know-the-constitutional-provisions-under-article-81-1472932'),
    ImageData(
        imagePath: "images/legal_news/News2.jpg",
        opacityText:
            "Allahabad High Court allows bail application of person accused of cheating and forged",
      imageLinkUrl: 'https://www.google.com/search?sxsrf=AB5stBj_siN1Jp3HbPiAqJrCf7kTfeo3Zg:1690036311508&q=lok+sabha&tbm=isch&sa=X&ved=2ahUKEwjC0YTww6KAAxWObWwGHRD0CWEQ0pQJegQICxAB&biw=1024&bih=441&dpr=1.88#imgrc=54Xg1plsH-6A0M',
    ),
    ImageData(
        imagePath: "images/legal_news/News3.jpg",
        opacityText:
            "Calcutta High Court dismisses PIL Substitution Law Of Act consider",
        imageLinkUrl: 'https://medium.com/@RayLiVerified/create-a-rounded-image-icon-with-ripple-effect-in-flutter-eb0f4a720b90'),
    ImageData(
        imagePath: "images/legal_news/News4.jpg",
        opacityText:
            "Lok Adalat Collegium has recommended appointment of one judicial",
    imageLinkUrl: 'https://news.abplive.com/news/india/govt-to-increase-lok-sabha-strength-to-1-000-know-the-constitutional-provisions-under-article-81-1472932'),
    ImageData(
        imagePath: "images/legal_news/News5.jpg",
        opacityText:
            "Rajya Sabha dismisses all Substitution Law Of Act consider to the bail application",
        imageLinkUrl: 'https://www.google.com/search?sxsrf=AB5stBj_siN1Jp3HbPiAqJrCf7kTfeo3Zg:1690036311508&q=lok+sabha&tbm=isch&sa=X&ved=2ahUKEwjC0YTww6KAAxWObWwGHRD0CWEQ0pQJegQICxAB&biw=1024&bih=441&dpr=1.88#imgrc=54Xg1plsH-6A0M'),
    ImageData(
        imagePath: "images/legal_news/News6.jpg",
        opacityText:
            "Supreme Court Collegium has recommended appointment of one judicial",
        imageLinkUrl: 'https://medium.com/@RayLiVerified/create-a-rounded-image-icon-with-ripple-effect-in-flutter-eb0f4a720b90'),
    ImageData(
        imagePath: "images/legal_news/News7.jpg",
        opacityText:
            "Allahabad High Court allows bail application of person accused of cheating and forged",
        imageLinkUrl: 'https://dribbble.com/search/login'),
    ImageData(
        imagePath: "images/legal_news/News8.jpg",
        opacityText:
            "Calcutta High Court dismisses PIL Substitution Law Of Act consider",
        imageLinkUrl: 'https://www.ambitionbox.com/it-services-and-consulting-companies-in-surat'),
    ImageData(
        imagePath: "images/legal_news/News9.jpg",
        opacityText:
            "Lok Adalat Collegium has recommended appointment of one judicial",
        imageLinkUrl: 'https://www.1377x.to/'),
    ImageData(
        imagePath: "images/legal_news/News10.jpg",
        opacityText:
            "Rajya Sabha dismisses all Substitution Law Of Act consider to the bail application",
        imageLinkUrl: 'https://dribbble.com/search/login'),
    ImageData(
        imagePath: "images/legal_news/News11.jpg",
        opacityText:
            "Supreme Court Collegium has recommended appointment of one judicial",
        imageLinkUrl: 'https://www.ambitionbox.com/it-services-and-consulting-companies-in-surat'),
    ImageData(
        imagePath: "images/legal_news/News12.jpg",
        opacityText:
            "Allahabad High Court allows bail application of person accused of cheating and forged",
        imageLinkUrl: 'https://www.1377x.to/'),
    ImageData(
        imagePath: "images/legal_news/News13.jpg",
        opacityText:
            "Calcutta High Court dismisses PIL Substitution Law Of Act consider",
        imageLinkUrl: 'https://www.google.com/search?q=calculator&oq=calcula&aqs=chrome.1.69i57j0i131i433i512j0i512j0i433i512j0i131i433i650j0i433i512j0i512j69i61.2927j0j4&sourceid=chrome&ie=UTF-8'),
    ImageData(
        imagePath: "images/legal_news/News14.jpg",
        opacityText:
            "Lok Adalat Collegium has recommended appointment of one judicial",
        imageLinkUrl: 'https://www.1377x.to/'),
    ImageData(
        imagePath: "images/legal_news/News15.jpg",
        opacityText:
            "Rajya Sabha dismisses all Substitution Law Of Act consider to the bail application",
        imageLinkUrl: 'https://www.google.com/search?q=calculator&oq=calcula&aqs=chrome.1.69i57j0i131i433i512j0i512j0i433i512j0i131i433i650j0i433i512j0i512j69i61.2927j0j4&sourceid=chrome&ie=UTF-8'),
  ];*/

  List<newsDatum?> data = [];

  Future<void> fetchDataFromAPI() async {
    await legalNewsData().then((value) {
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

  List imgList = [
    Image.asset('images/News1.jpg'),
    Image.asset('images/News2.jpg'),
    Image.asset('images/News3.jpg'),
    Image.asset('images/News4.jpg'),
    Image.asset('images/News5.jpg'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          'Legal News',
          textScaleFactor: 0.9,
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: data.isNotEmpty
        ? ScrollConfiguration(
        behavior: MyBehavior(),
        child: data.length > 0
            ? ListView.builder(
                controller: _controller,
                // itemCount: imageDataList.length,
                itemCount: data.length,
                itemBuilder: (BuildContext context, int index) {
                  // final imageData = imageDataList[index];
                  return Card(
                    elevation: 0,
                    margin: EdgeInsets.all(10),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        side: BorderSide(color: Colors.grey, width: 0.15)),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Ink(
                        height: screenheight(context, dividedby: 3.h),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.all(Radius.circular(10)),
                          image: DecorationImage(
                            // image: AssetImage(
                            //         imageData.imagePath,
                            //       ),
                            image: NetworkImage(data[index]!.photoUrl),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: InkWell(
                          radius: 0,
                          onTap: () async {
                            launch(data[index]!.link);
                            Fluttertoast.showToast(
                                msg: "Launching URL In Browser...",
                                fontSize: 12.sp,
                                backgroundColor: Colors.green);
                            // String url = imageData.imageLinkUrl;
                            // String url = data[index]!.link;
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
                            // launch(data[index]!.link);
                          },
                          // hoverColor: Colors.white,
                          borderRadius:
                              BorderRadius.all(Radius.circular(10)),
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              width: double.infinity,
                              constraints: BoxConstraints(),
                              // margin: EdgeInsets.only(top: 140),
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  color: Color.fromARGB(180, 32, 50, 50),
                                  borderRadius: BorderRadius.only(
                                      bottomRight: Radius.circular(10),
                                      bottomLeft: Radius.circular(10))),
                              child: Text(
                                // imageData.opacityText,
                                data[index]!.title,
                                textAlign: TextAlign.center,
                                textScaleFactor: 1.17,
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
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
      )   : Shimmer.fromColors(
    baseColor: Colors.grey.shade400,
      highlightColor: Colors.grey.shade100,
      child: ScrollConfiguration(
        behavior: MyBehavior(),
        child: ListView.builder(
          controller: _controller,
          itemCount: 15,
          itemBuilder: (_, __) => Padding(
            padding: const EdgeInsets.only(left: 10,right: 10,bottom: 15,top: 10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(10.r),topRight: Radius.circular(10.r)),
                    color: Colors.white,
                  ),
                ),
                ...List.generate(
                  4,
                      (index) => Padding(
                    padding: const EdgeInsets.only(top: 2.5, left: 7.5, right: 7.5),
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

// ========Previous Design============
//Stack(
//                         children: [
//                           Material(
//                             elevation: 0,
//                             shape: RoundedRectangleBorder(),
//                             clipBehavior: Clip.antiAlias,
//                             color: Colors.transparent,
//                             child: Ink(
//                               height: screenheight(context, dividedby: 3.h),
//                               width: double.infinity,
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(10),
//                                 image: DecorationImage(
//                                   image: AssetImage(
//                                     imageData.imagePath,
//                                   ),
//                                   fit: BoxFit.cover,
//                                 ),
//                               ),
//                               child: InkWell(
//                                 onTap: () async{
//                                   String url = imageData.imageLinkUrl;
//                                   var urllaunchable = await canLaunch(
//                                       url); //canLaunch is from url_launcher package
//                                   if (urllaunchable) {
//                                     await launch(
//                                         url); //launch is from url_launcher package to launch URL
//                                   } else {
//                                     Fluttertoast.showToast(
//                                         msg: "URL Launch Error !!!",
//                                         fontSize: 12.sp,
//                                         backgroundColor: Colors.green);
//                                   }
//
//                                   Fluttertoast.showToast(
//                                       msg: "Launching URL In Browser...",
//                                       fontSize: 12.sp,
//                                       backgroundColor: Colors.green);
//                                 },
//                                 // hoverColor: Colors.white,
//                                 borderRadius:
//                                     BorderRadius.all(Radius.circular(10)),
//                                 child: Container(
//                                   margin: EdgeInsets.only(top: 140),
//                                   padding: EdgeInsets.all(10),
//                                   decoration: BoxDecoration(
//                                       color: Color.fromARGB(180, 32, 50, 50),
//                                       borderRadius: BorderRadius.only(
//                                           bottomRight: Radius.circular(10),
//                                           bottomLeft: Radius.circular(10))),
//                                   child: Align(
//                                     alignment: Alignment.topCenter,
//                                     // child: Text("Supreme Court Collegium has recommended appointment of one judicial",
//                                     //   style: TextStyle(fontSize: 15, color: Colors.white),),
//                                     child: Text(
//                                       imageData.opacityText,
//                                       style:
//                                       TextStyle(color: Colors.white),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ),
//                           // InkWell(
//                           //   onTap: () {},
//                           //   hoverColor: Colors.white,
//                           //   borderRadius: BorderRadius.all(Radius.circular(10.r)),
//                           //   child: Image.asset(
//                           //     'images/News1.jpg',
//                           //     height: screenheight(context, dividedby: 3.4.h),
//                           //     width: double.infinity,
//                           //     fit: BoxFit.cover,
//                           //   ),
//                           // ),
//                         ],
//                       ),

//===============Rough Work======================
// Container(
//             //   height: screenheight(context, dividedby: 3.5.h),
//             //   decoration: BoxDecoration(
//             //     color: Colors.white,
//             //     image: DecorationImage(
//             //       fit: BoxFit.cover,
//             //       image:
//             //     ),
//             //   ),
//             //   child: Align(
//             //     alignment: Alignment.bottomCenter,
//             //     child: Container(
//             //       color: Colors.black,
//             //       child: Text(
//             //         'Supreme Court Collegium has recommended appointment of one judicial',
//             //         style: TextStyle(
//             //             color: Colors.white, fontWeight: FontWeight.bold),
//             //       ),
//             //     ),
//             //   ),
//             // ),
