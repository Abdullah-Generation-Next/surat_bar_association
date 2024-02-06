import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:surat_district_bar_association/drawer_details/achievement/achievement_tile.dart';
import 'package:surat_district_bar_association/drawer_details/blog_tile/blog_tile.dart';
import 'package:surat_district_bar_association/drawer_details/blog_tile/blog_tile_detail.dart';
import 'package:surat_district_bar_association/drawer_details/contact_us/contact_us_tile.dart';
import 'package:surat_district_bar_association/drawer_details/important_links/important_links_tile.dart';
import 'package:surat_district_bar_association/drawer_details/news/news_tile.dart';
import 'package:surat_district_bar_association/drawer_details/participation/participation_tile.dart';
import 'package:surat_district_bar_association/drawer_details/public_documents/public_documents_tile.dart';
import 'package:surat_district_bar_association/services/AppConfig.dart';
import 'package:surat_district_bar_association/view-screens/forgot_password.dart';
import 'package:surat_district_bar_association/view-screens/splash_again.dart';
import 'package:surat_district_bar_association/widgets/sharedpref.dart';
import 'package:surat_district_bar_association/view-screens/home_page.dart';
import 'package:surat_district_bar_association/view-screens/splash_screen.dart';
import 'package:surat_district_bar_association/view-screens/login_page.dart';
import 'drawer_details/committee/committee_tile.dart';
import 'drawer_details/events/event_tile.dart';
import 'drawer_details/events/event_tile_detail.dart';
import 'drawer_details/notice_board/noticeboard_tile.dart';
import 'drawer_details/notice_board/noticeboard_tile_detail.dart';
import 'drawer_details/search/search_tile.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPref.init();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  runApp(const MyApp());
  // var now = DateTime.now();
  // var formatter = DateFormat();
  // String formatted = formatter.format(now);
  // print(formatted); // something like 2013-04-20
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
      // minTextAdapt: true,
    return ScreenUtilInit(
      // designSize: const Size(360, 690),
      // splitScreenMode: true,
    builder: (context, child) => MaterialApp(
        builder: (context, child) {
          return MediaQuery(
            child: child!,
            data: MediaQuery.of(context).copyWith(textScaleFactor: 1.17),
          );
        },
        debugShowCheckedModeBanner: false,
        title: '${AppConfig.barAssociation} District Bar Association',
        // theme: ThemeData(
        //   primaryColor: Color(0xff1f9e9a),
        // ),
        initialRoute: '/',
        routes: {
          '/': (context) => SplashScreen(),
          // '/login': (context) => LoginScreen(),
          '/loginAgain': (context) => LoginAgain(),
          // '/forgotPassword': (context) => ForgotPassword(),
          '/forgotAgain': (context) => ForgotAgain(),
          '/splashAgain': (context) => SplashAgain(),
          '/homePage': (context) => HomePage(),
          '/searchTile': (context) => SearchTileScreen(),
          // '/searchDetail': (context) => SearchDetailScreen(),
          '/noticeBoardTile': (context) => NoticeBoardTileScreen(),
          '/noticeBoardDetail': (context) => NoticeBoardDetailScreen(),
          '/eventTile': (context) => EventTileScreen(),
          '/eventDetail': (context) => EventDetailScreen(),
          '/achievementTile': (context) => AchievementTileScreen(),
          '/participationTile': (context) => ParticipationTileScreen(),
          '/contactUsTile': (context) => ContactUsTileScreen(),
          '/committeeTile': (context) => CommitteeTileScreen(),
          // '/committeeDetail': (context) => CommitteeDetailScreen(),
          '/importantLinksTile': (context) => ImportantLinksTileScreen(),
          '/publicDocumentsTile': (context) => PublicDocumentsTileScreen(),
          // '/blogTile': (context) => BlogTileScreen(),
          '/blogTile': (context) => BlogTileScreen(),
          '/blogDetail': (context) => BlogTileDetailScreen(),
          '/newsTile': (context) => NewsTileScreen(),
          // '/editProfile': (context) => EditProfileScreen(data: null,),
          // '/GlobeExample': (context) => GlobeExample(),
          // '/myHomePage': (context) => MyHomePage(),
          // '/drawer': (context) => MyDrawerWidget(),
          // '/roughHomePage': (context) => RoughHomepage(),
        },
        theme: ThemeData(
          primarySwatch: Colors.blue,
          textTheme: GoogleFonts.nunitoTextTheme(
            Theme.of(context).textTheme,
          ),
        ),
        // home: SplashScreen(),
      ),
    );
  }
}
