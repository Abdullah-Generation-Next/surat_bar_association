import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';
import 'package:surat_district_bar_association/drawer_details/search/search_tile_detail.dart';
import 'package:surat_district_bar_association/model/search_model.dart';
import 'package:surat_district_bar_association/model/search_sub_category_model.dart';
import 'package:surat_district_bar_association/services/AppConfig.dart';
import 'package:surat_district_bar_association/services/all_api_services.dart';
import '../../model/login_model.dart';
import '../../model/search_category_model.dart';
import '../../model/user_about_model.dart';
import '../../widgets/media_query_sizes.dart';
import '../../widgets/sharedpref.dart';
import 'dart:collection';

class SearchTileScreen extends StatefulWidget {
  const SearchTileScreen({super.key});

  @override
  State<SearchTileScreen> createState() => _SearchTileScreenState();
}

class _SearchTileScreenState extends State<SearchTileScreen> {
  LoginModel login = loginModelFromJson(SharedPref.get(prefKey: PrefKey.saveUser)!);

  final ScrollController _controller = ScrollController();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController textController = TextEditingController();
  TextEditingController searchController = TextEditingController();

  bool fetchingData = false;

  String mainUrl = "https://vakalat-public.s3.ap-southeast-1.amazonaws.com/";

  List<UserAboutDatum?> LawyerData = [];

