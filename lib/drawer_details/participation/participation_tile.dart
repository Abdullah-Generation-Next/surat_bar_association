import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:surat_district_bar_association/drawer_details/participation/participation_tile_detail.dart';
import 'package:surat_district_bar_association/model/particpant_model.dart';
import '../../model/login_model.dart';
import '../../services/all_api_services.dart';
import '../../widgets/drawer.dart';
import '../../widgets/sharedpref.dart';

class ParticipationTileScreen extends StatefulWidget {
  const ParticipationTileScreen({super.key});

  @override
  State<ParticipationTileScreen> createState() => _ParticipationTileScreenState();
}

class _ParticipationTileScreenState extends State<ParticipationTileScreen> {
  LoginModel login = loginModelFromJson(SharedPref.get(prefKey: PrefKey.saveUser)!);

  final ScrollController _controller = ScrollController();
  String mainUrl = "https://vakalat-public.s3.ap-southeast-1.amazonaws.com/";

  List<participantDatum?> data = [];

  Future<void> fetchDataFromAPI(id) async {
    Map<String, dynamic> parameter = {
      "user_id": id,
    };
    await participantData(parameter: parameter).then((value) {
      setState(() {
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
    fetchDataFromAPI(login.parentId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          'Participation',
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
      body: data.isNotEmpty
          ? ScrollConfiguration(
        behavior: MyBehavior(),
        child: data.length > 0
            ? ListView.builder(
            controller: _controller,
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
                  borderRadius: BorderRadius.all(Radius.circular(10.r)),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                ParticipationDetailScreen(
                                  allData: data[index],
                                )));
                  },
                  hoverColor: Colors.white,
                  child: Padding(
                    padding: EdgeInsets.only(
                        top: 10, bottom: 10),
                    child: ListTile(
                      leading: Container(
                        height: 200,width: 100,
                        child: GestureDetector(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return GestureDetector(
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    child: Dialog(
                                      child: Container(
                                        height: MediaQuery.of(context).size.height * 0.5,
                                        child: Center(
                                          child: Image(
                                            image: NetworkImage("${mainUrl + data[index]!.coverImage}"),
                                            fit: BoxFit.fitWidth,
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                            child: Image(image: NetworkImage("${mainUrl + data[index]!.coverImage}"),fit: BoxFit.fitWidth,)),
                      ),
                      title: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Title : ${data[index]!.body}",textScaleFactor: 0.9,),
                          SizedBox(height: 5,),
                          Text("Month: ${data[index]!.monthDigit} " " ${data[index]!.month}",textScaleFactor: 0.9,),
                          SizedBox(height: 5,),
                          Text("Year: ${data[index]!.year}",textScaleFactor: 0.9,),
                        ],
                      ),
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
      ) : Shimmer.fromColors(
    baseColor: Colors.grey.shade400,
      highlightColor: Colors.grey.shade100,
      child: Padding(
        padding: EdgeInsets.only(
            left: 15, right: 15, top: 25, bottom: 20),
        child: ScrollConfiguration(
          behavior: MyBehavior(),
          child: ListView.builder(
            controller: _controller,
            itemCount: 15,
            itemBuilder: (_, __) => Padding(
              padding: const EdgeInsets.only(bottom: 30),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Container(
                      width: 100,
                      height: 75,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(5.r)),
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(width: 10,),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10,right: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            width: double.infinity,
                            height: 10,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(5.r)),
                              color: Colors.white,
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 7),
                          ),
                          Container(
                            width: double.infinity,
                            height: 10,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(5.r)),
                              color: Colors.white,
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 7),
                          ),
                          Container(
                            width: 100,
                            height: 10,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(5.r)),
                              color: Colors.white,
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 7),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    ),
    );
  }
}
