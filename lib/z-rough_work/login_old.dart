import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:surat_district_bar_association/services/AppConfig.dart';
import 'package:surat_district_bar_association/widgets/media_query_sizes.dart';

import '../services/all_api_services.dart';
import '../widgets/sharedpref.dart';
import '../widgets/common_fields.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final ScrollController _controller = ScrollController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _validate = false;
  bool _validate1 = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  // void login(String email, password) async {
  //   try {
  //     Response response =
  //     await post(Uri.parse("https://www.vakalat.com/api/login/user_login"), body: {
  //       'email': email,
  //       'password': password,
  //     });
  //
  //     if (response.statusCode == 200) {
  //       var data = jsonDecode(response.body.toString());
  //       // print(data['id']);
  //       print(data);
  //
  //       print('Account Created Successfully');
  //     } else {
  //       print('Failed');
  //     }
  //   } catch (e) {
  //     print(e.toString());
  //   }
  // }

  // Future<void> fetchDataFromAPI(email, password) async {
  //   await loginData(email,password).then((value) {
  //     setState(() {
  //     });
  //     // print(value);
  //   }).onError((error, stackTrace) {
  //     print(error);
  //   });
  // }
  login() {
    Map<String, dynamic> parameter = {
      'username': emailController.text,
      'password': passwordController.text,
      'user_master_id': '',
      'fcm_token': '',
      'app_user': AppConfig.APP_USER
    };
    loginData(parameter: parameter).then((value) {
      if (value.success == "yes") {
        SharedPref.save(
            value: jsonEncode(value.toJson()), prefKey: PrefKey.saveUser);
        moveToHome();
      } else if (emailController.text.isNotEmpty || passwordController.text.isNotEmpty){
        Fluttertoast.showToast(
            msg: "Enter Valid Credentials Please",
            fontSize: 12.sp,textColor: Colors.white,
            backgroundColor: Colors.red);
      } else if(emailController.text.isEmpty && passwordController.text.isEmpty){
        Fluttertoast.showToast(
            msg: "Enter Credentials Please",
            fontSize: 12.sp,textColor: Colors.white,
            backgroundColor: Colors.red);
      }
    }).onError((error, stackTrace) {          //On Server, If Fetching Error...
      Fluttertoast.showToast(
          msg: "Something Went Wrong",
          fontSize: 12.sp,textColor: Colors.white,
          backgroundColor: Colors.red,);
    });
  }
  // Future<LoginModel> login(String email, password) async {
  //
  //     Response response =
  //     await post(Uri.parse("https://www.vakalat.com/api/login/user_login"), body: );
  //
  //     if (response.statusCode == 200) {
  //       var data = loginModelFromJson(response.body);
  //       print(data);
  //       print('Login Sucessfull');
  //     } else {
  //       print('Failed');
  //     }
  //     return loginModelFromJson(response.body);
  // }

  @override
  void initState() {
    super.initState();
    emailController.text = 'G/2644/2012';
    passwordController.text = '9879073555';
  }

  moveToHome() async {
    Fluttertoast.showToast(
        msg: "LOGIN SUCCESS", fontSize: 12.sp, textColor: Colors.white, backgroundColor: Colors.green);
    Navigator.pushNamed(context, '/splashAgain');
  }

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
    return WillPopScope(
      onWillPop: showExitPopup,
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.white,
        body: Center(
          child: ListView(
            shrinkWrap: true,
            controller: _controller,
            children: [
              Column(
                children: [
                  Container(
                      height: screenheight(context, dividedby: 5.5.h),
                      width: screenwidth(context, dividedby: 2.5.w),
                      color: Colors.transparent,
                      child: Image.asset('images/${AppConfig.barAssociation.toLowerCase()}_district_logo.png')),
                  // SizedBox(height: screenheight(context, dividedby: 12.h)),
                  // Container(
                  //   decoration: BoxDecoration(
                  //       color: Colors.grey,
                  //       borderRadius:
                  //           BorderRadius.all(Radius.circular(20.r)),
                  //       boxShadow: [
                  //         BoxShadow(
                  //           color: Colors.grey,
                  //           blurRadius: 5.0.r,
                  //           spreadRadius: 5.r,
                  //         )
                  //       ]),
                  //   child:
                  Container(
                    constraints: BoxConstraints(
                      maxWidth: screenwidth(context, dividedby: 1.08.w),
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20.r)),
                      color: Colors.white,
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: screenwidth(context, dividedby: 25.w),
                        vertical: screenheight(context, dividedby: 110.h),
                      ),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 15.h,
                          ),
                          Align(
                            alignment: AlignmentDirectional.center,
                            child: Text(
                              'Sign In',
                              textScaleFactor: 1.6,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                          ),
                          Padding(padding: EdgeInsets.only(top: 40)),
                          CommonTextField(
                            controller: emailController,
                            labelText: 'Sanad No/Mobile No',
                            number: TextInputType.text,
                            hintText: 'Sanad No/Mobile No',
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                left: screenwidth(context, dividedby: 25.w),
                                top: 2),
                            child: Align(
                                alignment: AlignmentDirectional.centerStart,
                                child: Text(
                                  _validate
                                      ? "Enter User Name/Mobile No"
                                      : "".toString(),
                                  textScaleFactor: 1,
                                  style: TextStyle(color: Colors.red),
                                )),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal:
                                    screenwidth(context, dividedby: 8.w),
                                vertical: 3.5.h),
                            child: Text(
                              'For Example : G/xxxx/xxxx',
                              textScaleFactor: 1.1,
                              style: TextStyle(
                                  // fontSize: 16.sp,
                                  color: Colors.grey.shade700),
                            ),
                          ),
                          Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: screenheight(context,
                                      dividedby: 100.h))),
                          CommonPasswordTextField(
                              // function: (p0) {
                              //   if(p0!.isEmpty){
                              //     return "Data missing";
                              //   }
                              //   return "";
                              // },
                              controller: passwordController,
                              labelText: 'Password',
                              number: TextInputType.visiblePassword,
                              hintText: 'Password',
                              isPasswordField: false),
                          Padding(
                            padding: EdgeInsets.only(
                                left: screenwidth(context, dividedby: 25.w),
                                top: screenheight(context, dividedby: 150.w)),
                            child: Align(
                                alignment: AlignmentDirectional.centerStart,
                                child: Text(
                                  _validate1
                                      ? "Enter Password"
                                      : "".toString(),
                                  textScaleFactor: 1,
                                  style: TextStyle(color: Colors.red),
                                )),
                          ),
                          SizedBox(
                            height: screenheight(context, dividedby: 20.h),
                          ),
                          SizedBox(
                            width: 250.w,
                            height: 40.h,
                            child: ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  emailController.text.isEmpty
                                      ? _validate = true
                                      : _validate = false;
                                });
                                setState(() {
                                  passwordController.text.isEmpty
                                      ? _validate1 = true
                                      : _validate1 = false;
                                });
                                login();
                              },
                              style: ButtonStyle(
                                  elevation: MaterialStateProperty.all(0),
                                  backgroundColor:
                                      MaterialStateProperty.all(Colors.black),
                                  textStyle: MaterialStateProperty.all(
                                      TextStyle(fontWeight: FontWeight.w500)),
                                  shape: MaterialStateProperty.all(
                                      RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10.r))))),
                              child: const Text(
                                "LOGIN",
                                textScaleFactor: 1.17,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal:
                                    screenwidth(context, dividedby: 5.w),
                                vertical:
                                    screenheight(context, dividedby: 65.h)),
                            child: TextButton(
                                onPressed: () {
                                  Navigator.pushNamed(
                                      context, '/forgotPassword');
                                },
                                style: TextButton.styleFrom(
                                  foregroundColor: Colors.white,
                                ),
                                child: Text(
                                  'Forgot Password',
                                  textScaleFactor: 1.25,
                                  style: TextStyle(
                                    color: Colors.orange.shade500,
                                  ),
                                )),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ===================Rough Work=====================