  Future<void> fetchLawyerData(userId, parentId, searchData) async {
    setState(() {
      showLawyer = true;
    });
    Map<String, dynamic> parameter = {
      "user_id": userId,
      "app_user": parentId,
    };
    await userAboutData(parameter: parameter).then((value) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SearchDetailScreen(
            allUserData: LawyerData = value.data,
            searchData: searchData,
          ),
        ),
      );
      setState(() {
        LawyerData = value.data;
      });
      setState(() {
        showLawyer = false;
      });
    }).onError((error, stackTrace) {
      print(error);
    });
  }

  String dropdownvalue1 = '0';
  String dropdownvalue2 = '';
  String dropDownHint2 = "Select Sub Category";

  // Future<void> fetchLawyerData(userId, parentId, searchDatum userData) async {
  //   setState(() {
  //     showLawyer = true;
  //   });
  //
  //   Map<String, dynamic> parameter = {
  //     "user_id": userId,
  //     "app_user": parentId,
  //   };
  //
  //   try {
  //     final value = await userAboutData(parameter: parameter);
  //
  //     // Ensure that the API response contains data and is not null
  //     if (value.data != null && value.data!.isNotEmpty) {
  //       Navigator.push(
  //         context,
  //         MaterialPageRoute(
  //           builder: (context) => SearchDetailScreen(
  //             allData: value.data!,
  //             selectedUserData: userData,
  //           ),
  //         ),
  //       );
  //     } else {
  //       print("No data received from the API");
  //       // Handle the case where no data is received
  //       // You might want to show an error message or handle it appropriately
  //     }
  //   } catch (error) {
  //     print("Error fetching user data: $error");
  //     // Handle the error, show an error message, or log it
  //   } finally {
  //     setState(() {
  //       showLawyer = false;
  //     });
  //   }
  // }

  // Future<void> fetchUserDataFromAPI(id) async {
  //   setState(() {
  //     show = true;
  //   });
  //   Map<String, dynamic> parameter = {
  //     "user_id": id,
  //   };
  //   await userData(parameter: parameter).then((value) {
  //     Navigator.push(
  //         context,
  //         MaterialPageRoute(
  //             builder: (Context) => SearchDetailScreen(
  //               userData: value,
  //             )));
  //     setState(() {
  //       show = false;
  //     });
  //     print(value);
  //   }).onError((error, stackTrace) {
  //     print(error);
  //   });
  // }

  List<searchDatum?> data = [];
  List<searchDatum?> searchResults = [];
  bool show = false;
  bool showLawyer = false;

  // Future<void> fetchDataFromAPI({
  //   required String cat_id,
  //   String? sub_cat_id,
  //   String? searchKeyword,
  // }) async {
  //   setState(() {
  //     show = false;
  //   });
  //   Map<String, dynamic> parameter = {
  //     'cat_id': cat_id,
  //     // 'sub_cat_id': sub_cat_id,
  //     // 'city_id': "0",
  //     'app_user': login.parentId
  //   };
  //   if (sub_cat_id != null) {
  //     parameter['sub_cat_id'] = sub_cat_id;
  //   }
  //
  //   if (searchKeyword != null && searchKeyword.isNotEmpty) {
  //     parameter['search_keyword'] = searchKeyword; // Add search keyword to parameters
  //   }
  //   // if (sub_cat_id != null) {
  //   //   parameter['city_id'] = sub_cat_id;
  //   // }
  //   // await searchData(parameter: parameter).then((value) {
  //   //   setState(() {
  //   //     show = true;
  //   //     // data = value.data;
  //   //     // Update data based on whether there is a search keyword
  //   //     if (searchKeyword != null && searchKeyword.isNotEmpty) {
  //   //       // If there is a search keyword, filter the data using contains
  //   //       data = value.data
  //   //           .where((item) =>
  //   //       item != null &&
  //   //           (item.firstName.toLowerCase().contains(searchKeyword.toLowerCase())) ||
  //   //           (item?.middleName.toLowerCase().contains(searchKeyword.toLowerCase()) ?? false) ||
  //   //           (item?.lastName.toLowerCase().contains(searchKeyword.toLowerCase()) ?? false))
  //   //           .toList();
  //   //     } else {
  //   //       // If there is no search keyword, use the full data
  //   //       data = value.data;
  //   //     }
  //   //   });
  //   //   // print(value);
  //   // }).onError((error, stackTrace) {
  //   //   print(error);
  //   // });
  //   try {
  //     // Make the API call
  //     final value = await searchData(parameter: parameter);
  //
  //     setState(() {
  //       show = true;
  //       // Update data based on whether there is a search keyword
  //       if (searchKeyword != null && searchKeyword.isNotEmpty) {
  //         data = value.data
  //             .where((item) {
  //           if (item == null) return false;
  //
  //           bool matchesFirstName = item.firstName.toLowerCase().contains(searchKeyword.toLowerCase());
  //           bool matchesMiddleName = item.middleName.toLowerCase().contains(searchKeyword.toLowerCase());
  //           bool matchesLastName = item.lastName.toLowerCase().contains(searchKeyword.toLowerCase());
  //
  //           return matchesFirstName || matchesMiddleName || matchesLastName;
  //         })
  //             .toList();
  //         // data = value.data
  //         //     .where((item) =>
  //         // item != null &&
  //         //     (item.firstName.toLowerCase().contains(searchKeyword.toLowerCase())) ||
  //         //     (item?.middleName.toLowerCase().contains(searchKeyword.toLowerCase()) ?? false) ||
  //         //     (item?.lastName.toLowerCase().contains(searchKeyword.toLowerCase()) ?? false))
  //         //     .toList();
  //       } else {
  //         data = value.data;
  //       }
  //     });
  //   } catch (error) {
  //     print(error);
  //   } finally {
  //     setState(() {
  //       fetchingData = false;
  //     });
  //   }
  // }

  Future<void> fetchDataFromAPI({
    required String cat_id,
    String? sub_cat_id,
    String? searchKeyword,
  }) async {
    setState(() {
      show = false;
    });
    Map<String, dynamic> parameter = {
      'cat_id': cat_id,
      // 'sub_cat_id': sub_cat_id,
      // 'city_id': "0",
      'app_user': login.parentId
    };
    if (sub_cat_id != null) {
      parameter['sub_cat_id'] = sub_cat_id;
    }

    if (searchKeyword != null && searchKeyword.isNotEmpty) {
      parameter['search_keyword'] = searchKeyword; // Add search keyword to parameters
    }
    // if (sub_cat_id != null) {
    //   parameter['city_id'] = sub_cat_id;
    // }
    await searchData(parameter: parameter).then((value) {
      setState(() {
        data = value.data;
        // data.sort((a, b) => a!.fullName.compareTo(b!.fullName));

        // data.sort((a, b) {
        //   // Compare by firstName
        //   var firstNameComparison = a!.firstName.compareTo(b!.firstName);
        //   if (firstNameComparison != 0) {
        //     return firstNameComparison;
        //   }
        //
        //   // Compare by middleName
        //   var middleNameComparison = a.middleName.compareTo(b.middleName);
        //   if (middleNameComparison != 0) {
        //     return middleNameComparison;
        //   }
        //
        //   // Compare by lastName
        //   var lastNameComparison = a.lastName.compareTo(b.lastName);
        //   if (lastNameComparison != 0) {
        //     return lastNameComparison;
        //   }
        //
        //   // Compare by fullName
        //   return a.fullName.compareTo(b.fullName);
        // });

        // data.sort((a, b) {
        //   // Extract first names
        //   var firstNameA = a!.fullName.split(' ')[0];
        //   var firstNameB = b!.fullName.split(' ')[0];
        //
        //   // Compare by first name
        //   return firstNameA.compareTo(firstNameB);
        // });

        // Filter and sort by first name or last name match
        // data.sort((a, b) {
        //   // Extract names
        //   var namesA = a!.fullName.split(' ');
        //   var namesB = b!.fullName.split(' ');
        //
        //   // Compare by first name or last name match
        //   var matchA = namesA[0] == parameter || namesA.length > 1 && namesA[1] == parameter;
        //   var matchB = namesB[0] == parameter || namesB.length > 1 && namesB[1] == parameter;
        //
        //   if (matchA && !matchB) {
        //     return -1;
        //   } else if (!matchA && matchB) {
        //     return 1;
        //   } else {
        //     // If both have the match or no match, compare by full name
        //     return a.fullName.compareTo(b.fullName);
        //   }
        // });

        // Filter and sort by first name or last name match
        // data.sort((a, b) {
        //   // Extract names
        //   var namesA = a!.fullName.split(' ');
        //   var namesB = b!.fullName.split(' ');
        //
        //   // Compare by first name or last name match
        //   var matchA = namesA[0] == parameter || namesA.length > 1 && namesA[1] == parameter;
        //   var matchB = namesB[0] == parameter || namesB.length > 1 && namesB[1] == parameter;
        //
        //   if (matchA && !matchB) {
        //     return -1;
        //   } else if (!matchA && matchB) {
        //     return 1;
        //   } else {
        //     // If both have the match or no match, compare by full name (case-insensitive)
        //     return a.fullName.toLowerCase().compareTo(b.fullName.toLowerCase());
        //   }
        // });

        // Sort by first name
        // data.sort((a, b) {
        //   // Extract first names
        //   var firstNameA = a!.fullName.split(' ')[0];
        //   var firstNameB = b!.fullName.split(' ')[0];
        //
        //   // Compare by first name
        //   return firstNameA.compareTo(firstNameB);
        // });

        // // Sort by first name
        // data.sort((a, b) {
        //   // Extract first names
        //   var firstNameA = a!.fullName.split(' ')[0];
        //   var firstNameB = b!.fullName.split(' ')[0];
        //
        //   // Compare by first name
        //   if (firstNameA == firstNameB) {
        //     // If first names are the same, compare by the full name
        //     return a.fullName.compareTo(b.fullName);
        //   } else {
        //     return firstNameA.compareTo(firstNameB);
        //   }
        // });

        // Sort by first name
        // data.sort((a, b) {
        //   // Extract first names
        //   var firstNameA = a!.firstName.split(' ')[0].trim();
        //   var firstNameB = b!.firstName.split(' ')[0].trim();
        //
        //   // Compare by first name
        //   return firstNameA.compareTo(firstNameB);
        // });

        data.sort((a, b) {
          // Define a custom comparison function to trim leading spaces
          int compareFirstNames(String nameA, String nameB) {
            return nameA.trim().compareTo(nameB.trim());
          }

          // Extract first names and compare using the custom function
          var firstNameA = a!.fullName.split(' ')[0];
          var firstNameB = b!.fullName.split(' ')[0];

          return compareFirstNames(firstNameA, firstNameB);
        });

        show = true;
      });
      // print(value);
    }).onError((error, stackTrace) {
      print(error);
    });
  }

  // Future<void> fetchDataFromAPI({
  //   required String cat_id,
  //   String? sub_cat_id,
  //   String? searchKeyword,
  // }) async {
  //   setState(() {
  //     show = false;
  //   });
  //   Map<String, dynamic> parameter = {
  //     'cat_id': cat_id,
  //     'app_user': login.parentId,
  //   };
  //
  //   if (sub_cat_id != null) {
  //     parameter['sub_cat_id'] = sub_cat_id;
  //   }
  //
  //   if (searchKeyword != null && searchKeyword.isNotEmpty) {
  //     parameter['search_keyword'] = searchKeyword;
  //   }
  //
  //   await searchData(parameter: parameter).then((value) {
  //     setState(() {
  //       show = true;
  //       // Update data based on whether there is a search keyword
  //       if (searchKeyword != null && searchKeyword.isNotEmpty) {
  //         // If there is a search keyword, filter the data using contains
  //         searchResults = value.data
  //             .where((item) =>
  //         item != null &&
  //             (item.firstName.toLowerCase().contains(searchKeyword.toLowerCase()) ||
  //                 (item.middleName.toLowerCase().contains(searchKeyword.toLowerCase())) ||
  //                 (item.lastName.toLowerCase().contains(searchKeyword.toLowerCase()))))
  //             .toList();
  //       } else {
  //         // If there is no search keyword, use the full data
  //         searchResults = value.data;
  //       }
  //     });
  //   }).onError((error, stackTrace) {
  //     print(error);
  //   });
  // }

  List<searchCategoryDatum?> category_Data = [];

  Future<void> fetchCategoryDataFromAPI() async {
    await searchCategoryData().then((value) {
      setState(() {
        category_Data = value.data;
      });
    }).onError((error, stackTrace) {
      print(error);
    });
  }

  List<searchSubCategoryDatum?> sub_Category_Data = [];
  // bool show = false;
  //   Future<void> fetchSubCategoryDataFromAPI(cat_id) async {
  //     setState(() {
  //       show = false;
  //     });
  //     sub_Category_Data.clear();
  //
  //   }

  // Future<void> fetchSubCategoryDataFromAPI({
  //   required key,
  // }) async {
  //   Map<String, dynamic> parameter = {'app_user': login.parentId, "search": key};
  //
  //   await searchData(parameter: parameter).then((value) {
  //     setState(() {
  //       data = value.data;
  //       data.sort((a, b) => a!.fullName.compareTo(b!.fullName));
  //       show = true;
  //
  //
  //     });
  //   }).onError((error, stackTrace) {
  //     print(error);
  //   });
  // }

  @override
  void initState() {
    super.initState();
    fetchDataFromAPI(
      cat_id: '0',
    );
    fetchCategoryDataFromAPI();
    // fetchSubCategoryDataFromAPI(key: "");
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  // List of items in our dropdown menu
  var items1 = [
    'Burger',
    'Pizza',
    'Donuts',
    'Apple Thick Shake',
  ];

  // List of items in our dropdown menu
  var items2 = [
    'Mayonnaise',
    'Pepper',
    'Ketchup',
    'Almonds',
  ];

  bool _validate = false;
  bool _validate1 = false;
  bool _validate2 = false;

  submitButton(BuildContext context) async {
    if (_validate && _validate1 && _validate2 == false) {
      // await Future.delayed(const Duration(milliseconds: 1000));

      data.clear();

      Fluttertoast.showToast(msg: "Filter Done", fontSize: 12.sp, backgroundColor: Colors.green);
    }
  }

  _dialogBox() {
    showDialog(
        // barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(builder: (context, setState) {
            return Dialog(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15.r))),
              child: SingleChildScrollView(
                controller: _controller,
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
                                // value: category_Data,
                                hint: Text(
                                  'Select Category',
                                  style: GoogleFonts.nunito(textStyle: TextStyle(color: Colors.black)),
                                ),
                                icon: Icon(
                                  Icons.arrow_drop_down_sharp,
                                  size: 20.h,
                                  color: Colors.black,
                                ),
                                decoration: const InputDecoration.collapsed(
                                  hintText: 'Select Category',
                                ),
                                style: const TextStyle(color: Colors.black),
                                items: category_Data
                                    .map((e) => DropdownMenuItem(value: e!.catId, child: Text(e.catName)))
                                    .toList(),
                                onChanged: (value) async {
                                  setState(() {
                                    dropdownvalue1 = value!;
                                    sub_Category_Data.clear();
                                  });

                                  Map<String, dynamic> parameter = {
                                    'cat_id': value,
                                  };
                                  await searchSubCategoryData(parameter: parameter).then((value) {
                                    setState(() {
                                      sub_Category_Data = value.data;
                                    });
                                    // print(value.data);
                                  }).onError((error, stackTrace) {
                                    print(error);
                                  });
                                },
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
                                      // DropdownButtonFormField<String>(
                                      //   hint: Text(
                                      //     'Select Sub Category',
                                      //     style: GoogleFonts.nunito(
                                      //         textStyle: TextStyle(
                                      //             color: Colors.black)),
                                      //   ),
                                      //   icon: Icon(
                                      //     Icons.arrow_drop_down_sharp,
                                      //     size: 20.h,
                                      //     color: Colors.black,
                                      //   ),
                                      //   onChanged: (_) {},
                                      //   decoration:
                                      //       const InputDecoration.collapsed(
                                      //     floatingLabelAlignment:
                                      //         FloatingLabelAlignment.center,
                                      //     hintText: 'Select Sub Category',
                                      //   ),
                                      //   style: const TextStyle(
                                      //       color: Colors.black),
                                      //   // value: sub_Category_Data.first!.catId,
                                      //   items: null,
                                      // ),
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
                        Padding(padding: EdgeInsets.only(top: 10)),
                        Text(
                          'City',
                          textScaleFactor: 1,
                          style: TextStyle(color: Colors.grey.shade700),
                        ),
                        Padding(padding: EdgeInsets.only(top: 10)),
                        Container(
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
                          child: TextFormField(
                              textInputAction: TextInputAction.done,
                              cursorColor: Colors.black,
                              // cursorHeight: 22.h,
                              controller: textController,
                              keyboardType: TextInputType.text,
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                fontSize: MediaQuery.of(context).textScaleFactor * 12,
                                color: Colors.black,
                              ),
                              // validator: (String? value) {
                              //   if (value != null && value.isEmpty) {
                              //     return "Enter City";
                              //   }
                              // },
                              decoration: InputDecoration(
                                  contentPadding:
                                      EdgeInsets.symmetric(horizontal: screenwidth(context, dividedby: 25.w)),
                                  prefixIcon: Icon(
                                    CupertinoIcons.search,
                                    color: Colors.grey.shade800,
                                    size: screenheight(context, dividedby: 30.h),
                                  ),
                                  hintText: "Enter City",
                                  hintStyle: TextStyle(
                                    fontSize: MediaQuery.of(context).textScaleFactor * 12,
                                  ),
                                  disabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.transparent),
                                      borderRadius: BorderRadius.circular(5.r)),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.transparent),
                                      borderRadius: BorderRadius.circular(5.r)),
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.transparent),
                                      borderRadius: BorderRadius.circular(5.r)),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.transparent),
                                      borderRadius: BorderRadius.circular(5.r)))),
                        ),
                        // _validate
                        //     ? Padding(
                        //   padding: const EdgeInsets.only(top: 5, left: 10),
                        //   child: Row(
                        //     children: [
                        //       Text(
                        //         _validate ? "Enter City To Filter" : "",
                        //         textScaleFactor: 1,
                        //         style: TextStyle(color: Colors.red),
                        //       ),
                        //     ],
                        //   ),
                        // )
                        //     : SizedBox(),
                        Padding(padding: EdgeInsets.only(top: 20)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              height: screenheight(context, dividedby: 20.h),
                              width: screenwidth(context, dividedby: 3.10.w),
                              child: ClipRRect(
                                borderRadius: BorderRadius.all(Radius.circular(10.r)),
                                child: ElevatedButton(
                                  onPressed: () {
                                    // setState(() {
                                    //   // textController.text.isEmpty
                                    //   //     ? _validate = true
                                    //   //     : _validate = false;
                                    //   sub_Category_Data.isEmpty
                                    //       ? _validate2 = true
                                    //       : _validate2 = false;
                                    // });
                                    // FocusScopeNode currentFocus =
                                    //     FocusScope.of(context);
                                    // if (!currentFocus.hasPrimaryFocus) {
                                    //   currentFocus.unfocus();
                                    // }
                                    fetchDataFromAPI(
                                      cat_id: dropdownvalue1,
                                      sub_cat_id: dropdownvalue2,
                                    );
                                    Navigator.pop(context);
                                    // submitButton(context);
                                    // if(_validate2 == false) {
                                    //   Navigator.pop(context);
                                    // }
                                  },
                                  style: ButtonStyle(
                                    elevation: MaterialStateProperty.all(0),
                                    backgroundColor: MaterialStateProperty.all(Colors.black),
                                  ),
                                  child: Text(
                                    'SUBMIT',
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
                              width: screenwidth(context, dividedby: 3.10.w),
                              child: ClipRRect(
                                borderRadius: BorderRadius.all(Radius.circular(10.r)),
                                child: ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      textController.clear();
                                      sub_Category_Data.clear();
                                      category_Data.clear();
                                    });
                                  },
                                  style: ButtonStyle(
                                    elevation: MaterialStateProperty.all(0),
                                    backgroundColor: MaterialStateProperty.all(Colors.black),
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

  // void filterData(String query) {
  //   searchResults.clear();
  //   setState(() {
  //     searchResults = data
  //         .where((item) {
  //       if (item?.fullName == null) return false;
  //
  //       var fullName = item!.fullName.toLowerCase();
  //       var firstName = item.firstName.toLowerCase();
  //       var middleName = item.middleName.toLowerCase();
  //       var lastName = item.lastName.toLowerCase();
  //
  //       return fullName.contains(query.toLowerCase()) ||
  //           (firstName.contains(query.toLowerCase()) &&
  //               middleName.contains(query.toLowerCase())) ||
  //           (firstName.contains(query.toLowerCase()) &&
  //               lastName.contains(query.toLowerCase())) ||
  //           (middleName.contains(query.toLowerCase()) &&
  //               lastName.contains(query.toLowerCase())) ||
  //           (middleName.contains(query.toLowerCase()) &&
  //               firstName.contains(query.toLowerCase())) ||
  //           (lastName.contains(query.toLowerCase()) &&
  //               middleName.contains(query.toLowerCase())) ||
  //           (lastName.contains(query.toLowerCase()) &&
  //               firstName.contains(query.toLowerCase()));
  //     })
  //         .toList();
  //
  //     // Sort the search results by first name
  //     searchResults.sort((a, b) {
  //       int compareFirstNames(String nameA, String nameB) {
  //         return nameA.trim().compareTo(nameB.trim());
  //       }
  //
  //       var firstNameA = a!.fullName.split(' ')[0];
  //       var firstNameB = b!.fullName.split(' ')[0];
  //
  //       return compareFirstNames(firstNameA, firstNameB);
  //       // return firstNameA.compareTo(firstNameB);
  //     });
  //   });
  // }

  // void filterData(String query) {
  //   searchResults.clear();
  //   setState(() {
  //     searchResults = data
  //         .where((item) {
  //       if (item?.fullName == null) return false;
  //
  //       var fullName = item!.fullName.toLowerCase();
  //       var firstName = item.firstName.toLowerCase();
  //       var middleName = item.middleName.toLowerCase();
  //       var lastName = item.lastName.toLowerCase();
  //
  //       return firstName.contains(query.toLowerCase()) ||
  //           middleName.contains(query.toLowerCase()) ||
  //           lastName.contains(query.toLowerCase());
  //     })
  //         .toList();
  //
  //     // Sort the search results by first name
  //     searchResults.sort((a, b) {
  //       int compareFirstNames(String nameA, String nameB) {
  //         return nameA.trim().compareTo(nameB.trim());
  //       }
  //
  //       var firstNameA = a!.fullName.split(' ')[0];
  //       var firstNameB = b!.fullName.split(' ')[0];
  //
  //       return compareFirstNames(firstNameA, firstNameB);
  //     });
  //   });
  // }

  // void filterData(String query) {
  //   searchResults.clear();
  //   setState(() {
  //     searchResults = data
  //         .where((item) {
  //       if (item?.firstName == null) return false;
  //
  //       var fullName = item!.fullName.toLowerCase();
  //       var firstName = item.firstName.toLowerCase();
  //       var middleName = item.middleName.toLowerCase();
  //       var lastName = item.lastName.toLowerCase();
  //
  //       return fullName.contains(query.toLowerCase()) ||
  //           (firstName.contains(query.toLowerCase()) &&
  //               middleName.contains(query.toLowerCase())) ||
  //           (firstName.contains(query.toLowerCase()) &&
  //               lastName.contains(query.toLowerCase())) ||
  //           (middleName.contains(query.toLowerCase()) &&
  //               lastName.contains(query.toLowerCase())) ||
  //           (middleName.contains(query.toLowerCase()) &&
  //               firstName.contains(query.toLowerCase())) ||
  //           (lastName.contains(query.toLowerCase()) &&
  //               middleName.contains(query.toLowerCase())) ||
  //           (lastName.contains(query.toLowerCase()) &&
  //               firstName.contains(query.toLowerCase())) ||
  //           (firstName.contains(query.toLowerCase()) &&
  //               middleName.contains(query.toLowerCase()) &&
  //               lastName.contains(query.toLowerCase())) ||
  //           (firstName.contains(query.toLowerCase()) &&
  //               lastName.contains(query.toLowerCase()) &&
  //               middleName.contains(query.toLowerCase())) ||
  //           (middleName.contains(query.toLowerCase()) &&
  //               firstName.contains(query.toLowerCase()) &&
  //               lastName.contains(query.toLowerCase())) ||
  //           (middleName.contains(query.toLowerCase()) &&
  //               lastName.contains(query.toLowerCase()) &&
  //               firstName.contains(query.toLowerCase())) ||
  //           (lastName.contains(query.toLowerCase()) &&
  //               middleName.contains(query.toLowerCase()) &&
  //               firstName.contains(query.toLowerCase())) ||
  //           (lastName.contains(query.toLowerCase()) &&
  //               firstName.contains(query.toLowerCase()) &&
  //               middleName.contains(query.toLowerCase())) ||
  //           (fullName.contains(query.toLowerCase()));
  //     })
  //         .toList();
  //
  //     // Sort the search results by first name
  //     searchResults.sort((a, b) {
  //       int compareFirstNames(String nameA, String nameB) {
  //         return nameA.trim().compareTo(nameB.trim());
  //       }
  //
  //       var firstNameA = a!.firstName.split(' ')[0];
  //       var firstNameB = b!.firstName.split(' ')[0];
  //
  //       return compareFirstNames(firstNameA, firstNameB);
  //     });
  //   });
  // }

  // void filterData(String query) {
  //   searchResults.clear();
  //   setState(() {
  //
  //     searchResults = data.where((element) =>
  //                                     element?.fullName.toLowerCase().contains(query) == true ||
  //                                     element?.firstName.toLowerCase().contains(query) == true ||
  //                                     element?.middleName.toLowerCase().contains(query) == true ||
  //                                     element?.lastName.toLowerCase().contains(query) == true
  //                                 ).toList();
  //
  //     searchResults.sort((a,b) => a!.firstName.toLowerCase().compareTo(b!.firstName.toLowerCase()));
  //
  //     print (searchResults);
  //
  //     // Sort the search results by first name
  //     // searchResults.sort((a, b) {
  //     //   int compareFirstNames(String nameA, String nameB) {
  //     //     return nameA.trim().compareTo(nameB.trim());
  //     //   }
  //     //
  //     //   var firstNameA = a!.firstName.split(' ')[0];
  //     //   var firstNameB = b!.firstName.split(' ')[0];
  //     //
  //     //   return compareFirstNames(firstNameA, firstNameB);
  //     // });
  //   });
  // }

  void filterData(String query) {
    searchResults.clear();
    setState(() {
      searchResults = data
          .where((item) {
        if (item?.fullName == null) return false;

        var fullName = item!.fullName.toLowerCase();
        var queryParts = query.toLowerCase().split(' ');

        return queryParts.every((part) =>
        fullName.contains(part) ||
            item.firstName.toLowerCase().contains(part) ||
            item.middleName.toLowerCase().contains(part) ||
            item.lastName.toLowerCase().contains(part));
      })
          .toList();

      // Sort the search results by first name
      searchResults.sort((a, b) {
        int compareFirstNames(String nameA, String nameB) {
          return nameA.trim().compareTo(nameB.trim());
        }

        var firstNameA = a!.firstName.split(' ')[0];
        var firstNameB = b!.firstName.split(' ')[0];

        return compareFirstNames(firstNameA, firstNameB);
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      // appBar: AppBar(
      //   // iconTheme: IconThemeData(color: Colors.grey,),
      //   backgroundColor: Colors.transparent,
      //   elevation: 0,
      //   automaticallyImplyLeading: false,
      //   flexibleSpace: SafeArea(
      //     child: Row(
      //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //       crossAxisAlignment: CrossAxisAlignment.center,
      //       children: [
      //         IconButton(
      //           onPressed: () {
      //             Navigator.pop(context);
      //             // if (scaffoldKey.currentState!.isDrawerOpen) {
      //             //   scaffoldKey.currentState!.closeDrawer();
      //             //   //close drawer, if drawer is open
      //             // } else {
      //             //   scaffoldKey.currentState!.openDrawer();
      //             //   //open drawer, if drawer is closed
      //             // }
      //           },
      //           tooltip: "Back",
      //           icon: Icon(
      //             Icons.arrow_back_rounded,
      //             size: screenheight(context, dividedby: 29.h),
      //             color: Colors.black,
      //           ),
      //         ),
      //         Text(
      //           '${AppConfig.barAssociation} District Bar Association',
      //           textAlign: TextAlign.center,
      //           style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
      //         ),
      //         IconButton(
      //             onPressed: () {
      //               sub_Category_Data.clear();
      //               setState(() {
      //                 dropdownvalue1 = "0";
      //                 dropdownvalue2 = "0";
      //                 _validate = false;
      //                 _validate2 = false;
      //               });
      //               _dialogBox();
      //             },
      //             tooltip: "Filter",
      //             icon: Icon(
      //               Icons.filter_alt_outlined,
      //               size: screenheight(context, dividedby: 29.h),
      //             )),
      //       ],
      //     ),
      //   ),
      // ),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black,),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        automaticallyImplyLeading: true,
        title: Text(
          '${AppConfig.barAssociation} District Bar Association',
          textScaleFactor: 0.9,
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: screenheight(context, dividedby: 15.h),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(10.r)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 1.5.r,
                        spreadRadius: 1.5.r,
                      )
                    ],
                  ),
                  child: show
                      ? Padding(
                          padding: const EdgeInsets.only(top: 4.5,bottom: 4.5),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(Radius.circular(5.r)),
                            ),
                            child: TextField(
                                cursorColor: Colors.black,
                                textInputAction: TextInputAction.done,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: MediaQuery.of(context).textScaleFactor * 12,
                                ),
                                controller: searchController,
                                onChanged: (text) {
                                  // fetchDataFromAPI(cat_id: '0', searchKeyword: text);
                                  filterData(text);
                                },
                                decoration: InputDecoration(
                                    contentPadding:
                                        EdgeInsets.symmetric(horizontal: 5),
                                    prefixIcon: Icon(
                                      Icons.search,
                                      color: Colors.grey.shade600,
                                      size: 30.h,
                                    ),
                                    suffixIcon: searchController.text.isNotEmpty
                                        ? IconButton(
                                            splashRadius: 0.1,
                                            onPressed: () {
                                              searchController.clear();
                                              setState(() {});
                                              // fetchDataFromAPI(
                                              //   cat_id: '0',
                                              // );
                                            },
                                            icon: Icon(
                                              Icons.cancel_outlined,
                                              color: Colors.black,
                                              size: 18,
                                            ),
                                          )
                                        : SizedBox(),
                                    hintText: "Search...",
                                    hintStyle: TextStyle(
                                      fontSize: MediaQuery.of(context).textScaleFactor * 12,
                                    ),
                                    disabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.transparent),
                                        borderRadius: BorderRadius.circular(5.r)),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.transparent),
                                        borderRadius: BorderRadius.circular(5.r)),
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.transparent),
                                        borderRadius: BorderRadius.circular(5.r)),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.transparent),
                                        borderRadius: BorderRadius.circular(5.r)))),
                          ),
                        )
                      : SizedBox(),
                ),
                Padding(padding: EdgeInsets.only(top: 15)),
                Expanded(
                  child: show
                      ? data.isNotEmpty
                          ? RefreshIndicator(
                              color: Colors.black,
                              backgroundColor: Colors.white,
                              onRefresh: () async {
                                searchController.clear();
                                await fetchDataFromAPI(cat_id: '0', searchKeyword: '');
                              },
                              child: ScrollConfiguration(
                                behavior: const ScrollBehavior().copyWith(overscroll: false),
                                child: searchController.text.isEmpty
                                    ? ListView.separated(
                                        controller: _controller,
                                        // itemCount: data.length,
                                        itemCount: data.length,
                                        // itemCount: searchController.text.isEmpty ? data.length : searchResults.length,
                                        // itemCount: searchResults.isNotEmpty ? searchResults.length : data.length,
                                        itemBuilder: (BuildContext context, int index) {
                                          searchDatum? dataSearch = data[index];
                                          // searchDatum? dataSearch = searchController.text.isEmpty ? data[index] : searchResults[index];
                                          final fullName =
                                              "${dataSearch?.fullName}";
                                              // "${dataSearch?.firstName} ${dataSearch?.middleName} ${dataSearch?.lastName}";

                                          return Padding(
                                            padding: EdgeInsets.only(top: 5, bottom: 5),
                                            child: ListTile(
                                              onTap: () {
                                                // fetchUserDataFromAPI(login.userId);
                                                fetchLawyerData(
                                                    data[index]?.userId.toString(), login.parentId, dataSearch);
                                                // Navigator.push(
                                                //   context,
                                                //   MaterialPageRoute(
                                                //     builder: (context) => SearchDetailScreen(
                                                //       selectedUserData: datasearch,
                                                //       // selectedUserData: userData,
                                                //     ),
                                                //   ),
                                                // );
                                              },
                                              leading: CachedNetworkImage(
                                                imageUrl: mainUrl + dataSearch!.profilePic,
                                                imageBuilder: (context, imageProvider) => CircleAvatar(
                                                  radius: 30.r,
                                                  backgroundColor: Colors.grey.shade400,
                                                  child: CircleAvatar(
                                                    radius: 27.r,
                                                    backgroundColor: Colors.grey,
                                                    backgroundImage:
                                                        // AssetImage('images/avatarlogos.jpg'),
                                                        imageProvider,
                                                  ),
                                                ),
                                                placeholder: (context, url) => CircleAvatar(
                                                  radius: 30.r,
                                                  backgroundColor: Colors.grey.shade300,
                                                ),
                                                errorWidget: (context, url, error) => Visibility(
                                                    visible: true,
                                                    child: CircleAvatar(
                                                      radius: 30.r,
                                                      backgroundColor: Colors.grey.shade400,
                                                      child: CircleAvatar(
                                                        radius: 27.r,
                                                        backgroundColor: Colors.grey,
                                                        backgroundImage: AssetImage('images/avatarlogos.jpg'),
                                                      ),
                                                    )),
                                              ),

                                              // CircleAvatar(
                                              //   radius: 30.r,
                                              //   backgroundColor: Colors.grey.shade400,
                                              //   child: CircleAvatar(
                                              //     radius: 27.r,
                                              //     backgroundColor: Colors.grey,
                                              //     backgroundImage:
                                              //         // AssetImage('images/avatarlogos.jpg'),
                                              //         NetworkImage(mainUrl + data[index]!.profilePic),
                                              //   ),
                                              // ),
                                              title: Text(
                                                // 'AJAZHUSSAIN IMTIYAZ ALI MOMIN',
                                                 "${dataSearch.firstName} ${dataSearch.middleName} ${dataSearch.lastName}",
                                                // "${fullName}",
                                                textScaleFactor: 0.84,
                                                style: TextStyle(
                                                    // fontSize: ScreenUtil().setWidth(9.5),
                                                    fontWeight: FontWeight.w500),
                                              ),
                                              subtitle: Text(
                                                // '9824198195',
                                                dataSearch.mobile.isEmpty
                                                    ? 'Mobile Number Not Available'
                                                    : data[index]!.mobile,
                                                textScaleFactor: 1,
                                                style: TextStyle(),
                                              ),
                                            ),
                                          );
                                        },
                                        separatorBuilder: (context, index) {
                                          return Divider(
                                            thickness: 1.5.h,
                                            height: 0.01.h,
                                          );
                                        },
                                      )
                                    : searchResults.isNotEmpty
                                        ? ListView.separated(
                                            controller: _controller,
                                            // itemCount: data.length,
                                            itemCount: searchResults.length,
                                            // itemCount: searchController.text.isEmpty ? data.length : searchResults.length,
                                            // itemCount: searchResults.isNotEmpty ? searchResults.length : data.length,
                                            itemBuilder: (BuildContext context, int index) {
                                              searchDatum? dataSearch = searchResults[index];
                                              // searchDatum? dataSearch = searchController.text.isEmpty ? data[index] : searchResults[index];
                                              // final fullName =
                                              //     "${dataSearch?.firstName} ${dataSearch?.middleName} ${dataSearch?.lastName}";

                                              return Padding(
                                                padding: EdgeInsets.only(top: 5, bottom: 5),
                                                child: ListTile(
                                                  onTap: () {
                                                    // fetchUserDataFromAPI(login.userId);
                                                    fetchLawyerData(searchResults[index]?.userId.toString(),
                                                        login.parentId, dataSearch);
                                                    // Navigator.push(
                                                    //   context,
                                                    //   MaterialPageRoute(
                                                    //     builder: (context) => SearchDetailScreen(
                                                    //       selectedUserData: datasearch,
                                                    //       // selectedUserData: userData,
                                                    //     ),
                                                    //   ),
                                                    // );
                                                  },
                                                  leading: CachedNetworkImage(
                                                    imageUrl: mainUrl + dataSearch!.profilePic,
                                                    imageBuilder: (context, imageProvider) => CircleAvatar(
                                                      radius: 30.r,
                                                      backgroundColor: Colors.grey.shade400,
                                                      child: CircleAvatar(
                                                        radius: 27.r,
                                                        backgroundColor: Colors.grey,
                                                        backgroundImage:
                                                            // AssetImage('images/avatarlogos.jpg'),
                                                            imageProvider,
                                                      ),
                                                    ),
                                                    placeholder: (context, url) => CircleAvatar(
                                                      radius: 30.r,
                                                      backgroundColor: Colors.grey.shade300,
                                                    ),
                                                    errorWidget: (context, url, error) => Visibility(
                                                        visible: true,
                                                        child: CircleAvatar(
                                                          radius: 30.r,
                                                          backgroundColor: Colors.grey.shade400,
                                                          child: CircleAvatar(
                                                            radius: 27.r,
                                                            backgroundColor: Colors.grey,
                                                            backgroundImage: AssetImage('images/avatarlogos.jpg'),
                                                          ),
                                                        )),
                                                  ),

                                                  // CircleAvatar(
                                                  //   radius: 30.r,
                                                  //   backgroundColor: Colors.grey.shade400,
                                                  //   child: CircleAvatar(
                                                  //     radius: 27.r,
                                                  //     backgroundColor: Colors.grey,
                                                  //     backgroundImage:
                                                  //         // AssetImage('images/avatarlogos.jpg'),
                                                  //         NetworkImage(mainUrl + data[index]!.profilePic),
                                                  //   ),
                                                  // ),
                                                  title: Text(
                                                    // 'AJAZHUSSAIN IMTIYAZ ALI MOMIN',
                                                    "${dataSearch.firstName} ${dataSearch.middleName} ${dataSearch.lastName}",
                                                    textScaleFactor: 0.84,
                                                    style: TextStyle(
                                                        // fontSize: ScreenUtil().setWidth(9.5),
                                                        fontWeight: FontWeight.w500),
                                                  ),
                                                  subtitle: Text(
                                                    // '9824198195',
                                                    dataSearch.mobile.isEmpty
                                                        ? 'Mobile Number Not Available'
                                                        : dataSearch.mobile,
                                                    textScaleFactor: 1
                                                  ),
                                                ),
                                              );
                                            },
                                            separatorBuilder: (context, index) {
                                              return Divider(
                                                thickness: 1.5.h,
                                                height: 0.01.h,
                                              );
                                            },
                                          )
                                        : Center(
                                            child: Text(
                                  "No data",
                                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                                ),
                                          ),
                              ),
                            )
                          :
                          // Center(
                          //   child: fetchingData
                          //       ? Text(
                          //     "",
                          //     style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                          //   ) : Align(
                          //     alignment: Alignment.topCenter,
                          //     child: Text(
                          //       searchController.text.isNotEmpty ? "\"${searchController.text}\" Search Not Found" : "",
                          //       style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                          //     ),
                          //   ),
                          // )
                          Center(
                              child: Text(
                                "No data",
                                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                              ),
                            )
                      : ScrollConfiguration(
                          behavior: const ScrollBehavior().copyWith(overscroll: false),
                          child: ListView.builder(
                              // itemCount: snapshot.data!.length,
                              controller: _controller,
                              itemCount: 15,
                              itemBuilder: (context, index) {
                                return Shimmer.fromColors(
                                  baseColor: Colors.grey.shade400,
                                  highlightColor: Colors.grey.shade100,
                                  child: Column(
                                    children: [
                                      ListTile(
                                        title: Container(
                                          height: 12,
                                          width: 89,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(Radius.circular(5.r)),
                                            color: Colors.white,
                                          ),
                                        ),
                                        subtitle: Container(
                                          height: 12,
                                          width: 89,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(Radius.circular(5.r)),
                                            color: Colors.white,
                                          ),
                                        ),
                                        leading: CircleAvatar(
                                          radius: 30.r,
                                          backgroundColor: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }),
                        ),
                ),
              ],
              //                 : searchController.text.isNotEmpty
              //         ? Center(
              //         child: Text(
              //         "No results found",
              //         style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              // ),
              // )
            ),
          ),
          showLawyer == true
              ? Center(
                  child: FittedBox(
                    fit: BoxFit.fitWidth,
                    child: Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(20)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 4,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text("Loading", style: TextStyle(color: Colors.white)),
                          SizedBox(
                            height: 10,
                          ),
                          Text("Please Wait...", style: TextStyle(color: Colors.white)),
                        ],
                      ),
                    ),
                  ),
                )
              : SizedBox(),
        ],
      ),
      // drawer: MyDrawerWidget(),
    );
  }

  // void filterData(String query) {
  //   searchResults.clear();
  //   // setState(() {
  //   //   searchResults = data
  //   //       .where((item) => (item?.fullName.toLowerCase().contains(query.toLowerCase()) ?? false)
  //   //           // ||
  //   //           // (item?.cityName.toLowerCase().contains(query.toLowerCase()) ?? false)
  //   //           )
  //   //       .toList();
  //   // });
  //   setState(() {
  //     searchResults = data
  //         .where((item) =>
  //     item?.fullName.toLowerCase().contains(query.toLowerCase()) ?? false)
  //         .toList();
  //
  //     // Sort the search results by first name
  //     searchResults.sort((a, b) {
  //       // Define a custom comparison function to trim leading spaces
  //       int compareFirstNames(String nameA, String nameB) {
  //         return nameA.trim().compareTo(nameB.trim());
  //       }
  //
  //       // Extract first names and compare using the custom function
  //       var firstNameA = a!.fullName.split(' ')[0];
  //       var firstNameB = b!.fullName.split(' ')[0];
  //
  //       return compareFirstNames(firstNameA, firstNameB);
  //     });
  //   });
  //
  // }
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}

