import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:html/parser.dart';
import 'package:shimmer/shimmer.dart';
import 'package:surat_district_bar_association/drawer_details/committee/committee_tile_detail.dart';
import 'package:surat_district_bar_association/model/committee_model.dart';
import 'package:surat_district_bar_association/services/all_api_services.dart';

import '../../model/login_model.dart';
import '../../widgets/drawer.dart';
import '../../widgets/media_query_sizes.dart';
import '../../widgets/sharedpref.dart';

class CommitteeTileScreen extends StatefulWidget {
  const CommitteeTileScreen({super.key});

  @override
  State<CommitteeTileScreen> createState() => _CommitteeTileScreenState();
}

class _CommitteeTileScreenState extends State<CommitteeTileScreen> {
  LoginModel login = loginModelFromJson(SharedPref.get(prefKey: PrefKey.saveUser)!);
  final ScrollController _controller = ScrollController();
  int? selectedYearFilter = DateTime.now().year;

  List<committeeDatum?> data = [];

  Future<void> fetchDataFromAPI(id) async {
    Map<String, dynamic> parameter = {
      "app_user": id,
    };
    await committeeData(parameter: parameter).then((value) {
      setState(() {
        data = value.data;
      });
      // print(value);
    }).onError((error, stackTrace) {
      print(error);
    });
  }

  String _parseHtmlString(String htmlString) {
    final document = parse(htmlString);
    final String parsedString = parse(document.body!.text).documentElement!.text;

    return parsedString;
  }

  @override
  void initState() {
    super.initState();
    selectedYearFilter = null;
    fetchDataFromAPI(login.parentId);
  }

  // List<committeeDatum?> getFilteredData() {
  //   return data.where((committee) {
  //     int committeeYear = int.parse(committee!.createdDatetime.split("/")[2]);
  //     return committeeYear == selectedYearFilter;
  //   }).toList();
  // }
  //
  // void filterDataByYear(int year) {
  //   setState(() {
  //     selectedYearFilter = year;
  //   });
  // }

  // List<committeeDatum?> getFilteredData() {
  //   if (selectedYearFilter != null) {
  //     return data.where((committee) {
  //       int committeeYear =
  //       int.parse(committee!.createdDatetime.split("/")[2]);
  //       return committeeYear == selectedYearFilter;
  //     }).toList();
  //   } else {
  //     return data;
  //   }
  // }

  // List<committeeDatum?> getFilteredData() {
  //   if (selectedYearFilter != null) {
  //     return data.where((committee) {
  //       int committeeYear = int.parse(committee!.createdDatetime.split("/")[2]);
  //       return committeeYear == selectedYearFilter;
  //     }).toList();
  //   } else {
  //     // If selectedYearFilter is null, return all data
  //     return List.from(data); // Create a new list to avoid modifying the original data
  //   }
  // }

  List<committeeDatum?> getFilteredData() {
    if (selectedYearFilter != null) {
      return data
          .where((committee) =>
      committee != null &&
          int.parse(committee.createdDatetime.split("/")[2]) ==
              selectedYearFilter)
          .toList();
    } else {
      return List.from(data);
    }
  }

