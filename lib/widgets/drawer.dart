import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:surat_district_bar_association/view-screens/edit_profile.dart';
import 'package:surat_district_bar_association/widgets/media_query_sizes.dart';
import 'package:url_launcher/url_launcher.dart';
import '../model/login_model.dart';
import '../services/Utilities/app_url.dart';
import '../services/all_api_services.dart';
import '../view-screens/login_page.dart';
import 'sharedpref.dart';

class MyDrawerWidget extends StatefulWidget {
  MyDrawerWidget({Key? key}) : super(key: key);

  @override
  State<MyDrawerWidget> createState() => _MyDrawerWidgetState();
}

class _MyDrawerWidgetState extends State<MyDrawerWidget> {
  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  final ScrollController _controller = ScrollController();
  final imageURL = "images/ProfileGandhiji.jpg";
  // "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT1VppIV35ax1nwHoaURdUEMCUIKaZqjG8QZg&usqp=CAU";

  LoginModel login = loginModelFromJson(SharedPref.get(prefKey: PrefKey.saveUser)!);
  bool show = false;

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

  Future<void> fetchDataFromAPI(id) async {
    setState(() {
      show = true;
    });
    Map<String, dynamic> parameter = {
      "user_id": id,
    };
    await userData(parameter: parameter).then((value) {
      setState(() {
        show = true;
      });
      Navigator.pop(context);
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => EditProfileScreen(userData: value, ),
          ));
      setState(() {
        show = false;
      });
      // print(value);
    }).onError((error, stackTrace) {
      print(error);
    });
  }

  // Future<UserModel> fetchDataFromAPI(String id, SearchModel searchData) async {
  //   // Find the matching user in the search data
  //   searchDatum? matchingUser;
  //   for (var searchUser in searchData.data) {
  //     if (searchUser?.userId == id) {
  //       matchingUser = searchUser;
  //       break;
  //     }
  //   }
  //
  //   // You can add additional error handling if needed
  //
  //   if (matchingUser != null) {
  //     // If a matching user is found, directly navigate to EditProfileScreen
  //     Navigator.pop(context);
  //     Navigator.push(
  //       context,
  //       MaterialPageRoute(
  //         builder: (context) => EditProfileScreen(searchDatas: matchingUser),
  //       ),
  //     );
  //   } else {
  //     // Handle case when matching user is not found
  //     print("Matching user not found in searchData");
  //   }
  //
  //   // You might want to return some value or simply return an empty UserModel
  //   return UserModel(data: [], fullName: "", flag: 0, message: "");
  // }

  // Future<void> fetchDataFromAPI(id) async {
  //   setState(() {
  //     show = true;
  //   });
  //
  //   Map<String, dynamic> parameter = {
  //     "user_id": id,
  //   };
  //
  //   // Fetch user data
  //   UserModel userDatas = await userData(parameter: parameter);
  //
  //   // Fetch search data
  //   SearchModel searchModel = await fetchSearchDataFromAPI(id);
  //
  //   // Find the matching user in the search data
  //   searchDatum? matchingUser;
  //   for (var searchUser in searchModel.data) {
  //     if (searchUser?.userId == id.toString()) {
  //       matchingUser = searchUser;
  //       break;
  //     }
  //   }
  //   // for (var searchUser in searchModel.data) {
  //   //   if (searchUser?.userId.toString() == id) {
  //   //     matchingUser = searchUser;
  //   //     break;
  //   //   }
  //   // }
  //   // for (var searchUser in searchModel.data) {
  //   //   if (searchUser?.userId == id) {
  //   //     matchingUser = searchUser;
  //   //     break;
  //   //   }
  //   // }
  //
  //   Navigator.pop(context);
  //
  //   if (matchingUser != null) {
  //     Navigator.push(
  //       context,
  //       MaterialPageRoute(
  //         builder: (context) => EditProfileScreen(userData: userDatas, searchModels: searchModel),
  //       ),
  //     );
  //   } else {
  //     // Handle case when matching user is not found
  //     print("Matching user not found in searchData");
  //   }
  //
  //   setState(() {
  //     show = false;
  //   });
  // }

  // Future<void> fetchSearchDataFromAPI(id) async {
  //   setState(() {
  //     show = true;
  //   });
  //   Map<String, dynamic> parameter = {
  //     'app_user': id,
  //   };
  //   await searchData(parameter: parameter).then((value) {
  //     Navigator.push(
  //         context,
  //         MaterialPageRoute(
  //           builder: (context) => EditProfileScreen(searchData: value),
  //         ));
  //     setState(() {
  //       show = false;
  //     });
  //     print(value);
  //   }).onError((error, stackTrace) {
  //     print(error);
  //   });
  // }

  // Future<SearchModel> fetchSearchDataFromAPI(id) async {
  //   setState(() {
  //     show = true;
  //   });
  //
  //   Map<String, dynamic> parameter = {
  //     'app_user': id,
  //   };
  //
  //   try {
  //     // Assuming searchData returns a SearchModel
  //     SearchModel searchModel = await searchData(parameter: parameter);
  //
  //     Navigator.push(
  //       context,
  //       MaterialPageRoute(
  //         builder: (context) => EditProfileScreen(searchModels: searchModel),
  //       ),
  //     );
  //
  //     setState(() {
  //       show = false;
  //     });
  //
  //     return searchModel; // Return the fetched data
  //   } catch (error) {
  //     print(error);
  //     return SearchModel(data: [], flag: 0, message: "Error fetching data");
  //   }
  // }

  // String? getUserIdFromPreferences() {
  //   // Replace this with your actual shared preferences logic
  //   // to retrieve the user ID
  //   // Example:
  //   // return mySharedPreferences.getString('user_id');
  // }
  //
  // void findUserInSearchData(SearchModel searchData) {
  //   String? userIdToFind = getUserIdFromPreferences();
  //
  //   if (userIdToFind != null) {
  //     searchDatum? userDatum = searchData.data.firstWhere(
  //           (datum) => datum?.userId == userIdToFind,
  //       orElse: () => null,
  //     );
  //
  //     if (userDatum != null) {
  //       // Now you have the matching user data
  //       print(userDatum.userId);
  //       print(userDatum.firstName);
  //       print(userDatum.middleName);
  //       // Access other fields as needed
  //     } else {
  //       print("User not found in searchData");
  //     }
  //   } else {
  //     print("User ID not found in shared preferences");
  //   }
  // }

  // Future<void> fetchDataFromAPI(id) async {
  //   setState(() {
  //     show = true;
  //   });
  //
  //   // Fetch user data
  //   Map<String, dynamic> userParameter = {
  //     "user_id": id,
  //   };
  //
  //   // Fetch search data
  //   Map<String, dynamic> searchParameter = {
  //     "app_user": login.parentId,
  //   };
  //
  //   // Using Future.wait to wait for both API calls to complete
  //   await Future.wait([
  //     userData(parameter: userParameter),
  //     fetchSearchDataFromAPI(login.userId),
  //   ]).then((List<dynamic> values) {
  //     Navigator.pop(context);
  //
  //     // Extract user data and search data
  //     // Extract user data and search data
  //     UserModel userData = values[0] as UserModel;
  //     SearchModel searchData = values[1] as SearchModel;
  //
  //     var userInSearchData = searchData != null
  //         ? searchData.data.firstWhere((user) => user!.userId == id, orElse: () => null)
  //         : null;
  //
  //     if (searchData != null) {
  //       // Find the user in the search data based on userId
  //       var userInSearchData = searchData.data
  //           .firstWhere((user) => user!.userId == id, orElse: () => null);
  //
  //       // Check if the user was found in search data
  //       if (userInSearchData != null) {
  //         // Now you can navigate to the EditProfileScreen with both user and search data
  //         Navigator.push(
  //           context,
  //           MaterialPageRoute(
  //             builder: (context) => EditProfileScreen(
  //               userData: userData,
  //               searchData: userInSearchData,
  //             ),
  //           ),
  //         );
  //       } else {
  //         // Handle the case where the user was not found in search data
  //         print("User with ID $id not found in search data");
  //       }
  //     } else {
  //       // Handle the case where searchData is null
  //       print("Search data is null");
  //     }
  //
  //     setState(() {
  //       show = false;
  //     });
  //   }).onError((error, stackTrace) {
  //     print(error);
  //   });
  // }
  //
  // Future<void> fetchSearchDataFromAPI(String userId) async {
  //   setState(() {
  //     show = true;
  //   });
  //
  //   Map<String, dynamic> parameter = {
  //     'app_user': userId,
  //   };
  //
  //   await searchData(parameter: parameter).then((value) {
  //     Navigator.pop(context);
  //
  //     // Check if the response has data
  //     if (value.data != null) {
  //       // Check if the user with the specified ID exists in the list
  //       bool userExists = false;
  //
  //       for (var user in value.data) {
  //         if (user?.userId == userId) {
  //           userExists = true;
  //           break;
  //         }
  //       }
  //
  //       if (userExists) {
  //         // Now you can navigate to the EditProfileScreen
  //         Navigator.push(
  //           context,
  //           MaterialPageRoute(
  //             builder: (context) => EditProfileScreen(searchData: value),
  //           ),
  //         );
  //       } else {
  //         // Handle the case where the user with the specified ID is not found
  //         print('User with ID $userId not found');
  //       }
  //     } else {
  //       // Handle the case where the response data is null
  //       print('No data in the response');
  //     }
  //
  //     setState(() {
  //       show = false;
  //     });
  //   }).onError((error, stackTrace) {
  //     print(error);
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        WillPopScope(
          onWillPop: () async {
            // if(scaffoldKey.currentState!.isDrawerOpen){
            //   scaffoldKey.currentState!.closeDrawer();
            // }
            return Navigator.of(context).canPop();
          },
          // child: ScrollConfiguration(
          //     behavior: MyBehavior(),
          child: Drawer(
            width: screenwidth(context, dividedby: 1.33.w),
            child: Column(
              children: [
                Container(
                  child: SafeArea(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          height: screenheight(context, dividedby: 75.h),
                        ),
                        Padding(
                          padding: EdgeInsets.all(7),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Spacer(),
                              CircleAvatar(
                                backgroundColor: Colors.black,
                                radius: 40.r,
                                child: CircleAvatar(
                                  backgroundColor: Colors.white,
                                  radius: 38.r,
                                  child: Material(
                                    elevation: 0,
                                    shape: CircleBorder(side: BorderSide(width: 0.3, color: Colors.grey.shade900)),
                                    clipBehavior: Clip.antiAlias,
                                    color: Colors.transparent,
                                    child: login.profilePic != null && login.profilePic != ""
                                        ? Ink.image(
                                            image: NetworkImage(URLs.imagepath + login.profilePic!),
                                            // fit: BoxFit.cover,
                                            width: 72.h,
                                            height: 72.w,
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
                                                              image: NetworkImage(URLs.imagepath + login.profilePic!),
                                                              fit: BoxFit.contain),
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
                                          )
                                        : Ink.image(
                                            image: AssetImage('images/avatarlogos.jpg'),
                                            // fit: BoxFit.cover,
                                            width: 72.h,
                                            height: 72.w,
                                            child: InkWell(
                                              radius: 0,
                                              onTap: () async {
                                                Navigator.pop(context);
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
                                                              fit: BoxFit.contain),
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
                              Spacer(
                                flex: 2,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 150,
                                    child: Text(
                                      login.fullName ?? "",
                                      // "Sonal Sharma Shamim With Sequencial",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        // fontSize: 15.sp
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  SizedBox(
                                    height: screenheight(
                                      context,
                                      dividedby: 25.h,
                                    ),
                                    child: ElevatedButton(
                                      onPressed: () async  {
                                        await fetchDataFromAPI("${login.userId}");
                                        // await fetchCityData('5Xf!-VQ*Zjad>@Q-}Bwb@w2/YrY#n','2','4030');

                                        // Fetch search data
                                        // Directly call fetchDataFromAPI with the user ID and search data
                                        // await fetchDataFromAPI("${login.userId}");
                                        // var searchData = await fetchSearchDataFromAPI("${login.userId}");
                                        // print(searchData);
                                      },
                                      child: Text(
                                        'View Profile',
                                        textScaleFactor: 0.85,
                                      ),
                                      style: TextButton.styleFrom(elevation: 0, backgroundColor: Colors.black),
                                    ),
                                  ),
                                ],
                              ),
                              Spacer(),
                            ],
                          ),
                        ),
                        // Padding(padding: EdgeInsets.symmetric(vertical: screenheight(context,dividedby: 40.h))),
                        SizedBox(
                          height: screenheight(context, dividedby: 50.h),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: InkWell(
                            onTap: () async {
                              launch("https://www.vakalat.com/");
                              Fluttertoast.showToast(
                                  msg: "Launching URL In Browser...", fontSize: 12.sp, backgroundColor: Colors.green);
                              // String url = "https://www.vakalat.com/";
                              // var urllaunchable = await canLaunch(
                              //     url); //canLaunch is from url_launcher package
                              // if (urllaunchable) {
                              //   await launch(
                              //       url); //launch is from url_launcher package to launch URL
                              //   Fluttertoast.showToast(
                              //       msg: "Launching URL 'Vakalat.com' ...",
                              //       fontSize: 12.sp,
                              //       backgroundColor: Colors.green);
                              // } else {
                              //   Fluttertoast.showToast(
                              //       msg: "URL Launch Error !!!",
                              //       fontSize: 12.sp,
                              //       backgroundColor: Colors.green);
                              // }
                            },
                            child: Container(
                              height: screenheight(context, dividedby: 35.h),
                              width: double.infinity,
                              color: Colors.black,
                              child: Center(
                                child: Text(
                                  "Powered By : Vakalat.com",
                                  textScaleFactor: 1,
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      // fontSize: 12.sp,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: GlowingOverscrollIndicator(
                    axisDirection: AxisDirection.down,
                    color: Colors.grey.shade700,
                    child: ScrollConfiguration(
                      behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
                      child: Scrollbar(
                        controller: _controller,
                        interactive: true,
                        thickness: 7.5.r,
                        radius: Radius.circular(5.r),
                        child: SingleChildScrollView(
                            controller: _controller,
                            scrollDirection: Axis.vertical,
                            child: Column(
                              children: [
                                SizedBox(
                                  height: screenheight(context, dividedby: 50.h),
                                ),
                                ListTile(
                                  // dense: true,
                                  visualDensity: VisualDensity(vertical: -2),
                                  leading: Icon(
                                    CupertinoIcons.home,
                                    color: Colors.black,
                                  ),
                                  title: Text(
                                    "Home",
                                    style: TextStyle(color: Colors.black, fontWeight: FontWeight.w400),
                                    textScaleFactor: 1.2,
                                  ),
                                  onTap: () {
                                    Navigator.of(context).pop();
                                    Navigator.pushNamed(context, '/homePage');
                                  },
                                ),
                                ListTile(
                                    visualDensity: VisualDensity(vertical: -2),
                                    leading: Icon(
                                      CupertinoIcons.search,
                                      color: Colors.black,
                                      //onPressed: () {},
                                    ),
                                    title: Text(
                                      "Search",
                                      style: TextStyle(color: Colors.black, fontWeight: FontWeight.w400),
                                      textScaleFactor: 1.2,
                                    ),
                                    onTap: () {
                                      Navigator.of(context).pop();
                                      Navigator.pushNamed(context, '/searchTile');
                                    }),
                                ListTile(
                                  visualDensity: VisualDensity(vertical: -2),
                                  leading: Icon(
                                    CupertinoIcons.captions_bubble,
                                    color: Colors.black,
                                    //onPressed: () {},
                                  ),
                                  title: Text(
                                    "Notice Board",
                                    style: TextStyle(color: Colors.black, fontWeight: FontWeight.w400),
                                    textScaleFactor: 1.2,
                                  ),
                                  onTap: () {
                                    Navigator.of(context).pop();
                                    Navigator.pushNamed(context, '/noticeBoardTile');
                                  },
                                ),
                                ListTile(
                                  visualDensity: VisualDensity(vertical: -2),
                                  leading: Icon(
                                    CupertinoIcons.calendar_badge_plus,
                                    color: Colors.black,
                                    //onPressed: () {},
                                  ),
                                  title: Text(
                                    "Events",
                                    style: TextStyle(color: Colors.black, fontWeight: FontWeight.w400),
                                    textScaleFactor: 1.2,
                                  ),
                                  onTap: () {
                                    Navigator.of(context).pop();
                                    Navigator.pushNamed(context, '/eventTile');
                                  },
                                ),
                                ListTile(
                                  visualDensity: VisualDensity(vertical: -2),
                                  leading: Icon(
                                    CupertinoIcons.group_solid,
                                    color: Colors.black,
                                    //onPressed: () {},
                                  ),
                                  title: Text(
                                    "Committee",
                                    style: TextStyle(color: Colors.black, fontWeight: FontWeight.w400),
                                    textScaleFactor: 1.2,
                                  ),
                                  onTap: () {
                                    Navigator.of(context).pop();
                                    Navigator.pushNamed(context, '/committeeTile');
                                  },
                                ),
                                // ListTile(
                                //   visualDensity: VisualDensity(vertical: -2),
                                //   leading: Icon(
                                //     CupertinoIcons.bookmark_solid,
                                //     color: Colors.black,
                                //     //onPressed: () {},
                                //   ),
                                //   title: Text(
                                //     "Blog",
                                //     style: TextStyle(color: Colors.black, fontWeight: FontWeight.w400),
                                //     textScaleFactor: 1.2,
                                //   ),
                                //   onTap: () {
                                //     Navigator.of(context).pop();
                                //     Navigator.pushNamed(context, '/blogTile');
                                //   },
                                // ),
                                ListTile(
                                  visualDensity: VisualDensity(vertical: -2),
                                  leading: Icon(
                                    CupertinoIcons.link,
                                    color: Colors.black,
                                    //onPressed: () {},
                                  ),
                                  title: Text(
                                    "Important Links",
                                    style: TextStyle(color: Colors.black, fontWeight: FontWeight.w400),
                                    textScaleFactor: 1.2,
                                  ),
                                  onTap: () {
                                    Navigator.of(context).pop();
                                    Navigator.pushNamed(context, '/importantLinksTile');
                                  },
                                ),
                                ListTile(
                                  visualDensity: VisualDensity(vertical: -2),
                                  leading: Icon(
                                    CupertinoIcons.doc_chart_fill,
                                    color: Colors.black,
                                    //onPressed: () {},
                                  ),
                                  title: Text(
                                    "Public Documents",
                                    style: TextStyle(color: Colors.black, fontWeight: FontWeight.w400),
                                    textScaleFactor: 1.2,
                                  ),
                                  onTap: () {
                                    Navigator.of(context).pop();
                                    Navigator.pushNamed(context, '/publicDocumentsTile');
                                  },
                                ),
                                ListTile(
                                  visualDensity: VisualDensity(vertical: -2),
                                  leading: Icon(
                                    Icons.verified_user_rounded,
                                    color: Colors.black,
                                  ),
                                  title: Text(
                                    "Achievement",
                                    style: TextStyle(color: Colors.black, fontWeight: FontWeight.w400),
                                    textScaleFactor: 1.2,
                                  ),
                                  onTap: () {
                                    Navigator.of(context).pop();
                                    Navigator.pushNamed(context, '/achievementTile');
                                  },
                                ),
                                ListTile(
                                  visualDensity: VisualDensity(vertical: -2),
                                  leading: Icon(
                                    // CupertinoIcons.antenna_radiowaves_left_right,
                                    Icons.school_rounded,
                                    color: Colors.black,
                                    //onPressed: () {},
                                  ),
                                  title: Text(
                                    "Participation",
                                    style: TextStyle(color: Colors.black, fontWeight: FontWeight.w400),
                                    textScaleFactor: 1.2,
                                  ),
                                  onTap: () {
                                    Navigator.of(context).pop();
                                    Navigator.pushNamed(context, '/participationTile');
                                  },
                                ),
                                ListTile(
                                  visualDensity: VisualDensity(vertical: -2),
                                  leading: Icon(
                                    CupertinoIcons.globe,
                                    color: Colors.black,
                                    //onPressed: () {},
                                  ),
                                  title: Text(
                                    "Legal News",
                                    style: TextStyle(color: Colors.black, fontWeight: FontWeight.w400),
                                    textScaleFactor: 1.2,
                                  ),
                                  onTap: () {
                                    Navigator.of(context).pop();
                                    Navigator.pushNamed(context, '/newsTile');
                                  },
                                ),
                                ListTile(
                                  visualDensity: VisualDensity(vertical: -2),
                                  leading: Icon(
                                    CupertinoIcons.phone_fill_badge_plus,
                                    color: Colors.black,
                                    //onPressed: () {},
                                  ),
                                  title: Text(
                                    "Contact Us",
                                    style: TextStyle(color: Colors.black, fontWeight: FontWeight.w400),
                                    textScaleFactor: 1.2,
                                  ),
                                  onTap: () {
                                    Navigator.of(context).pop();
                                    Navigator.pushNamed(context, '/contactUsTile');
                                  },
                                ),
                                ListTile(
                                  visualDensity: VisualDensity(vertical: -2),
                                  leading: Icon(
                                    CupertinoIcons.square_arrow_left_fill,
                                    color: Colors.black,
                                  ),
                                  title: Text(
                                    "Logout",
                                    style: TextStyle(color: Colors.black, fontWeight: FontWeight.w400),
                                    textScaleFactor: 1.2,
                                  ),
                                  onTap: () {
                                    Navigator.pop(context);
                                    logoutPopup();
                                  },
                                ),
                                SizedBox(
                                  height: screenheight(context, dividedby: 150.h),
                                ),
                              ],
                            )),
                      ),
                    ),
                  ),
                ),
                // SizedBox(
                //   height: screenheight(context, dividedby: 15.h),
                // ),
                // InkWell(
                //   onTap: () async {
                //     launch("https://www.vakalat.com/");
                //     Fluttertoast.showToast(
                //         msg: "Launching URL In Browser...", fontSize: 12.sp, backgroundColor: Colors.green);
                //     // String url = "https://www.vakalat.com/";
                //     // var urllaunchable = await canLaunch(
                //     //     url); //canLaunch is from url_launcher package
                //     // if (urllaunchable) {
                //     //   await launch(
                //     //       url); //launch is from url_launcher package to launch URL
                //     //   Fluttertoast.showToast(
                //     //       msg: "Launching URL 'Vakalat.com' ...",
                //     //       fontSize: 12.sp,
                //     //       backgroundColor: Colors.green);
                //     // } else {
                //     //   Fluttertoast.showToast(
                //     //       msg: "URL Launch Error !!!",
                //     //       fontSize: 12.sp,
                //     //       backgroundColor: Colors.green);
                //     // }
                //   },
                //   child: Container(
                //     height: screenheight(context, dividedby: 32.h),
                //     color: Colors.black,
                //     child: Center(
                //       child: Text(
                //         "Powered By : Vakalat.com",
                //         textScaleFactor: 1,
                //         textAlign: TextAlign.start,
                //         style: TextStyle(
                //             // fontSize: 12.sp,
                //             color: Colors.white),
                //       ),
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
          // ),
        ),
        show == true ? Center(child: Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
              color: Colors.black,
            borderRadius: BorderRadius.circular(20)
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(color: Colors.white, strokeWidth: 4,),
              SizedBox(height: 20,),
              Text("Loading",style: TextStyle(color: Colors.white),),
              SizedBox(height: 10,),
              Text("Please Wait...",style: TextStyle(color: Colors.white),),
            ],
          ),
        ),) : SizedBox(),
      ],
    );
  }
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
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
