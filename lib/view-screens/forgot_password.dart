import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:surat_district_bar_association/services/AppConfig.dart';
import '../drawer_details/search/search_tile.dart';
import '../services/all_api_services.dart';
import '../widgets/media_query_sizes.dart';

class ForgotAgain extends StatefulWidget {
  const ForgotAgain({super.key});

  @override
  State<ForgotAgain> createState() => _ForgotAgainState();
}

class _ForgotAgainState extends State<ForgotAgain> {
  // LoginModel login = loginModelFromJson(SharedPref.get(prefKey: PrefKey.saveUser)!);
  final ScrollController _controller = ScrollController();
  TextEditingController mobileController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _validate = false;
  bool show = false;

  // Future<void> fetchDataFromAPI(appUserId, mobile) async {
  //   Map<String, dynamic> parameter = {
  //     "app_user": appUserId,
  //     "mobile" : mobile,
  //   };
  //   await forgotData(parameter: parameter).then((value) {
  //     setState(() {
  //
  //     });
  //     // print(value);
  //   }).onError((error, stackTrace) {
  //     print(error);
  //   });
  // }

  forgotPassword() {
    setState(() {
      show = true;
    });
    Map<String, dynamic> parameter = {
      'app_user': AppConfig.APP_USER,
      'mobile': mobileController.text,
    };
    forgotData(parameter: parameter).then((value) {
      if(value.isMailSent == true) {
        Fluttertoast.showToast(
            msg: value.message ?? "",
            fontSize: 12.sp,
            textColor: Colors.white,
            backgroundColor: Colors.green);
      }
      else if (mobileController.text.isNotEmpty && value.isMailSent != true) {
        setState(() {
          show = false;
        });
        Fluttertoast.showToast(
            msg: value.message ?? "Enter Valid Credentials Please",
            fontSize: 12.sp,
            textColor: Colors.white,
            backgroundColor: Colors.red);
      }
      setState(() {
        show = false;
      });
    }).onError((error, stackTrace) {
      //On Server, If Fetching Error...
      Fluttertoast.showToast(
        msg: "Something Went Wrong",
        fontSize: 12.sp,
        textColor: Colors.white,
        backgroundColor: Colors.red,
      );
    });
  }

  @override
  void dispose() {
    mobileController.dispose();
    super.dispose();
  }

  // moveToLogin(BuildContext context) async {
  //     if (_formKey.currentState!.validate() &&
  //         mobileController.text.isNotEmpty) {
  //       Fluttertoast.showToast(
  //           msg: "We Have Sent An Email\nPlease Check Out Inbox To Reset Password",
  //           fontSize: 12.sp,
  //           backgroundColor: Colors.green);
  //       Navigator.pushNamed(context, '/loginAgain');
  //     } else if (_formKey.currentState!.validate() &&
  //         mobileController.text.isEmpty) {
  //       Fluttertoast.showToast(
  //           msg: "Enter Credentials Please",
  //           fontSize: 12.sp,
  //           textColor: Colors.white,
  //           backgroundColor: Colors.red);
  //     }
  // }

