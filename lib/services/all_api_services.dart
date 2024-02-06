import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:surat_district_bar_association/model/blog_category_model.dart';
import 'package:surat_district_bar_association/model/blog_model.dart';
import 'package:surat_district_bar_association/model/contact_admin_model.dart';
import 'package:surat_district_bar_association/model/document_model.dart';
import 'package:surat_district_bar_association/model/imp_links_model.dart';
import 'package:surat_district_bar_association/model/news_model.dart';
import 'package:surat_district_bar_association/model/profile_bar_association_model.dart';
import 'package:surat_district_bar_association/model/profile_category_model.dart';
import 'package:surat_district_bar_association/model/search_model.dart';
import 'package:surat_district_bar_association/model/user_about_model.dart';
import 'package:surat_district_bar_association/model/user_model.dart';
import 'package:surat_district_bar_association/services/utilities/app_url.dart';
import '../model/achievement_model.dart';
import '../model/blog_sub_category_model.dart';
import '../model/city_model.dart';
import '../model/committee_detail_model.dart';
import '../model/committee_model.dart';
import '../model/forgot_password_model.dart';
import '../model/login_model.dart';
import '../model/particpant_model.dart';
import '../model/search_category_model.dart';
import '../model/event_model.dart';
import '../model/notice_board_model.dart';
import '../model/search_sub_category_model.dart';

Future<SearchModel> searchData({required Map<String, dynamic> parameter}) async {
  var url = Uri.parse(URLs.get_search_data);
  var response = await http.post(body: parameter, url);
  // print('Response Body: ${response.body}');
  return searchModelFromJson(response.body);
}

Future<NoticeModel> noticeData({required Map<String, dynamic> parameter}) async {
  var url = Uri.parse(URLs.getUserNotice);
  var response = await http.post(body: parameter, url);
  // print('Response Body: ${response.body}');
  return noticeModelFromJson(response.body);
}

Future<EventModel> eventData({required Map<String, dynamic> parameter}) async {
  var url = Uri.parse(URLs.getAllEvent);
  var response = await http.post(body: parameter, url);
  // print('Response Body: ${response.body}');
  return eventModelFromJson(response.body);
}

Future<BlogModel> blogData({dynamic parameter}) async {
  var url = Uri.parse(URLs.getAllBlog);
  var response = await http.get(url);
  // print('Response Body: ${response.body}');
  return blogModelFromJson(response.body);
}

Future<ImpLinksModel> impLinksData({required var parameter}) async {
  var url = Uri.parse(URLs.getAllLinks);
  var response = await http.post(body: parameter,url);
  // print('Response Body: ${response.body}');
  return impLinksModelFromJson(response.body);
}

Future<CommitteeModel> committeeData({required Map<String, dynamic> parameter}) async {
  var url = Uri.parse(URLs.getAllCommittee);
  var response = await http.post(body: parameter, url);
  // print('Response Body: ${response.body}');
  return committeeModelFromJson(response.body);
}

Future<CommitteeDetailModel> committeeDetailData({required Map<String, dynamic> parameter}) async {
  var url = Uri.parse(URLs.getAllCommitteeMember);
  var response = await http.post(body: parameter, url);
  // print('Response Body: ${response.body}');
  return committeeDetailModelFromJson(response.body);
}

Future<LegalNewsModel> legalNewsData() async {
  var url = Uri.parse(URLs.getAllNews);
  var response = await http.get(url);
  // print('Response Body: ${response.body}');
  return legalNewsModelFromJson(response.body);
}

Future<SearchCategoryModel> searchCategoryData() async {
  var url = Uri.parse(URLs.MainCategory);
  var response = await http.get(url);
  // print('Response Body: ${response.body}');
  return searchCategoryModelFromJson(response.body);
}

Future<SearchSubCategoryModel> searchSubCategoryData({required Map<String, dynamic> parameter}) async {
  var url = Uri.parse(URLs.SubCategory);
  var response = await http.post(body: parameter, url);
  // print('Response Body: ${response.body}');
  return searchSubCategoryModelFromJson(response.body);
}

Future<BlogCategoryModel> blogCategoryData() async {
  var url = Uri.parse(URLs.getCategoryForFilter);
  var response = await http.get(url);
  // print('Response Body: ${response.body}');
  return blogCategoryModelFromJson(response.body);
}