/*
 Container(
  height:
      screenheight(context, dividedby: 15.h),
  width: screenwidth(context, dividedby: 1.w),
  decoration: BoxDecoration(
      borderRadius: BorderRadius.all(
          Radius.circular(10.r)),
      color: Colors.white,
      boxShadow: [
        BoxShadow(
          color: Colors.grey,
          blurRadius: 2.0.r,
          spreadRadius: 1.5.r,
        )
      ]),
  child: TextFormField(
    cursorColor: Colors.black,
    textInputAction: TextInputAction.next,
    // cursorHeight:
    //     screenheight(context, dividedby: 25.h),
    controller: emailController,
    keyboardType: TextInputType.text,
    textAlign: TextAlign.start,
    style: TextStyle(
      // fontSize: 17.sp,
      color: Colors.black,
    ),
    // validator: (String? value) {
    //   if (value != null && value.isEmpty) {
    //     return "Enter User Name/Mobile No";
    //   }
    // },
    decoration: InputDecoration(
      // labelText: "Sanad No/Mobile No",
      hintText: "Sanad No/Mobile No",
      labelStyle: TextStyle(
          color: Colors.grey.shade500,
          // fontSize: 15.sp
      ),
      contentPadding: EdgeInsets.symmetric(
          horizontal: screenwidth(context,
              dividedby: 25.w),
          vertical: screenheight(context,
              dividedby: 60.h)),
      // errorStyle: TextStyle(
      //   color: Colors.orange.shade900,
      //   height: screenheight(context, dividedby: 2000.h),
      // ),
      errorStyle: TextStyle(
        color: Colors.orange.shade900,
      ),
      floatingLabelStyle: TextStyle(
        color: Colors.black,
        // fontSize: 17.sp
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius:
            BorderRadius.circular(15.r),
      ),
      border: const UnderlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.all(
            Radius.circular(7)),
      ),
    ),
  ),
),
 */

