import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';
import 'package:surat_district_bar_association/drawer_details/blog_tile/blog_tile_detail.dart';
import 'package:surat_district_bar_association/model/blog_category_model.dart';
import '../../model/blog_model.dart';
import '../../model/login_model.dart';
import '../../services/all_api_services.dart';
import '../../widgets/drawer.dart';
import '../../widgets/media_query_sizes.dart';
import '../../widgets/sharedpref.dart';

class BlogTileScreen extends StatefulWidget {
  const BlogTileScreen({super.key});

  @override
  State<BlogTileScreen> createState() => _BlogTileScreenState();
}

class _BlogTileScreenState extends State<BlogTileScreen> {
  LoginModel login = loginModelFromJson(SharedPref.get(prefKey: PrefKey.saveUser)!);

  final ScrollController _controller = ScrollController();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController textController = TextEditingController();

  String mainUrl = "https://vakalat-public.s3.ap-southeast-1.amazonaws.com/";

  String dropdownvalue1 = '0';
  String dropdownvalue2 = '';

  List<blogDatum?> data = [];
  get index => null;

  Future<void> fetchDataFromAPI({required String cat_id, String? sub_cat_id}) async {
    Map<String, dynamic> parameter = {
      'cat_id': cat_id,
      // 'sub_cat_id': sub_cat_id,
      // 'city_id': "0",
      'app_user': login.parentId
    };
    if (sub_cat_id != null) {
      parameter['sub_cat_id'] = sub_cat_id;
    }
    await blogData().then((value) {
      setState(() {
        data = value.data;
      });
      // print(value);
    }).onError((error, stackTrace) {
      print(error);
    });
  }

  List<blogCategoryDatum?> category_Data = [];

  Future<void> fetchCategoryDataFromAPI() async {
    await blogCategoryData().then((value) {
      setState(() {
        category_Data = value.data;
      });
      // print(value);
    }).onError((error, stackTrace) {
      print(error);
    });
  }

  List<blogCategoryDatum?> sub_Category_Data = [];

  Future<void> fetchSubCategoryDataFromAPI({
    required key,
  }) async {

    Map<String, dynamic> parameter = {'app_user': login.parentId,
      "search" : key};


    await blogData(parameter: parameter).then((value) {
      setState(() {
        data = value.data;
      });
    }).onError((error, stackTrace) {
      print(error);
    });
  }

  @override
  void initState() {
    super.initState();
    fetchDataFromAPI(
      cat_id: '0',
    );
    fetchCategoryDataFromAPI();
    fetchSubCategoryDataFromAPI(key: "");
  }

  // List of items in our dropdown menu
  var items1 = [
    'Select Category',
    'Burger',
    'Pizza',
    'Donuts',
    'Apple Thick Shake',
  ];

  // List of items in our dropdown menu
  var items2 = [
    'Select Sub Category',
    'Mayonnaise',
    'Pepper',
    'Ketchup',
    'Almonds',
  ];

  bool _validate = false;
  bool _validate1 = false;
  bool _validate2 = false;

  searchButton(BuildContext context) async {
    if (_validate && _validate1 && _validate2 == false) {
      await Future.delayed(const Duration(milliseconds: 1000));
      // Navigator.pushNamed(context, '/homePage');

      Fluttertoast.showToast(
          msg: "Search Complete",
          fontSize: 12.sp,
          backgroundColor: Colors.green);
    }
  }