Future<BlogSubCategoryModel> blogSubCategoryData({required Map<String, dynamic> parameter}) async {
  var url = Uri.parse(URLs.getSubCategoryForFilter);
  var response = await http.post(body: parameter, url);
  // print('Response Body: ${response.body}');
  return blogSubCategoryModelFromJson(response.body);
}

Future<LoginModel> loginData({required var parameter}) async {
  var url = Uri.parse(URLs.Login);
  var response = await http.post(body: parameter, url);
  print('Response Body: ${json.decode(response.body)}');
  return loginModelFromJson(response.body);
}

Future<ForgotPasswordModel> forgotData({required var parameter}) async {
  var url = Uri.parse(URLs.forgotPassword);
  var response = await http.post(body: parameter, url);
  // print('Response Body: ${response.body}');
  return forgotPasswordModelFromJson(response.body);
}

Future<ForgotPasswordModel> changePasswordData({required var parameter}) async {
  var url = Uri.parse(URLs.clientchangePassword);
  var response = await http.post(body: parameter, url);
  print('Response Body: ${json.decode(response.body)}');
  return forgotPasswordModelFromJson(response.body);
}

Future<DocumentModel> documentsData({required var parameter}) async {
  var url = Uri.parse(URLs.getAllPublicDocuments);
  var response = await http.post(body: parameter,url);
  String responseData = jsonEncode(json.decode(response.body));
  print('Response Body: ${json.decode(response.body)}');
  return documentModelFromJson(response.body);
}

Future<ContactAdminModel> contactAdmin({required var parameter}) async {
  var url = Uri.parse(URLs.contactAdmin);
  var response = await http.post(body: parameter, url);
  // print('Response Body: ${response.body}');
  return contactAdminModelFromJson(response.body);
}

Future<AchievementModel> achievementData({required var parameter}) async {
  var url = Uri.parse(URLs.getAllAchievement);
  var response = await http.post(body: parameter, url);
  // print('Response Body: ${response.body}');
  return achievementModelFromJson(response.body);
}

Future<ParticipantModel> participantData({required var parameter}) async {
  var url = Uri.parse(URLs.getAllParticipant);
  var response = await http.post(body: parameter, url);
  // print('Response Body: ${response.body}');
  return participantModelFromJson(response.body);
}

Future<UserModel> userData({required var parameter}) async {
  var url = Uri.parse(URLs.lawyerFullView);
  var response = await http.post(body: parameter, url);
  // print('Response Body: ${response.body}');
  print('Response Body: ${json.decode(response.body)}');
  return userModelFromJson(response.body);
}

Future<ProfileCategoryModel> profileCategory() async {
  var url = Uri.parse(URLs.getAllCategory);
  var response = await http.get(url);
  // print('Response Body: ${response.body}');
  return profileCategoryModelFromJson(response.body);
}

Future<ProfileBarAssociationModel> profileBarAssociation() async {
  var url = Uri.parse(URLs.getAllBarAssociation);
  var response = await http.get(url);
  // print('Response Body: ${response.body}');
  return profileBarAssociationModelFromJson(response.body);
}

Future<UserAboutModel> userAboutData({required var parameter}) async {
  var url = Uri.parse(URLs.clientEditProfile);
  // var response = await http.post(body: parameter, url);
  // print('Response Body: ${response.body}');
  // return userAboutModelFromJson(response.body);
  var response = await http.post(url, body: parameter);
  if (response.statusCode == 200) {
    // print('Response Body: ${response.body}');
    return userAboutModelFromJson(response.body);
  } else {
    print('Error: ${response.statusCode}');
    throw Exception('Failed to load data');
  }
}

// Future<CityModel> getCitesFromVakalat({required var parameter}) async {
//   var url = Uri.parse(URLs.getCitesFromVakalatApp);
//   var response = await http.post(body: parameter, url);
//   print('Response Body Length: ${response.body.length}');
//   print('Response Body: ${response.body}');
//   return cityModelFromJson(response.body);
// }

Future<CityModel> getCitesFromVakalat({required var parameter}) async {
  var url = Uri.parse(URLs.getCitesFromVakalatApp);
  var response = await http.post(body: parameter, url);
  // print('Response Body Length: ${response.body.length}');
  // print('Response Body: ${response.body}');

  // Parse the JSON and print the CityModel
  var cityModel = cityModelFromJson(response.body);
  // print('Parsed CityModel: $cityModel');
  // print('Number of cities: ${cityModel.cities.length}');

  return cityModel;
}
