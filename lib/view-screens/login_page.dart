import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:surat_district_bar_association/drawer_details/search/search_tile.dart';
import 'package:surat_district_bar_association/services/AppConfig.dart';
import '../services/all_api_services.dart';
import '../widgets/media_query_sizes.dart';
import '../widgets/sharedpref.dart';

class LoginAgain extends StatefulWidget {
  const LoginAgain({super.key});

  @override
  State<LoginAgain> createState() => _LoginAgainState();
}

class _LoginAgainState extends State<LoginAgain> {
  final ScrollController _controller = ScrollController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool passwordVisible = false;
  bool _validate = false;
  bool _validate1 = false;
  bool show = false;

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  login() {
    setState(() {
      show = true;
    });
    Map<String, dynamic> parameter = {
      'username': emailController.text,
      'password': passwordController.text,
      'user_master_id': '',
      'fcm_token': '',
      'app_user': AppConfig.APP_USER
    };
    loginData(parameter: parameter).then((value) {
        if(value.success == "yes") {
          Navigator.pushNamed(context, '/homePage');
          SharedPref.save(
              value: jsonEncode(value.toJson()), prefKey: PrefKey.saveUser);
          Fluttertoast.showToast(
              msg: "LOGIN SUCCESS",
              fontSize: 12.sp,
              textColor: Colors.white,
              backgroundColor: Colors.green);
        }
        else if (emailController.text.isNotEmpty &&
            passwordController.text.isNotEmpty && value.success != "yes") {
          setState(() {
            show = false;
          });
          Fluttertoast.showToast(
              msg: "Enter Valid Credentials Please",
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
  void initState() {
    super.initState();
    passwordVisible = true;
    // emailController.text = 'G/2644/2012';
    // passwordController.text = '987907355';
  }

  moveToHome() async {
    // if (_formKey.currentState!.validate()) {
    if (_validate && _validate1 == false) {
      // await Future.delayed(const Duration(milliseconds: 1000));
      // Fluttertoast.showToast(
      //     msg: "LOGIN SUCCESS",
      //     fontSize: 12.sp,
      //     textColor: Colors.white,
      //     backgroundColor: Colors.green);
      // Navigator.pushNamed(context, '/splashAgain');
    }
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
    return Stack(
      children: [
        WillPopScope(
          onWillPop: showExitPopup,
          child: Scaffold(
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
                              'Sign In',
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
                              'Welcome To ${AppConfig.sortName} App, Please Enter Your Credentials To Login.',
                              textScaleFactor: 1,
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black),
                            ),
                          ),
                        ),
                        Padding(padding: EdgeInsets.only(top: 30)),
                        // Container(
                        //   constraints: BoxConstraints(
                        //     maxHeight: MediaQuery.of(context).size.height * 0.55
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
                                    // Padding(padding: EdgeInsets.only(left: 5)),
                                    // Expanded(
                                    //   child: Container(
                                    //     height: 60,
                                    //     width: double.infinity,
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
                                    //           textInputAction: TextInputAction.next,
                                    //           controller: emailController,
                                    //           keyboardType: TextInputType.text,
                                    //           style: TextStyle(
                                    //             color: Colors.black,
                                    //             fontSize: MediaQuery.of(context)
                                    //                 .textScaleFactor *
                                    //                 12,
                                    //           ),
                                    //           // validator: (String? value) {
                                    //           //   if (value == null || value.isEmpty) {
                                    //           //     // return "\t\tCredentials Are Required To Proceed !!!";
                                    //           //     return null;
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
                                    //             // hintText: 'Enter Sanad No / Mobile No',
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
                                            textInputAction: TextInputAction.next,
                                            controller: emailController,
                                            keyboardType: TextInputType.text,
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: MediaQuery.of(context)
                                                  .textScaleFactor *
                                                  12,
                                            ),
                                            // validator: (String? value) {
                                            //   if (value == null || value.isEmpty) {
                                            //     // return "\t\tCredentials Are Required To Proceed !!!";
                                            //     return null;
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
                                              // hintText: 'Enter Sanad No / Mobile No',
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
                                padding: const EdgeInsets.only(left: 5),
                                child: Row(
                                    children: [
                                      Text(
                                        _validate ? "Username Required To Proceed !!!" : "",
                                        textScaleFactor: 1,
                                        style: TextStyle(color: Colors.red),
                                      ),
                                    ],
                                ),
                              ),
                                  )
                                  : SizedBox(),
                              Padding(padding: EdgeInsets.only(top: 20)),
                              // Padding(
                              //   padding: EdgeInsets.symmetric(
                              //       horizontal:
                              //           screenwidth(context, dividedby: 8.w),
                              //       vertical: 7.h),
                              //   child: Text(
                              //     'For Example : G/xxxx/xxxx',
                              //     textScaleFactor: 1.1,
                              //     style: TextStyle(color: Colors.grey.shade700),
                              //   ),
                              // ),
                              Padding(
                                padding: const EdgeInsets.only(left: 5),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  // mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      'Password : (e.g. G/XXXX/XXXX)',
                                      textScaleFactor: 1,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    ),
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
                                            controller: passwordController,
                                            keyboardType: TextInputType.text,
                                            obscureText: passwordVisible,
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
                                                  passwordVisible ?
                                                  Icons.visibility_off : Icons.visibility,
                                                  color: passwordVisible ? Colors.grey.shade600 : Colors.black,
                                                ),
                                                onPressed: () {
                                                  setState(
                                                        () {
                                                      passwordVisible =
                                                      !passwordVisible;
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
                              _validate1
                                  ? Align(
                                alignment: AlignmentDirectional.centerStart,
                                    child: Padding(
                                padding: const EdgeInsets.only(left: 5),
                                child: Row(
                                    children: [
                                      Text(
                                        _validate1 ? "Password Required To Proceed !!!" : "",
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
                                          context, '/forgotAgain');
                                    },
                                    style: TextButton.styleFrom(
                                      foregroundColor: Colors.white,
                                    ),
                                    child: Text(
                                      'Forgot Password ..?',
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
                                      if (emailController.text.isEmpty ||
                                          passwordController.text.isEmpty) {
                                        Fluttertoast.showToast(
                                            msg: "Credentials Are Required To Proceed !!!",
                                            fontSize: 12.sp,
                                            textColor: Colors.white,
                                            backgroundColor: Colors.red);
                                      }
                                      if (emailController.text.isNotEmpty &&
                                          passwordController.text.isNotEmpty) {
                                        login();
                                      }
                                    }
                                    setState(() {
                                      emailController.text.isEmpty
                                          ? _validate = true
                                          : _validate = false;
                                      passwordController.text.isEmpty
                                          ? _validate1 = true
                                          : _validate1 = false;
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
                                    "LOGIN",
                                    textScaleFactor: 1.17,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Container(
                        //   height: 40,
                        //   width: double.infinity,
                        //   decoration: BoxDecoration(
                        //     color: Colors.grey.shade300,
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        show == true ? Center(child: CircularProgressIndicator(color: Colors.black,),) : SizedBox(),
      ],
    );
  }
}

class CustomIconButton extends StatefulWidget {
  const CustomIconButton({Key? key, required this.onPressed}) : super(key: key);
  final void Function(bool) onPressed;

  @override
  State<CustomIconButton> createState() => _CustomIconButtonState();
}

class _CustomIconButtonState extends State<CustomIconButton> {
  bool isButtonPressed = true;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        setState(() => isButtonPressed = !isButtonPressed);
        widget.onPressed(isButtonPressed);
      },
      splashRadius: 20.0,
      icon: Icon(
        isButtonPressed
            ? Icons.visibility_rounded
            : Icons.visibility_off_rounded,
        color: Colors.black,
      ),
    );
  }
}

//Purana Design
/*
* Padding(padding: EdgeInsets.only(top: 40)),
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
                                        'User ID : ',
                                        textScaleFactor: 1,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black87),
                                      ),
                                    ),
                                  ),
                                  // Padding(padding: EdgeInsets.only(left: 5)),
                                  Expanded(
                                    child: Container(
                                      height: 60,
                                      width: double.infinity,
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
                                            textInputAction: TextInputAction.next,
                                            controller: emailController,
                                            keyboardType: TextInputType.text,
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: MediaQuery.of(context)
                                                  .textScaleFactor *
                                                  12,
                                            ),
                                            // validator: (String? value) {
                                            //   if (value == null || value.isEmpty) {
                                            //     // return "\t\tCredentials Are Required To Proceed !!!";
                                            //     return null;
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
                                              // hintText: 'Enter Sanad No / Mobile No',
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
                                  ? Padding(
                                padding: const EdgeInsets.only(left: 75),
                                child: Row(
                                  children: [
                                    Text(
                                      _validate ? "\t\tUsername Required To Proceed !!!" : "",
                                      textScaleFactor: 1,
                                      style: TextStyle(color: Colors.red),
                                    ),
                                  ],
                                ),
                              )
                                  : SizedBox(),
                              Padding(padding: EdgeInsets.only(top: 20)),
                              // Padding(
                              //   padding: EdgeInsets.symmetric(
                              //       horizontal:
                              //           screenwidth(context, dividedby: 8.w),
                              //       vertical: 7.h),
                              //   child: Text(
                              //     'For Example : G/xxxx/xxxx',
                              //     textScaleFactor: 1.1,
                              //     style: TextStyle(color: Colors.grey.shade700),
                              //   ),
                              // ),
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
                                        'Password : ',
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
                                            controller: passwordController,
                                            keyboardType: TextInputType.text,
                                            obscureText: passwordVisible,
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
                                                  passwordVisible ?
                                                  Icons.visibility_off : Icons.visibility,
                                                  color: passwordVisible ? Colors.grey.shade600 : Colors.black,
                                                ),
                                                onPressed: () {
                                                  setState(
                                                        () {
                                                      passwordVisible =
                                                      !passwordVisible;
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
                              _validate1
                                  ? Padding(
                                padding: const EdgeInsets.only(left: 75),
                                child: Row(
                                  children: [
                                    Text(
                                      _validate1 ? "\t\tPassword Required To Proceed !!!" : "",
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
* */