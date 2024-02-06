import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:shimmer/shimmer.dart';
import 'package:surat_district_bar_association/services/AppConfig.dart';
import '../drawer_details/search/search_tile.dart';
import '../model/blog_category_model.dart';
import '../model/blog_model.dart';
import '../model/blog_sub_category_model.dart';
import '../model/login_model.dart';
import '../widgets/media_query_sizes.dart';
import '../widgets/sharedpref.dart';

class BlogTileAgain extends StatefulWidget {
  const BlogTileAgain({super.key});

  @override
  State<BlogTileAgain> createState() => _BlogTileAgainState();
}

class _BlogTileAgainState extends State<BlogTileAgain> {
  LoginModel login = loginModelFromJson(SharedPref.get(prefKey: PrefKey.saveUser)!);
  final ScrollController _controller = ScrollController();
  String mainUrl = "https://vakalat-public.s3.ap-southeast-1.amazonaws.com/";

  String apiUrlBlog = 'https://www.vakalat.com/api/blog/getAllBlog';
  String apiUrlCategory = 'https://www.vakalat.com/api/blog/getAllCategory';
  String apiUrlSubCategory = 'https://www.vakalat.com/api/blog/getAllSubCategory';

  String selectedCategory = "";
  String? selectedSubCategory;
  String search_text = "";

  List<blogDatum> blogData = [];
  List<blogCategoryDatum?> categoryData = [];
  List<blogSubCategoryDatum?> subCategoryData = [];

  // Fetch Blog Data
  Future<void> fetchBlogData() async {
    try {
      final response = await http.post(
        Uri.parse(apiUrlBlog),
        body: {
          "app_user": AppConfig.APP_USER,
          "search_text": search_text,
          "category_id": selectedCategory,
          "subcat_id": selectedSubCategory ?? "",
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);
        BlogModel blogModel = BlogModel.fromJson(jsonResponse);

        if (blogModel.flag == 0) {
          setState(() {
            blogData = blogModel.data;
          });
        } else {
          // Handle the case when the API returns an error
        }
      } else {
        // Handle errors from the API
      }
    } catch (e) {
      // Handle other errors
      print(e.toString());
    }
  }