//First Way Big Card

// child: Material(
//   elevation: 2,
//   shadowColor: Colors.grey,
//   child: Container(
//     height: _mediaQuery.size.height * 0.175.h,
//     color: Colors.transparent,
//     child: Row(
//       children: [
//         Column(
//           crossAxisAlignment:
//               CrossAxisAlignment.start,
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: [
//             Padding(
//               padding: EdgeInsets.symmetric(
//                   horizontal:
//                       _mediaQuery.size.height *
//                           0.02.w,
//                   vertical: _mediaQuery.size.height *
//                       0.019.h),
//               child: CircleAvatar(
//                 radius: 51.r,
//                 backgroundColor: Colors.grey.shade400,
//                 child: CircleAvatar(
//                   radius: 50.r,
//                   backgroundImage: AssetImage(
//                       'images/avatarlogos.jpg'),
//                 ),
//               ),
//             ),
//           ],
//         ),
//         Padding(
//             padding: EdgeInsets.symmetric(
//                 horizontal:
//                     _mediaQuery.size.height * 0.005)),
//         Center(
//           child: Column(
//             mainAxisAlignment:
//                 MainAxisAlignment.center,
//             crossAxisAlignment:
//                 CrossAxisAlignment.start,
//             children: [
//               Text(
//                 'AJAZHUSSAIN IMTIYAZ ALI MOMIN',
//                 textScaleFactor: 0.84,
//                 style: TextStyle(
//                     // fontSize: ScreenUtil().setWidth(9.5),
//                     fontWeight: FontWeight.w900),
//               ),
//               Padding(
//                   padding: EdgeInsets.symmetric(
//                       vertical:
//                           _mediaQuery.size.height *
//                               0.001)),
//               Text(
//                 '9824198195',
//                 textScaleFactor: 1.1,
//                 //, style: TextStyle(
//                 //     fontSize: ScreenUtil().setWidth(12),
//                 //   ),
//               )
//             ],
//           ),
//         ),
//       ],
//     ),
//   ),
// ),

//Second Way Small Card Like ListTile

//ListView.builder(
//                       itemCount: 20,
//                       itemBuilder: (BuildContext context, int index) {
//                         return Card(
//                           elevation: 5,
//                           margin: EdgeInsets.all(10),
//                           shape: RoundedRectangleBorder(
//                               borderRadius:
//                                   BorderRadius.all(Radius.circular(10)),
//                               side:
//                                   BorderSide(color: Colors.grey, width: 0.15)),
//                           child: Container(
//                             height: screenheight(context, dividedby: 9.h),
//                             child: Padding(
//                               padding: EdgeInsets.symmetric(
//                                   vertical:
//                                       screenheight(context, dividedby: 250.h)),
//                               child: ListTile(
//                                 onTap: () {
//                                   Navigator.pushNamed(context, '/searchDetail');
//                                 },
//                                 leading: CircleAvatar(
//                                   radius: 30.r,
//                                   backgroundColor: Colors.grey.shade400,
//                                   child: CircleAvatar(
//                                     radius: 27.r,
//                                     backgroundImage:
//                                         AssetImage('images/avatarlogos.jpg'),
//                                   ),
//                                 ),
//                                 title: Text(
//                                   'AJAZHUSSAIN IMTIYAZ ALI MOMIN',
//                                   textScaleFactor: 0.84,
//                                   style: TextStyle(
//                                       // fontSize: ScreenUtil().setWidth(9.5),
//                                       fontWeight: FontWeight.w900),
//                                 ),
//                                 subtitle: Text(
//                                   '9824198195',
//                                   textScaleFactor: 1,
//                                   style: TextStyle(),
//                                 ),
//
//                               ),
//                             ),
//                           ),
//                         );
//                       }),

// ==========================Rough Work==================================

// Column(
//   children: [
//     CommonTextField(controller: con, labelText: 'sgdfgf', number: TextInputType.text, maxlength: 6,),
//   ],
// )

// Column(
//   children: [
// Padding(
//   padding: const EdgeInsets.all(8.0),
//   child: Material(
//     elevation: 5,
//     shape: RoundedRectangleBorder(
//       borderRadius: BorderRadius.all(Radius.circular(10)),
//     ),
//     // surfaceTintColor: Colors.grey,
//     shadowColor: Colors.grey,
//     child: ClipRRect(
//       borderRadius: BorderRadius.all(Radius.circular(7)),
//       child: Container(
//         height: 45,
//         width: 360,
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.all(Radius.circular(10)),
//         ),
//         child: Padding(
//           padding: const EdgeInsets.all(7),
//           child: Container(
//             height: 35,
//             width: 320,
//             color: Colors.grey,
//             child: TextField(
//                 cursorColor: Colors.black,
//                 style: TextStyle(
//                   fontSize: 20,
//                   color: Colors.black,
//                 ),
//                 decoration: InputDecoration(
//                     contentPadding: EdgeInsets.only(left: 50),
//                     prefixIcon: Icon(
//                       Icons.search,
//                       color: Colors.grey.shade800,
//                       size: 30,
//                     ),
//                     hintText: "  Search",
//                     disabledBorder: OutlineInputBorder(
//                         borderSide:
//                             BorderSide(color: Colors.transparent),
//                         borderRadius: BorderRadius.circular(5)),
//                     enabledBorder: OutlineInputBorder(
//                         borderSide:
//                             BorderSide(color: Colors.transparent),
//                         borderRadius: BorderRadius.circular(5)),
//                     border: OutlineInputBorder(
//                         borderSide:
//                             BorderSide(color: Colors.transparent),
//                         borderRadius: BorderRadius.circular(5)),
//                     focusedBorder: OutlineInputBorder(
//                         borderSide:
//                             BorderSide(color: Colors.transparent),
//                         borderRadius: BorderRadius.circular(5)))),
//           ),
//         ),
//       ),
//     ),
//   ),
// ),

// Padding(
//   padding: EdgeInsets.only(top: 10, left: 15, right: 15),
//   child: Material(
//     elevation: 10,
//     shadowColor: Colors.black,
//     child: Container(
//       height: 40,
//       width: 330,
//       decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.all(Radius.circular(4)),
//           border: Border.all(
//               color: Colors.grey,
//               width: 0.5,
//               style: BorderStyle.solid)),
//       child: Padding(
//         padding: const EdgeInsets.all(5),
//         child: Container(
//           height: 30,
//           width: 300,
//           color: Colors.grey,
//           child: Row(
//             children: [
//               Padding(
//                 padding: const EdgeInsets.only(
//                     left: 22, top: 2, bottom: 2),
//                 child: Icon(
//                   Icons.search,
//                   color: Colors.grey.shade900,
//                   size: 22,
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.only(
//                     left: 10, top: 0, bottom: 0),
//                 child: TextFormField(
//                   cursorColor: Colors.black,
//                   cursorHeight: 22,
//                   controller: searchController,
//                   keyboardType: TextInputType.text,
//                   textAlign: TextAlign.start,
//                   style: const TextStyle(
//                     fontSize: 20,
//                     color: Colors.black,
//                   ),
//                   validator: (String? value) {
//                     if (value != null && value.isEmpty) {
//                       return "Enter City";
//                     }
//                   },
//                   decoration: InputDecoration(
//                     label: Center(
//                         child: Text(
//                       "Enter City",
//                       textAlign: TextAlign.start,
//                     )),
//                     // labelText: "Enter City",
//                     labelStyle: TextStyle(
//                         color: Colors.grey.shade500, fontSize: 12),
//                     contentPadding: const EdgeInsets.only(
//                         left: 14.0,
//                         // top: 7.0,
//                         // bottom: 2.7,
//                         right: 10.0),
//                     errorStyle: TextStyle(
//                         color: Colors.orange.shade900, height: 0.5),
//                     floatingLabelBehavior:
//                         FloatingLabelBehavior.never,
//                     floatingLabelStyle:
//                         TextStyle(color: Colors.black, fontSize: 10),
//                     focusedBorder: UnderlineInputBorder(
//                       borderSide: BorderSide.none,
//                       borderRadius: BorderRadius.circular(15),
//                     ),
//                     border: const UnderlineInputBorder(
//                       borderSide: BorderSide.none,
//                       borderRadius:
//                           BorderRadius.all(Radius.circular(7)),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     ),
//   ),
// ),

//   ],
// ),

//=====================Rough======================

// Padding(
//   padding: const EdgeInsets.only(
//       top: 10, left: 15, right: 15),
//   child: Container(
//     height: 41,
//     width: 250,
//     child: Material(
//       elevation: 3,
//       shadowColor: Colors.black,
//       child: Padding(
//         padding: const EdgeInsets.all(10),
//         child: DropdownButton(
//           // Initial Value
//           value: dropdownvalue2,
//           underline: Container(),
//           // Down Arrow Icon
//           icon: Padding(
//             padding:
//                 const EdgeInsets.only(left: 35),
//             child: const Icon(
//                 Icons.arrow_drop_down_sharp),
//           ),
//
//           // Array list of items
//           items: items2.map((String items) {
//             return DropdownMenuItem(
//               value: items,
//               child: Text(items),
//             );
//           }).toList(),
//           // After selecting the desired option,it will
//           // change button value to selected value
//           onChanged: (String? newValue) {
//             setState(() {
//               dropdownvalue2 = newValue!;
//             });
//           },
//         ),
//       ),
//     ),
//   ),
// ),

/*DropdownButton(
                                      // Initial Value
                                      value: dropdownvalue1,
                                      underline: Container(),
                                      // Down Arrow Icon
                                      icon: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 50),
                                        child: const Icon(
                                            Icons.arrow_drop_down_sharp),
                                      ),

                                      // Array list of items
                                      items: items1.map((String items) {
                                        return DropdownMenuItem(
                                          value: items,
                                          child: Text(items),
                                        );
                                      }).toList(),
                                      // After selecting the desired option,it will
                                      // change button value to selected value

                                      onChanged: (newValue) async {
                                        setState(() {
                                          dropdownvalue1 = newValue!;
                                        });
                                      },
                                    ),*/

/*
* // ListView.builder(
                      //   itemCount: searchController.text.isEmpty
                      //       ? data.length
                      //       : data.where((item) =>
                      //   item?.fullName.toLowerCase().contains(searchController.text.toLowerCase()) ?? false).length,
                      //   controller: _controller,
                      //   itemBuilder: (context, index) {
                      //     searchDatum? datasearch = data[index];
                      //     if (searchController.text.isEmpty ||
                      //         (data[index]?.fullName.toLowerCase().contains(searchController.text.toLowerCase()) ?? false)) {
                      //       return Padding(
                      //         padding: EdgeInsets.only(top: 5, bottom: 5),
                      //         child: ListTile(
                      //           onTap: () {
                      //             // fetchUserDataFromAPI(login.userId);
                      //             fetchLawyerData(data[index]?.userId.toString(), login.parentId);
                      //             // Navigator.push(
                      //             //   context,
                      //             //   MaterialPageRoute(
                      //             //     builder: (context) => SearchDetailScreen(
                      //             //       selectedUserData: datasearch,
                      //             //       // selectedUserData: userData,
                      //             //     ),
                      //             //   ),
                      //             // );
                      //           },
                      //           leading: CachedNetworkImage(
                      //             imageUrl: mainUrl + datasearch!.profilePic,
                      //             imageBuilder: (context, imageProvider) => CircleAvatar(
                      //               radius: 30.r,
                      //               backgroundColor: Colors.grey.shade400,
                      //               child: CircleAvatar(
                      //                 radius: 27.r,
                      //                 backgroundColor: Colors.grey,
                      //                 backgroundImage:
                      //                 // AssetImage('images/avatarlogos.jpg'),
                      //                 imageProvider,
                      //               ),
                      //             ),
                      //             placeholder: (context, url) => CircleAvatar(
                      //               radius: 30.r,
                      //               backgroundColor: Colors.grey.shade300,
                      //             ),
                      //             errorWidget: (context, url, error) => Visibility(
                      //                 visible: true,
                      //                 child: CircleAvatar(
                      //                   radius: 30.r,
                      //                   backgroundColor: Colors.grey.shade400,
                      //                   child: CircleAvatar(
                      //                     radius: 27.r,
                      //                     backgroundColor: Colors.grey,
                      //                     backgroundImage: AssetImage('images/avatarlogos.jpg'),
                      //                   ),
                      //                 )),
                      //           ),
                      //
                      //           // CircleAvatar(
                      //           //   radius: 30.r,
                      //           //   backgroundColor: Colors.grey.shade400,
                      //           //   child: CircleAvatar(
                      //           //     radius: 27.r,
                      //           //     backgroundColor: Colors.grey,
                      //           //     backgroundImage:
                      //           //         // AssetImage('images/avatarlogos.jpg'),
                      //           //         NetworkImage(mainUrl + data[index]!.profilePic),
                      //           //   ),
                      //           // ),
                      //           title: Text(
                      //             // 'AJAZHUSSAIN IMTIYAZ ALI MOMIN',
                      //             "${datasearch.firstName} ${datasearch.middleName} ${datasearch.lastName}",
                      //             textScaleFactor: 0.84,
                      //             style: TextStyle(
                      //               // fontSize: ScreenUtil().setWidth(9.5),
                      //                 fontWeight: FontWeight.w500),
                      //           ),
                      //           subtitle: Text(
                      //             // '9824198195',
                      //             datasearch.mobile.isEmpty ? 'Mobile Number Not Available' : data[index]!.mobile,
                      //             textScaleFactor: 1,
                      //             style: TextStyle(),
                      //           ),
                      //         ),
                      //       );
                      //     } else {
                      //       return null; // Return null for items that don't match the search
                      //     }
                      //   },
                      //   // Add this section to display "No results found" message
                      //   // emptyChild: Center(
                      //   //   child: Text(
                      //   //     "No results found",
                      //   //     style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                      //   //   ),
                      //   // ),
                      // )*/