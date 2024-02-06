import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:html/parser.dart';
import 'package:intl/intl.dart';
import 'package:surat_district_bar_association/model/notice_board_model.dart';
import 'package:surat_district_bar_association/widgets/media_query_sizes.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../widgets/drawer.dart';
import 'notice_image_detail_screen.dart';

class NoticeBoardDetailScreen extends StatefulWidget {
  noticeDatum? allData;
  NoticeBoardDetailScreen({
    super.key,
    this.allData,
  });

  @override
  State<NoticeBoardDetailScreen> createState() => _NoticeBoardDetailScreenState();
}

class _NoticeBoardDetailScreenState extends State<NoticeBoardDetailScreen> with SingleTickerProviderStateMixin {
  final ScrollController _controller = ScrollController();

  late final TransformationController Tcontroller;
  TapDownDetails? tapDownDetails;

  // late final AnimationController animationController;
  // Animation<Matrix4>? animation;

  void _launchPdfViewer(String pdfUrl) async {
    // if (await canLaunch(pdfUrl)) {
    //   await launch(mainUrl + widget.allData!.image);
    // } else {
    //   await Fluttertoast.showToast(msg: "Launching URL Failed", fontSize: 12.sp, backgroundColor: Colors.red);
    // }
    launch(mainUrl + widget.allData!.image);
  }

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

  String mainUrl = "https://vakalat-public.s3.ap-southeast-1.amazonaws.com/";

  String _parseHtmlString(String htmlString) {
    final document = parse(htmlString);
    final String parsedString = parse(document.body!.text).documentElement!.text;

    return parsedString;
  }