  _dialogBox() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(builder: (context, setState) {
            return Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15.r))),
              child: ScrollConfiguration(
                behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Container(
                    constraints: BoxConstraints(
                      maxHeight: double.infinity,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Filter',
                              textScaleFactor: 1.35,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                // fontSize: 15.sp
                              ),
                            ),
                            IconButton(
                                constraints: BoxConstraints(),
                                padding: EdgeInsets.zero,
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                tooltip: "Cancel",
                                icon: Icon(
                                  CupertinoIcons.xmark_circle,
                                  size: 25.h,
                                )),
                          ],
                        ),
                        Divider(
                          height: 15.h,
                          color: Colors.black,
                          thickness: 2.w,
                        ),
                        Padding(padding: EdgeInsets.only(top: 15)),
                        Container(
                          height: screenheight(context, dividedby: 20.h),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.shade700,
                                blurRadius: 0.3.r,
                                spreadRadius: 0.8.r,
                              )
                            ],
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(left: 5, right: 5),
                            child: Align(
                              alignment: Alignment.center,
                              child: DropdownButtonFormField<String>(
                                hint: Text(
                                  'Select Category',
                                  style: TextStyle(
                                      // fontSize: 15.sp,
                                      color: Colors.black),
                                ),
                                //
                                icon: Icon(
                                  Icons.arrow_drop_down_sharp,
                                  size: 20.h,
                                  color: Colors.black, // <-- SEE HERE
                                ),
                                decoration: const InputDecoration.collapsed(
                                  // floatingLabelAlignment:
                                  // FloatingLabelAlignment.center,
                                  hintText: 'Select Category',
                                ),
                                // value: 1,
                                style: const TextStyle(color: Colors.black),
                                // value: category_Data.first!.catId,
                                items: category_Data
                                    .map((e) => DropdownMenuItem(
                                        value: e!.catId,
                                        child: Text(e.catName)))
                                    .toList(),
                                onChanged: (value) async {
                                  setState(() {
                                    dropdownvalue1 = value!;
                                    sub_Category_Data.clear();
                                  });
                                  Map<String, dynamic> parameter = {
                                    'cat_id': value,
                                  };
                                  await blogSubCategoryData(parameter: parameter).then((value) {
                                    setState(() {
                                      sub_Category_Data = value.data.cast<blogCategoryDatum?>();
                                    });
                                    // print(value.data);
                                  }).onError((error, stackTrace) {
                                    print(error);
                                  });
                                },

                                // <DropdownMenuItem<int>>[
                                //   // DropdownMenuItem<int>(
                                //   //   value: 1,
                                //   //   child: Text(
                                //   //     "Select Category",
                                //   //     style: TextStyle(
                                //   //         // fontSize: 11.sp,
                                //   //         color: Colors.black),
                                //   //   ),
                                //   // ),
                                //   DropdownMenuItem<int>(
                                //     value: 1,
                                //     child: Text(
                                //       "Burger",
                                //       style: TextStyle(
                                //           // fontSize: 11.sp,
                                //           color: Colors.black),
                                //     ),
                                //   ),
                                //   DropdownMenuItem<int>(
                                //     value: 2,
                                //     child: Text(
                                //       "Pizza",
                                //       style: TextStyle(
                                //           // fontSize: 11.sp,
                                //           color: Colors.black),
                                //     ),
                                //   ),
                                //   DropdownMenuItem<int>(
                                //     value: 3,
                                //     child: Text(
                                //       "Donuts",
                                //       style: TextStyle(
                                //           // fontSize: 11.sp,
                                //           color: Colors.black),
                                //     ),
                                //   ),
                                //   DropdownMenuItem<int>(
                                //     value: 4,
                                //     child: Text(
                                //       "Apple Thick Shake",
                                //       style: TextStyle(
                                //           // fontSize: 11.sp,
                                //           color: Colors.black),
                                //     ),
                                //   ),
                                // ],
                              ),
                            ),
                          ),
                        ),
                        Padding(padding: EdgeInsets.only(top: 15)),
                        sub_Category_Data.isEmpty
                            ? Container(
                          height: screenheight(context, dividedby: 20.h),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.shade500,
                                blurRadius: 1.r,
                                spreadRadius: 0.2.r,
                              )
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 5, right: 5),
                            child: Align(
                                alignment: Alignment.center,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Select Sub Category',
                                      style:
                                      GoogleFonts.nunito(textStyle: TextStyle(color: Colors.grey.shade500)),
                                    ),
                                    Icon(
                                      Icons.arrow_drop_down_sharp,
                                      size: 20.h,
                                      color: Colors.grey.shade500,
                                    ),
                                  ],
                                )
                            ),
                          ),
                        )
                            : Container(
                          height: screenheight(context, dividedby: 20.h),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.shade700,
                                blurRadius: 0.3.r,
                                spreadRadius: 0.8.r,
                              )
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 5, right: 5),
                            child: Align(
                              alignment: Alignment.center,
                              child: DropdownButtonFormField<String>(
                                hint: Text('Select Sub Category',
                                    style: GoogleFonts.nunito(textStyle: TextStyle(color: Colors.black))),
                                icon: Icon(
                                  Icons.arrow_drop_down_sharp,
                                  size: 20.h,
                                  color: Colors.black,
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    dropdownvalue2 = value ?? "0";
                                  });
                                },
                                decoration: const InputDecoration.collapsed(
                                  floatingLabelAlignment: FloatingLabelAlignment.center,
                                  hintText: 'Select Sub Category',
                                ),
                                style: TextStyle(color: Colors.black),
                                // value: sub_Category_Data.first!.catId,
                                items: sub_Category_Data
                                    .map((e) => DropdownMenuItem(value: e!.catId, child: Text(e.catName)))
                                    .toList(),
                              ),
                            ),
                          ),
                        ),
                        // Container(
                        //   height: screenheight(context, dividedby: 20.h),
                        //   width: double.infinity,
                        //   decoration: BoxDecoration(
                        //     color: Colors.white,
                        //     borderRadius:
                        //         BorderRadius.all(Radius.circular(10)),
                        //     boxShadow: [
                        //       BoxShadow(
                        //         color: Colors.grey.shade700,
                        //         blurRadius: 0.3.r,
                        //         spreadRadius: 0.8.r,
                        //       )
                        //     ],
                        //   ),
                        //   child: Padding(
                        //     padding: const EdgeInsets.only(left: 5, right: 5),
                        //     child: Align(
                        //       alignment: Alignment.center,
                        //       child: DropdownButtonFormField<String>(
                        //         hint: Text(
                        //           'Select Sub Category',
                        //           style: TextStyle(
                        //               // fontSize: 15.sp,
                        //               color: Colors.black),
                        //         ),
                        //         //
                        //         icon: Icon(
                        //           Icons.arrow_drop_down_sharp,
                        //           size: 20.h,
                        //           color: Colors.black, // <-- SEE HERE
                        //         ),
                        //
                        //         decoration: const InputDecoration.collapsed(
                        //           // floatingLabelAlignment:
                        //           // FloatingLabelAlignment.center,
                        //           hintText: 'Select Sub Category',
                        //         ),
                        //         // value: 1,
                        //         style: const TextStyle(color: Colors.black),
                        //         // value: sub_Category_Data.first!.catId,
                        //         items: sub_Category_Data
                        //             .map((e) => DropdownMenuItem(
                        //                 value: e!.catId,
                        //                 child: Text(e.catName)))
                        //             .toList(),
                        //         onChanged: (value) async {
                        //           setState(() {
                        //             dropdownvalue1 = value!;
                        //             sub_Category_Data.clear();
                        //           });
                        //
                        //           await blogSubCategoryData().then((value) {
                        //             setState(() {
                        //               sub_Category_Data = 'No Sub Category To Display' as List<blogCategoryDatum?>;
                        //             });
                        //             // print(value.data);
                        //           }).onError((error, stackTrace) {
                        //             print(error);
                        //           });
                        //         },
                        //         // <DropdownMenuItem<int>>[
                        //         //   // DropdownMenuItem<int>(
                        //         //   //   value: 1,
                        //         //   //   child: Text(
                        //         //   //     "Select Sub Category",
                        //         //   //     style: TextStyle(
                        //         //   //         // fontSize: 11.sp,
                        //         //   //         color: Colors.black),
                        //         //   //   ),
                        //         //   // ),
                        //         //   DropdownMenuItem<int>(
                        //         //     value: 1,
                        //         //     child: Text(
                        //         //       "Mayonnaise",
                        //         //       style: TextStyle(
                        //         //           // fontSize: 11.sp,
                        //         //           color: Colors.black),
                        //         //     ),
                        //         //   ),
                        //         //   DropdownMenuItem<int>(
                        //         //     value: 2,
                        //         //     child: Text(
                        //         //       "Pepper",
                        //         //       style: TextStyle(
                        //         //           // fontSize: 11.sp,
                        //         //           color: Colors.black),
                        //         //     ),
                        //         //   ),
                        //         //   DropdownMenuItem<int>(
                        //         //     value: 3,
                        //         //     child: Text(
                        //         //       "Ketchup",
                        //         //       style: TextStyle(
                        //         //           // fontSize: 11.sp,
                        //         //           color: Colors.black),
                        //         //     ),
                        //         //   ),
                        //         //   DropdownMenuItem<int>(
                        //         //     value: 4,
                        //         //     child: Text(
                        //         //       "Almonds",
                        //         //       style: TextStyle(
                        //         //           // fontSize: 11.sp,
                        //         //           color: Colors.black),
                        //         //     ),
                        //         //   ),
                        //         // ],
                        //       ),
                        //     ),
                        //
                        //     /*DropdownButton(
                        //               // Initial Value
                        //               value: dropdownvalue1,
                        //               underline: Container(),
                        //               // Down Arrow Icon
                        //               icon: Padding(
                        //                 padding:
                        //                     const EdgeInsets.only(left: 50),
                        //                 child: const Icon(
                        //                     Icons.arrow_drop_down_sharp),
                        //               ),
                        //
                        //               // Array list of items
                        //               items: items1.map((String items) {
                        //                 return DropdownMenuItem(
                        //                   value: items,
                        //                   child: Text(items),
                        //                 );
                        //               }).toList(),
                        //               // After selecting the desired option,it will
                        //               // change button value to selected value
                        //
                        //               onChanged: (newValue) async {
                        //                 setState(() {
                        //                   dropdownvalue1 = newValue!;
                        //                 });
                        //               },
                        //             ),*/
                        //   ),
                        // ),
                        Padding(padding: EdgeInsets.only(top: 15)),
                        // sub_Category_Data.isEmpty
                        //     ? Container(
                        //         height:
                        //             screenheight(context, dividedby: 20.h),
                        //         width: double.infinity,
                        //         decoration: BoxDecoration(
                        //           color: Colors.white,
                        //           borderRadius:
                        //               BorderRadius.all(Radius.circular(10)),
                        //           boxShadow: [
                        //             BoxShadow(
                        //               color: Colors.grey.shade700,
                        //               blurRadius: 1.r,
                        //               spreadRadius: 0.2.r,
                        //             )
                        //           ],
                        //         ),
                        //         child: Padding(
                        //           padding: const EdgeInsets.only(
                        //               left: 5, right: 5),
                        //           child: Align(
                        //               alignment: Alignment.center,
                        //               child: Row(
                        //                 mainAxisAlignment:
                        //                     MainAxisAlignment.spaceBetween,
                        //                 children: [
                        //                   Text(
                        //                     'Select Sub Category',
                        //                     style: GoogleFonts.nunito(
                        //                         textStyle: TextStyle(
                        //                             color: Colors.black)),
                        //                   ),
                        //                   Icon(
                        //                     Icons.arrow_drop_down_sharp,
                        //                     size: 20.h,
                        //                     color: Colors.black,
                        //                   ),
                        //                 ],
                        //               )),
                        //         ),
                        //       )
                        //     : Container(
                        //         height:
                        //             screenheight(context, dividedby: 20.h),
                        //         width: double.infinity,
                        //         decoration: BoxDecoration(
                        //           color: Colors.white,
                        //           borderRadius:
                        //               BorderRadius.all(Radius.circular(10)),
                        //           boxShadow: [
                        //             BoxShadow(
                        //               color: Colors.grey.shade700,
                        //               blurRadius: 0.3.r,
                        //               spreadRadius: 0.8.r,
                        //             )
                        //           ],
                        //         ),
                        //         child: Padding(
                        //           padding: const EdgeInsets.only(
                        //               left: 5, right: 5),
                        //           child: Align(
                        //             alignment: Alignment.center,
                        //             child: DropdownButtonFormField<String>(
                        //               hint: Text('Select Sub Category',
                        //                   style: GoogleFonts.nunito(
                        //                       textStyle: TextStyle(
                        //                           color: Colors.black))),
                        //               icon: Icon(
                        //                 Icons.arrow_drop_down_sharp,
                        //                 size: 20.h,
                        //                 color: Colors.black,
                        //               ),
                        //               onChanged: (_) => {},
                        //               decoration:
                        //                   const InputDecoration.collapsed(
                        //                 floatingLabelAlignment:
                        //                     FloatingLabelAlignment.center,
                        //                 hintText: 'Select Sub Category',
                        //               ),
                        //               style: TextStyle(color: Colors.black),
                        //               // value: sub_Category_Data.first!.catId,
                        //               items: sub_Category_Data
                        //                   .map((e) => DropdownMenuItem(
                        //                       value: e!.catId,
                        //                       child: Text(e.catName)))
                        //                   .toList(),
                        //             ),
                        //           ),
                        //         ),
                        //       ),
                        // SizedBox(),
                        // _validate2
                        //     ? Padding(
                        //         padding:
                        //             const EdgeInsets.only(top: 5, left: 10),
                        //         child: Row(
                        //           children: [
                        //             Text(
                        //               _validate2
                        //                   ? "Select Sub Category To Filter"
                        //                   : "",
                        //               textScaleFactor: 1,
                        //               style: TextStyle(color: Colors.red),
                        //             ),
                        //           ],
                        //         ),
                        //       )
                        //     : SizedBox(),
                        // Padding(padding: EdgeInsets.only(top: 10)),
                        Text(
                          'Search',
                          textScaleFactor: 1,
                          style: TextStyle(
                              // fontSize: 10.sp,
                              color: Colors.grey.shade700),
                        ),
                        Padding(padding: EdgeInsets.only(top: 10)),
                        Container(
                          height: screenheight(context, dividedby: 20.h),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.shade700,
                                blurRadius: 0.3.r,
                                spreadRadius: 0.8.r,
                              )
                            ],
                          ),
                          child: TextField(
                              textInputAction: TextInputAction.done,
                              cursorColor: Colors.black,
                              // cursorHeight: 22.h,
                              controller: textController,
                              keyboardType: TextInputType.text,
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                // fontSize: 13.sp,
                                color: Colors.black,
                              ),
                              // validator: (String? value) {
                              //   if (value != null && value.isEmpty) {
                              //     return "Enter City";
                              //   }
                              // },
                              decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: screenwidth(context,
                                          dividedby: 25.w)),
                                  prefixIcon: Icon(
                                    CupertinoIcons.search,
                                    color: Colors.grey.shade800,
                                    size: screenheight(context,
                                        dividedby: 30.h),
                                  ),
                                  hintText: "Search Text",
                                  hintStyle: TextStyle(fontSize: 14.sp),
                                  disabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.transparent),
                                      borderRadius:
                                          BorderRadius.circular(5.r)),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.transparent),
                                      borderRadius:
                                          BorderRadius.circular(5.r)),
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.transparent),
                                      borderRadius:
                                          BorderRadius.circular(5.r)),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.transparent),
                                      borderRadius:
                                          BorderRadius.circular(5.r)))),
                        ),
                        Padding(padding: EdgeInsets.only(top: 20)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              height: screenheight(context, dividedby: 20.h),
                              width: screenwidth(context, dividedby: 3.25.w),
                              child: ClipRRect(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.r)),
                                child: ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      fetchDataFromAPI(
                                        cat_id: dropdownvalue1,
                                        sub_cat_id: dropdownvalue2,
                                      );
                                      Navigator.pop(context);
                                    });
                                    FocusScopeNode currentFocus =
                                        FocusScope.of(context);
                                    if (!currentFocus.hasPrimaryFocus) {
                                      currentFocus.unfocus();
                                    }
                                  },
                                  style: ButtonStyle(
                                    elevation: MaterialStateProperty.all(0),
                                    backgroundColor:
                                        MaterialStateProperty.all(
                                            Colors.black),
                                  ),
                                  child: Text(
                                    'SEARCH',
                                    style: TextStyle(
                                      color: Colors.white,
                                      // fontSize: 10.sp
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: screenheight(context, dividedby: 20.h),
                              width: screenwidth(context, dividedby: 3.25.w),
                              child: ClipRRect(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.r)),
                                child: ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      textController.clear();
                                      category_Data.clear();
                                      sub_Category_Data.clear();
                                    });
                                  },
                                  style: ButtonStyle(
                                    elevation: MaterialStateProperty.all(0),
                                    backgroundColor:
                                        MaterialStateProperty.all(
                                            Colors.black),
                                  ),
                                  child: Text(
                                    'CLEAR',
                                    style: TextStyle(
                                      color: Colors.white,
                                      // fontSize: 10.sp
                                    ),
                                  ),
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
            );
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          tooltip: "Back",
          icon: Icon(
            Icons.arrow_back_rounded,
            size: screenheight(context, dividedby: 29.h),
            color: Colors.black,
          ),
        ),
        title: Text("Blog",
          textAlign: TextAlign.center,
          textScaleFactor: 0.9,
          style:
          TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
        // flexibleSpace: SafeArea(
        //   child: Row(
        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //     crossAxisAlignment: CrossAxisAlignment.center,
        //     children: [
        //       IconButton(
        //         onPressed: () {
        //           Navigator.pop(context);
        //           // if (scaffoldKey.currentState!.isDrawerOpen) {
        //           //   scaffoldKey.currentState!.closeDrawer();
        //           // } else {
        //           //   scaffoldKey.currentState!.openDrawer();
        //           // }
        //         },
        //         tooltip: "Back",
        //         icon: Icon(
        //           Icons.arrow_back_rounded,
        //           size: screenheight(context, dividedby: 29.h),
        //           color: Colors.black,
        //         ),
        //       ),
        //       Text(
        //         'Blog',
        //         textAlign: TextAlign.center,
        //         style:
        //             TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        //       ),
        //       IconButton(
        //           onPressed: () {
        //             sub_Category_Data.clear();
        //             setState(() {
        //               _validate = false;
        //               _validate2 = false;
        //             });
        //             _dialogBox();
        //           },
        //           tooltip: "Filter",
        //           icon: Icon(
        //             Icons.filter_list,
        //             size: screenheight(context, dividedby: 29.h),
        //           )),
        //     ],
        //   ),
        // ),
      ),
      body: data.isNotEmpty
          ? ScrollConfiguration(
        behavior: MyBehavior(),
        child: data.length > 0
            ? ListView.builder(
                controller: _controller,
                itemCount: data.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(10),
                    child: Material(
                      elevation: 5,
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(10.r))),
                      child: InkWell(
                        radius: 0,
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      BlogTileDetailScreen(
                                        allData: data[index],
                                      )));
                        },
                        hoverColor: Colors.white,
                        borderRadius:
                            BorderRadius.all(Radius.circular(10.r)),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 10, bottom: 10, left: 10, right: 10),
                          child: Container(
                            constraints: BoxConstraints(
                              maxHeight: double.infinity,
                            ),
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.r)),
                            ),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        // '1. JUVENILE\nDELINQUENCY OR SOCIAL WELFARE ASSOCIATION',
                                        data[index]!.title,
                                        softWrap: true,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                        textScaleFactor: 1,
                                        style: TextStyle(
                                            // fontSize: 10.6,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                    Spacer(),
                                    Text(
                                      // '21/12/2021',
                                      data[index]!.blogDate,
                                      softWrap: true,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                      textScaleFactor: 1,
                                      style: TextStyle(
                                          // fontSize: 10.6,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ],
                                ),
                                // Padding(padding: EdgeInsets.symmetric(vertical: screenheight(context,dividedby: 200.h))),
                                Padding(padding: EdgeInsets.only(top: 10)),
                                // ClipRRect(
                                //     borderRadius: BorderRadius.all(
                                //         Radius.circular(10)),
                                //     child: Image(
                                //       image:
                                //           // AssetImage('images/blogpost.png'),
                                //       NetworkImage(mainUrl + data[index]!.imageUrl),
                                //       height: screenheight(context,
                                //           dividedby: 3.75.h),
                                //       width: double.infinity,
                                //       fit: BoxFit.cover,
                                //     )),
                                CachedNetworkImage(
                                  imageUrl: mainUrl + data[index]!.imageUrl,
                                  imageBuilder: (context, imageProvider) =>
                                      ClipRRect(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                          child: Image(
                                            image:
                                                // AssetImage('images/blogpost.png'),
                                                NetworkImage(mainUrl +
                                                    data[index]!.imageUrl),
                                            height: screenheight(context,
                                                dividedby: 3.75.h),
                                            width: double.infinity,
                                            fit: BoxFit.cover,
                                          )),
                                  placeholder: (context, url) => Center(
                                      child: CircularProgressIndicator(
                                    color: Colors.grey,
                                    strokeWidth: 3,
                                  )),
                                  errorWidget: (context, url, error) =>
                                      Visibility(
                                          visible: false,
                                          child: Container()),
                                ),
                                Padding(padding: EdgeInsets.only(top: 10)),
                                Text(
                                  // "Scanning pages of our favourite Newspaper(s) and giving a brief glance to our mobile phone to keep ourselves abreast with the social media updates is nowadays our indispensable daily repeat. Nearly 150 years on, the story of Khan's ordeal now features in a list of the earliest crimes reported in Delhi, records for which were uploaded on the city police's website last month.",
                                  data[index]!.description,
                                  softWrap: true,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 4,
                                  textScaleFactor: 0.9,
                                  style: TextStyle(
                                      // fontSize: 10.6,
                                      fontWeight: FontWeight.w400),
                                ),
                                Padding(padding: EdgeInsets.only(top: 10)),
                                Row(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.start,
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
                                      data[index]!.authorName,
                                      softWrap: true,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                      textScaleFactor: 1,
                                      style: TextStyle(
                                          // fontSize: 10.6,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    Spacer(),
                                    Icon(
                                      CupertinoIcons.doc_on_clipboard_fill,
                                      color: Colors.grey.shade600,
                                      size: 17,
                                    ),
                                    Text(
                                      // ' Criminal',
                                      " " + data[index]!.catName,
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
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 10, bottom: 10),
                                  child: Divider(
                                    color: Colors.black,
                                    thickness: 1,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Row(
                                    children: [
                                      Icon(
                                        CupertinoIcons.hand_thumbsup,
                                        size: 20,
                                        color: Colors.grey.shade600,
                                      ),
                                      Text(
                                        // ' 0',
                                        " " +
                                            data[index]!
                                                .totalLike
                                                .toString(),
                                        textScaleFactor: 1.17,
                                        style: TextStyle(
                                            // fontSize: 10.6,
                                            fontWeight: FontWeight.w400),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 20),
                                        child: Icon(
                                          CupertinoIcons.hand_thumbsdown,
                                          color: Colors.grey.shade600,
                                          size: 20,
                                        ),
                                      ),
                                      Text(
                                        // ' 0',
                                        " " +
                                            data[index]!
                                                .totalDislike
                                                .toString(),
                                        textScaleFactor: 1.17,
                                        style: TextStyle(
                                            // fontSize: 10.6,
                                            fontWeight: FontWeight.w400),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 20),
                                        child: Icon(
                                          CupertinoIcons
                                              .captions_bubble_fill,
                                          size: 20,
                                          color: Colors.grey.shade600,
                                        ),
                                      ),
                                      Text(
                                        // ' 0',
                                        " " +
                                            data[index]!
                                                .totalComment
                                                .toString(),
                                        textScaleFactor: 1.17,
                                        style: TextStyle(
                                            // fontSize: 10.6,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                })
            : Center(
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
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 20, top: 20, right: 20),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: 30,
                          width: 150,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                                Radius.circular(10.r)),
                            color: Colors.white,
                          ),
                        ),
                        Container(
                          height: 20,
                          width: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                                Radius.circular(10.r)),
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 20),
                    ),
                    Container(
                      height:
                      screenheight(context, dividedby: 3.75.h),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius:
                        BorderRadius.all(Radius.circular(10.r)),
                        color: Colors.white,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10),
                    ),
                    Container(
                      height: 10,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius:
                        BorderRadius.all(Radius.circular(10.r)),
                        color: Colors.white,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 7.5),
                    ),
                    Container(
                      height: 10,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius:
                        BorderRadius.all(Radius.circular(10.r)),
                        color: Colors.white,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 7.5),
                    ),
                    Container(
                      height: 10,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius:
                        BorderRadius.all(Radius.circular(10.r)),
                        color: Colors.white,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 7.5),
                    ),
                    Container(
                      height: 10,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius:
                        BorderRadius.all(Radius.circular(10.r)),
                        color: Colors.white,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10),
                    ),
                    Row(
                      mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: 20,
                          width: 110,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                                Radius.circular(10.r)),
                            color: Colors.white,
                          ),
                        ),
                        Container(
                          height: 20,
                          width: 120,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                                Radius.circular(10.r)),
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding:
                      const EdgeInsets.only(top: 10, bottom: 10),
                      child: Divider(
                        color: Colors.black,
                        thickness: 1,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            height: 25,
                            width: 35,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                  Radius.circular(5.r)),
                              color: Colors.white,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: Container(
                              height: 25,
                              width: 35,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(
                                    Radius.circular(5.r)),
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: Container(
                              height: 25,
                              width: 35,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(
                                    Radius.circular(5.r)),
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      // drawer: MyDrawerWidget(),
    );
  }
}