  void filterDataByYear(int? year) {
    setState(() {
      selectedYearFilter = year;
    });
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Select Year',
                              textScaleFactor: 1.4,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
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
                              child: DropdownButtonFormField<int?>(
                                value: selectedYearFilter,
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
                                items: [null, 2021, 2022, 2023].map((year) {
                                  return DropdownMenuItem<int?>(
                                    value: year,
                                    child: Text(year != null ? year.toString() : "All"),
                                  );
                                }).toList(),
                                onChanged: (int? year) {
                                  filterDataByYear(year);
                                  Navigator.of(context).pop();
                                },
                              ),
                            ),
                          ),
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
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          'Committee',
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
        // actions: [
        //   IconButton(
        //     icon: Icon(Icons.filter_list),
        //     onPressed: () {
        //       showDialog(
        //         context: context,
        //         builder: (BuildContext context) {
        //           return AlertDialog(
        //             title: Text("Select Year"),
        //             content: DropdownButton<int>(
        //               value: selectedYearFilter,
        //               icon: Icon(Icons.arrow_drop_down_sharp,color: Colors.black,),
        //               items: [2021, 2022, 2023].map((year) {
        //                 return DropdownMenuItem<int>(
        //                   value: year,
        //                   child: Text(year.toString()),
        //                 );
        //               }).toList(),
        //               onChanged: (int? year) {
        //                 if (year != null) {
        //                   filterDataByYear(year);
        //                   Navigator.of(context).pop();
        //                 }
        //               },
        //             ),
        //           );
        //         },
        //       );
        //     },
        //   ),
        // ],
        actions: [
          IconButton(
            padding: EdgeInsets.only(right: 10),
            icon: Icon(Icons.filter_list),
            onPressed: () {
              // Show a year selection dialog or a dropdown menu
              // Let the user choose the year and call filterDataByYear
              // to update the filtered data
              // For example:
              // showDialog(
              //   context: context,
              //   builder: (BuildContext context) {
              //     return AlertDialog(
              //       title: Text("Select Year"),
              //       content: DropdownButton<int?>(
              //         value: selectedYearFilter,
              //         items: [null, 2021, 2022, 2023].map((year) {
              //           return DropdownMenuItem<int?>(
              //             value: year,
              //             child: Text(year != null ? year.toString() : "All"),
              //           );
              //         }).toList(),
              //         onChanged: (int? year) {
              //           filterDataByYear(year);
              //           Navigator.of(context).pop();
              //         },
              //       ),
              //     );
              //   },
              // );
              _dialogBox();
            },
          ),
        ],
      ),
      body: data.isNotEmpty
          ? ScrollConfiguration(
        behavior: MyBehavior(),
        child: data.length > 0
            ? ListView.builder(
          controller: _controller,
            // itemCount: 10,
            // itemCount: data.length,
            itemCount: getFilteredData().length,
            itemBuilder: (BuildContext context, int index) {
            final allData = data[index];
            final filterData = getFilteredData()[index];
              return Card(
                elevation: 5,
                margin: EdgeInsets.all(10),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    side: BorderSide(color: Colors.grey, width: 0.15)),
                child: InkWell(
                  radius: 0,
                  onTap: () {
                    // Navigator.pushNamed(context, '/committeeDetail');
                  },
                  // splashColor: Colors.white,
                  // highlightColor: Colors.transparent,
                  hoverColor: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(10.r)),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15,right: 15,top: 10,bottom: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Text(
                                // 'Committee : Co-Opt Member Of Council',
                                'Committee : ${filterData!.committeeName}',
                                softWrap: true,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                textScaleFactor: 1.17,
                                style: TextStyle(
                                  // fontSize: 10.6,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ],
                        ),
                        Padding(padding: EdgeInsets.only(top: 10)),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              // 'Formation : 14',
                              'Formation : ${filterData.formationDate}',
                              textScaleFactor: 1.05,
                              style: TextStyle(
                                // fontSize: 12,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                        Padding(padding: EdgeInsets.only(top: 5)),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              // 'Puprpose : <p><br></p>',
                              'Purpose : ',
                              textScaleFactor: 1.05,
                              style: TextStyle(
                                // fontSize: 12,
                                  fontWeight: FontWeight.w500),
                            ),
                            Text(
                              // 'Puprpose : <p><br></p>',
                              _parseHtmlString('${filterData.purpose.isNotEmpty ? filterData.purpose : "Purpose Not Available"}'),
                              textScaleFactor: 1.05,
                              style: TextStyle(
                                // fontSize: 12,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                        Padding(padding: EdgeInsets.only(top: 5)),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              // 'Members : 12',
                              'Members : ${filterData.totalMember}',
                              textScaleFactor: 1.05,
                              style: TextStyle(
                                // fontSize: 12,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                        Padding(padding: EdgeInsets.only(top: 10)),
                        SizedBox(
                          width: double.infinity,
                          height:
                          screenheight(context, dividedby: 20.h),
                          child: ClipRRect(
                            borderRadius: BorderRadius.all(
                                  Radius.circular(10.r)),
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => CommitteeDetailScreen(
                                  committeeId: filterData.committeeId
                                )));
                              },
                              style: ButtonStyle(
                                  backgroundColor:
                                  MaterialStateProperty.all(
                                      (Colors.black)),
                                  ),
                              child: const Text(
                                "MEMBERS",
                                textScaleFactor: 1.17,
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
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
            padding: const EdgeInsets.only(bottom: 20,top: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 25, right: 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Container(
                          height: 20,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(7.5.r)),
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                ...List.generate(
                  3,
                      (index) => Padding(
                    padding: const EdgeInsets.only(top: 12, left: 25, right: 25),
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
                Padding(padding: EdgeInsets.only(top: 12.5),),
                Padding(
                  padding: const EdgeInsets.only(left: 100, right: 100),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Container(
                          height: 30,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(7.5.r)),
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
      // drawer: MyDrawerWidget(),
    );
  }
}