  @override
  Widget build(BuildContext context) {
    // List<Iterable> fetchedItems = fetchDataByIDs(itemIds).cast<Iterable>();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          'Notice Detail',
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
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  Text(
                    // 'Advertisement and Application form for Panel Advocate',
                    widget.allData!.title,
                    textScaleFactor: 1.30,
                    style: TextStyle(
                        // fontSize: 10.6,
                        fontWeight: FontWeight.w900),
                  ),
                  // Padding(
                  //     padding: EdgeInsets.symmetric(
                  //         vertical: screenheight(context, dividedby: 200.h))),
                  Padding(padding: EdgeInsets.only(top: 10)),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.calendar_month_outlined,
                        size: screenheight(context, dividedby: 25.h),
                        color: Colors.grey.shade600,
                      ),
                      Padding(padding: EdgeInsets.symmetric(horizontal: screenwidth(context, dividedby: 100.w))),
                      Text(
                        // '14/02/2022',
                        // DateUtils.dateOnly(widget.allData!.startDate).toString(),
                        // textScaleFactor: 1.30,
                        DateFormat("dd-MM-yyyy").format(DateTime.parse(widget.allData!.startDate.toString())),
                        style: TextStyle(
                            // fontSize: 12,
                            fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                  // Padding(
                  //     padding: EdgeInsets.symmetric(
                  //         vertical: screenheight(context, dividedby: 200.h))),
                  Padding(padding: EdgeInsets.only(top: 10)),
                  Text(
                    // "શાળામાં બાળકોને વારંવાર ગુજરાત વિશે અંગ્રેજીમાં 10 લીટીઓ લખવાનું કહેવામાં આવે છે. અમે વિદ્યાર્થીઓને તેમનું હોમવર્ક અસરકારક રીતે કરવામાં મદદ કરીએ છીએ. જો તમને આ લેખ ગમ્યો હોય, તો કૃપા કરીને નીચે ટિપ્પણી કરો અને અમને જણાવો કે તમને તે કેવી રીતે ગમ્યો. અમે અમારી સેવાને વધુ બહેતર બનાવવા માટે તમારી ટિપ્પણીઓનો ઉપયોગ કરીએ છીએ. અમે આશા રાખીએ છીએ કે તમે ઉપરોક્ત વિષય પર થોડું શીખ્યા હશે. તમે મારી YouTube ચેનલની મુલાકાત પણ લઈ શકો છો જે https://www.youtube.com/synctechlearn છે." +
                    //     "તમે અમને Facebook https://www.facebook.com/synctechlearn પર પણ ફોલો કરી શકો છો." +
                    //     "શાળામાં બાળકોને વારંવાર ગુજરાત વિશે અંગ્રેજીમાં 10 લીટીઓ લખવાનું કહેવામાં આવે છે. અમે વિદ્યાર્થીઓને તેમનું હોમવર્ક અસરકારક રીતે કરવામાં મદદ કરીએ છીએ. જો તમને આ લેખ ગમ્યો હોય, તો કૃપા કરીને નીચે ટિપ્પણી કરો અને અમને જણાવો કે તમને તે કેવી રીતે ગમ્યો. અમે અમારી સેવાને વધુ બહેતર બનાવવા માટે તમારી ટિપ્પણીઓનો ઉપયોગ કરીએ છીએ. અમે આશા રાખીએ છીએ કે તમે ઉપરોક્ત વિષય પર થોડું શીખ્યા હશે. તમે મારી YouTube ચેનલની મુલાકાત પણ લઈ શકો છો જે https://www.youtube.com/synctechlearn છે." +
                    //     "તમે અમને Facebook https://www.facebook.com/synctechlearn પર પણ ફોલો કરી શકો છો.",
                    _parseHtmlString(
                      widget.allData!.description,
                    ),
                    textScaleFactor: 1,
                    style: TextStyle(
                        // fontSize: 10.6,
                        fontWeight: FontWeight.w500),
                  ),
                  // Padding(
                  //     padding: EdgeInsets.symmetric(
                  //         vertical: screenheight(context, dividedby: 50.h))),
                  Padding(padding: EdgeInsets.only(top: 25)),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'File(s)',
                        style: TextStyle(
                            // fontSize: 10.6,
                            fontWeight: FontWeight.w900),
                      ),
                    ],
                  ),
                  // Padding(
                  //     padding: EdgeInsets.symmetric(
                  //         vertical: screenheight(context, dividedby: 50.h),
                  //         horizontal: screenwidth(context, dividedby: 10.w))),
                  Padding(padding: EdgeInsets.only(top: 25)),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      widget.allData!.image.toLowerCase().endsWith('.pdf')
                          ? Align(
                              alignment: AlignmentDirectional.topStart,
                              child: InkWell(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text('Open PDF Viewer'),
                                        content: Text('Do you want to open the PDF Viewer?'),
                                        actions: [
                                          ElevatedButton(
                                            style: ButtonStyle(
                                              elevation: MaterialStateProperty.all(0),
                                              backgroundColor: MaterialStateProperty.all(Colors.black),
                                            ),
                                            onPressed: () => Navigator.pop(context),
                                            //return false when click on "NO"
                                            child: Text(
                                              'Cancel',
                                            ),
                                          ),
                                          ElevatedButton(
                                            style: ButtonStyle(
                                              elevation: MaterialStateProperty.all(0),
                                              backgroundColor: MaterialStateProperty.all(Colors.black),
                                            ),
                                            onPressed: () {
                                              Navigator.pop(context);
                                              _launchPdfViewer(mainUrl + widget.allData!.image);
                                            },
                                            //return true when click on "Yes"
                                            child: Text('Open PDF'),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                                borderRadius: BorderRadius.circular(20),
                                child: Container(
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      color: Colors.black12,
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(color: Colors.black12)),
                                  height: 50,
                                  child: Center(
                                      child: Text(
                                    "OPEN FILE",
                                    textScaleFactor: 1.2,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
                                  )),
                                ),
                              ),
                            )
                          : CachedNetworkImage(
                              imageUrl: mainUrl + widget.allData!.image,
                              imageBuilder: (context, imageProvider) => Material(
                                elevation: 0,
                                shape: RoundedRectangleBorder(),
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                color: Colors.transparent,
                                child: Container(
                                    height: screenheight(context, dividedby: 3.h),
                                    width: MediaQuery.of(context).size.width / 1.06,
                                    child: InkWell(
                                      onTap: () {},
                                      radius: 0,
                                      borderRadius: BorderRadius.circular(10),
                                      // child:
                                      // GestureDetector(
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
                                            image: NetworkImage(mainUrl + widget.allData!.image),
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                        child: GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) => NoticeImgZoom(
                                                          imageIndex: mainUrl + widget.allData!.image,
                                                        )));
                                          },
                                        ),
                                      ),
                                    )
                                    // Ink(
                                    //   // height: screenheight(context, dividedby: 4.h),
                                    //   // width: screenwidth(context, dividedby: 1.5.w),
                                    //   decoration: BoxDecoration(
                                    //     // boxShadow: [
                                    //     //   BoxShadow(
                                    //     //     color: Colors.white,
                                    //     //     blurRadius: 10.r,
                                    //     //     spreadRadius: 10.r,
                                    //     //   ),
                                    //     // ],
                                    //     borderRadius: BorderRadius.circular(10),
                                    //     image: DecorationImage(
                                    //       image: AssetImage(
                                    //         "images/notice_detail_img.png",
                                    //       ),
                                    //       // image: NetworkImage(
                                    //       //   mainUrl + widget.imageData!.image,
                                    //       // ),
                                    //       fit: BoxFit.fill,
                                    //     ),
                                    //   ),
                                    //   child: InkWell(
                                    //     onTap: () {},
                                    //     // hoverColor: Colors.white,
                                    //     borderRadius:
                                    //         BorderRadius.all(Radius.circular(10)),
                                    //   ),
                                    // ),
                                    ),

                                // Ink.image(
                                //   image: AssetImage('images/notice_detail_img.png'),
                                //   fit: BoxFit.cover,
                                //   height: screenheight(context,dividedby: 4.h),
                                //   width: screenwidth(context,dividedby: 1.5.w),
                                //   child: InkWell(
                                //     onTap: () {},
                                //   ),
                                // ),
                              ),
                              placeholder: (context, url) => SizedBox(
                                  height: screenheight(context, dividedby: 3.h),
                                  width: MediaQuery.of(context).size.width / 1.06,
                                  child: Center(
                                      child: CircularProgressIndicator(
                                    color: Colors.grey,
                                    strokeWidth: 3,
                                  ))),
                              errorWidget: (context, url, error) => Visibility(visible: false, child: Container()),
                            ),
                      // Container(
                      //   height: screenheight(context,dividedby: 4.h),
                      //   width: screenwidth(context,dividedby: 1.5.w),
                      //   child: Image(
                      //     image: AssetImage(
                      //       'images/notice_detail_img.png',
                      //     ),
                      //     fit: BoxFit.cover,
                      //   ),
                      // ),
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

// class DynamicListWidget extends StatefulWidget {
//   @override
//   State<DynamicListWidget> createState() => _DynamicListWidgetState();
// }

// class _DynamicListWidgetState extends State<DynamicListWidget> {
//   List<dynamic> data = [];
//
//   @override
//   Widget build(BuildContext context) {
//     List<data> containers = List.generate(context, (index) {
//       return Container(
//         height: 100,
//         child: Center(
//           child: Text(
//             'Container ${index + 1}',
//             style: TextStyle(color: Colors.white, fontSize: 20),
//           ),
//         ),
//       );
//     });
//
//     return ListView(
//       children: data,
//     );
//   }
// }
