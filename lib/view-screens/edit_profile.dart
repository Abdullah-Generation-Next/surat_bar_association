import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:html/parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:surat_district_bar_association/model/city_model.dart';
import 'package:surat_district_bar_association/model/profile_bar_association_model.dart';
import 'package:surat_district_bar_association/model/profile_category_model.dart';
import 'package:surat_district_bar_association/model/user_model.dart';
import 'package:surat_district_bar_association/view-screens/change_password.dart';
import 'package:surat_district_bar_association/widgets/common_fields.dart';
import '../model/login_model.dart';
import '../model/user_about_model.dart';
import '../services/Utilities/app_url.dart';
import '../services/all_api_services.dart';
import '../widgets/media_query_sizes.dart';
import '../widgets/sharedpref.dart';
import 'forgot_password.dart';

class EditProfileScreen extends StatefulWidget {
  final UserModel? userData;
  final CityModel? cityData;
  // final SearchModel? searchData;
  const EditProfileScreen({super.key, this.userData, this.cityData});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  LoginModel login = loginModelFromJson(SharedPref.get(prefKey: PrefKey.saveUser)!);

  String? _genderSelected;
  String? _physicalSelected = 'No';
  String? genderVal;
  String? physicalVal;
  Set<String> selectedCategories = Set<String>();

  ScrollController _controller1 = ScrollController();
  ScrollController _controller2 = ScrollController();
  ScrollController _controller3 = ScrollController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController middleNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobileNoController = TextEditingController();
  TextEditingController birthDateController = TextEditingController();
  TextEditingController bloodGroupController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController officeAddressController = TextEditingController();
  TextEditingController sanadRegController = TextEditingController();
  TextEditingController sanadDateController = TextEditingController();
  TextEditingController welfareRegController = TextEditingController();
  TextEditingController welfareDateController = TextEditingController();
  TextEditingController districtRegController = TextEditingController();
  TextEditingController districtDateController = TextEditingController();
  TextEditingController qualificationController = TextEditingController();
  TextEditingController notaryController = TextEditingController();
  TextEditingController experienceController = TextEditingController();

  TextEditingController lawFirmController = TextEditingController();
  TextEditingController websiteController = TextEditingController();
  TextEditingController barAssoController = TextEditingController();
  TextEditingController aboutController = TextEditingController();

  bool showCat = false;
  bool showChecked = false;
  bool showMatching = false;
  bool showAsso = false;
  bool cityShow = false;
  bool isMounted = false;

  String _parseHtmlString(String htmlString) {
    final document = parse(htmlString);
    final String parsedString = parse(document.body!.text).documentElement!.text;

    return parsedString;
  }

  List<profileCategoryDatum?> category_Data = [];
  Map<String, bool> categorySelections = {};

  Future<void> fetchCategoryDataFromAPI() async {
    setState(() {
      showCat = true;
    });
    await profileCategory().then((value) {
      setState(() {
        category_Data = value.data;
        categorySelections = Map.fromIterable(
          category_Data,
          key: (category) => (category as profileCategoryDatum).catId,
          value: (_) => false,
        );
      });
      setState(() {
        showCat = false;
      });
      // for (var data in category_Data) {
      //   // print("Category ID from categoryData: ${data?.catId}");
      // }
      // print(value);
    }).onError((error, stackTrace) {
      print(error);
    });
  }

  List<UserAboutDatum?> checkedData = [];

  Future<void> fetchCategoryChecked(userId, parentId) async {
    setState(() {
      showChecked = true;
    });
    Map<String, dynamic> parameter = {
      "user_id": userId,
      "app_user": parentId,
    };
    await userAboutData(parameter: parameter).then((value) {
      setState(() {
        checkedData = value.data;
      });
      // print("CheckedData length: ${checkedData.length}");
      for (var data in checkedData) {
        if (data != null) {
          // print("Category ID from checkedData: ${data.categoryId}");
        }
      }
      setState(() {
        showChecked = false;
      });
      // for (var data in checkedData) {
      //   print("Category ID from checkedData: ${data?.categoryId}");
      // }
    }).onError((error, stackTrace) {
      print(error);
    });
  }

  List<profileCategoryDatum?> matchingCategories = [];

  Future<void> fetchMatchingCategories() async {
    setState(() {
      showMatching = true;
    });
    await Future.wait([
      fetchCategoryChecked(login.userId, login.parentId),
      fetchCategoryDataFromAPI(),
    ]);

    setState(() {
      matchingCategories = category_Data
          .where((category) => checkedData.any((checked) =>
      checked != null &&
          checked.categoryId.split(',').map((id) => id.trim()).contains(category?.catId)))
          .toList();
    });

    setState(() {
      categorySelections = Map.fromIterable(
        category_Data,
        key: (category) => (category as profileCategoryDatum).catId,
        value: (category) => matchingCategories.any((selectedCategory) => selectedCategory?.catId == category?.catId),
      );
    });

    setState(() {
      showMatching = false;
    });

    // print("Matching Categories: ${matchingCategories.length}");
    // for (var category in matchingCategories) {
    //   // print("Matching Category ID: ${category?.catId}");
    // }
  }


  List<profileBarAssciationDatum?> bar_association_Data = [];
  String? selectedDropdownValue;

  Future<void> fetchAssociationDataFromAPI() async {
    setState(() {
      showAsso = true;
    });
    await profileBarAssociation().then((value) {
      setState(() {
        bar_association_Data = value.data;
        selectedDropdownValue = getDefaultBarAssociationValue();
      });
      setState(() {
        showAsso = false;
      });
      // print(value);
    }).onError((error, stackTrace) {
      print(error);
    });
  }

  String? getDefaultBarAssociationValue() {
    // Replace this logic with your own to find the default value
    if (bar_association_Data.isNotEmpty) {
      // Assuming your profileBarAssciationDatum has a field named barAssociationId
      String parentId = login.parentId ?? "";

      // Find the item with the matching parentId
      var defaultAssociation = bar_association_Data.firstWhere(
            (item) => item?.barAssociationId == parentId,
        orElse: () => null,
      );

      return defaultAssociation?.barAssociationName;
    }
    return null;
  }



  List<allCity?> cityList = [];

  Future<void> fetchCityData(apiKey,device,stateId) async {
    setState(() {
      cityShow = true;
    });
    Map<String, dynamic> parameter = {
      "apiKey": apiKey,
      "device" : device,
      "state_id" : stateId,
    };
    await getCitesFromVakalat(parameter: parameter).then((value) {
   value.cities.forEach((element) {
     if(element?.cityId == widget.userData?.data?.first?.cityId.toString()) {
       setState(() {
         cityController.text = element!.cityName;
       });
     }
   });

      setState(() {
        cityShow = false;
      });
      // print(value);
    }).onError((error, stackTrace) {
      print(error);
    });
  }



  // Widget city() {
  //   return FutureBuilder(
  //     future: getCitesFromVakalat(
  //       parameter: {
  //         "apiKey": '5Xf!-VQ*Zjad>@Q-}Bwb@w2/YrY#n',
  //         "device": '2',
  //         "state_id": widget.userData?.data.first?.stateId,
  //       },
  //     ),
  //     builder: (context, snapshot) {
  //       if (snapshot.connectionState == ConnectionState.waiting) {
  //         return CircularProgressIndicator();
  //       } else if (snapshot.hasError) {
  //         return Text('Error: ${snapshot.error}');
  //       } else {
  //         cityController.text =
  //         getCityName(widget.userData?.data.first?.cityId)!;
  //         return Container();
  //       }
  //     },
  //   );
  // }



  @override
  void initState() {
    super.initState();

    isMounted = true;
    fetchCityData('5Xf!-VQ*Zjad>@Q-}Bwb@w2/YrY#n','2',widget.userData?.data?.first?.stateId);
    fetchCategoryDataFromAPI();
    fetchCategoryChecked(login.userId, login.parentId);
    // fetchMatchingCategories();
    fetchAssociationDataFromAPI();

    firstNameController.text = widget.userData?.data?.first?.firstName ?? "";
    middleNameController.text = widget.userData?.data?.first?.middleName ?? "";
    lastNameController.text = widget.userData?.data?.first?.lastName ?? "";
    emailController.text = widget.userData?.data?.first?.email ?? "";
    mobileNoController.text = widget.userData?.data?.first?.mobile ?? "";
    birthDateController.text = DateFormat("${widget.userData?.data?.first?.dateOfBirth ?? ""}").format(DateTime.now());
    bloodGroupController.text = widget.userData?.data?.first?.bloodGroup ?? "";
    countryController.text = 'INDIA';
    // cityController.text = login.cityId.isNotEmpty ? login.cityId : "";
    // cityController.text = getCityName(widget.userData?.data.first?.cityId)! ?? "";
    // cityController.text = getCityName(widget.userData?.data.first?.cityId) ?? "";
    // cityController.text = city.toString() ?? "";
    addressController.text = widget.userData?.data?.first?.address ?? "";
    officeAddressController.text = widget.userData?.data?.first?.officeAddress ?? "";
    sanadRegController.text = widget.userData?.data?.first?.sanadRegNo ?? "";
    sanadDateController.text = DateFormat("${widget.userData?.data?.first?.sanadRegDate ?? ""}").format(DateTime.now());
    welfareRegController.text = widget.userData?.data?.first?.welfareNo ?? "";
    welfareDateController.text =  widget.userData?.data?.first?.welfareDate ?? "";
    districtRegController.text = widget.userData?.data?.first?.distCourtRegiNo ?? "";
    districtDateController.text = widget.userData?.data?.first?.distCourtRegiDate ?? "";
    qualificationController.text = widget.userData?.data?.first?.qualification ?? "";
    notaryController.text = widget.userData?.data?.first?.notaryNo ?? "";
    experienceController.text = "${widget.userData?.data?.first?.experience ?? "--"} Years";
    _genderSelected = widget.userData?.data?.first!.gender;
    genderVal = _genderSelected;

    lawFirmController.text = widget.userData?.data?.first?.lawFirmCollege ?? "";
    websiteController.text = widget.userData?.data?.first?.websiteUrl ?? "";
    fetchAssociationDataFromAPI().then((_) {
      setState(() {
        selectedDropdownValue = getDefaultBarAssociationValue();
      });
    });
    // barAssoController.text = widget.userData?.data.first?.assoMemberNo ?? "";
    aboutController.text = _parseHtmlString(widget.userData?.data?.first?.aboutUser ?? "");
  }

  @override
  void dispose() {
    isMounted = false;
    super.dispose();
  }

  bool value1 = false;
  bool value2 = false;
  bool value3 = false;
  // bool _validate1 = false;
  // bool _validate2 = false;
  // bool _isChecked = true;
  // String _currText = '';

  profileUpdated() async {
    await Future.delayed(const Duration(milliseconds: 1000));

    // _validate1() {
    //   Fluttertoast.showToast(
    //       msg: "Profile Updated",
    //       fontSize: 12.sp,
    //       backgroundColor: Colors.green);
    // }
    // _validate2() {
    //   Fluttertoast.showToast(
    //       msg: "Information Updated",
    //       fontSize: 12.sp,
    //       backgroundColor: Colors.green);
    // }
  }

  DateTime? _selectedDate;
  // late File imageFile;

  // _openGallery() async {
  //   var picture = await ImagePicker().pickImage(source:
  //   ImageSource.gallery);
  //   this.setState(() {
  //     imageFile = picture as File;
  //   });
  // }