/*Container(
                                height:
                                    screenheight(context, dividedby: 15.h),
                                width: screenwidth(context, dividedby: 1.w),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(10.r)),
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey,
                                        blurRadius: 2.0.r,
                                        spreadRadius: 1.5.r,
                                      )
                                    ]),
                                child: TextFormField(
                                  cursorColor: Colors.black,
                                  textInputAction: TextInputAction.next,
                                  controller: passwordController,
                                  keyboardType: TextInputType.text,
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    // fontSize: 17.sp,
                                    color: Colors.black,
                                  ),
                                  decoration: InputDecoration(
                                    hintText: "Password",
                                    labelStyle: TextStyle(
                                        color: Colors.grey.shade500,
                                    ),
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: screenwidth(context,
                                            dividedby: 25.w),
                                        vertical: screenheight(context,
                                            dividedby: 60.h)),
                                    errorStyle: TextStyle(
                                      color: Colors.orange.shade900,
                                    ),
                                    floatingLabelStyle: TextStyle(
                                      color: Colors.black,
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius:
                                          BorderRadius.circular(15.r),
                                    ),
                                    border: const UnderlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(7)),
                                    ),
                                  ),
                                ),
                              ),*/

/*SizedBox(
                                  height: 42.h,
                                  width: 300.w,
                                  child: ClipRRect(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    child: ElevatedButton(
                                      onPressed: () {
                                        moveToHome(context);
                                      },
                                      style: ButtonStyle(
                                        elevation: MaterialStateProperty.all(0),
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                Colors.black),
                                      ),
                                      child: Text(
                                        'LOGIN',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 14),
                                      ),
                                    ),
                                  ),
                                ),*/
