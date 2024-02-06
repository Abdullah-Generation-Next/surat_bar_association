import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:surat_district_bar_association/services/AppConfig.dart';

import '../widgets/common_fields.dart';
import '../widgets/media_query_sizes.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final ScrollController _controller = ScrollController();
  TextEditingController mobileController = TextEditingController();
  bool _validate = false;

  @override
  void dispose() {
    mobileController.dispose();
    super.dispose();
  }

  // login() {
  //   Map<String, dynamic> parameter = {
  //     'username': mobileController.text,
  //     'user_master_id': '',
  //     'fcm_token': '',
  //     'app_user': '270'
  //   };
  //   loginData(parameter: parameter).then((value) {
  //     if (value.success == "yes") {
  //       SharedPref.save(
  //           value: jsonEncode(value.toJson()), prefKey: PrefKey.saveUser);
  //       moveToHome();
  //     } else if (emailController.text.isNotEmpty || passwordController.text.isNotEmpty){
  //       Fluttertoast.showToast(
  //           msg: "Enter Valid Credentials Please",
  //           fontSize: 12.sp,textColor: Colors.white,
  //           backgroundColor: Colors.red);
  //     } else if(emailController.text.isEmpty && passwordController.text.isEmpty){
  //       Fluttertoast.showToast(
  //           msg: "Enter Credentials Please",
  //           fontSize: 12.sp,textColor: Colors.white,
  //           backgroundColor: Colors.red);
  //     }
  //   }).onError((error, stackTrace) {          //On Server, If Fetching Error...
  //     Fluttertoast.showToast(
  //       msg: "Something Went Wrong",
  //       fontSize: 12.sp,textColor: Colors.white,
  //       backgroundColor: Colors.red,);
  //   });
  // }

  moveToLogin(BuildContext context) async {
    // if (_formKey.currentState!.validate()) {
    //   await Future.delayed(const Duration(milliseconds: 1000));
    //   Navigator.pushNamed(context, '/login');
    //
    //   Fluttertoast.showToast(
    //       msg: "Password Reset Success \nPlease Login To Continue",
    //       fontSize: 12.sp,
    //       backgroundColor: Colors.green);
    // }
    // if (_validate == false) {
    //   await Future.delayed(const Duration(milliseconds: 1000));
      Fluttertoast.showToast(
          msg: "We Have Sent An Email\nPlease Check Out Inbox To Reset Password",
          fontSize: 12.sp,
          backgroundColor: Colors.green);
      Navigator.pushNamed(context, '/login');
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      body: Center(
        child: ListView(
          shrinkWrap: true,
          controller: _controller,
          children: [
            Column(
              children: [
                SizedBox(
                    height: screenheight(context, dividedby: 5.5.h),
                    width: screenwidth(context, dividedby: 2.5.w),
                    child: Image.asset('images/${AppConfig.barAssociation.toLowerCase()}_district_logo.png')),
                // SizedBox(height: screenheight(context, dividedby: 20.h)),
                // Container(
                //   decoration: BoxDecoration(
                //       color: Colors.grey,
                //       borderRadius: BorderRadius.all(Radius.circular(20.r)),
                //       boxShadow: [
                //         BoxShadow(
                //           color: Colors.grey,
                //           blurRadius: 5.0.r,
                //           spreadRadius: 5.r,
                //         )
                //       ]
                //     ),
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
                      vertical: screenheight(context, dividedby: 70.h),
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 15.h,
                        ),
                        Align(
                          alignment: AlignmentDirectional.center,
                          child: Text(
                            'Forgot Password',
                            textScaleFactor: 1.6,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                        ),
                        Padding(padding: EdgeInsets.only(top: 40)),
                        CommonTextField(
                          controller: mobileController,
                          labelText: 'Mobile Number',
                          number: TextInputType.text,
                          hintText: 'Enter Mobile No.',
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: screenwidth(context, dividedby: 25.w),
                              top: screenheight(context, dividedby: 150.w)),
                          child: Align(
                              alignment: AlignmentDirectional.centerStart,
                              child: Text(
                                _validate
                                    ? "Enter Mobile No."
                                    : "".toString(),
                                textScaleFactor: 1,
                                style: TextStyle(color: Colors.red),
                              )),
                        ),
                        SizedBox(
                            height: screenheight(context, dividedby: 20.h)),
                        Container(
                          width: 250.w,
                          height: 40.h,
                          child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                mobileController.text.isEmpty
                                    ? _validate = true
                                    : _validate = false;
                                moveToLogin(context);
                              });
                            },
                            style: ButtonStyle(
                                elevation: MaterialStateProperty.all(0),
                                backgroundColor:
                                    MaterialStateProperty.all((Colors.black)),
                                textStyle: MaterialStateProperty.all(
                                    TextStyle(fontWeight: FontWeight.w500)),
                                shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10.r))))),
                            child: const Text(
                              "SUBMIT",
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
                                Navigator.pushNamed(context, '/loginAgain');
                              },
                              style: TextButton.styleFrom(
                                foregroundColor: Colors.white,
                              ),
                              child: Text(
                                'Back To Login',
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
            )
          ],
        ),
      ),
    );
  }
}

//==================Rough Work==================

/*Align(
                              alignment: AlignmentDirectional.topStart,
                              child: Text(
                                'Sanad No/Mobile No',
                                textScaleFactor: 1,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    // fontSize: 15.sp,
                                    color: Colors.black),
                              ),
                            ),
                            Padding(
                                padding: EdgeInsets.only(top: 5)),
                            Container(
                              // height: screenheight(context, dividedby: 17.h),
                              // width: screenwidth(context, dividedby: 1.05.w),
                              constraints: BoxConstraints(
                              ),
                              decoration: BoxDecoration(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(10.r)),
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey,
                                      blurRadius: 2.r,
                                      spreadRadius: 0.1.r,
                                    )
                                  ]),
                              child: TextFormField(
                                autocorrect: true,
                                textAlign: TextAlign. start,
                                cursorColor: Colors.black,
                                textInputAction: TextInputAction.next,
                                // cursorHeight:
                                //     screenheight(context, dividedby: 25.h),
                                controller: emailController,
                                keyboardType: TextInputType.text,
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
                                  hintStyle: TextStyle(
                                    fontSize: 13.sp,
                                  ),
                                  // labelStyle: TextStyle(
                                  //   color: Colors.grey.shade500,
                                  //   // fontSize: 15.sp
                                  // ),
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: screenwidth(context,
                                          dividedby: 25.w),
                                      // vertical: screenheight(context,
                                      //     dividedby: 60.h)
                                  ),
                                  // errorStyle: TextStyle(
                                  //     color: Colors.orange.shade900,
                                  //     height: screenheight(context, dividedby: 750.h),),
                                  errorStyle: TextStyle(
                                    color: Colors.orange.shade900,
                                  ),
                                  floatingLabelStyle:
                                  TextStyle(color: Colors.black),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(15.r),
                                  ),
                                  border: UnderlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(7)),
                                  ),
                                ),
                              ),
                            ),*/

/*SizedBox(
                            height: 35,
                            width: 300,
                            child: ClipRRect(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              child: ElevatedButton(
                                onPressed: () {
                                  moveToLogin(context);
                                },
                                style: ButtonStyle(
                                  elevation: MaterialStateProperty.all(0),
                                  backgroundColor:
                                      MaterialStateProperty.all(
                                          Colors.black),
                                ),
                                child: Text(
                                  'SUBMIT',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 14),
                                ),
                              ),
                            ),
                          ),*/