  Future<bool> showExitPopup() async {
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
    return Stack(
      children: [
        Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: Colors.white,
          body: ScrollConfiguration(
            behavior: MyBehavior(),
            child: ListView(
              shrinkWrap: true,
              controller: _controller,
              children: [
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      SizedBox(height: 75),
                      Container(
                        height: screenheight(context, dividedby: 7.5.h),
                        width: screenwidth(context, dividedby: 2.5.w),
                        color: Colors.white,
                        child: Ink(
                          child: Image(
                            image: AssetImage('images/${AppConfig.barAssociation.toLowerCase()}_district_logo.png'),
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20, top: 30),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'Forgot Password',
                            textScaleFactor: 2,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20, top: 40,right: 20),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'Welcome to ${AppConfig.sortName} App, please provide your mobile number, an E-mail will be sent to Reset Password.',
                            textScaleFactor: 1,
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.black),
                          ),
                        ),
                      ),
                      Padding(padding: EdgeInsets.only(top: 30)),
                      // Spacer(),
                      // Container(
                      //   constraints: BoxConstraints(
                      //       maxHeight: MediaQuery.of(context).size.height * 0.55
                      //   ),
                      //   decoration: BoxDecoration(
                      //     color: Colors.grey.shade300,
                      //     borderRadius: BorderRadius.only(
                      //         topLeft: Radius.circular(50),
                      //         topRight: Radius.circular(50)),
                      //   ),
                      //   child: Padding(
                      //     padding: EdgeInsets.symmetric(
                      //       horizontal: screenwidth(context, dividedby: 20.w),
                      //       vertical: screenheight(context, dividedby: 110.h),
                      //     ),
                      //     child:
                      //   ),
                      // ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Column(
                          children: [
                            Padding(padding: EdgeInsets.only(top: 40)),
                            Padding(
                              padding: const EdgeInsets.only(left: 5),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                // mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    'User ID : (Mobile No)',
                                    textScaleFactor: 1,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black87),
                                  ),
                                  // Padding(padding: EdgeInsets.only(top: 5)),
                                  // Expanded(
                                  //   child: Container(
                                  //     height: 60,
                                  //     width: double.infinity,
                                  //     // constraints: BoxConstraints(),
                                  //     // margin: EdgeInsets.symmetric(vertical: 5),
                                  //     // decoration: BoxDecoration(
                                  //     //   borderRadius:
                                  //     //   BorderRadius.all(Radius.circular(30.r)),
                                  //     //   color: Colors.grey.shade400,
                                  //     // ),
                                  //     child: Padding(
                                  //       padding:
                                  //       const EdgeInsets.only(left: 5, right: 5),
                                  //       child: Center(
                                  //         child: TextFormField(
                                  //           cursorHeight: 22,
                                  //           autocorrect: true,
                                  //           textAlign: TextAlign.start,
                                  //           cursorColor: Colors.black,
                                  //           textInputAction: TextInputAction.done,
                                  //           controller: mobileController,
                                  //           keyboardType: TextInputType.text,
                                  //           style: TextStyle(
                                  //             color: Colors.black,
                                  //             fontSize: MediaQuery.of(context)
                                  //                 .textScaleFactor *
                                  //                 12,
                                  //           ),
                                  //           // validator: (String? value) {
                                  //           //   if (value != null && value.isEmpty) {
                                  //           //     return "\t\tMobile Number Required To Proceed !!!";
                                  //           //   }
                                  //           //   return null;
                                  //           // },
                                  //           decoration: InputDecoration(
                                  //             prefixIcon: Padding(
                                  //               padding: EdgeInsets.only(
                                  //                   left: 10, right: 10),
                                  //               child: Icon(
                                  //                 Icons.person_4_rounded,
                                  //                 color: Colors.grey.shade600,
                                  //               ),
                                  //             ),
                                  //             // hintText: 'Enter Sanad No.',
                                  //             hintText: '',
                                  //             hintStyle: TextStyle(
                                  //                 fontSize: MediaQuery.of(context)
                                  //                     .textScaleFactor *
                                  //                     12,
                                  //                 color: Colors.grey.shade600),
                                  //             disabledBorder:
                                  //             OutlineInputBorder(
                                  //               borderRadius: BorderRadius.all(
                                  //                   Radius.circular(15)),
                                  //               borderSide: BorderSide(color: Colors.grey.shade400),
                                  //             ),
                                  //             enabledBorder: OutlineInputBorder(
                                  //               borderRadius: BorderRadius.all(
                                  //                   Radius.circular(15)),
                                  //               borderSide: BorderSide(color: Colors.grey.shade400),
                                  //             ),
                                  //             focusedBorder: OutlineInputBorder(
                                  //               borderSide: BorderSide(color: Colors.grey.shade400),
                                  //               borderRadius:
                                  //               BorderRadius.circular(15.r),
                                  //             ),
                                  //             border: OutlineInputBorder(
                                  //               borderSide: BorderSide(color: Colors.grey.shade400),
                                  //               borderRadius: BorderRadius.all(
                                  //                   Radius.circular(15)),
                                  //             ),
                                  //           ),
                                  //         ),
                                  //       ),
                                  //     ),
                                  //   ),
                                  // ),
                                ],),
                            ),
                            Padding(padding: EdgeInsets.only(top: 5)),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Expanded(
                                  child: Container(
                                    height: 60,
                                    width: double.infinity,
                                    // constraints: BoxConstraints(),
                                    // margin: EdgeInsets.symmetric(vertical: 5),
                                    // decoration: BoxDecoration(
                                    //   borderRadius:
                                    //   BorderRadius.all(Radius.circular(30.r)),
                                    //   color: Colors.grey.shade400,
                                    // ),
                                    child: Padding(
                                      padding:
                                      const EdgeInsets.only(left: 5, right: 5),
                                      child: Center(
                                        child: TextFormField(
                                          cursorHeight: 22,
                                          autocorrect: true,
                                          textAlign: TextAlign.start,
                                          cursorColor: Colors.black,
                                          textInputAction: TextInputAction.done,
                                          controller: mobileController,
                                          keyboardType: TextInputType.text,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: MediaQuery.of(context)
                                                .textScaleFactor *
                                                12,
                                          ),
                                          // validator: (String? value) {
                                          //   if (value != null && value.isEmpty) {
                                          //     return "\t\tMobile Number Required To Proceed !!!";
                                          //   }
                                          //   return null;
                                          // },
                                          decoration: InputDecoration(
                                            prefixIcon: Padding(
                                              padding: EdgeInsets.only(
                                                  left: 10, right: 10),
                                              child: Icon(
                                                Icons.person_4_rounded,
                                                color: Colors.grey.shade600,
                                              ),
                                            ),
                                            // hintText: 'Enter Sanad No.',
                                            hintText: '',
                                            hintStyle: TextStyle(
                                                fontSize: MediaQuery.of(context)
                                                    .textScaleFactor *
                                                    12,
                                                color: Colors.grey.shade600),
                                            disabledBorder:
                                            OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(15)),
                                              borderSide: BorderSide(color: Colors.grey.shade400),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(15)),
                                              borderSide: BorderSide(color: Colors.grey.shade400),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(color: Colors.grey.shade400),
                                              borderRadius:
                                              BorderRadius.circular(15.r),
                                            ),
                                            border: OutlineInputBorder(
                                              borderSide: BorderSide(color: Colors.grey.shade400),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(15)),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],),
                            _validate
                                ? Align(
                              alignment: AlignmentDirectional.centerStart,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 5.0),
                                child: Column(
                                  children: [
                                    Text(
                                      _validate ? "Mobile Number Required To Proceed !!!" : "",
                                      textScaleFactor: 1,
                                      style: TextStyle(color: Colors.red),
                                    ),
                                  ],
                                ),
                              ),
                            )
                                : SizedBox(),
                            SizedBox(
                              height: 5,
                            ),
                            Align(
                              alignment: Alignment.topRight,
                              child: TextButton(
                                  onPressed: () {
                                    Navigator.pushNamed(
                                        context, '/loginAgain');
                                  },
                                  style: TextButton.styleFrom(
                                    foregroundColor: Colors.white,
                                  ),
                                  child: Text(
                                    'Back to Login',
                                    textScaleFactor: 1.25,
                                    style: TextStyle(
                                      color: Colors.orange.shade500,
                                    ),
                                  )),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            SizedBox(
                              width: double.infinity,
                              height: 40.h,
                              child: ElevatedButton(
                                onPressed: () {
                                  if(_formKey.currentState!.validate()){
                                    if (mobileController.text.isEmpty) {
                                      Fluttertoast.showToast(
                                          msg: "Credentials Are Required To Proceed !!!",
                                          fontSize: 12.sp,
                                          textColor: Colors.white,
                                          backgroundColor: Colors.red);
                                    }
                                    if (mobileController.text.isNotEmpty) {
                                      forgotPassword();
                                    }
                                  }
                                  // moveToLogin(context);
                                  setState(() {
                                    mobileController.text.isEmpty
                                        ? _validate = true
                                        : _validate = false;
                                  });
                                },
                                style: ButtonStyle(
                                    elevation: MaterialStateProperty.all(0),
                                    backgroundColor:
                                    MaterialStateProperty.all(
                                        Colors.black),
                                    textStyle: MaterialStateProperty.all(
                                        TextStyle(
                                            fontWeight: FontWeight.w500)),
                                    shape: MaterialStateProperty.all(
                                        RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(30.r))))),
                                child: const Text(
                                  "SUBMIT",
                                  textScaleFactor: 1.17,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Container(
                      //   height: 160,
                      //   width: double.infinity,
                      //   decoration: BoxDecoration(
                      //     color: Colors.grey.shade300,
                      //   ),
                      // ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        show == true ? Center(child: CircularProgressIndicator(color: Colors.black,),) : SizedBox(),
      ],
    );
  }
}