// =============================Previous Blog Design 1==================================
//GlowingOverscrollIndicator(
//         axisDirection: AxisDirection.down,
//         color: Colors.grey,
//         child: Scrollbar(
//           interactive: true,
//           thickness: 7.5.r,
//           radius: Radius.circular(5.r),
//           child: ListView.builder(
//               itemCount: 5,
//               itemBuilder: (BuildContext context, int index) {
//                 return Padding(
//                   padding: const EdgeInsets.all(10),
//                   child: Material(
//                     elevation: 5,
//                     color: Colors.white,
//                     shape: RoundedRectangleBorder(
//                         borderRadius:
//                         BorderRadius.all(Radius.circular(10.r))),
//                     child: InkWell(
//                       onTap: () {
//                         Navigator.pushNamed(context, '/blogDetail');
//                       },
//                       hoverColor: Colors.white,
//                       borderRadius: BorderRadius.all(Radius.circular(10.r)),
//                       child: Padding(
//                         padding: const EdgeInsets.all(7.5),
//                         child: Container(
//                           height: screenheight(context, dividedby: 2.20.h),
//                           width: double.infinity,
//                           decoration: BoxDecoration(
//                             borderRadius:
//                             BorderRadius.all(Radius.circular(10.r)),
//                           ),
//                           child: Stack(
//                             children: [
//                               Container(
//                                 child: Column(
//                                   children: [
//                                     Row(
//                                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                       crossAxisAlignment: CrossAxisAlignment.start,
//                                       children: [
//                                         Expanded(
//                                           child: Text(
//                                             '1. JUVENILE\nDELINQUENCY OR SOCIETY WELFARE',
//                                             softWrap: true,
//                                             overflow: TextOverflow.ellipsis,
//                                             maxLines: 2,
//                                             textScaleFactor: 1,
//                                             style: TextStyle(
//                                               // fontSize: 10.6,
//                                                 fontWeight: FontWeight.w600),
//                                           ),
//                                         ),
//                                         Padding(
//                                           padding: EdgeInsets.only(left: 75),
//                                           child: Text(
//                                             '21/12/2021',
//                                             softWrap: true,
//                                             overflow: TextOverflow.ellipsis,
//                                             maxLines: 2,
//                                             textScaleFactor: 1,
//                                             style: TextStyle(
//                                               // fontSize: 10.6,
//                                                 fontWeight: FontWeight.w600),
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                     Padding(
//                                       padding: const EdgeInsets.only(top: 5),
//                                       child: Container(
//                                         height: screenheight(context,dividedby: 5.5.h),
//                                           width: screenwidth(context,dividedby: 1.w),
//                                           decoration: BoxDecoration(
//                                             color: Colors.white,
//                                             borderRadius: BorderRadius.all(Radius.circular(10)),
//                                             boxShadow: [
//                                               BoxShadow(
//                                                 color: Colors.grey.shade700,
//                                                 blurRadius: 2.5.r,
//                                                 spreadRadius: 0.5.r,
//                                               )
//                                             ],
//                                           ),
//                                           child: ClipRRect(
//                                               borderRadius: BorderRadius.all(Radius.circular(10)),
//                                               child: Image(image: AssetImage('images/blogpost.png'),fit: BoxFit.cover,))),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               Padding(
//                                 padding: EdgeInsets.only(top: 150,left: 15,right: 15),
//                                 child: Material(
//                                   elevation: 2,
//                                   color: Colors.white,
//                                   shape: RoundedRectangleBorder(
//                                       borderRadius:
//                                       BorderRadius.all(Radius.circular(10.r))),
//                                   child: Container(
//                                     height: screenheight(context,dividedby: 4.h),
//                                     decoration: BoxDecoration(
//                                       color: Colors.white,
//                                       borderRadius:
//                                       BorderRadius.all(Radius.circular(10.r)),
//                                       border: Border.all(
//                                           color: Colors.grey.shade400, width: 0.01),
//                                     ),
//                                     child: Padding(
//                                       padding: const EdgeInsets.all(8),
//                                       child: Column(
//                                         children: [
//                                           Expanded(
//                                             child: Text(
//                                               'Scanning pages of our favourite Newspaper(s) and giving a brief glance to our mobile phone to keep ourselves abreast with the social media updates is nowadays our indispensable daily repeat',
//                                               softWrap: true,
//                                               overflow: TextOverflow.ellipsis,
//                                               maxLines: 4,
//                                               textScaleFactor: 0.9,
//                                               style: TextStyle(
//                                                 // fontSize: 10.6,
//                                                   fontWeight: FontWeight.w600),
//                                             ),
//                                           ),
//                                           Padding(
//                                             padding: const EdgeInsets.only(left: 10),
//                                             child: Row(
//                                               crossAxisAlignment: CrossAxisAlignment.start,
//                                               children: [
//                                                 Text(
//                                                   'By : ',
//                                                   softWrap: true,
//                                                   overflow: TextOverflow.ellipsis,
//                                                   maxLines: 2,
//                                                   textScaleFactor: 1,
//                                                   style: TextStyle(
//                                                     // fontSize: 10.6,
//                                                       fontWeight: FontWeight.w600),
//                                                 ),
//                                                 Text(
//                                                   'Ravi Mathur',
//                                                   softWrap: true,
//                                                   overflow: TextOverflow.ellipsis,
//                                                   maxLines: 2,
//                                                   textScaleFactor: 1,
//                                                   style: TextStyle(
//                                                     // fontSize: 10.6,
//                                                       fontWeight: FontWeight.w400),
//                                                 ),
//                                                 Padding(
//                                                   padding: const EdgeInsets.only(left: 35),
//                                                   child: Icon(Icons.badge_rounded,color: Colors.blue,size: 18,),
//                                                 ),
//                                                 Text(
//                                                   ' Criminal',
//                                                   softWrap: true,
//                                                   overflow: TextOverflow.ellipsis,
//                                                   maxLines: 2,
//                                                   textScaleFactor: 1,
//                                                   style: TextStyle(
//                                                     // fontSize: 10.6,
//                                                       fontWeight: FontWeight.w400),
//                                                 ),
//                                               ],
//                                             ),
//                                           ),
//                                           Divider(color: Colors.black,thickness: 1,),
//                                           Padding(
//                                             padding: const EdgeInsets.only(left: 10),
//                                             child: Row(
//                                               children: [
//                                                 Icon(CupertinoIcons.hand_thumbsup,size: 20,color: Colors.black,),
//                                                 Text(
//                                                   ' 0',
//                                                   textScaleFactor: 1.17,
//                                                   style: TextStyle(
//                                                     // fontSize: 10.6,
//                                                       fontWeight: FontWeight.w400),
//                                                 ),
//                                                 Padding(
//                                                   padding: const EdgeInsets.only(left: 10),
//                                                   child: Icon(CupertinoIcons.hand_thumbsdown,size: 20,color: Colors.black,),
//                                                 ),
//                                                 Text(
//                                                   ' 0',
//                                                   textScaleFactor: 1.17,
//                                                   style: TextStyle(
//                                                     // fontSize: 10.6,
//                                                       fontWeight: FontWeight.w400),
//                                                 ),
//                                                 Padding(
//                                                   padding: const EdgeInsets.only(left: 10),
//                                                   child: Icon(CupertinoIcons.text_bubble_fill,size: 20,color: Colors.black,),
//                                                 ),
//                                                 Text(
//                                                   ' 0',
//                                                   textScaleFactor: 1.17,
//                                                   style: TextStyle(
//                                                     // fontSize: 10.6,
//                                                       fontWeight: FontWeight.w400),
//                                                 ),
//                                               ],
//                                             ),
//                                           )
//                                         ],
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               )
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 );
//               }),
//         ),
//       ),

