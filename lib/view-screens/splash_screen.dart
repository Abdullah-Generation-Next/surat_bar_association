import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:surat_district_bar_association/services/AppConfig.dart';
import 'package:surat_district_bar_association/view-screens/home_page.dart';
import 'package:surat_district_bar_association/view-screens/login_page.dart';

import '../widgets/media_query_sizes.dart';
import '../widgets/sharedpref.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToLogin();
  }

  _navigateToLogin() async {
    await Future.delayed(const Duration(seconds: 3));
    // Navigator.pushReplacement(
    //     context, MaterialPageRoute(builder: (context) => const HomePage()));
    Navigator.pushNamed(context, '/loginAgain');

    try {
      if (SharedPref.get(prefKey: PrefKey.saveUser) != null) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomePage()));
      }
      else {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => LoginAgain()));
      }
    } catch (e) {
      print(e.toString());
      Fluttertoast.showToast(
        msg: "Something Went Wrong From Server",
        fontSize: 12.sp,
        textColor: Colors.white,
        backgroundColor: Colors.red,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          children: [
            Spacer(),
            Container(
              height: screenheight(context, dividedby: 3.5.h),
              color: Colors.transparent,
              child: Image.asset(
                'images/${AppConfig.barAssociation.toLowerCase()}_district_logo.png',
                fit: BoxFit.cover,
              ),
            ),
            Spacer(),
            LoadingAnimationWidget.prograssiveDots(
              color: Colors.black,
              size: screenheight(context, dividedby: 10.h),
            ),
            SizedBox(
              height: screenheight(context, dividedby: 20.h),
            ),
          ],
        ),
      ),
    );
  }
}