  // Fetch Category Data
  Future<void> fetchCategoryData() async {
    try {
      final response = await http.get(Uri.parse(apiUrlCategory));

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);
        BlogCategoryModel categoryModel = BlogCategoryModel.fromJson(jsonResponse);

        if (categoryModel.flag == 0) {
          setState(() {
            categoryData = categoryModel.data;
          });
        } else {
          // Handle the case when the API returns an error
        }
      } else {
        // Handle errors from the API
      }
    } catch (e) {
      // Handle other errors
      print(e.toString());
    }
  }

  // Fetch Subcategory Data
  Future<void> fetchSubCategoryData(String key) async {
    try {
      final response = await http.get(Uri.parse(apiUrlSubCategory));

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);
        BlogSubCategoryModel subCategoryModel = BlogSubCategoryModel.fromJson(jsonResponse);

        if (subCategoryModel.flag == 0) {
          setState(() {
            subCategoryData = subCategoryModel.data;
          });
        } else {
          // Handle the case when the API returns an error
        }
      } else {
        // Handle errors from the API
      }
    } catch (e) {
      // Handle other errors
      print(e.toString());
    }
  }

  void showCategoryDropdown(BuildContext context) {
    showMenu(
      context: context,
      position: RelativeRect.fromLTRB(100, 100, 0, 0),
      items: categoryData.map((category) {
        return PopupMenuItem<String>(
          value: category?.catId ?? '',
          child: Text(category?.catName ?? ''),
        );
      }).toList(),
    ).then((value) {
      if (value != null) {
        setState(() {
          selectedCategory = value;
        });
        // Fetch blog data based on the selected category
        fetchBlogData();
      }
    });
  }

  void showSubCategoryDropdown(BuildContext context) {
    showMenu(
      context: context,
      position: RelativeRect.fromLTRB(100, 100, 0, 0),
      items: subCategoryData.map((subcategory) {
        return PopupMenuItem<String>(
          value: subcategory?.catId ?? '',
          child: Text(subcategory?.catName ?? ''),
        );
      }).toList(),
    ).then((value) {
      if (value != null) {
        setState(() {
          selectedSubCategory = value;
        });
        // Fetch blog data based on the selected sub-category
        fetchBlogData();
      }
    });
  }

  @override
  void initState() {
    super.initState();
    // Call the fetch methods when the widget is initialized
    fetchBlogData();
    fetchCategoryData();
    fetchSubCategoryData("some_key"); // Pass the required key here
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your App Title'),
        // actions: [
        //   IconButton(
        //     icon: Icon(Icons.filter_list),
        //     onPressed: () {
        //       _showFilterDialog();
        //     },
        //   ),
        // ],
        actions: [
          // Add your filter button here
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'category') {
                // Show category dropdown
                showCategoryDropdown(context);
              } else if (value == 'subcategory') {
                // Show sub-category dropdown
                showSubCategoryDropdown(context);
              }
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              const PopupMenuItem<String>(
                value: 'category',
                child: Text('Category'),
              ),
              const PopupMenuItem<String>(
                value: 'subcategory',
                child: Text('Sub-Category'),
              ),
            ],
          ),
        ],
      ),
      body: blogData.isNotEmpty
          ? ScrollConfiguration(
        behavior: MyBehavior(),
        child: blogData.length > 0
            ? ListView.builder(
            controller: _controller,
            itemCount: blogData.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.all(10),
                child: Material(
                  elevation: 5,
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius:
                      BorderRadius.all(Radius.circular(10.r))),
                  child: InkWell(
                    radius: 0,
                    onTap: () {
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) =>
                      //             BlogTileDetailScreen(
                      //               allData: data[index],
                      //             )));
                    },
                    hoverColor: Colors.white,
                    borderRadius:
                    BorderRadius.all(Radius.circular(10.r)),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 10, bottom: 10, left: 10, right: 10),
                      child: Container(
                        constraints: BoxConstraints(
                          maxHeight: double.infinity,
                        ),
                        decoration: BoxDecoration(
                          borderRadius:
                          BorderRadius.all(Radius.circular(10.r)),
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Text(
                                    // '1. JUVENILE\nDELINQUENCY OR SOCIAL WELFARE ASSOCIATION',
                                    blogData[index].title,
                                    softWrap: true,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                    textScaleFactor: 1,
                                    style: TextStyle(
                                      // fontSize: 10.6,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                                Spacer(),
                                Text(
                                  // '21/12/2021',
                                  blogData[index].blogDate,
                                  softWrap: true,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  textScaleFactor: 1,
                                  style: TextStyle(
                                    // fontSize: 10.6,
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                            // Padding(padding: EdgeInsets.symmetric(vertical: screenheight(context,dividedby: 200.h))),
                            Padding(padding: EdgeInsets.only(top: 10)),
                            // ClipRRect(
                            //     borderRadius: BorderRadius.all(
                            //         Radius.circular(10)),
                            //     child: Image(
                            //       image:
                            //           // AssetImage('images/blogpost.png'),
                            //       NetworkImage(mainUrl + data[index]!.imageUrl),
                            //       height: screenheight(context,
                            //           dividedby: 3.75.h),
                            //       width: double.infinity,
                            //       fit: BoxFit.cover,
                            //     )),
                            CachedNetworkImage(
                              imageUrl: mainUrl + blogData[index].imageUrl,
                              imageBuilder: (context, imageProvider) =>
                                  ClipRRect(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10)),
                                      child: Image(
                                        image:
                                        // AssetImage('images/blogpost.png'),
                                        NetworkImage(mainUrl +
                                            blogData[index].imageUrl),
                                        height: screenheight(context,
                                            dividedby: 3.75.h),
                                        width: double.infinity,
                                        fit: BoxFit.cover,
                                      )),
                              placeholder: (context, url) => Center(
                                  child: CircularProgressIndicator(
                                    color: Colors.grey,
                                    strokeWidth: 3,
                                  )),
                              errorWidget: (context, url, error) =>
                                  Visibility(
                                      visible: false,
                                      child: Container()),
                            ),
                            Padding(padding: EdgeInsets.only(top: 10)),
                            Text(
                              // "Scanning pages of our favourite Newspaper(s) and giving a brief glance to our mobile phone to keep ourselves abreast with the social media updates is nowadays our indispensable daily repeat. Nearly 150 years on, the story of Khan's ordeal now features in a list of the earliest crimes reported in Delhi, records for which were uploaded on the city police's website last month.",
                              blogData[index].description,
                              softWrap: true,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 4,
                              textScaleFactor: 0.9,
                              style: TextStyle(
                                // fontSize: 10.6,
                                  fontWeight: FontWeight.w400),
                            ),
                            Padding(padding: EdgeInsets.only(top: 10)),
                            Row(
                              crossAxisAlignment:
                              CrossAxisAlignment.center,
                              mainAxisAlignment:
                              MainAxisAlignment.start,
                              children: [
                                Text(
                                  'By : ',
                                  softWrap: true,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  textScaleFactor: 1,
                                  style: TextStyle(
                                    // fontSize: 10.6,
                                      fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  // 'Ravi Mathur',
                                  blogData[index].authorName,
                                  softWrap: true,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  textScaleFactor: 1,
                                  style: TextStyle(
                                    // fontSize: 10.6,
                                      fontWeight: FontWeight.w400),
                                ),
                                Spacer(),
                                Icon(
                                  CupertinoIcons.doc_on_clipboard_fill,
                                  color: Colors.grey.shade600,
                                  size: 17,
                                ),
                                Text(
                                  // ' Criminal',
                                  " " + blogData[index].catName,
                                  softWrap: true,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  textScaleFactor: 1,
                                  style: TextStyle(
                                    // fontSize: 10.6,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 10, bottom: 10),
                              child: Divider(
                                color: Colors.black,
                                thickness: 1,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Row(
                                children: [
                                  Icon(
                                    CupertinoIcons.hand_thumbsup,
                                    size: 20,
                                    color: Colors.grey.shade600,
                                  ),
                                  Text(
                                    // ' 0',
                                    " " +
                                        blogData[index]
                                            .totalLike
                                            .toString(),
                                    textScaleFactor: 1.17,
                                    style: TextStyle(
                                      // fontSize: 10.6,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  Padding(
                                    padding:
                                    const EdgeInsets.only(left: 20),
                                    child: Icon(
                                      CupertinoIcons.hand_thumbsdown,
                                      color: Colors.grey.shade600,
                                      size: 20,
                                    ),
                                  ),
                                  Text(
                                    // ' 0',
                                    " " +
                                        blogData[index]
                                            .totalDislike
                                            .toString(),
                                    textScaleFactor: 1.17,
                                    style: TextStyle(
                                      // fontSize: 10.6,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  Padding(
                                    padding:
                                    const EdgeInsets.only(left: 20),
                                    child: Icon(
                                      CupertinoIcons
                                          .captions_bubble_fill,
                                      size: 20,
                                      color: Colors.grey.shade600,
                                    ),
                                  ),
                                  Text(
                                    // ' 0',
                                    " " +
                                        blogData[index]
                                            .totalComment
                                            .toString(),
                                    textScaleFactor: 1.17,
                                    style: TextStyle(
                                      // fontSize: 10.6,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
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
        child: ScrollConfiguration(
          behavior: MyBehavior(),
          child: ListView.builder(
            controller: _controller,
            itemCount: 15,
            itemBuilder: (_, __) => Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 20, top: 20, right: 20),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: 30,
                          width: 150,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                                Radius.circular(10.r)),
                            color: Colors.white,
                          ),
                        ),
                        Container(
                          height: 20,
                          width: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                                Radius.circular(10.r)),
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 20),
                    ),
                    Container(
                      height:
                      screenheight(context, dividedby: 3.75.h),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius:
                        BorderRadius.all(Radius.circular(10.r)),
                        color: Colors.white,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10),
                    ),
                    Container(
                      height: 10,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius:
                        BorderRadius.all(Radius.circular(10.r)),
                        color: Colors.white,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 7.5),
                    ),
                    Container(
                      height: 10,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius:
                        BorderRadius.all(Radius.circular(10.r)),
                        color: Colors.white,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 7.5),
                    ),
                    Container(
                      height: 10,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius:
                        BorderRadius.all(Radius.circular(10.r)),
                        color: Colors.white,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 7.5),
                    ),
                    Container(
                      height: 10,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius:
                        BorderRadius.all(Radius.circular(10.r)),
                        color: Colors.white,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10),
                    ),
                    Row(
                      mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: 20,
                          width: 110,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                                Radius.circular(10.r)),
                            color: Colors.white,
                          ),
                        ),
                        Container(
                          height: 20,
                          width: 120,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                                Radius.circular(10.r)),
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding:
                      const EdgeInsets.only(top: 10, bottom: 10),
                      child: Divider(
                        color: Colors.black,
                        thickness: 1,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            height: 25,
                            width: 35,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                  Radius.circular(5.r)),
                              color: Colors.white,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: Container(
                              height: 25,
                              width: 35,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(
                                    Radius.circular(5.r)),
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: Container(
                              height: 25,
                              width: 35,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(
                                    Radius.circular(5.r)),
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
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
