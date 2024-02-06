import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:surat_district_bar_association/services/AppConfig.dart';
import '../../model/committee_detail_model.dart';
import '../../model/login_model.dart';
import '../../services/all_api_services.dart';
import '../../widgets/drawer.dart';
import '../../widgets/sharedpref.dart';

class CommitteeDetailScreen extends StatefulWidget {
  final String committeeId;
  final String committeeName;

  const CommitteeDetailScreen({super.key, required this.committeeId, required this.committeeName});

  @override
  State<CommitteeDetailScreen> createState() => _CommitteeDetailScreenState();
}

class _CommitteeDetailScreenState extends State<CommitteeDetailScreen> {
  LoginModel login = loginModelFromJson(SharedPref.get(prefKey: PrefKey.saveUser)!);

  final ScrollController _controller = ScrollController();

  List<committeeDetailDatum?> data = [];

  Future<void> fetchDataFromAPI(userId, committeeId) async {
    Map<String, dynamic> parameter = {
      "app_user": AppConfig.APP_USER,
      "user_id": userId,
      "committee_id": committeeId,
    };
    await committeeDetailData(parameter: parameter).then((value) {
      setState(() {
        value.data.sort((a, b) {
          DateTime aDate = DateTime.parse(a!.createdDatetime);
          DateTime bDate = DateTime.parse(b!.createdDatetime);
          return bDate.compareTo(aDate);
        });
        data = value.data;
      });
      // print(value);
    }).onError((error, stackTrace) {
      print(error);
    });
  }

  @override
  void initState() {
    super.initState();
    fetchDataFromAPI(login.userId, widget.committeeId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          '${widget.committeeName}',
          textScaleFactor: 0.9,
          overflow: TextOverflow.ellipsis,
          softWrap: true,
          maxLines: 1,
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: true,
      ),
      body: data.isNotEmpty
        ? ScrollConfiguration(
        behavior: MyBehavior(),
        child: data.length > 0
            ? ListView.builder(
          controller: _controller,
            // itemCount: 10,
            itemCount: data.length,
            itemBuilder: (BuildContext context, int index) {
              return Card(
                elevation: 5,
                margin: EdgeInsets.all(10),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    side: BorderSide(color: Colors.grey, width: 0.15)),
                child: InkWell(
                  radius: 0,
                  onTap: () {
                    // Navigator.pushNamed(context, '/committeeDetail');
                  },
                  // splashColor: Colors.white,
                  // highlightColor: Colors.transparent,
                  hoverColor: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(10.r)),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10,bottom: 10,left: 15,right: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Text(
                                // 'Name : AJAYKUMAR GONDALIYA ',
                                'Name : ${data[index]!.name.isEmpty ? "" : data[index]!.name}',
                                softWrap: true,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                textScaleFactor: 1.17,
                                style: TextStyle(
                                  // fontSize: 10.6,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ],
                        ),
                        // Padding(padding: EdgeInsets.symmetric(vertical: screenheight(context,dividedby: 350.h))),
                        Padding(padding: EdgeInsets.only(top: 10)),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              // 'Designation Name : Member',
                              'Designation Name : ${data[index]!.designationName.isEmpty ? "" : data[index]!.designationName}',
                              textScaleFactor: 1.05,
                              style: TextStyle(
                                // fontSize: 12,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                        // Padding(padding: EdgeInsets.symmetric(vertical: screenheight(context,dividedby: 350.h))),
                        Padding(padding: EdgeInsets.only(top: 5)),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              // 'Date : 2023-01-28',
                              'Creation Date : ${data[index]!.createdDatetime.isEmpty ? "" : data[index]!.createdDatetime}',
                              textScaleFactor: 1.05,
                              style: TextStyle(
                                // fontSize: 12,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            })
            : Center(
          child: Text(
            "No Result",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          ),
        ),
      )   : Shimmer.fromColors(
        baseColor: Colors.grey.shade400,
        highlightColor: Colors.grey.shade100,
        child: ScrollConfiguration(
          behavior: MyBehavior(),
          child: ListView.builder(
            controller: _controller,
            itemCount: 15,
            itemBuilder: (_, __) => Padding(
              padding: const EdgeInsets.only(bottom: 20,top: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 25, right: 25),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Container(
                            height: 20,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(7.5.r)),
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  ...List.generate(
                    2,
                        (index) => Padding(
                      padding: const EdgeInsets.only(top: 12, left: 25, right: 25),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Container(
                              height: 15,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(10.r)),
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
