import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:surat_district_bar_association/model/contact_admin_model.dart';
import 'package:surat_district_bar_association/services/all_api_services.dart';
import 'package:surat_district_bar_association/widgets/common_fields.dart';
import '../../model/login_model.dart';
import '../../widgets/drawer.dart';
import '../../widgets/media_query_sizes.dart';
import '../../widgets/sharedpref.dart';

class ContactUsTileScreen extends StatefulWidget {
  const ContactUsTileScreen({super.key});

  @override
  State<ContactUsTileScreen> createState() => _ContactUsTileScreenState();
}

class _ContactUsTileScreenState extends State<ContactUsTileScreen> {
  final ScrollController _controller = ScrollController();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController subjectController = TextEditingController();
  TextEditingController commentController = TextEditingController();
  // bool _validate = false;
  // bool _validate1 = false;
  // bool _validate2 = false;
  // bool _validate3 = false;
  // bool _validate4 = false;
  bool showNameError = false;
  bool showEmailError = false;
  bool showPhoneError = false;
  bool showSubjectError = false;
  bool showCommentError = false;
  // final focusNode = FocusNode();
  final subjectFocusNode = FocusNode();
  final commentFocusNode = FocusNode();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    subjectController.dispose();
    commentController.dispose();

    subjectFocusNode.dispose();
    commentFocusNode.dispose();
    super.dispose();
  }

  final formKey = GlobalKey<FormState>();

  bool show = false;

  bool isLoading = false;

  ContactAdminModel? data;

  Future<void> fetchDataFromAPI(userId, userName, userEmail, userMobile, userSubject, userMessage, appUser) async {
    setState(() {
      show = true;
    });
    Map<String, dynamic> parameter = {
      "user_id" : userId,
      "name" : userName,
      "email" : userEmail,
      "mobile" : userMobile,
      "subject" : userSubject,
      "message" : userMessage,
      "app_user" : appUser,
    };
    await contactAdmin(parameter: parameter).then((value) {
      setState(() {
        if(subjectController.text.isNotEmpty && commentController.text.isNotEmpty) {
          data = value;
        }
        show = false;
      });
      Navigator.pop(context);

      Fluttertoast.showToast(
          msg: value.message, fontSize: 12.sp, backgroundColor: Colors.green);

      // print(value);
    }).onError((error, stackTrace) {
      print(error);
      Fluttertoast.showToast(
          msg: "Message Sending Failed, Server Error", fontSize: 12.sp, backgroundColor: Colors.red);
    });
  }

  @override
  void initState() {
    super.initState();

    nameController.text = (login.fname ?? "") + ' ' + (login.lname ?? "");
    emailController.text = login.email ?? "";
    phoneController.text = login.mobile ?? "";
  }

  LoginModel login = loginModelFromJson(SharedPref.get(prefKey: PrefKey.saveUser)!);

  @override
  Widget build(BuildContext context) {
    // final double scaleFactor = MediaQuery.of(context).textScaleFactor;
    return Stack(
      children: [
        Scaffold(
            resizeToAvoidBottomInset: true,
            backgroundColor: Colors.white,
            appBar: AppBar(
              iconTheme: IconThemeData(color: Colors.black),
              title: Text(
                'Contact Us',
                textScaleFactor: 0.9,
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
              centerTitle: true,
              backgroundColor: Colors.transparent,
              elevation: 0,
              automaticallyImplyLeading: true,
            ),
            body: ScrollConfiguration(
              behavior: MyBehavior(),
              child: ListView(
                controller: _controller,
                children: [
                  Padding(
                    // padding: EdgeInsets.symmetric(horizontal: screenwidth(context,dividedby: 20.w)),
                    padding: EdgeInsets.only(left: 15,right: 15),
                    child: Form(
                      key: formKey,
                      autovalidateMode: AutovalidateMode.disabled,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                              // padding: EdgeInsets.symmetric(
                              //     vertical: screenheight(context, dividedby: 35.h))
                            padding: EdgeInsets.only(top: 15),
                          ),
                          CommonContactTextField(controller: nameController,
                             labelText: 'Enter Your Name',
                             number: TextInputType.text,
                             hintText: 'Enter Your Name',
                             validation: (value) {
                                if(value.isEmpty) {
                                  return "Enter Your Name";
                                }
                                return null;
                             },
                          ),
                          Padding(
                              // padding: EdgeInsets.symmetric(
                              //     vertical: screenheight(context, dividedby: 50.h))
                            padding: EdgeInsets.only(top: 15),
                          ),

                          CommonContactTextField(controller: emailController,
                              labelText: 'Enter Your Email Address',
                              number: TextInputType.emailAddress,
                              hintText: 'Enter Your Email Address',
                              validation: (value) {
                                if(value.isEmpty) {
                                  return "Enter Your Email Address";
                                }
                                return null;
                              },
                          ),
                          Padding(
                            // padding: EdgeInsets.symmetric(
                            //     vertical: screenheight(context, dividedby: 50.h))
                            padding: EdgeInsets.only(top: 15),
                          ),

                          CommonContactTextField(
                            controller: phoneController,
                              labelText: 'Enter Your Phone Number',
                              number: TextInputType.number,
                              hintText: 'Enter Your Phone Number',
                              validation: (value) {
                                if(value.isEmpty) {
                                  return "Enter Your Phone Number";
                                }
                                return null;
                              },
                            length: 10,
                          ),

                          Padding(
                            // padding: EdgeInsets.symmetric(
                            //     vertical: screenheight(context, dividedby: 50.h))
                            padding: EdgeInsets.only(top: 15),
                          ),
                          CommonContactTextField(
                            controller: subjectController,
                            labelText: 'Subject For Contacting Us',
                            number: TextInputType.text,
                            hintText: 'Subject For Contacting Us',
                            validation: (String? value) {
                              if (value != null && value.isEmpty) {
                                return "Enter subject please";
                              }
                              return null;
                            },
                          ),

                          Padding(
                            padding: EdgeInsets.only(top: 15),
                          ),
                          Align(
                            alignment: AlignmentDirectional.topStart,
                            child: Text(
                              'Comment or Message',
                              textScaleFactor: 0.8,
                              style:
                              TextStyle(fontWeight: FontWeight.w400, color: Colors.black),
                            ),
                          ),
                          Padding(padding: EdgeInsets.only(top: 5)),
                          SizedBox(
                            height: 125.h,
                            // height: 125.h,width: double.infinity,
                            // decoration: BoxDecoration(
                            //   borderRadius: BorderRadius.all(Radius.circular(10.r)),
                            //   border: Border.all(color: Colors.black12, width: 0.8),
                            //   color: Color(0xffeeeeee),
                            // ),
                            child: Stack(
                              children: [
                                TextFormField(
                                  autocorrect: true,
                                  textAlign: TextAlign.start,
                                  cursorColor: Colors.black,
                                  textInputAction: TextInputAction.newline,
                                  controller: commentController,
                                  keyboardType: TextInputType.multiline,
                                  minLines: null,
                                  maxLines: null,
                                  expands: true,
                                  focusNode: commentFocusNode,
                                  onEditingComplete: () {
                                    FocusScope.of(context).requestFocus(subjectFocusNode);
                                  },
                                  textAlignVertical: TextAlignVertical.top,
                                  validator: (value) {
                                    if(value!.isEmpty) {
                                      return "Enter any comments please";
                                    }
                                    return null;
                                  },
                                  style: TextStyle(
                                      fontSize: MediaQuery.of(context).textScaleFactor * 12,
                                  color: Colors.black,
                                    fontWeight: FontWeight.w500),
                                  decoration: InputDecoration(
                                    alignLabelWithHint: true,
                                    fillColor: Color(0xffeeeeee),
                                    filled: true,
                                    hintText: "Comment or Message",
                                    // hintText: "hello",
                                    hintStyle: TextStyle(
                                        color: Colors.grey.shade600,
                                        fontSize: MediaQuery.of(context).textScaleFactor * 12,
                                        fontWeight: FontWeight.w500
                                    ),
                                    contentPadding: EdgeInsets.symmetric(
                                      horizontal: screenwidth(context, dividedby: 25.w),
                                      vertical: 10,
                                    ),
                                    disabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.black12),
                                      borderRadius: BorderRadius.all(Radius.circular(10.r)),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.black12),
                                      borderRadius: BorderRadius.all(Radius.circular(10.r)),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.black12),
                                      borderRadius: BorderRadius.all(Radius.circular(10.r)),
                                    ),
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.black12),
                                      borderRadius: BorderRadius.all(Radius.circular(10.r)),
                                    ),
                                  ),
                                ),
                                // Visibility(
                                //   visible: !commentFocusNode.hasFocus,
                                //   child: Positioned(
                                //     left: screenwidth(context, dividedby: 25.w,),
                                //     top: 10,
                                //     child: Text(
                                //       "Comment or Message",
                                //       style: TextStyle(
                                //         color: Colors.grey.shade600,
                                //         fontSize: MediaQuery.of(context).textScaleFactor * 12,
                                //         fontWeight: FontWeight.w500,
                                //       ),
                                //     ),
                                //   ),
                                // ),
                              ],
                            ),
                          ),
                          // if (showCommentError)
                          //   Text(
                          //     "Enter any comments please",
                          //     style: TextStyle(
                          //       color: Colors.red,
                          //       fontSize: 12.0,
                          //     ),
                          //   ),

                          Padding(
                            // padding: EdgeInsets.symmetric(
                            //     vertical: screenheight(context, dividedby: 50.h))
                            padding: EdgeInsets.only(top: 25),
                          ),
                          SizedBox(
                            width: double.infinity,
                            height:
                            screenheight(context, dividedby: 17.h),
                            child: ElevatedButton(
                              onPressed: () {
                                if(formKey.currentState!.validate()) {
                                  fetchDataFromAPI(login.userId, login.fullName, login.email, login.mobile, subjectController.text, commentController.text, login.parentId);
                                }
                              },
                              style: ButtonStyle(
                                elevation: MaterialStateProperty.all(0),
                                  backgroundColor:
                                  MaterialStateProperty.all(
                                      (Colors.black)),
                                  textStyle:
                                  MaterialStateProperty.all(TextStyle(
                                    // fontSize: 14.sp,
                                      fontWeight: FontWeight.w500,color: Colors.white)),
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
                                  vertical: screenheight(context, dividedby: 35.h))),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          // drawer: MyDrawerWidget(),
        ),
        show == true ? Center(child: CircularProgressIndicator(color: Colors.black, strokeWidth: 4,),): SizedBox(),
      ],
    );
  }
}