// =============================Previous Blog Design 2==================================
//Stack(
//                             children: [
//                               Row(
//                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Expanded(
//                                     child: Text(
//                                       '1. JUVENILE\nDELINQUENCY OR SOCIAL WELFARE',
//                                       softWrap: true,
//                                       overflow: TextOverflow.ellipsis,
//                                       maxLines: 2,
//                                       textScaleFactor: 1,
//                                       style: TextStyle(
//                                         // fontSize: 10.6,
//                                           fontWeight: FontWeight.w600),
//                                     ),
//                                   ),
//                                   Spacer(),
//                                   Text(
//                                     '21/12/2021',
//                                     softWrap: true,
//                                     overflow: TextOverflow.ellipsis,
//                                     maxLines: 2,
//                                     textScaleFactor: 1,
//                                     style: TextStyle(
//                                       // fontSize: 10.6,
//                                         fontWeight: FontWeight.w600),
//                                   ),
//                                 ],
//                               ),
//                               Padding(padding: EdgeInsets.only(top: 10)),
//                               Column(
//                                 children: [
//                                   ClipRRect(
//                                       borderRadius: BorderRadius.all(Radius.circular(10)),
//                                       child: Image(image: AssetImage('images/blogpost.png'),fit: BoxFit.cover,)),
//                                   Padding(
//                                     padding: const EdgeInsets.only(top: 10),
//                                     child: Expanded(
//                                       child: Text(
//                                         "Scanning pages of our favourite Newspaper(s) and giving a brief glance to our mobile phone to keep ourselves abreast with the social media updates is nowadays our indispensable daily repeat. Nearly 150 years on, the story of Khan's ordeal now features in a list of the earliest crimes reported in Delhi, records for which were uploaded on the city police's website last month.",
//                                         softWrap: true,
//                                         overflow: TextOverflow.ellipsis,
//                                         maxLines: 4,
//                                         textScaleFactor: 0.9,
//                                         style: TextStyle(
//                                           // fontSize: 10.6,
//                                             fontWeight: FontWeight.w600),
//                                       ),
//                                     ),
//                                   ),
//                                   Padding(
//                                     padding: const EdgeInsets.only(top: 10),
//                                     child: Row(
//                                       crossAxisAlignment: CrossAxisAlignment.start,
//                                       children: [
//                                         Text(
//                                           'By : ',
//                                           softWrap: true,
//                                           overflow: TextOverflow.ellipsis,
//                                           maxLines: 2,
//                                           textScaleFactor: 1,
//                                           style: TextStyle(
//                                             // fontSize: 10.6,
//                                               fontWeight: FontWeight.w600),
//                                         ),
//                                         Text(
//                                           'Ravi Mathur',
//                                           softWrap: true,
//                                           overflow: TextOverflow.ellipsis,
//                                           maxLines: 2,
//                                           textScaleFactor: 1,
//                                           style: TextStyle(
//                                             // fontSize: 10.6,
//                                               fontWeight: FontWeight.w400),
//                                         ),
//                                         Padding(
//                                           padding: const EdgeInsets.only(left: 35),
//                                           child: Icon(Icons.badge_rounded,color: Colors.blue,size: 18,),
//                                         ),
//                                         Text(
//                                           ' Criminal',
//                                           softWrap: true,
//                                           overflow: TextOverflow.ellipsis,
//                                           maxLines: 2,
//                                           textScaleFactor: 1,
//                                           style: TextStyle(
//                                             // fontSize: 10.6,
//                                               fontWeight: FontWeight.w400),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                   Padding(
//                                     padding: const EdgeInsets.only(top: 10),
//                                     child: Divider(color: Colors.black,thickness: 1,),
//                                   ),
//                                   Padding(
//                                     padding: const EdgeInsets.only(left: 10,top: 10),
//                                     child: Row(
//                                       children: [
//                                         Icon(CupertinoIcons.hand_thumbsup,size: 20,color: Colors.black,),
//                                         Text(
//                                           ' 0',
//                                           textScaleFactor: 1.17,
//                                           style: TextStyle(
//                                             // fontSize: 10.6,
//                                               fontWeight: FontWeight.w400),
//                                         ),
//                                         Padding(
//                                           padding: const EdgeInsets.only(left: 10),
//                                           child: Icon(CupertinoIcons.hand_thumbsdown,size: 20,color: Colors.black,),
//                                         ),
//                                         Text(
//                                           ' 0',
//                                           textScaleFactor: 1.17,
//                                           style: TextStyle(
//                                             // fontSize: 10.6,
//                                               fontWeight: FontWeight.w400),
//                                         ),
//                                         Padding(
//                                           padding: const EdgeInsets.only(left: 10),
//                                           child: Icon(CupertinoIcons.text_bubble_fill,size: 20,color: Colors.black,),
//                                         ),
//                                         Text(
//                                           ' 0',
//                                           textScaleFactor: 1.17,
//                                           style: TextStyle(
//                                             // fontSize: 10.6,
//                                               fontWeight: FontWeight.w400),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ],
//                           ),