  File? _image;
  final _picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery, imageQuality: 80);

    if (pickedFile != null) {
      _image = File(pickedFile.path);
      setState(() {});
    } else {
      print('No Image Selected');
    }

    // setState(() {
    //   _image = pickedFile as File;
    // });
  }

  List<String> bloodGroupList = [
    "A+",
    "A-",
    "B+",
    "B-",
    "AB+",
    "AB-",
    "O+",
    "O-",
  ];

  _selectBirthDate(BuildContext context) async {
    final DateTime? newSelectedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate = DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2050),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Colors.grey.shade900,
              onPrimary: Colors.white,
              onSurface: Colors.grey.shade900,
              surface: Colors.grey.shade900,
              background: Colors.grey.shade900,
              onBackground: Colors.grey.shade900,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: Colors.black87,
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (newSelectedDate != null) {
      _selectedDate = newSelectedDate;
      birthDateController
        ..text = DateFormat("dd/MM/yyyy").format(_selectedDate!)
        ..selection = TextSelection.fromPosition(
            TextPosition(offset: birthDateController.text.length, affinity: TextAffinity.upstream));
    }
  }

  _selectSanadDate(BuildContext context) async {
    final DateTime? newSelectedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate = DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2050),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Colors.grey.shade900,
              onPrimary: Colors.white,
              onSurface: Colors.grey.shade900,
              surface: Colors.grey.shade900,
              background: Colors.grey.shade900,
              onBackground: Colors.grey.shade900,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: Colors.black87,
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (newSelectedDate != null) {
      _selectedDate = newSelectedDate;
      sanadDateController
        ..text = DateFormat("dd/MM/yyyy").format(_selectedDate!)
        ..selection = TextSelection.fromPosition(
            TextPosition(offset: sanadDateController.text.length, affinity: TextAffinity.upstream));
    }
  }

  _selectWelfareDate(BuildContext context) async {
    final DateTime? newSelectedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate = DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2050),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Colors.grey.shade900,
              onPrimary: Colors.white,
              onSurface: Colors.grey.shade900,
              surface: Colors.grey.shade900,
              background: Colors.grey.shade900,
              onBackground: Colors.grey.shade900,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: Colors.black87,
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (newSelectedDate != null) {
      _selectedDate = newSelectedDate;
      welfareDateController
        ..text = DateFormat("dd/MM/yyyy").format(_selectedDate!)
        ..selection = TextSelection.fromPosition(
            TextPosition(offset: welfareDateController.text.length, affinity: TextAffinity.upstream));
    }
  }

  _selectDistrictDate(BuildContext context) async {
    final DateTime? newSelectedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate = DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2050),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Colors.grey.shade900,
              onPrimary: Colors.white,
              onSurface: Colors.grey.shade900,
              surface: Colors.grey.shade900,
              background: Colors.grey.shade900,
              onBackground: Colors.grey.shade900,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: Colors.black87,
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (newSelectedDate != null) {
      _selectedDate = newSelectedDate;
      districtDateController
        ..text = DateFormat("dd/MM/yyyy").format(_selectedDate!)
        ..selection = TextSelection.fromPosition(
            TextPosition(offset: districtDateController.text.length, affinity: TextAffinity.upstream));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        DefaultTabController(
          length: 2,
          child: Scaffold(
            resizeToAvoidBottomInset: true,
            backgroundColor: Colors.black,
            appBar: AppBar(
              iconTheme: IconThemeData(color: Colors.white),
              title: Text(
                'View Profile',
                textScaleFactor: 0.8,
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              centerTitle: true,
              backgroundColor: Colors.transparent,
              elevation: 0,
              automaticallyImplyLeading: true,
              bottom: TabBar(
                indicatorColor: Colors.white,
                tabs: [
                  Tooltip(
                    message: "PROFILE",
                    child: Tab(
                        child: Text(
                      'PROFILE',
                      textScaleFactor: 0.85,
                    )),
                  ),
                  Tooltip(
                    message: "ADDITIONAL INFORMATION",
                    child: Tab(
                        child: Text(
                      'ADDITIONAL INFORMATION',
                      textScaleFactor: 0.85,
                    )),
                  ),
                ],
              ),
            ),
            body: ScrollConfiguration(
              behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
              child: GlowingOverscrollIndicator(
                axisDirection: AxisDirection.right,
                color: Colors.white,
                child: TabBarView(
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                    Stack(
                      children: [
                        ScrollConfiguration(
                          behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
                          child: GlowingOverscrollIndicator(
                            axisDirection: AxisDirection.down,
                            color: Colors.white,
                            child: Scrollbar(
                              controller: _controller1,
                              interactive: true,
                              thickness: 7.5.r,
                              radius: Radius.circular(5.r),
                              child: ListView(
                                controller: _controller1,
                                children: [
                                  // Center(
                                  //   child: Padding(
                                  //     padding: EdgeInsets.symmetric(
                                  //         vertical: screenheight(context, dividedby: 45.h)),
                                  //     child: Material(
                                  //       elevation: 10,
                                  //       shape: CircleBorder(
                                  //           side: BorderSide(width: 0.3, color: Colors.grey)),
                                  //       clipBehavior: Clip.antiAlias,
                                  //       color: Colors.transparent,
                                  //       child: Ink.image(
                                  //         image: AssetImage('images/avatarlogos.jpg'),
                                  //         // image: NetworkImage(widget.allData!.profilePic),
                                  //         fit: BoxFit.cover,
                                  //         width: 190.w,
                                  //         height: 190.h,
                                  //         child: InkWell(
                                  //           radius: 0,
                                  //           onTap: () {},
                                  //         ),
                                  //       ),
                                  //     ),
                                  //   ),
                                  // ),
                                  Container(
                                    constraints: BoxConstraints(maxWidth: 190.w, maxHeight: 190.h),
                                    child: Stack(
                                      clipBehavior: Clip.none,
                                      fit: StackFit.expand,
                                      children: [
                                        Center(
                                          child: Padding(
                                            padding:
                                                EdgeInsets.symmetric(vertical: screenheight(context, dividedby: 45.h)),
                                            child: Material(
                                                elevation: 10,
                                                shape: CircleBorder(side: BorderSide(width: 3, color: Colors.grey)),
                                                clipBehavior: Clip.antiAlias,
                                                color: Colors.transparent,
                                                child: _image == null ?
                                                      login.profilePic != null && login.profilePic != "" ?
                                                        Ink.image(
                                                        image: NetworkImage(URLs.imagepath + login.profilePic!),
                                                        // AssetImage(
                                                        //     'images/avatarlogos.jpg'
                                                        //   // _image!.path
                                                        // ),
                                                        fit: BoxFit.contain,
                                                        width: 220.w,
                                                        height: 220.h,
                                                        child: InkWell(
                                                          radius: 0,
                                                          onTap: () async {
                                                            await showDialog(
                                                              context: context,
                                                              builder: (_) => Center(
                                                                child: Padding(
                                                                  padding: const EdgeInsets.only(left: 50, right: 50),
                                                                  child: Container(
                                                                    decoration: BoxDecoration(
                                                                      shape: BoxShape.circle,
                                                                      image: DecorationImage(
                                                                          image: NetworkImage(
                                                                              URLs.imagepath + login.profilePic!),
                                                                          fit: BoxFit.contain),
                                                                    ),
                                                                    child: GestureDetector(
                                                                      onTap: () {
                                                                        Navigator.pop(context);
                                                                      },
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            );
                                                          },
                                                        ),
                                                      )
                                                          : Ink.image(
                                                        image: AssetImage('images/avatarlogos.jpg'),
                                                        fit: BoxFit.contain,
                                                        width: 220.w,
                                                        height: 220.h,
                                                        child: InkWell(
                                                          radius: 0,
                                                          onTap: () async {
                                                            await showDialog(
                                                              context: context,
                                                              builder: (_) => Center(
                                                                child: Padding(
                                                                  padding: const EdgeInsets.only(left: 50, right: 50),
                                                                  child: Container(
                                                                    decoration: BoxDecoration(
                                                                      shape: BoxShape.circle,
                                                                      image: DecorationImage(
                                                                          image:AssetImage('images/avatarlogos.jpg'),
                                                                          fit: BoxFit.contain),
                                                                    ),
                                                                    child: GestureDetector(
                                                                      onTap: () {
                                                                        Navigator.pop(context);
                                                                      },
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            );
                                                          },
                                                        ),
                                                      )
                                                    : Ink.image(
                                                        image: FileImage(File(_image!.path).absolute),
                                                        fit: BoxFit.contain,
                                                        width: 220.w,
                                                        height: 220.h,
                                                        child: InkWell(
                                                          radius: 0,
                                                          onTap: () async {
                                                            await showDialog(
                                                              context: context,
                                                              builder: (_) => Center(
                                                                child: Padding(
                                                                  padding: const EdgeInsets.only(left: 50, right: 50),
                                                                  child: Container(
                                                                    decoration: BoxDecoration(
                                                                      shape: BoxShape.circle,
                                                                      image: DecorationImage(
                                                                          image: FileImage(File(_image!.path).absolute),
                                                                          fit: BoxFit.contain),
                                                                    ),
                                                                    child: GestureDetector(
                                                                      onTap: () {
                                                                        Navigator.pop(context);
                                                                      },
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            );
                                                          },
                                                        ),
                                                      )),
                                          ),
                                        ),
                                        Positioned(
                                          bottom: 10,
                                          right: -40,
                                          left: 70,
                                          child: Tooltip(
                                            message: 'Pick Image',
                                            child: RawMaterialButton(
                                              onPressed: () {
                                                // print("Button Pressed");
                                                getImage();
                                              },
                                              elevation: 2,
                                              fillColor: Colors.white,
                                              child: Icon(
                                                Icons.camera_alt_outlined,
                                                color: Colors.grey,
                                              ),
                                              padding: EdgeInsets.all(7.5),
                                              shape: CircleBorder(side: BorderSide(color: Colors.grey)),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(padding: EdgeInsets.only(top: 10)),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Note: Upload your latest photo with Court uniform.',
                                        textScaleFactor: 0.8,
                                        style: TextStyle(color: Colors.white38),
                                      ),
                                    ],
                                  ),
                                  Padding(padding: EdgeInsets.only(top: 10)),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 20, right: 20),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        CommonEditTextField(
                                          controller: firstNameController,
                                          labelText: 'First Name',
                                          number: TextInputType.text,
                                          hintText: 'Enter First Name',
                                          inputFormatters: [UpperCaseTextFormatter()],
                                        ),
                                        Padding(padding: EdgeInsets.only(top: 10)),
                                        CommonEditTextField(
                                          controller: middleNameController,
                                          labelText: 'Middle Name',
                                          number: TextInputType.text,
                                          hintText: 'Enter Middle Name',
                                          inputFormatters: [UpperCaseTextFormatter()],
                                        ),
                                        Padding(padding: EdgeInsets.only(top: 10)),
                                        CommonEditTextField(
                                          controller: lastNameController,
                                          labelText: 'Last Name',
                                          number: TextInputType.text,
                                          hintText: 'Enter Last Name',
                                          inputFormatters: [UpperCaseTextFormatter()],
                                        ),
                                        Padding(padding: EdgeInsets.only(top: 10)),
                                        CommonEditTextField(
                                          controller: emailController,
                                          labelText: 'Email',
                                          number: TextInputType.emailAddress,
                                          hintText: 'Enter Email Address',
                                        ),
                                        Padding(padding: EdgeInsets.only(top: 10)),
                                        CommonEditTextField(
                                          controller: mobileNoController,
                                          labelText: 'Mobile No',
                                          hintText: 'Enter Mobile Number',
                                          number: TextInputType.numberWithOptions(signed: true),
                                          length: 10,
                                        ),
                                        Padding(padding: EdgeInsets.only(top: 10)),
                                        Column(
                                          children: [
                                            Align(
                                              alignment: AlignmentDirectional.topStart,
                                              child: Text(
                                                'Birth Date',
                                                textScaleFactor: 0.8,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w400,
                                                  color: Colors.white54,
                                                ),
                                              ),
                                            ),
                                            Padding(padding: EdgeInsets.only(top: 5)),
                                            Container(
                                              // constraints: BoxConstraints(),
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.all(Radius.circular(10.r)),
                                                color: Colors.white12,
                                              ),
                                              child: TextField(
                                                autocorrect: true,
                                                textAlign: TextAlign.start,
                                                cursorColor: Colors.white,
                                                textInputAction: TextInputAction.next,
                                                controller: birthDateController,
                                                keyboardType: TextInputType.datetime,
                                                focusNode: AlwaysDisabledFocusNode(),
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: MediaQuery.of(context).textScaleFactor * 10,
                                                ),
                                                onTap: () {
                                                  _selectBirthDate(context);
                                                },
                                                decoration: InputDecoration(
                                                  hintText: 'Enter Your Birth Date',
                                                  hintStyle: TextStyle(
                                                    color: Colors.white54,
                                                    fontSize: MediaQuery.of(context).textScaleFactor * 10,
                                                  ),
                                                  contentPadding: EdgeInsets.symmetric(
                                                    horizontal: screenwidth(context, dividedby: 25.w),
                                                    vertical: screenheight(context, dividedby: 75.h),
                                                  ),
                                                  focusedBorder: UnderlineInputBorder(
                                                    borderSide: BorderSide.none,
                                                    borderRadius: BorderRadius.circular(15.r),
                                                  ),
                                                  border: UnderlineInputBorder(
                                                    borderSide: BorderSide.none,
                                                    borderRadius: BorderRadius.all(Radius.circular(7)),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Padding(padding: EdgeInsets.only(top: 10)),
                                        CommonEditTextField(
                                          controller: bloodGroupController,
                                          labelText: 'Blood Group',
                                          number: TextInputType.text,
                                          hintText: 'Enter Your Blood Group',
                                          inputFormatters: [UpperCaseTextFormatter()],
                                        ),
                                        Padding(padding: EdgeInsets.only(top: 10)),
                                        Align(
                                          alignment: AlignmentDirectional.topStart,
                                          child: Text(
                                            'Gender',
                                            textScaleFactor: 0.8,
                                            style: TextStyle(fontWeight: FontWeight.w400, color: Colors.white54),
                                          ),
                                        ),
                                        Padding(padding: EdgeInsets.only(top: 5)),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            Radio(
                                              value: 'M',
                                              groupValue: _genderSelected,
                                              activeColor: Colors.white38,
                                              fillColor: MaterialStateProperty.all(Colors.white),
                                              onChanged: (String? value) {
                                                setState(() {
                                                  _genderSelected = value!;
                                                  genderVal = value;
                                                });
                                              },
                                            ),
                                            Text(
                                              'Male',
                                              textScaleFactor: 0.9,
                                              style: TextStyle(color: Colors.white),
                                            ),
                                            Radio(
                                              value: 'F',
                                              groupValue: _genderSelected,
                                              activeColor: Colors.white38,
                                              fillColor: MaterialStateProperty.all(Colors.white),
                                              onChanged: (String? value) {
                                                setState(() {
                                                  _genderSelected = value!;
                                                  genderVal = value;
                                                });
                                              },
                                            ),
                                            Text(
                                              'Female',
                                              textScaleFactor: 0.9,
                                              style: TextStyle(color: Colors.white),
                                            )
                                          ],
                                        ),
                                        Padding(padding: EdgeInsets.only(top: 10)),
                                        Align(
                                          alignment: AlignmentDirectional.topStart,
                                          child: Text(
                                            'Is Physically Challenged?',
                                            textScaleFactor: 0.8,
                                            style: TextStyle(fontWeight: FontWeight.w400, color: Colors.white54),
                                          ),
                                        ),
                                        Padding(padding: EdgeInsets.only(top: 5)),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            Radio(
                                              value: 'Yes',
                                              groupValue: _physicalSelected,
                                              activeColor: Colors.white38,
                                              fillColor: MaterialStateProperty.all(Colors.white),
                                              onChanged: (String? value) {
                                                setState(() {
                                                  _physicalSelected = value!;
                                                  physicalVal = value;
                                                });
                                              },
                                            ),
                                            Text(
                                              'Yes',
                                              textScaleFactor: 0.9,
                                              style: TextStyle(color: Colors.white),
                                            ),
                                            Radio(
                                              value: 'No',
                                              groupValue: _physicalSelected,
                                              activeColor: Colors.white38,
                                              fillColor: MaterialStateProperty.all(Colors.white),
                                              onChanged: (String? value) {
                                                setState(() {
                                                  _physicalSelected = value!;
                                                  physicalVal = value;
                                                });
                                              },
                                            ),
                                            Text(
                                              'No',
                                              textScaleFactor: 0.9,
                                              style: TextStyle(color: Colors.white),
                                            )
                                          ],
                                        ),
                                        Padding(padding: EdgeInsets.only(top: 10)),
                                        Column(
                                          children: [
                                            Align(
                                              alignment: AlignmentDirectional.topStart,
                                              child: Text(
                                                'Country',
                                                textScaleFactor: 0.8,
                                                style: TextStyle(fontWeight: FontWeight.w400, color: Colors.white54),
                                              ),
                                            ),
                                            Padding(padding: EdgeInsets.only(top: 5)),
                                            Container(
                                              // constraints: BoxConstraints(),
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.all(Radius.circular(10.r)),
                                                color: Colors.white12,
                                              ),
                                              child: TextFormField(
                                                inputFormatters: [UpperCaseTextFormatter()],
                                                autocorrect: true,
                                                textAlign: TextAlign.start,
                                                cursorColor: Colors.white,
                                                textInputAction: TextInputAction.next,
                                                controller: countryController,
                                                keyboardType: TextInputType.text,
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: MediaQuery.of(context).textScaleFactor * 10,
                                                ),
                                                decoration: InputDecoration(
                                                  hintText: 'Enter Your Country',
                                                  hintStyle: TextStyle(
                                                    color: Colors.white54,
                                                    fontSize: MediaQuery.of(context).textScaleFactor * 10,
                                                  ),
                                                  contentPadding: EdgeInsets.symmetric(
                                                    horizontal: screenwidth(context, dividedby: 25.w),
                                                    vertical: screenheight(context, dividedby: 75.h),
                                                  ),
                                                  focusedBorder: UnderlineInputBorder(
                                                    borderSide: BorderSide.none,
                                                    borderRadius: BorderRadius.circular(15.r),
                                                  ),
                                                  border: UnderlineInputBorder(
                                                    borderSide: BorderSide.none,
                                                    borderRadius: BorderRadius.all(Radius.circular(7)),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Padding(padding: EdgeInsets.only(top: 10)),
                                        CommonEditTextField(
                                          controller: cityController,
                                          labelText: 'City',
                                          number: TextInputType.text,
                                          hintText: 'Enter Your City',
                                          inputFormatters: [UpperCaseTextFormatter()],
                                        ),
                                        Padding(padding: EdgeInsets.only(top: 10)),
                                        Column(
                                          children: [
                                            Align(
                                              alignment: AlignmentDirectional.topStart,
                                              child: Text(
                                                'Address',
                                                textScaleFactor: 0.8,
                                                style: TextStyle(fontWeight: FontWeight.w400, color: Colors.white54),
                                              ),
                                            ),
                                            Padding(padding: EdgeInsets.only(top: 5)),
                                            Container(
                                              constraints: BoxConstraints(minHeight: 120.h, maxWidth: double.infinity),
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.all(Radius.circular(10.r)),
                                                color: Colors.white12,
                                                // border: Border.all(color: Colors.grey, width:  0.8),
                                              ),
                                              child: TextFormField(
                                                onTap: () {
                                                  // selectAll;
                                                },
                                                textInputAction: TextInputAction.newline,
                                                cursorColor: Colors.white,
                                                // cursorHeight: screenheight(context, dividedby: 30.h),
                                                controller: addressController,
                                                keyboardType: TextInputType.streetAddress,
                                                // keyboardType: TextInputType.multiline,
                                                minLines: 1,
                                                maxLines: 8,
                                                autocorrect: true,
                                                textAlign: TextAlign.start,
                                                inputFormatters: [UpperCaseTextFormatter()],
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: MediaQuery.of(context).textScaleFactor * 10),
                                                decoration: InputDecoration(
                                                  hintText: 'Enter Full Address',
                                                  hintStyle: TextStyle(
                                                    color: Colors.white54,
                                                    fontSize: MediaQuery.of(context).textScaleFactor * 10,
                                                  ),
                                                  contentPadding: EdgeInsets.symmetric(
                                                    horizontal: screenwidth(context, dividedby: 25.w),
                                                    vertical: screenheight(context, dividedby: 75.h),
                                                  ),
                                                  focusedBorder: UnderlineInputBorder(
                                                    borderSide: BorderSide.none,
                                                    borderRadius: BorderRadius.circular(15.r),
                                                  ),
                                                  border: UnderlineInputBorder(
                                                    borderSide: BorderSide.none,
                                                    borderRadius: BorderRadius.all(Radius.circular(7)),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Padding(padding: EdgeInsets.only(top: 10)),
                                        Column(
                                          children: [
                                            Align(
                                              alignment: AlignmentDirectional.topStart,
                                              child: Text(
                                                'Office Address',
                                                textScaleFactor: 0.8,
                                                style: TextStyle(fontWeight: FontWeight.w400, color: Colors.white54),
                                              ),
                                            ),
                                            Padding(padding: EdgeInsets.only(top: 5)),
                                            Container(
                                              constraints: BoxConstraints(minHeight: 120.h, maxWidth: double.infinity),
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.all(Radius.circular(10.r)),
                                                color: Colors.white12,
                                                // border: Border.all(color: Colors.grey, width:  0.8),
                                              ),
                                              child: TextFormField(
                                                textInputAction: TextInputAction.newline,
                                                cursorColor: Colors.white,
                                                // cursorHeight: screenheight(context, dividedby: 30.h),
                                                controller: officeAddressController,
                                                // keyboardType: TextInputType.multiline,
                                                keyboardType: TextInputType.streetAddress,
                                                minLines: 1,
                                                maxLines: 8,
                                                autocorrect: true,
                                                textAlign: TextAlign.start,
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: MediaQuery.of(context).textScaleFactor * 10,
                                                ),
                                                decoration: InputDecoration(
                                                  hintText: 'Enter Office Address',
                                                  hintStyle: TextStyle(
                                                    color: Colors.white54,
                                                    fontSize: MediaQuery.of(context).textScaleFactor * 10,
                                                  ),
                                                  contentPadding: EdgeInsets.symmetric(
                                                    horizontal: screenwidth(context, dividedby: 25.w),
                                                    vertical: screenheight(context, dividedby: 75.h),
                                                  ),
                                                  focusedBorder: UnderlineInputBorder(
                                                    borderSide: BorderSide.none,
                                                    borderRadius: BorderRadius.circular(15.r),
                                                  ),
                                                  border: UnderlineInputBorder(
                                                    borderSide: BorderSide.none,
                                                    borderRadius: BorderRadius.all(Radius.circular(7)),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Padding(padding: EdgeInsets.only(top: 10)),
                                        CommonEditTextField(
                                          controller: sanadRegController,
                                          labelText: 'Sanad Registration No.',
                                          number: TextInputType.text,
                                          hintText: 'Enter Sanad Registration No.',
                                          inputFormatters: [UpperCaseTextFormatter()],
                                        ),
                                        Padding(padding: EdgeInsets.only(top: 10)),
                                        Column(
                                          children: [
                                            Align(
                                              alignment: AlignmentDirectional.topStart,
                                              child: Text(
                                                'Sanad Registration Date',
                                                textScaleFactor: 0.8,
                                                style: TextStyle(fontWeight: FontWeight.w400, color: Colors.white54),
                                              ),
                                            ),
                                            Padding(padding: EdgeInsets.only(top: 5)),
                                            Container(
                                              // constraints: BoxConstraints(),
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.all(Radius.circular(10.r)),
                                                color: Colors.white12,
                                              ),
                                              child: TextField(
                                                autocorrect: true,
                                                textAlign: TextAlign.start,
                                                cursorColor: Colors.white,
                                                textInputAction: TextInputAction.next,
                                                controller: sanadDateController,
                                                keyboardType: TextInputType.datetime,
                                                focusNode: AlwaysDisabledFocusNode(),
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: MediaQuery.of(context).textScaleFactor * 10),
                                                onTap: () {
                                                  _selectSanadDate(context);
                                                },
                                                decoration: InputDecoration(
                                                  hintText: 'Enter Sanad Registration Date',
                                                  hintStyle: TextStyle(
                                                    color: Colors.white54,
                                                    fontSize: MediaQuery.of(context).textScaleFactor * 10,
                                                  ),
                                                  contentPadding: EdgeInsets.symmetric(
                                                    horizontal: screenwidth(context, dividedby: 25.w),
                                                    vertical: screenheight(context, dividedby: 75.h),
                                                  ),
                                                  focusedBorder: UnderlineInputBorder(
                                                    borderSide: BorderSide.none,
                                                    borderRadius: BorderRadius.circular(15.r),
                                                  ),
                                                  border: UnderlineInputBorder(
                                                    borderSide: BorderSide.none,
                                                    borderRadius: BorderRadius.all(Radius.circular(7)),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Padding(padding: EdgeInsets.only(top: 10)),
                                        CommonEditTextField(
                                          controller: welfareRegController,
                                          labelText: 'Welfare Registration No.',
                                          number: TextInputType.text,
                                          hintText: 'Enter Welfare Registration No.',
                                          inputFormatters: [UpperCaseTextFormatter()],
                                        ),
                                        Padding(padding: EdgeInsets.only(top: 10)),
                                        Column(
                                          children: [
                                            Align(
                                              alignment: AlignmentDirectional.topStart,
                                              child: Text(
                                                'Welfare Registration Date',
                                                textScaleFactor: 0.8,
                                                style: TextStyle(fontWeight: FontWeight.w400, color: Colors.white54),
                                              ),
                                            ),
                                            Padding(padding: EdgeInsets.only(top: 5)),
                                            Container(
                                              // constraints: BoxConstraints(),
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.all(Radius.circular(10.r)),
                                                color: Colors.white12,
                                              ),
                                              child: TextField(
                                                autocorrect: true,
                                                textAlign: TextAlign.start,
                                                cursorColor: Colors.white,
                                                textInputAction: TextInputAction.next,
                                                controller: welfareDateController,
                                                keyboardType: TextInputType.datetime,
                                                focusNode: AlwaysDisabledFocusNode(),
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: MediaQuery.of(context).textScaleFactor * 10),
                                                onTap: () {
                                                  _selectWelfareDate(context);
                                                },
                                                decoration: InputDecoration(
                                                  hintText: 'Enter Welfare Registration Date',
                                                  hintStyle: TextStyle(
                                                    color: Colors.white54,
                                                    fontSize: MediaQuery.of(context).textScaleFactor * 10,
                                                  ),
                                                  contentPadding: EdgeInsets.symmetric(
                                                    horizontal: screenwidth(context, dividedby: 25.w),
                                                    vertical: screenheight(context, dividedby: 75.h),
                                                  ),
                                                  focusedBorder: UnderlineInputBorder(
                                                    borderSide: BorderSide.none,
                                                    borderRadius: BorderRadius.circular(15.r),
                                                  ),
                                                  border: UnderlineInputBorder(
                                                    borderSide: BorderSide.none,
                                                    borderRadius: BorderRadius.all(Radius.circular(7)),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Padding(padding: EdgeInsets.only(top: 10)),
                                        Column(
                                          children: [
                                            Align(
                                              alignment: AlignmentDirectional.topStart,
                                              child: Text(
                                                'District Court Registration No.',
                                                textScaleFactor: 0.8,
                                                style: TextStyle(fontWeight: FontWeight.w400, color: Colors.white54),
                                              ),
                                            ),
                                            Padding(padding: EdgeInsets.only(top: 5)),
                                            Container(
                                              // constraints: BoxConstraints(),
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.all(Radius.circular(10.r)),
                                                color: Colors.white12,
                                              ),
                                              child: TextFormField(
                                                autocorrect: true,
                                                textAlign: TextAlign.start,
                                                cursorColor: Colors.white,
                                                textInputAction: TextInputAction.next,
                                                controller: districtRegController,
                                                keyboardType: TextInputType.text,
                                                inputFormatters: [UpperCaseTextFormatter()],
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: MediaQuery.of(context).textScaleFactor * 10),
                                                decoration: InputDecoration(
                                                  hintText: 'Enter Dist. Court Regi. No.',
                                                  hintStyle: TextStyle(
                                                    color: Colors.white54,
                                                    fontSize: MediaQuery.of(context).textScaleFactor * 10,
                                                  ),
                                                  contentPadding: EdgeInsets.symmetric(
                                                    horizontal: screenwidth(context, dividedby: 25.w),
                                                    vertical: screenheight(context, dividedby: 75.h),
                                                  ),
                                                  focusedBorder: UnderlineInputBorder(
                                                    borderSide: BorderSide.none,
                                                    borderRadius: BorderRadius.circular(15.r),
                                                  ),
                                                  border: UnderlineInputBorder(
                                                    borderSide: BorderSide.none,
                                                    borderRadius: BorderRadius.all(Radius.circular(7)),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Padding(padding: EdgeInsets.only(top: 10)),
                                        Column(
                                          children: [
                                            Align(
                                              alignment: AlignmentDirectional.topStart,
                                              child: Text(
                                                'District Court Registration Date',
                                                textScaleFactor: 0.8,
                                                style: TextStyle(fontWeight: FontWeight.w400, color: Colors.white54),
                                              ),
                                            ),
                                            Padding(padding: EdgeInsets.only(top: 5)),
                                            Container(
                                              // constraints: BoxConstraints(),
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.all(Radius.circular(10.r)),
                                                color: Colors.white12,
                                              ),
                                              child: TextField(
                                                autocorrect: true,
                                                textAlign: TextAlign.start,
                                                cursorColor: Colors.white,
                                                textInputAction: TextInputAction.next,
                                                controller: districtDateController,
                                                keyboardType: TextInputType.datetime,
                                                focusNode: AlwaysDisabledFocusNode(),
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: MediaQuery.of(context).textScaleFactor * 10),
                                                onTap: () {
                                                  _selectDistrictDate(context);
                                                },
                                                decoration: InputDecoration(
                                                  hintText: 'Enter Dist. Court Regi. Date',
                                                  hintStyle: TextStyle(
                                                    color: Colors.white54,
                                                    fontSize: MediaQuery.of(context).textScaleFactor * 10,
                                                  ),
                                                  contentPadding: EdgeInsets.symmetric(
                                                    horizontal: screenwidth(context, dividedby: 25.w),
                                                    vertical: screenheight(context, dividedby: 75.h),
                                                  ),
                                                  focusedBorder: UnderlineInputBorder(
                                                    borderSide: BorderSide.none,
                                                    borderRadius: BorderRadius.circular(15.r),
                                                  ),
                                                  border: UnderlineInputBorder(
                                                    borderSide: BorderSide.none,
                                                    borderRadius: BorderRadius.all(Radius.circular(7)),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Padding(padding: EdgeInsets.only(top: 10)),
                                        CommonEditTextField(
                                          controller: qualificationController,
                                          labelText: 'Qualification',
                                          number: TextInputType.text,
                                          hintText: 'Enter Qualification',
                                          inputFormatters: [UpperCaseTextFormatter()],
                                        ),
                                        Padding(padding: EdgeInsets.only(top: 10)),
                                        Column(
                                          children: [
                                            Align(
                                              alignment: AlignmentDirectional.topStart,
                                              child: Text(
                                                'Notary No.',
                                                textScaleFactor: 0.8,
                                                style: TextStyle(fontWeight: FontWeight.w400, color: Colors.white54),
                                              ),
                                            ),
                                            Padding(padding: EdgeInsets.only(top: 5)),
                                            Container(
                                              // constraints: BoxConstraints(),
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.all(Radius.circular(10.r)),
                                                color: Colors.white12,
                                              ),
                                              child: TextFormField(
                                                autocorrect: true,
                                                textAlign: TextAlign.start,
                                                cursorColor: Colors.white,
                                                textInputAction: TextInputAction.next,
                                                controller: notaryController,
                                                keyboardType: TextInputType.text,
                                                inputFormatters: [UpperCaseTextFormatter()],
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: MediaQuery.of(context).textScaleFactor * 10),
                                                decoration: InputDecoration(
                                                  hintText: 'Enter Notary No.',
                                                  hintStyle: TextStyle(
                                                    color: Colors.white54,
                                                    fontSize: MediaQuery.of(context).textScaleFactor * 10,
                                                  ),
                                                  contentPadding: EdgeInsets.symmetric(
                                                    horizontal: screenwidth(context, dividedby: 25.w),
                                                    vertical: screenheight(context, dividedby: 75.h),
                                                  ),
                                                  focusedBorder: UnderlineInputBorder(
                                                    borderSide: BorderSide.none,
                                                    borderRadius: BorderRadius.circular(15.r),
                                                  ),
                                                  border: UnderlineInputBorder(
                                                    borderSide: BorderSide.none,
                                                    borderRadius: BorderRadius.all(Radius.circular(7)),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Padding(padding: EdgeInsets.only(top: 10)),
                                        Column(
                                          children: [
                                            Align(
                                              alignment: AlignmentDirectional.topStart,
                                              child: Text(
                                                'Experience',
                                                textScaleFactor: 0.8,
                                                style: TextStyle(fontWeight: FontWeight.w400, color: Colors.white54),
                                              ),
                                            ),
                                            Padding(padding: EdgeInsets.only(top: 5)),
                                            Container(
                                              // constraints: BoxConstraints(),
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.all(Radius.circular(10.r)),
                                                color: Colors.white12,
                                              ),
                                              child: TextFormField(
                                                autocorrect: true,
                                                textAlign: TextAlign.start,
                                                cursorColor: Colors.white,
                                                textInputAction: TextInputAction.next,
                                                controller: experienceController,
                                                keyboardType: TextInputType.text,
                                                inputFormatters: [UpperCaseTextFormatter()],
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: MediaQuery.of(context).textScaleFactor * 10),
                                                decoration: InputDecoration(
                                                  hintText: 'Enter Experience',
                                                  hintStyle: TextStyle(
                                                    color: Colors.white54,
                                                    fontSize: MediaQuery.of(context).textScaleFactor * 10,
                                                  ),
                                                  contentPadding: EdgeInsets.symmetric(
                                                    horizontal: screenwidth(context, dividedby: 25.w),
                                                    vertical: screenheight(context, dividedby: 75.h),
                                                  ),
                                                  focusedBorder: UnderlineInputBorder(
                                                    borderSide: BorderSide.none,
                                                    borderRadius: BorderRadius.circular(15.r),
                                                  ),
                                                  border: UnderlineInputBorder(
                                                    borderSide: BorderSide.none,
                                                    borderRadius: BorderRadius.all(Radius.circular(7)),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        // Padding(padding: EdgeInsets.only(top: 25)),
                                        // SizedBox(
                                        //   width: double.infinity,
                                        //   height:
                                        //   screenheight(context, dividedby: 17.h),
                                        //   child: ElevatedButton(
                                        //     onPressed: () {
                                        //       Fluttertoast.showToast(
                                        //           msg: "Profile Updated",
                                        //           fontSize: 12.sp,
                                        //           backgroundColor: Colors.green);
                                        //     },
                                        //     style: ButtonStyle(
                                        //         elevation: MaterialStateProperty.all(0),
                                        //         backgroundColor:
                                        //         MaterialStateProperty.all(
                                        //             (Colors.white24)),
                                        //         textStyle:
                                        //         MaterialStateProperty.all(TextStyle(
                                        //             fontWeight: FontWeight.w500,color: Colors.white)),
                                        //         shape: MaterialStateProperty.all(
                                        //             RoundedRectangleBorder(
                                        //                 borderRadius: BorderRadius.all(
                                        //                     Radius.circular(10.r))))),
                                        //     child: const Text(
                                        //       "SUBMIT",
                                        //       textScaleFactor: 1.17,
                                        //     ),
                                        //   ),
                                        // ),
                                      ],
                                    ),
                                  ),
                                  Padding(padding: EdgeInsets.only(top: 20)),
                                ],
                              ),
                            ),
                          ),
                        ),
                        // show == true ? Center(child: Container(
                        //   // height: MediaQuery.of(context).size.height * 0.20,
                        //   // width: MediaQuery.of(context).size.width * 0.50,
                        //   padding: EdgeInsets.all(20),
                        //   decoration: BoxDecoration(
                        //       color: Colors.white,
                        //       borderRadius: BorderRadius.circular(20)
                        //   ),
                        //   child: Column(
                        //     mainAxisAlignment: MainAxisAlignment.center,
                        //     crossAxisAlignment: CrossAxisAlignment.center,
                        //     mainAxisSize: MainAxisSize.min,
                        //     children: [
                        //       CircularProgressIndicator(color: Colors.black, strokeWidth: 4,),
                        //       // SizedBox(height: 20,),
                        //       // Text("Loading",textScaleFactor: 1,textAlign: TextAlign.center,style: TextStyle(color: Colors.black),),
                        //       // SizedBox(height: 10,),
                        //       // Text("Please Wait...",textScaleFactor: 1,textAlign: TextAlign.center,style: TextStyle(color: Colors.black),),
                        //     ],
                        //   ),
                        // ),) : SizedBox(),
                      ],
                    ),
                    Stack(
                      children: [
                        ScrollConfiguration(
                          behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
                          child: GlowingOverscrollIndicator(
                            axisDirection: AxisDirection.down,
                            color: Colors.white,
                            child: Scrollbar(
                              controller: _controller2,
                              interactive: true,
                              thickness: 7.5.r,
                              radius: Radius.circular(5.r),
                              child: ListView(
                                controller: _controller2,
                                children: [
                                  Padding(padding: EdgeInsets.only(top: 20)),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 20, right: 20),
                                    child: Column(
                                      children: [
                                        Column(
                                          children: [
                                            Align(
                                              alignment: AlignmentDirectional.topStart,
                                              child: Text(
                                                'Law Firm',
                                                textScaleFactor: 0.8,
                                                style: TextStyle(fontWeight: FontWeight.w400, color: Colors.white54),
                                              ),
                                            ),
                                            Padding(padding: EdgeInsets.only(top: 5)),
                                            Container(
                                              // constraints: BoxConstraints(),
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.all(Radius.circular(10.r)),
                                                color: Colors.white12,
                                              ),
                                              child: TextFormField(
                                                autocorrect: true,
                                                textAlign: TextAlign.start,
                                                cursorColor: Colors.white,
                                                textInputAction: TextInputAction.next,
                                                controller: lawFirmController,
                                                keyboardType: TextInputType.text,
                                                inputFormatters: [UpperCaseTextFormatter()],
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: MediaQuery.of(context).textScaleFactor * 10,
                                                ),
                                                decoration: InputDecoration(
                                                  hintText: 'Enter Law Firm',
                                                  hintStyle: TextStyle(
                                                    color: Colors.white54,
                                                    fontSize: MediaQuery.of(context).textScaleFactor * 10,
                                                  ),
                                                  contentPadding: EdgeInsets.symmetric(
                                                    horizontal: screenwidth(context, dividedby: 25.w),
                                                    vertical: screenheight(context, dividedby: 75.h),
                                                  ),
                                                  focusedBorder: UnderlineInputBorder(
                                                    borderSide: BorderSide.none,
                                                    borderRadius: BorderRadius.circular(15.r),
                                                  ),
                                                  border: UnderlineInputBorder(
                                                    borderSide: BorderSide.none,
                                                    borderRadius: BorderRadius.all(Radius.circular(7)),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Padding(padding: EdgeInsets.only(top: 10)),
                                        Column(
                                          children: [
                                            Align(
                                              alignment: AlignmentDirectional.topStart,
                                              child: Text(
                                                'Website',
                                                textScaleFactor: 0.8,
                                                style: TextStyle(fontWeight: FontWeight.w400, color: Colors.white54),
                                              ),
                                            ),
                                            Padding(padding: EdgeInsets.only(top: 5)),
                                            Container(
                                              // constraints: BoxConstraints(),
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.all(Radius.circular(10.r)),
                                                color: Colors.white12,
                                              ),
                                              child: TextFormField(
                                                autocorrect: true,
                                                textAlign: TextAlign.start,
                                                cursorColor: Colors.white,
                                                textInputAction: TextInputAction.next,
                                                controller: websiteController,
                                                keyboardType: TextInputType.url,
                                                inputFormatters: [UpperCaseTextFormatter()],
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: MediaQuery.of(context).textScaleFactor * 10,
                                                ),
                                                decoration: InputDecoration(
                                                  hintText: 'Enter Website URL',
                                                  hintStyle: TextStyle(
                                                    color: Colors.white54,
                                                    fontSize: MediaQuery.of(context).textScaleFactor * 10,
                                                  ),
                                                  contentPadding: EdgeInsets.symmetric(
                                                    horizontal: screenwidth(context, dividedby: 25.w),
                                                    vertical: screenheight(context, dividedby: 75.h),
                                                  ),
                                                  focusedBorder: UnderlineInputBorder(
                                                    borderSide: BorderSide.none,
                                                    borderRadius: BorderRadius.circular(15.r),
                                                  ),
                                                  border: UnderlineInputBorder(
                                                    borderSide: BorderSide.none,
                                                    borderRadius: BorderRadius.all(Radius.circular(7)),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Padding(padding: EdgeInsets.only(top: 10)),
                                        Column(
                                          children: [
                                            Align(
                                              alignment: AlignmentDirectional.topStart,
                                              child: Text(
                                                'Bar Association',
                                                textScaleFactor: 0.8,
                                                style: TextStyle(fontWeight: FontWeight.w400, color: Colors.white54),
                                              ),
                                            ),
                                            Padding(padding: EdgeInsets.only(top: 5)),
                                            Theme(
                                                data: ThemeData(
                                                    canvasColor: Colors.blueGrey,
                                                    primaryColor: Colors.grey,
                                                    // accentColor: Colors.grey,
                                                    hintColor: Colors.grey,
                                                    highlightColor: Colors.transparent,
                                                    splashColor: Colors.white12,
                                                    hoverColor: Colors.transparent,
                                                    colorScheme: ColorScheme.dark()),
                                                child: Center(
                                                  child: PopupMenuButton<String>(
                                                    constraints: BoxConstraints.expand(height: MediaQuery.of(context).size.height * 0.5,width: 500),
                                                    tooltip: "Select Bar Association",
                                                    splashRadius: 24.r,
                                                    offset: Offset(0, 50),
                                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.r)),),
                                                    onSelected: (value) {
                                                      setState(() {
                                                        selectedDropdownValue = value;
                                                      });
                                                    },
                                                    itemBuilder: (BuildContext context) {
                                                      return bar_association_Data.map((profileBarAssciationDatum? value) {
                                                        return PopupMenuItem<String>(
                                                          value: value?.barAssociationName,
                                                          child: Container(
                                                            padding: EdgeInsets.symmetric(vertical: 16),
                                                            child: Text(
                                                              value?.barAssociationName ?? '',
                                                              style: TextStyle(
                                                                fontSize: MediaQuery.of(context).textScaleFactor * 12,
                                                                color: Colors.white, // Adjust the text color as needed
                                                              ),
                                                            ),
                                                          ),
                                                        );
                                                      }).toList();
                                                    },
                                                    child: Container(
                                                      height: 50,
                                                      decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.all(Radius.circular(10)),
                                                        color: Colors.white12,
                                                      ),
                                                      padding: EdgeInsets.symmetric(horizontal: 16),
                                                      child: Row(
                                                        children: [
                                                          Expanded(
                                                            child: Text(
                                                              selectedDropdownValue ?? "-- Select Bar Association --",
                                                              style: TextStyle(fontSize: MediaQuery.of(context).textScaleFactor * 10.5,color: Colors.white),
                                                            ),
                                                          ),
                                                          Icon(Icons.arrow_drop_down, color: Colors.white),
                                                        ],
                                                      ),
                                                    ),
                                                  )
                                                  // DropdownButtonFormField<String> (
                                                  //   value: selectedDropdownValue,
                                                  //   onChanged: (value) {
                                                  //     setState(() {
                                                  //       selectedDropdownValue = value!;
                                                  //     });
                                                  //   },
                                                  //   hint: Text("-- Select Bar Association --",
                                                  //       style:
                                                  //       TextStyle(fontSize: MediaQuery.of(context).textScaleFactor * 10)),
                                                  //   icon: Icon(
                                                  //     Icons.arrow_drop_down,
                                                  //     color: Colors.grey,
                                                  //   ),
                                                  //   decoration: InputDecoration(
                                                  //     enabled: true,
                                                  //     isDense: true,
                                                  //     hintText: 'The Surat District Bar Association',
                                                  //     hintStyle: TextStyle(
                                                  //       color: Colors.white54,
                                                  //       fontSize: MediaQuery.of(context).textScaleFactor * 10,
                                                  //     ),
                                                  //     contentPadding: EdgeInsets.symmetric(
                                                  //       horizontal: screenwidth(context, dividedby: 25.w),
                                                  //       vertical: screenheight(context, dividedby: 75.h),
                                                  //     ),
                                                  //     disabledBorder: UnderlineInputBorder(
                                                  //       borderSide: BorderSide.none,
                                                  //       borderRadius: BorderRadius.circular(15.r),
                                                  //     ),
                                                  //     enabledBorder: UnderlineInputBorder(
                                                  //       borderSide: BorderSide.none,
                                                  //       borderRadius: BorderRadius.circular(15.r),
                                                  //     ),
                                                  //     focusedBorder: UnderlineInputBorder(
                                                  //       borderSide: BorderSide.none,
                                                  //       borderRadius: BorderRadius.circular(15.r),
                                                  //     ),
                                                  //     border: UnderlineInputBorder(
                                                  //       borderSide: BorderSide.none,
                                                  //       borderRadius: BorderRadius.all(Radius.circular(7)),
                                                  //     ),
                                                  //     floatingLabelAlignment: FloatingLabelAlignment.center,
                                                  //   ),
                                                  //   style: TextStyle(
                                                  //     color: Colors.white,
                                                  //     fontSize: MediaQuery.of(context).textScaleFactor * 10,
                                                  //   ),
                                                  //   items: bar_association_Data.map((profileBarAssciationDatum? value) {
                                                  //     return DropdownMenuItem<String>(
                                                  //       value: value?.barAssociationId,
                                                  //       child: Text(
                                                  //         value?.barAssociationName ?? '',
                                                  //         textWidthBasis: TextWidthBasis.parent,
                                                  //         style: TextStyle(
                                                  //           fontSize: MediaQuery.of(context).textScaleFactor * 10,
                                                  //         ),
                                                  //       ),
                                                  //     );
                                                  //   }).toList(),
                                                  // ),
                                                )
                                            ),
                                          ],
                                        ),
                                        Padding(padding: EdgeInsets.only(top: 10)),
                                        // Column(
                                        //   children: [
                                        //     Align(
                                        //       alignment: AlignmentDirectional.topStart,
                                        //       child: Text(
                                        //         'Category',
                                        //         textScaleFactor: 0.8,
                                        //         style: TextStyle(fontWeight: FontWeight.w400, color: Colors.white54),
                                        //       ),
                                        //     ),
                                        //     Padding(padding: EdgeInsets.only(top: 5)),
                                        //     Stack(
                                        //       alignment: Alignment.center,
                                        //       children: [
                                        //         Container(
                                        //             margin: EdgeInsets.symmetric(vertical: 5),
                                        //             padding: EdgeInsets.symmetric(vertical: 5),
                                        //             height: MediaQuery.of(context).size.height * 0.2,
                                        //             decoration: BoxDecoration(
                                        //                 border: Border.all(color: Colors.white12),
                                        //                 borderRadius: BorderRadius.circular(10)
                                        //             ),
                                        //             // Scrollbar(
                                        //             //   thumbVisibility: true,
                                        //             //   controller: _controller3,
                                        //             //   interactive: true,
                                        //             //   thickness: 6.5,
                                        //             //   radius: Radius.circular(5.r),
                                        //             //   child: ListView.builder(
                                        //             //     controller: _controller3,
                                        //             //     shrinkWrap: true,
                                        //             //     itemCount: category_Data.length,
                                        //             //     itemBuilder: (context, index) {
                                        //             //       final category = category_Data[index];
                                        //             //       final catId = category?.catId ?? "";
                                        //             //       final isSelected = categorySelections[catId] ?? false;
                                        //             //
                                        //             //       print("checkedData: ${checkedData.map((data) => data?.categoryId)}");
                                        //             //       print("categorySelections: $categorySelections");
                                        //             //
                                        //             //       print("catId: $catId");
                                        //             //       print("isSelected: $isSelected");
                                        //             //       print("checkedData: ${checkedData.map((data) => data?.categoryId)}");
                                        //             //
                                        //             //       return Row(
                                        //             //         mainAxisAlignment: MainAxisAlignment.start,
                                        //             //         children: [
                                        //             //           Transform.scale(
                                        //             //             scale: 0.9,
                                        //             //             child: Checkbox(
                                        //             //               shape: RoundedRectangleBorder(
                                        //             //                 borderRadius: BorderRadius.all(
                                        //             //                   Radius.circular(5.0),
                                        //             //                 ),
                                        //             //               ),
                                        //             //               activeColor: Colors.white54,
                                        //             //               checkColor: Colors.black,
                                        //             //               fillColor: MaterialStateProperty.all(Colors.white),
                                        //             //               value: checkedData.any((data) => data?.categoryId == catId),
                                        //             //               onChanged: (value) {
                                        //             //                 setState(() {
                                        //             //                   if (value != null) {
                                        //             //                     if (checkedData.any((data) => data?.categoryId == catId)) {
                                        //             //                       categorySelections[category?.catId ?? ""] = value;
                                        //             //                       // categorySelections[catId] = value;
                                        //             //                     } else {
                                        //             //                       categorySelections[category?.catId ?? ""] = false;
                                        //             //                       // categorySelections[catId] = false;
                                        //             //                     }
                                        //             //                   }
                                        //             //                 });
                                        //             //               },
                                        //             //             ),
                                        //             //           ),
                                        //             //           SizedBox(width: 10),
                                        //             //           Text(
                                        //             //             category?.catName ?? 'Unknown Category',
                                        //             //             style: TextStyle(
                                        //             //               fontSize: MediaQuery.of(context).textScaleFactor * 12,
                                        //             //               color: Colors.white,
                                        //             //             ),
                                        //             //           ),
                                        //             //         ],
                                        //             //       );
                                        //             //     },
                                        //             //   ),
                                        //             // ),
                                        //
                                        //
                                        //
                                        //
                                        //             /*----------------------------*/
                                        //
                                        //
                                        //             // value: checkedData.any((data) => data?.categoryId == catId),
                                        //             // onChanged: (value) {
                                        //             //   setState(() {
                                        //             //     if (value != null) {
                                        //             //       // Check if the catId is present in the second API response
                                        //             //       if (checkedData.any((data) => data?.categoryId == catId)) {
                                        //             //         categorySelections[catId] = value;
                                        //             //       } else {
                                        //             //         // If not present, you may choose to keep it unchecked or show a message.
                                        //             //         categorySelections[catId] = false;
                                        //             //         // You can also show a message or take any other action
                                        //             //         // to inform the user that the category is not allowed.
                                        //             //         // For example:
                                        //             //         // ScaffoldMessenger.of(context).showSnackBar(
                                        //             //         //   SnackBar(
                                        //             //         //     content: Text("This category is not allowed."),
                                        //             //         //   ),
                                        //             //         // );
                                        //             //       }
                                        //             //     }
                                        //             //   });
                                        //             // },
                                        //             // value: categorySelections[category?.catId] ?? false,
                                        //             // onChanged: (value) {
                                        //             //   setState(() {
                                        //             //     // this.value1 = value!;
                                        //             //     categorySelections[category?.catId ?? ""] = value ?? false;
                                        //             //   });
                                        //             // },
                                        //             // value: categorySelections[category?.catId] ?? false,
                                        //             // onChanged: (value) {
                                        //             //   setState(() {
                                        //             //     if (value != null) {
                                        //             //       // Check if the catId is present in the second API response
                                        //             //       if (checkedData.any((data) => data?.categoryId == category?.catId)) {
                                        //             //         categorySelections[category?.catId ?? ""] = value;
                                        //             //       } else {
                                        //             //         // If not present, you may choose to keep it unchecked or show a message.
                                        //             //         categorySelections[category?.catId ?? ""] = false;
                                        //             //         // You can also show a message or take any other action
                                        //             //         // to inform the user that the category is not allowed.
                                        //             //         // For example:
                                        //             //         // ScaffoldMessenger.of(context).showSnackBar(
                                        //             //         //   SnackBar(
                                        //             //         //     content: Text("This category is not allowed."),
                                        //             //         //   ),
                                        //             //         // );
                                        //             //       }
                                        //             //     }
                                        //             //   });
                                        //             // },
                                        //
                                        //             child: ScrollConfiguration(
                                        //               behavior: ScrollBehavior().copyWith(overscroll: false),
                                        //               child:
                                        //               // Scrollbar(
                                        //               //   thumbVisibility: true,
                                        //               //   controller: _controller3,
                                        //               //   interactive: true,
                                        //               //   thickness: 6.5,
                                        //               //   radius: Radius.circular(5.r),
                                        //               //   child: ListView.builder(
                                        //               //     controller: _controller3,
                                        //               //     shrinkWrap: true,
                                        //               //     itemCount: category_Data.length,
                                        //               //     itemBuilder: (context, index) {
                                        //               //       final category = category_Data[index];
                                        //               //       final categoryId = category_Data[index]?.catId ?? "";
                                        //               //       bool isSelected = matchingCategories.any((category) => category?.catId == categoryId);
                                        //               //       // bool isSelected1 = selectedCategories.contains(categoryId);
                                        //               //
                                        //               //       return GestureDetector(
                                        //               //         onTap: () {
                                        //               //           setState(() {
                                        //               //             isSelected = !isSelected;
                                        //               //             categorySelections[category?.catId ?? ""] = !isSelected;
                                        //               //           });
                                        //               //         },
                                        //               //         child: Row(
                                        //               //           mainAxisAlignment: MainAxisAlignment.start,
                                        //               //           children: [
                                        //               //             Checkbox(
                                        //               //               shape: RoundedRectangleBorder(
                                        //               //                 borderRadius: BorderRadius.all(
                                        //               //                   Radius.circular(5.0),
                                        //               //                 ),
                                        //               //               ),
                                        //               //               activeColor: Colors.white54,
                                        //               //               checkColor: Colors.black,
                                        //               //               fillColor: MaterialStateProperty.all(Colors.white),
                                        //               //               value: isSelected,
                                        //               //               onChanged: (bool? value) {
                                        //               //                 setState(() {
                                        //               //                   isSelected = value!;
                                        //               //                   categorySelections[category?.catId ?? ""] = value;
                                        //               //                 });
                                        //               //               },
                                        //               //             ),
                                        //               //             SizedBox(width: 10),
                                        //               //             Text(
                                        //               //               category_Data[index]?.catName ?? 'Unknown Category',
                                        //               //               style: TextStyle(
                                        //               //                 fontSize: MediaQuery.of(context).textScaleFactor * 12,
                                        //               //                 color: Colors.white,
                                        //               //               ),
                                        //               //             ),
                                        //               //           ],
                                        //               //         ),
                                        //               //       );
                                        //               //     },
                                        //               //   ),
                                        //               // )
                                        //
                                        //               Scrollbar(
                                        //                 thumbVisibility: true,
                                        //                 controller: _controller3,
                                        //                 interactive: true,
                                        //                 thickness: 6.5,
                                        //                 radius: Radius.circular(5.r),
                                        //                 child: ListView.builder(
                                        //                   controller: _controller3,
                                        //                   shrinkWrap: true,
                                        //                   itemCount: category_Data.length,
                                        //                   itemBuilder: (context, index) {
                                        //                     final category = category_Data[index];
                                        //                     final categoryId = category?.catId ?? "";
                                        //                     final categoryName = category?.catName ?? "";
                                        //
                                        //                     bool isSelected = categorySelections[categoryId] ?? false;
                                        //
                                        //                     return GestureDetector(
                                        //                       onTap: () {
                                        //                         setState(() {
                                        //                           isSelected = !isSelected;
                                        //                           categorySelections[categoryId] = isSelected;
                                        //                         });
                                        //                       },
                                        //                       child: Row(
                                        //                         mainAxisAlignment: MainAxisAlignment.start,
                                        //                         children: [
                                        //                           Checkbox(
                                        //                             shape: RoundedRectangleBorder(
                                        //                               borderRadius: BorderRadius.all(
                                        //                                 Radius.circular(5.0),
                                        //                               ),
                                        //                             ),
                                        //                             activeColor: Colors.white54,
                                        //                             checkColor: Colors.black,
                                        //                             fillColor: MaterialStateProperty.all(Colors.white),
                                        //                             value: isSelected,
                                        //                             onChanged: (value) {
                                        //                               setState(() {
                                        //                                 isSelected = value ?? false;
                                        //                                 categorySelections[categoryId] = isSelected;
                                        //                               });
                                        //                             },
                                        //                           ),
                                        //                           SizedBox(width: 10),
                                        //                           Text(
                                        //                             categoryName.isEmpty ? 'Unknown Category' : categoryName,
                                        //                             style: TextStyle(
                                        //                               fontSize: MediaQuery.of(context).textScaleFactor * 12,
                                        //                               color: Colors.white,
                                        //                             ),
                                        //                           ),
                                        //                         ],
                                        //                       ),
                                        //                     );
                                        //                   },
                                        //                 ),
                                        //               )
                                        //
                                        //
                                        //
                                        //
                                        //
                                        //               // Scrollbar(
                                        //               //   thumbVisibility: true,
                                        //               //   controller: _controller3,
                                        //               //   interactive: true,
                                        //               //   thickness: 6.5,
                                        //               //   radius: Radius.circular(5.r),
                                        //               //   child: ListView.builder(
                                        //               //     controller: _controller3,
                                        //               //     shrinkWrap: true,
                                        //               //     itemCount: category_Data.length,
                                        //               //     itemBuilder: (context, index) {
                                        //               //       final category = category_Data[index];
                                        //               //       final categoryId = category?.catId ?? "";
                                        //               //       final categoryName = category?.catName ?? "";
                                        //               //
                                        //               //       // Check if categoryId is in matchingCategories
                                        //               //       final isPreselected = matchingCategories.any((category) => category?.catId == categoryId);
                                        //               //
                                        //               //       // Set initial state based on isPreselected
                                        //               //       final isSelected = categorySelections[categoryId] ?? isPreselected;
                                        //               //
                                        //               //       return CategoryCheckbox(
                                        //               //         categoryId: categoryId,
                                        //               //         categoryName: categoryName,
                                        //               //         categorySelections: categorySelections,
                                        //               //         onChanged: (value) {
                                        //               //           setState(() {
                                        //               //             isPreselected ? categorySelections[categoryId] = value! : categorySelections[categoryId] = value!;
                                        //               //             // categorySelections[categoryId] = value!;
                                        //               //           });
                                        //               //         },
                                        //               //         initialSelected: isSelected,
                                        //               //       );
                                        //               //     },
                                        //               //   ),
                                        //               // )
                                        //
                                        //
                                        //               // Scrollbar(
                                        //               //   thumbVisibility: true,
                                        //               //   controller: _controller3,
                                        //               //   interactive: true,
                                        //               //   thickness: 6.5,
                                        //               //   radius: Radius.circular(5.r),
                                        //               //   child: ListView.builder(
                                        //               //     controller: _controller3,
                                        //               //     shrinkWrap: true,
                                        //               //     itemCount: category_Data.length,
                                        //               //     itemBuilder: (context, index) {
                                        //               //       final category = category_Data[index];
                                        //               //       final categoryId = category?.catId ?? "";
                                        //               //       // final categoryName = category?.catName ?? "";
                                        //               //       final categoryName = matchingCategories.any((category) => category?.catId == categoryId);
                                        //               //
                                        //               //
                                        //               //       return CategoryCheckbox(
                                        //               //         categoryId: categoryId,
                                        //               //         categoryName: categoryName,
                                        //               //         categorySelections: categorySelections,
                                        //               //         onChanged: (value) {
                                        //               //           setState(() {
                                        //               //             categorySelections[categoryId] = value!;
                                        //               //           });
                                        //               //         },
                                        //               //       );
                                        //               //     },
                                        //               //   ),
                                        //               // )
                                        //
                                        //
                                        //
                                        //               //     Scrollbar(
                                        //               //   thumbVisibility: true,
                                        //               //   controller: _controller3,
                                        //               //   interactive: true,
                                        //               //   thickness: 6.5,
                                        //               //   radius: Radius.circular(5.r),
                                        //               //   child: ListView.builder(
                                        //               //     controller: _controller3,
                                        //               //     shrinkWrap: true,
                                        //               //     itemCount: category_Data.length,
                                        //               //     itemBuilder: (context, index) {
                                        //               //       final category = category_Data[index];
                                        //               //       final categoryId = category_Data[index]?.catId ?? "";
                                        //               //       bool isSelected = matchingCategories.any((category) => category?.catId == categoryId);
                                        //               //
                                        //               //       return Row(
                                        //               //         mainAxisAlignment: MainAxisAlignment.start,
                                        //               //         children: [
                                        //               //           Transform.scale(
                                        //               //             scale: 0.9,
                                        //               //             child: Checkbox(
                                        //               //               shape: RoundedRectangleBorder(
                                        //               //                 borderRadius: BorderRadius.all(
                                        //               //                   Radius.circular(5.0),
                                        //               //                 ),
                                        //               //               ),
                                        //               //               activeColor: Colors.white54,
                                        //               //               checkColor: Colors.black,
                                        //               //               fillColor: MaterialStateProperty.all(Colors.white),
                                        //               //               value: isSelected,
                                        //               //               onChanged: (value) {
                                        //               //                 setState(() {
                                        //               //                   categorySelections[category?.catId ?? ""] = value ?? false;
                                        //               //                 });
                                        //               //               },
                                        //               //             ),
                                        //               //           ),
                                        //               //           SizedBox(width: 10),
                                        //               //           Text(
                                        //               //             category_Data[index]?.catName ?? 'Unknown Category',
                                        //               //             style: TextStyle(
                                        //               //               fontSize: MediaQuery.of(context).textScaleFactor * 12,
                                        //               //               color: Colors.white,
                                        //               //             ),
                                        //               //           ),
                                        //               //         ],
                                        //               //       );
                                        //               //     },
                                        //               //   ),
                                        //               // )
                                        //
                                        //               // Scrollbar(
                                        //               //   thumbVisibility: true,
                                        //               //   controller: _controller3,
                                        //               //   interactive: true,
                                        //               //   thickness: 6.5,
                                        //               //   radius: Radius.circular(5.r),
                                        //               //   child: ListView.builder(
                                        //               //     controller: _controller3,
                                        //               //     shrinkWrap: true,
                                        //               //     itemCount: category_Data.length,
                                        //               //     itemBuilder: (context, index) {
                                        //               //       final category = category_Data[index];
                                        //               //       final catId = category?.catId ?? "";
                                        //               //       final isSelected = categorySelections[catId] ?? false;
                                        //               //       return Row(
                                        //               //         mainAxisAlignment: MainAxisAlignment.start,
                                        //               //         children: [
                                        //               //           Transform.scale(
                                        //               //             scale: 0.9,
                                        //               //             child: Checkbox(
                                        //               //               shape: RoundedRectangleBorder(
                                        //               //                 borderRadius: BorderRadius.all(
                                        //               //                   Radius.circular(5.0),
                                        //               //                 ),
                                        //               //               ),
                                        //               //               activeColor: Colors.white54,
                                        //               //               checkColor: Colors.black,
                                        //               //               fillColor: MaterialStateProperty.all(Colors.white),
                                        //               //               value: categorySelections[category?.catId] ?? false,
                                        //               //               onChanged: (value) {
                                        //               //                 setState(() {
                                        //               //                   // this.value1 = value!;
                                        //               //                   categorySelections[category?.catId ?? ""] = value ?? false;
                                        //               //                 });
                                        //               //               },
                                        //               //             ),
                                        //               //           ),
                                        //               //           SizedBox(width: 10),
                                        //               //           Text(category?.catName ?? 'Unknown Category',style: TextStyle(
                                        //               //             fontSize: MediaQuery.of(context).textScaleFactor * 12,
                                        //               //             color: Colors.white,
                                        //               //           ),),
                                        //               //         ],
                                        //               //       );
                                        //               //     },
                                        //               //   ),
                                        //               // ),
                                        //
                                        //
                                        //
                                        //
                                        //
                                        //               //     Column(
                                        //               //   mainAxisAlignment: MainAxisAlignment.start,
                                        //               //   crossAxisAlignment: CrossAxisAlignment.start,
                                        //               //   children: [
                                        //               //     Row(
                                        //               //       mainAxisAlignment: MainAxisAlignment.start,
                                        //               //       children: [
                                        //               //         Transform.scale(
                                        //               //           scale: 0.9,
                                        //               //           child: Checkbox(
                                        //               //             shape: RoundedRectangleBorder(
                                        //               //               borderRadius: BorderRadius.all(
                                        //               //                 Radius.circular(5.0),
                                        //               //               ),
                                        //               //             ),
                                        //               //             activeColor: Colors.white54,
                                        //               //             checkColor: Colors.black,
                                        //               //             fillColor: MaterialStateProperty.all(Colors.white),
                                        //               //             value: categorySelections.values.every((selected) => selected),
                                        //               //             onChanged: (value) {
                                        //               //               setState(() {
                                        //               //                 this.value1 = value!;
                                        //               //                 categorySelections.forEach((key, _) {
                                        //               //                   categorySelections[key] = value ?? false;
                                        //               //                 });
                                        //               //               });
                                        //               //             },
                                        //               //           ),
                                        //               //         ),
                                        //               //         SizedBox(width: 10),
                                        //               //
                                        //               //       ],
                                        //               //     ),
                                        //               //     // Text(
                                        //               //     //   'Personal / Family',
                                        //               //     //   textScaleFactor: 0.9,
                                        //               //     //   style: TextStyle(
                                        //               //     //       fontSize: MediaQuery.of(context).textScaleFactor * 12,
                                        //               //     //       color: Colors.white),
                                        //               //     // ),
                                        //               //     // Row(
                                        //               //     //   mainAxisAlignment: MainAxisAlignment.start,
                                        //               //     //   children: [
                                        //               //     //     Transform.scale(
                                        //               //     //       scale: 0.9,
                                        //               //     //       child: Checkbox(
                                        //               //     //         shape: RoundedRectangleBorder(
                                        //               //     //           borderRadius: BorderRadius.all(
                                        //               //     //             Radius.circular(5.0),
                                        //               //     //           ),
                                        //               //     //         ),
                                        //               //     //         activeColor: Colors.white,
                                        //               //     //         checkColor: Colors.black,
                                        //               //     //         fillColor: MaterialStateProperty.all(Colors.white),
                                        //               //     //         value: this.value2,
                                        //               //     //         onChanged: (value) {
                                        //               //     //           setState(() {
                                        //               //     //             this.value2 = value!;
                                        //               //     //           });
                                        //               //     //         },
                                        //               //     //       ),
                                        //               //     //     ),
                                        //               //     //     SizedBox(width: 10),
                                        //               //     //     Text(
                                        //               //     //       'Corporate Law',
                                        //               //     //       textScaleFactor: 0.9,
                                        //               //     //       style: TextStyle(
                                        //               //     //           fontSize: MediaQuery.of(context).textScaleFactor * 12,
                                        //               //     //           color: Colors.white),
                                        //               //     //     ),
                                        //               //     //   ],
                                        //               //     // ),
                                        //               //     // Row(
                                        //               //     //   mainAxisAlignment: MainAxisAlignment.start,
                                        //               //     //   children: [
                                        //               //     //     Transform.scale(
                                        //               //     //       scale: 0.9,
                                        //               //     //       child: Checkbox(
                                        //               //     //         shape: RoundedRectangleBorder(
                                        //               //     //           borderRadius: BorderRadius.all(
                                        //               //     //             Radius.circular(5.0),
                                        //               //     //           ),
                                        //               //     //         ),
                                        //               //     //         activeColor: Colors.white,
                                        //               //     //         checkColor: Colors.black,
                                        //               //     //         fillColor: MaterialStateProperty.all(Colors.white),
                                        //               //     //         value: this.value3,
                                        //               //     //         onChanged: (value) {
                                        //               //     //           setState(() {
                                        //               //     //             this.value3 = value!;
                                        //               //     //           });
                                        //               //     //         },
                                        //               //     //       ),
                                        //               //     //     ),
                                        //               //     //     SizedBox(width: 10),
                                        //               //     //     Text(
                                        //               //     //       'Civil / Debt. Matters',
                                        //               //     //       textScaleFactor: 0.9,
                                        //               //     //       style: TextStyle(
                                        //               //     //           fontSize: MediaQuery.of(context).textScaleFactor * 12,
                                        //               //     //           color: Colors.white),
                                        //               //     //     ),
                                        //               //     //   ],
                                        //               //     // ),
                                        //               //   ],
                                        //               // ),
                                        //
                                        //               // Scrollbar(
                                        //               //   thumbVisibility: true,
                                        //               //   controller: _controller3,
                                        //               //   interactive: true,
                                        //               //   thickness: 6.5,
                                        //               //   radius: Radius.circular(5.r),
                                        //               //   child: ListView.builder(
                                        //               //     controller: _controller3,
                                        //               //     shrinkWrap: true,
                                        //               //     itemCount: category_Data.length,
                                        //               //     itemBuilder: (context, index) {
                                        //               //       // final category = category_Data[index];
                                        //               //       // final catId = category?.catId ?? "";
                                        //               //       final isSelected = categorySelections[matchingCategories[index]?.catId] ?? false;
                                        //               //
                                        //               //       return Row(
                                        //               //         mainAxisAlignment: MainAxisAlignment.start,
                                        //               //         children: [
                                        //               //           Transform.scale(
                                        //               //             scale: 0.9,
                                        //               //             child: Checkbox(
                                        //               //               shape: RoundedRectangleBorder(
                                        //               //                 borderRadius: BorderRadius.all(
                                        //               //                   Radius.circular(5.0),
                                        //               //                 ),
                                        //               //               ),
                                        //               //               activeColor: Colors.white54,
                                        //               //               checkColor: Colors.black,
                                        //               //               fillColor: MaterialStateProperty.all(Colors.white),
                                        //               //               value: isSelected,
                                        //               //               onChanged: (value) {
                                        //               //                 setState(() {
                                        //               //                   categorySelections[matchingCategories[index]?.catId ?? ""] = value ?? false;
                                        //               //                 });
                                        //               //               },
                                        //               //             ),
                                        //               //           ),
                                        //               //           SizedBox(width: 10),
                                        //               //           Text(
                                        //               //             category_Data[index]?.catName ?? 'Unknown Category',
                                        //               //             style: TextStyle(
                                        //               //               fontSize: MediaQuery.of(context).textScaleFactor * 12,
                                        //               //               color: Colors.white,
                                        //               //             ),
                                        //               //           ),
                                        //               //         ],
                                        //               //       );
                                        //               //     },
                                        //               //   ),
                                        //               // )
                                        //             )
                                        //           //   Column(
                                        //           //   children: text
                                        //           //       .map((t) => CheckboxListTile(
                                        //           //     title: Text(t,style: TextStyle(color: Colors.white),),
                                        //           //     value: _isChecked,
                                        //           //     onChanged: (value) {
                                        //           //       setState(() {
                                        //           //         _isChecked = value!;
                                        //           //         if (value == true) {
                                        //           //           _currText = t;
                                        //           //         }
                                        //           //       });
                                        //           //     },
                                        //           //   ))
                                        //           //       .toList(),
                                        //           // ),
                                        //         ),
                                        //       ],
                                        //     ),
                                        //   ],
                                        // ),
                                        // Padding(padding: EdgeInsets.only(top: 10)),
                                        Align(
                                          alignment: AlignmentDirectional.topStart,
                                          child: Text(
                                            'About',
                                            textScaleFactor: 0.8,
                                            style: TextStyle(fontWeight: FontWeight.w400, color: Colors.white54),
                                          ),
                                        ),
                                        Padding(padding: EdgeInsets.only(top: 5)),
                                        Column(
                                          mainAxisSize : MainAxisSize.min,
                                          children: [
                                            Container(
                                              constraints: BoxConstraints(maxWidth: double.infinity),
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.all(Radius.circular(10.r)),
                                                color: Colors.white12,
                                                // border: Border.all(color: Colors.grey, width:  0.8),
                                              ),
                                              child: TextFormField(
                                                textInputAction: TextInputAction.newline,
                                                cursorColor: Colors.white,
                                                // cursorHeight: screenheight(context, dividedby: 30.h),
                                                controller: aboutController,
                                                keyboardType: TextInputType.multiline,
                                                minLines: 5,
                                                maxLines: widget.userData?.data?.first?.aboutUser?.length == 0 ?
                                                5 : widget.userData?.data?.first?.aboutUser?.length,
                                                autocorrect: true,
                                                textAlign: TextAlign.start,
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: MediaQuery.of(context).textScaleFactor * 11,
                                                ),
                                                decoration: InputDecoration(
                                                  hintText: "Enter About Your Self",
                                                  hintStyle: TextStyle(
                                                    color: Colors.white54,
                                                    fontSize: MediaQuery.of(context).textScaleFactor * 11,
                                                  ),
                                                  contentPadding: EdgeInsets.symmetric(
                                                    horizontal: screenwidth(context, dividedby: 25.w),
                                                    vertical: screenheight(context, dividedby: 75.h),
                                                  ),
                                                  focusedBorder: UnderlineInputBorder(
                                                    borderSide: BorderSide.none,
                                                    borderRadius: BorderRadius.circular(15.r),
                                                  ),
                                                  border: UnderlineInputBorder(
                                                    borderSide: BorderSide.none,
                                                    borderRadius: BorderRadius.all(Radius.circular(7)),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  // Padding(padding: EdgeInsets.only(top: 25)),
                                  // SizedBox(
                                  //   width: double.infinity,
                                  //   height:
                                  //   screenheight(context, dividedby: 17.h),
                                  //   child: ElevatedButton(
                                  //     onPressed: () {
                                  //       Fluttertoast.showToast(
                                  //           msg: "Information Updated",
                                  //           fontSize: 12.sp,
                                  //           backgroundColor: Colors.green);
                                  //     },
                                  //     style: ButtonStyle(
                                  //         elevation: MaterialStateProperty.all(0),
                                  //         backgroundColor:
                                  //         MaterialStateProperty.all(
                                  //             (Colors.white24)),
                                  //         textStyle:
                                  //         MaterialStateProperty.all(TextStyle(
                                  //             fontWeight: FontWeight.w500,color: Colors.white)),
                                  //         shape: MaterialStateProperty.all(
                                  //             RoundedRectangleBorder(
                                  //                 borderRadius: BorderRadius.all(
                                  //                     Radius.circular(10.r))))),
                                  //     child: const Text(
                                  //       "SUBMIT",
                                  //       textScaleFactor: 1.17,
                                  //     ),
                                  //   ),
                                  // ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: screenwidth(context, dividedby: 5.w),
                                        vertical: screenheight(context, dividedby: 65.h)),
                                    child: TextButton(
                                        onPressed: () async {
                                          // await showDialog(
                                          //   context: context,
                                          //   builder: (context) => AlertDialog(
                                          //     title: Text('Change Password'),
                                          //     content: Text(
                                          //       'This Action Will Leave This Page Are You Sure You Want To Update/Change Your Password ?',
                                          //       textScaleFactor: 1,
                                          //     ),
                                          //     actions: [
                                          //       ElevatedButton(
                                          //         style: ButtonStyle(
                                          //           elevation: MaterialStateProperty.all(0),
                                          //           backgroundColor: MaterialStateProperty.all(Colors.black),
                                          //         ),
                                          //         onPressed: () => Navigator.of(context).pop(),
                                          //         //return false when click on "NO"
                                          //         child: Text(
                                          //           'No',
                                          //         ),
                                          //       ),
                                          //       ElevatedButton(
                                          //         style: ButtonStyle(
                                          //           elevation: MaterialStateProperty.all(0),
                                          //           backgroundColor: MaterialStateProperty.all(Colors.black),
                                          //         ),
                                          //         onPressed: () {
                                          //           Navigator.of(context).pop();
                                          //           Navigator.push(
                                          //               context,
                                          //               MaterialPageRoute(
                                          //                 builder: (context) => ChangePassword(),
                                          //               ));
                                          //         },
                                          //         //return true when click on "Yes"
                                          //         child: Text('Yes'),
                                          //       ),
                                          //     ],
                                          //   ),
                                          // );
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => ChangePassword(),
                                              ));
                                        },
                                        style: TextButton.styleFrom(
                                          foregroundColor: Colors.white,
                                        ),
                                        child: Text(
                                          'Change Password ?',
                                          textScaleFactor: 1.25,
                                          style: TextStyle(
                                            color: Colors.orange.shade500,
                                          ),
                                        )),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        // show == true ? Center(child: Container(
                        //   // height: MediaQuery.of(context).size.height * 0.20,
                        //   // width: MediaQuery.of(context).size.width * 0.50,
                        //   padding: EdgeInsets.all(20),
                        //   decoration: BoxDecoration(
                        //       color: Colors.white,
                        //       borderRadius: BorderRadius.circular(20)
                        //   ),
                        //   child: Column(
                        //     mainAxisAlignment: MainAxisAlignment.center,
                        //     crossAxisAlignment: CrossAxisAlignment.center,
                        //     mainAxisSize: MainAxisSize.min,
                        //     children: [
                        //       CircularProgressIndicator(color: Colors.black, strokeWidth: 4,),
                        //       // SizedBox(height: 20,),
                        //       // Text("Loading",textScaleFactor: 1,textAlign: TextAlign.center,style: TextStyle(color: Colors.black),),
                        //       // SizedBox(height: 10,),
                        //       // Text("Please Wait...",textScaleFactor: 1,textAlign: TextAlign.center,style: TextStyle(color: Colors.black),),
                        //     ],
                        //   ),
                        // ),) : SizedBox(),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        (showCat == true) ? Center(child: FittedBox(
          fit: BoxFit.fitWidth,
          child: Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
                color: Colors.white60,
                borderRadius: BorderRadius.circular(20)
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(color: Colors.black, strokeWidth: 4,),
                SizedBox(height: 20,),
                Text("Loading",style: TextStyle(color: Colors.black,fontSize: 12,decoration: TextDecoration.none),),
                SizedBox(height: 10,),
                Text("Please Wait...",style: TextStyle(color: Colors.black,fontSize: 12,decoration: TextDecoration.none),),
              ],
            ),
          ),
        ),) : SizedBox(),
        (showChecked == true) ? Center(child: FittedBox(
          fit: BoxFit.fitWidth,
          child: Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
                color: Colors.white60,
                borderRadius: BorderRadius.circular(20)
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(color: Colors.black, strokeWidth: 4,),
                SizedBox(height: 20,),
                Text("Loading",style: TextStyle(color: Colors.black,fontSize: 12,decoration: TextDecoration.none),),
                SizedBox(height: 10,),
                Text("Please Wait...",style: TextStyle(color: Colors.black,fontSize: 12,decoration: TextDecoration.none),),
              ],
            ),
          ),
        ),) : SizedBox(),
        (showMatching == true) ? Center(child: FittedBox(
          fit: BoxFit.fitWidth,
          child: Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
                color: Colors.white60,
                borderRadius: BorderRadius.circular(20)
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(color: Colors.black, strokeWidth: 4,),
                SizedBox(height: 20,),
                Text("Loading",style: TextStyle(color: Colors.black,fontSize: 12,decoration: TextDecoration.none),),
                SizedBox(height: 10,),
                Text("Please Wait...",style: TextStyle(color: Colors.black,fontSize: 12,decoration: TextDecoration.none),),
              ],
            ),
          ),
        ),) : SizedBox(),
        (showAsso == true) ? Center(child: FittedBox(
          fit: BoxFit.fitWidth,
          child: Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
                color: Colors.white60,
                borderRadius: BorderRadius.circular(20)
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(color: Colors.black, strokeWidth: 4,),
                SizedBox(height: 20,),
                Text("Loading",style: TextStyle(color: Colors.black,fontSize: 12,decoration: TextDecoration.none),),
                SizedBox(height: 10,),
                Text("Please Wait...",style: TextStyle(color: Colors.black,fontSize: 12,decoration: TextDecoration.none),),
              ],
            ),
          ),
        ),) : SizedBox(),
        (cityShow == true) ? Center(child: FittedBox(
          fit: BoxFit.fitWidth,
          child: Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
                color: Colors.white60,
                borderRadius: BorderRadius.circular(20)
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(color: Colors.black, strokeWidth: 4,),
                SizedBox(height: 20,),
                Text("Loading",style: TextStyle(color: Colors.black,fontSize: 12,decoration: TextDecoration.none),),
                SizedBox(height: 10,),
                Text("Please Wait...",style: TextStyle(color: Colors.black,fontSize: 12,decoration: TextDecoration.none),),
              ],
            ),
          ),
        ),) : SizedBox(),
      ],
    );
  }
}

// class MyBehavior extends ScrollBehavior {
//   @override
//   Widget buildViewportChrome(
//       BuildContext context, Widget child, AxisDirection axisDirection) {
//     return child;
//   }
// }

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}


class CategoryCheckbox extends StatelessWidget {
  final String categoryId;
  final String categoryName;
  final Map<String, bool> categorySelections;
  final ValueChanged<bool?> onChanged;
  final bool initialSelected;

  const CategoryCheckbox({
    required this.categoryId,
    required this.categoryName,
    required this.categorySelections,
    required this.onChanged,
    required this.initialSelected,
  });

  @override
  Widget build(BuildContext context) {
    bool isSelected = categorySelections[categoryId] ?? false;

    return GestureDetector(
      onTap: () {
        onChanged(!isSelected);
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Checkbox(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(5.0),
              ),
            ),
            activeColor: Colors.white54,
            checkColor: Colors.black,
            fillColor: MaterialStateProperty.all(Colors.white),
            value: initialSelected,
            onChanged: (value) {
              onChanged(value);
            },
          ),
          SizedBox(width: 10),
          Text(
            categoryName,
            style: TextStyle(
              fontSize: MediaQuery.of(context).textScaleFactor * 12,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
