import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../widgets/media_query_sizes.dart';

class RoughHomepage extends StatefulWidget {
  @override
  State<RoughHomepage> createState() => _RoughHomepageState();
}
class _RoughHomepageState extends State<RoughHomepage> {
  String errorTextvalue = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: TextFormField(
                onChanged: (value) {
                  setState(() {
                    if (value.contains(' ')) {
                      errorTextvalue = value;
                    } else {
                      errorTextvalue = '';
                    }
                  });
                },
                decoration: InputDecoration(
                  border: InputBorder.none,
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                      borderSide: BorderSide(color: Colors.purple)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                      borderSide: BorderSide(color: Colors.purple)),
                  errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                      borderSide: BorderSide(color: Colors.red)),
                  focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                      borderSide: BorderSide(color: Colors.red)),
                  errorText:
                  errorTextvalue.isEmpty ? null : 'Don\'t use blank spaces',
                ),
              )),
          Padding(padding: EdgeInsets.only(top: 50)),
          Container(
            width: 100,
            height: 40,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
                borderRadius:
                BorderRadius.all(Radius.circular(10.r))
            ),
            child: TextButton(
              onPressed: () {

              },
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                      (Colors.white)),
                  foregroundColor:
                  MaterialStateProperty.all(
                      (Colors.black)),
                  padding: MaterialStateProperty.all(
                      EdgeInsets.symmetric(
                          vertical: screenheight(context, dividedby: 65.h))),
                  textStyle: MaterialStateProperty.all(
                      TextStyle(
                        // fontSize: 14.sp,
                          fontWeight: FontWeight.w500)),
                  shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                          borderRadius:
                          BorderRadius.all(Radius.circular(10.r))))),
              child: const Text("SUBMIT",textScaleFactor: 1.17,),
            ),
          ),
        ],
      ),
    );
  }
}