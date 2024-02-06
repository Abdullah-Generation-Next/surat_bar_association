import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:surat_district_bar_association/model/login_model.dart';
import 'package:surat_district_bar_association/services/AppConfig.dart';
import 'package:surat_district_bar_association/widgets/sharedpref.dart';
import '../drawer_details/search/search_tile.dart';
import '../services/all_api_services.dart';
import '../widgets/media_query_sizes.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  // LoginModel login = loginModelFromJson(SharedPref.get(prefKey: PrefKey.saveUser)!);
  final ScrollController _controller = ScrollController();
  TextEditingController oldPassword = TextEditingController();
  TextEditingController newPassword = TextEditingController();
  TextEditingController reTypeNewPassword = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _validateOldPassword = false;
  bool _validateNewPassword = false;
  bool _validateReTypeNewPassword = false;
  bool _validatePasswordMatch = false;
  bool oldPasswordVisible = true;
  bool newPasswordVisible = true;
  bool reTypePasswordVisible = true;
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

  changePassword() {
    setState(() {
      show = true;
    });
    LoginModel login = loginModelFromJson(SharedPref.get(prefKey: PrefKey.saveUser)!);
    //Change Parameter according to API
    Map<String, dynamic> parameter = {
      'mobile': login.mobile,
      'old_password': oldPassword.text,
      'new_password': newPassword.text,
      'confirm_password': reTypeNewPassword.text,
    };
    changePasswordData(parameter: parameter).then((value) async {
      if(value.message?.contains('successfully') == true) {
        await Fluttertoast.showToast(
            msg: value.message ?? "Enter Strong Password",
            fontSize: 12.sp,
            textColor: Colors.white,
            backgroundColor: Colors.green);
        Navigator.of(context).pop();
      }
      else {
        Fluttertoast.showToast(
            msg: value.message ?? "Enter Strong Password",
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
    oldPassword.dispose();
    newPassword.dispose();
    reTypeNewPassword.dispose();
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
          appBar: AppBar(
            iconTheme: IconThemeData(color: Colors.black),
            title: Text(
              'Change Password',
              textScaleFactor: 0.8,
              style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
            centerTitle: true,
            backgroundColor: Colors.white,
            elevation: 0,
            automaticallyImplyLeading: true,
          ),
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
                            'Change Password',
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
                            'Welcome to ${AppConfig.sortName} App, please enter your old password, and new Password.',
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
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Align(
                                  alignment: AlignmentDirectional.topStart,
                                  child: Container(
                                    width: 70,
                                    child: Text(
                                      'Old Password : ',
                                      textScaleFactor: 1,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    ),
                                  ),
                                ),
                                // Padding(padding: EdgeInsets.only(top: 5)),
                                Expanded(
                                  child: Container(
                                    height: 60,
                                    width: double.infinity,
                                    // constraints: BoxConstraints(),
                                    // decoration: BoxDecoration(
                                    //   borderRadius:
                                    //   BorderRadius.all(Radius.circular(30.r)),
                                    //   color: Colors.grey.shade400,
                                    // ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 5, right: 5),
                                      child: Center(
                                        child: TextFormField(
                                          cursorHeight: 22,
                                          autocorrect: true,
                                          textAlign: TextAlign.start,
                                          cursorColor: Colors.black,
                                          textInputAction: TextInputAction.done,
                                          controller: oldPassword,
                                          keyboardType: TextInputType.text,
                                          obscureText: oldPasswordVisible,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: MediaQuery.of(context)
                                                .textScaleFactor *
                                                12,
                                          ),
                                          // validator: (String? value) {
                                          //   if (value != null && value.isEmpty) {
                                          //     return "\t\tPassword Required To Proceed !!!";
                                          //   }
                                          //   return null;
                                          // },
                                          decoration: InputDecoration(
                                            prefixIcon: Padding(
                                              padding: EdgeInsets.only(
                                                  left: 10, right: 10),
                                              child: Icon(
                                                Icons.password_rounded,
                                                color: Colors.grey.shade600,
                                              ),
                                            ),
                                            // hintText: 'Enter Password',
                                            hintText: '',
                                            hintStyle: TextStyle(
                                              fontSize: MediaQuery.of(context)
                                                  .textScaleFactor *
                                                  12,
                                              color: Colors.grey.shade600,
                                            ),
                                            suffixIcon: IconButton(
                                              icon: Icon(
                                                oldPasswordVisible ?
                                                Icons.visibility_off : Icons.visibility,
                                                color: oldPasswordVisible ? Colors.grey.shade600 : Colors.black,
                                              ),
                                              onPressed: () {
                                                setState(
                                                      () {
                                                    oldPasswordVisible =
                                                    !oldPasswordVisible;
                                                  },
                                                );
                                              },
                                            ),
                                            disabledBorder:
                                            OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(15)),
                                              borderSide: BorderSide(color: Colors.grey.shade400),
                                            ),
                                            enabledBorder:
                                            OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(15)),
                                              borderSide: BorderSide(color: Colors.grey.shade400),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(color: Colors.grey.shade400),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(15)),
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
                            _validateOldPassword
                                ? Padding(
                              padding: const EdgeInsets.only(left: 75),
                              child: Column(
                                children: [
                                  Text(
                                    _validateOldPassword ? "Please enter your old password to continue!!!" : "",
                                    textScaleFactor: 1,
                                    style: TextStyle(color: Colors.red),
                                  ),
                                ],
                              ),
                            )
                                : SizedBox(),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Align(
                                  alignment: AlignmentDirectional.topStart,
                                  child: Container(
                                    width: 70,
                                    child: Text(
                                      'New Password : ',
                                      textScaleFactor: 1,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    ),
                                  ),
                                ),
                                // Padding(padding: EdgeInsets.only(top: 5)),
                                Expanded(
                                  child: Container(
                                    height: 60,
                                    width: double.infinity,
                                    // constraints: BoxConstraints(),
                                    // decoration: BoxDecoration(
                                    //   borderRadius:
                                    //   BorderRadius.all(Radius.circular(30.r)),
                                    //   color: Colors.grey.shade400,
                                    // ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 5, right: 5),
                                      child: Center(
                                        child: TextFormField(
                                          cursorHeight: 22,
                                          autocorrect: true,
                                          textAlign: TextAlign.start,
                                          cursorColor: Colors.black,
                                          textInputAction: TextInputAction.done,
                                          controller: newPassword,
                                          keyboardType: TextInputType.text,
                                          obscureText: newPasswordVisible,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: MediaQuery.of(context)
                                                .textScaleFactor *
                                                12,
                                          ),
                                          // validator: (String? value) {
                                          //   if (value != null && value.isEmpty) {
                                          //     return "\t\tPassword Required To Proceed !!!";
                                          //   }
                                          //   return null;
                                          // },
                                          decoration: InputDecoration(
                                            prefixIcon: Padding(
                                              padding: EdgeInsets.only(
                                                  left: 10, right: 10),
                                              child: Icon(
                                                Icons.password_rounded,
                                                color: Colors.grey.shade600,
                                              ),
                                            ),
                                            // hintText: 'Enter Password',
                                            hintText: '',
                                            hintStyle: TextStyle(
                                              fontSize: MediaQuery.of(context)
                                                  .textScaleFactor *
                                                  12,
                                              color: Colors.grey.shade600,
                                            ),
                                            suffixIcon: IconButton(
                                              icon: Icon(
                                                newPasswordVisible ?
                                                Icons.visibility_off : Icons.visibility,
                                                color: newPasswordVisible ? Colors.grey.shade600 : Colors.black,
                                              ),
                                              onPressed: () {
                                                setState(
                                                      () {
                                                        newPasswordVisible =
                                                    !newPasswordVisible;
                                                  },
                                                );
                                              },
                                            ),
                                            disabledBorder:
                                            OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(15)),
                                              borderSide: BorderSide(color: Colors.grey.shade400),
                                            ),
                                            enabledBorder:
                                            OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(15)),
                                              borderSide: BorderSide(color: Colors.grey.shade400),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(color: Colors.grey.shade400),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(15)),
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
                            _validateNewPassword
                                ? Padding(
                              padding: const EdgeInsets.only(left: 75),
                              child: Column(
                                children: [
                                  Text(
                                    _validateNewPassword ? "Please enter your new password to continue!!!" : "",
                                    textScaleFactor: 1,
                                    style: TextStyle(color: Colors.red),
                                  ),
                                ],
                              ),
                            )
                                : SizedBox(),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Align(
                                  alignment: AlignmentDirectional.topStart,
                                  child: Container(
                                    width: 70,
                                    child: Text(
                                      'Confirm New Password : ',
                                      textScaleFactor: 1,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    ),
                                  ),
                                ),
                                // Padding(padding: EdgeInsets.only(top: 5)),
                                Expanded(
                                  child: Container(
                                    height: 60,
                                    width: double.infinity,
                                    // constraints: BoxConstraints(),
                                    // decoration: BoxDecoration(
                                    //   borderRadius:
                                    //   BorderRadius.all(Radius.circular(30.r)),
                                    //   color: Colors.grey.shade400,
                                    // ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 5, right: 5),
                                      child: Center(
                                        child: TextFormField(
                                          cursorHeight: 22,
                                          autocorrect: true,
                                          textAlign: TextAlign.start,
                                          cursorColor: Colors.black,
                                          textInputAction: TextInputAction.done,
                                          controller: reTypeNewPassword,
                                          keyboardType: TextInputType.text,
                                          obscureText: reTypePasswordVisible,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: MediaQuery.of(context)
                                                .textScaleFactor *
                                                12,
                                          ),
                                          // validator: (String? value) {
                                          //   if (value != null && value.isEmpty) {
                                          //     return "\t\tPassword Required To Proceed !!!";
                                          //   }
                                          //   return null;
                                          // },
                                          decoration: InputDecoration(
                                            prefixIcon: Padding(
                                              padding: EdgeInsets.only(
                                                  left: 10, right: 10),
                                              child: Icon(
                                                Icons.password_rounded,
                                                color: Colors.grey.shade600,
                                              ),
                                            ),
                                            // hintText: 'Enter Password',
                                            hintText: '',
                                            hintStyle: TextStyle(
                                              fontSize: MediaQuery.of(context)
                                                  .textScaleFactor *
                                                  12,
                                              color: Colors.grey.shade600,
                                            ),
                                            suffixIcon: IconButton(
                                              icon: Icon(
                                                reTypePasswordVisible ?
                                                Icons.visibility_off : Icons.visibility,
                                                color: reTypePasswordVisible ? Colors.grey.shade600 : Colors.black,
                                              ),
                                              onPressed: () {
                                                setState(
                                                      () {
                                                        reTypePasswordVisible =
                                                    !reTypePasswordVisible;
                                                  },
                                                );
                                              },
                                            ),
                                            disabledBorder:
                                            OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(15)),
                                              borderSide: BorderSide(color: Colors.grey.shade400),
                                            ),
                                            enabledBorder:
                                            OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(15)),
                                              borderSide: BorderSide(color: Colors.grey.shade400),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(color: Colors.grey.shade400),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(15)),
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
                            _validateReTypeNewPassword
                                ? Padding(
                              padding: const EdgeInsets.only(left: 70),
                              child: Column(
                                children: [
                                  Text(
                                    _validateReTypeNewPassword ? "Please re-enter new password to continue!!!" : "",
                                    textScaleFactor: 1,
                                    style: TextStyle(color: Colors.red),
                                  ),
                                ],
                              ),
                            )
                                : _validatePasswordMatch
                                ? Padding(
                              padding: const EdgeInsets.only(left: 75),
                              child: Column(
                                children: [
                                  Text(
                                    _validatePasswordMatch ? "New password and re-enter password doesn't match!!!" : "",
                                    textScaleFactor: 1,
                                    style: TextStyle(color: Colors.red),
                                  ),
                                ],
                              ),
                            )
                                : SizedBox(),
                            SizedBox(
                              height: 5,
                            ),
                            SizedBox(
                              width: double.infinity,
                              height: 40.h,
                              child: ElevatedButton(
                                onPressed: () {
                                  if(_formKey.currentState!.validate()){
                                    setState(() {
                                      _validateOldPassword = false;
                                      _validateNewPassword = false;
                                      _validateReTypeNewPassword = false;
                                      _validatePasswordMatch = false;
                                      if (oldPassword.text.isEmpty) {
                                        _validateOldPassword = true;
                                        Fluttertoast.showToast(
                                            msg: "Please enter your old password to continue!!!",
                                            fontSize: 12.sp,
                                            textColor: Colors.white,
                                            backgroundColor: Colors.red);
                                      }
                                      else if (newPassword.text.isEmpty) {
                                        _validateNewPassword = true;
                                        Fluttertoast.showToast(
                                            msg: "Please enter your new password to continue!!!",
                                            fontSize: 12.sp,
                                            textColor: Colors.white,
                                            backgroundColor: Colors.red);
                                      }
                                      else if (reTypeNewPassword.text.isEmpty) {
                                        _validateReTypeNewPassword = true;
                                        Fluttertoast.showToast(
                                            msg: "Please re-enter your new password to continue!!!",
                                            fontSize: 12.sp,
                                            textColor: Colors.white,
                                            backgroundColor: Colors.red);
                                      }
                                      else if (newPassword.text != reTypeNewPassword.text) {
                                        _validatePasswordMatch = true;
                                        Fluttertoast.showToast(
                                            msg: "New password and re-enter password doesn't match!!!",
                                            fontSize: 12.sp,
                                            textColor: Colors.white,
                                            backgroundColor: Colors.red);
                                      }
                                      else {
                                        changePassword();
                                      }
                                    });

                                  }
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
