final String Base_url = "https://www.vakalat.com/api/";                                    //Done

class URLs {

  static String imagepath = "https://vakalat-public.s3.ap-southeast-1.amazonaws.com/";     //Done

  static String MainCategory = Base_url + "category/main_category_list";                   //Done

  static String SubCategory = Base_url + "category/sub_category_list";                     //Done

  static String get_search_data = Base_url + "category/get_search_data";                   //Done

  static String Login = Base_url + "login/user_login";                                     //Done

  static String forgotPassword = Base_url + "login/forgotPassword";                        //Done

  static String getAllBlog = Base_url + "blog/getAllBlog";                                 //Done

  static String getUserNotice = Base_url + "notice/getAllNotice";                          //Done

  static String getCategoryForFilter = Base_url + "blog/getCategoryForFilter";             //Done

  static String getSubCategoryForFilter = Base_url + "blog/getSubCategoryForFilter";       //Done

  static String getAllEvent = Base_url + "event/getAllEvent";                              //Done

  static String getAllAchievement = Base_url + "achievement/getAllAchievement";            //Done

  static String getAllCommittee = Base_url + "committee/getAllCommittee";                  //Done

  static String getAllCommitteeMember = Base_url + "committee_member/getAllCommitteeMember"; //Done

  static String getAllParticipant = Base_url + "participant/getAllParticipant";            //Done

  static String getAllLinks = Base_url + "refer/getAllLinks";                              //Done

  static String getAllNews = Base_url + "legal_news/getAllNews";                           //Done

  static String getAllPublicDocuments = Base_url + "document_management_system/frontDMS";  //Done

  // static String contactAdmin = Base_url + "contact/contactAdmin";                          //Done

  static String contactAdmin = Base_url + "contact/contactBarAssociation";                          //Done

  static String lawyerFullView = Base_url + "register/lawyerFullView";                     //Done

  static String getAllBarAssociation = Base_url + "profile/getAllBarAssociation";          //Done

  static String getAllCategory = Base_url + "register/getAllCategory";                     //Done

  static String clientEditProfile = Base_url + "profile/getUserDataForEdit";               //Done

  static String getCitesFromVakalatApp = "https://www.vakalat.com/user_api/get_cities";    //Done

  static String clientchangePassword = Base_url + "login/changePassword";

}

class URL {

  static String Base_url = "https://www.vakalat.com/api/";

  static String imagepath = "https://vakalat-public.s3.ap-southeast-1.amazonaws.com/";

  static String Base_urlpk = "https://testapp.vakalat.com/api/";

  static String contactLawyer = Base_url + "contact/contactLawyer";

  static String getAllUsertype = Base_url + "register/getAllUsertype";

  static String getAllCity = Base_url + "register/getCityBasedOnCountry";

  static String getAllCategory = Base_url + "register/getAllCategory";

  static String getAllLawCollege = Base_url + "register/getAllLawCollege";

  static String getAllLawFirm = Base_url + "register/getAllLawFirm";

  static String getAllCountry = Base_url + "register/getAllCountry";

  static String getAllPackage = Base_url + "register/getAllPackage";

  static String addRegister = Base_url + "register/addRegister";

  static String getUserAbout = Base_url + "profile/getUserAbout";

  static String clienteditprofile = Base_url + "profile/getUserDataForEdit";

  static String updateProfile = Base_url + "profile/updateProfile";

  static String requestForEdit = Base_url + "profile/requestForEdit";

  static String updateProfileSettings = Base_url + "profile/updateProfileSettings";

  static String uploadProfilePic = Base_url + "profile/uploadProfilePic";

  static String getAllBarCouncil = Base_url + "profile/getAllBarCouncil";

  static String getAllBarAssociation = Base_url + "profile/getAllBarAssociation";

  static String uploadBiodata = Base_url + "profile/uploadBiodata";

  static String addBlog = Base_url + "blog/addBlog";

  static String editBlog = Base_url + "blog/editBlog";

  static String getAllComment = Base_url + "blog/getAllComment";

  static String addComment = Base_url + "blog/addComment";

  static String getUserBlog = Base_url + "blog/getUserBlog";

  static String getNoticeDesignation = Base_url + "notice/getDesignation";

  static String addBlogLike = Base_url + "blog/addBlogLike";

  static String deleteBlog = Base_url + "blog/deleteBlog";

  static String getBlogDataForEdit = Base_url + "blog/getBlogDataForEdit";

  static String addBlogDislike = Base_url + "blog/addBlogDislike";

  static String getBlogDataByFilter = Base_url + "blog/getBlogDataByFilter";

  static String getAllJob = Base_url + "job/getAllJob";

  static String getJobDetails = Base_url + "job/getJobDetails";

  static String getAllPostJob = Base_url + "job/getAllPostJob";

  static String deleteJob = Base_url + "job/deleteJob";

  static String applyForJob = Base_url + "job/applyForJob";

  static String postNewJob = Base_url + "job/postNewJob";

  static String editPostJob = Base_url + "job/editPostJob";

  static String myAppliedList = Base_url + "job/myAppliedList";

  static String getAppliedJobStatus = Base_url + "job/getAppliedJobStatus";

  static String applyCandidateList = Base_url + "job/applyCandidateList";

  static String getAllUserListForReply = Base_url + "inbox/getAllUserListForReply";

  static String getAllInboxData = Base_url + "inbox/getAllInboxData";

  static String deleteInboxData = Base_url + "inbox/deleteInboxData";

  static String inboxMessageDetail = Base_url + "inbox/inboxMessageDetail";

  static String sendReply = Base_url + "inbox/sendReply";

  static String sendMessage = Base_url + "compose/sendMessage";

  static String sendForward = Base_url + "inbox/sendForward";

  static String multipleUploadDocumentInForward = Base_url + "inbox/multipleUploadDocumentInForward";

  static String getFilterMessagesin = Base_url + "inbox/getFilterMessages";

  static String getMessageToUserin = Base_url + "inbox/getMessageToUser";

  static String getAllEventType = Base_url + "event/getAllEventType";

  static String addEvent = Base_url + "event/addEvent";

  static String deleteEvent = Base_url + "event/deleteEvent";

  static String multilpleEventImageList = Base_url + "event/multilpleEventImageList";

  static String editEventCoverImage = Base_url + "event/editEventCoverImage";

  static String deleteEventImage = Base_url + "event/deleteEventImage";

  static String getUserEvent = Base_url + "event/getUserEvent";

  static String getEventDetail = Base_url + "event/getEventDetail";

  static String joinEvent = Base_url + "event/joinEvent";

  static String editEvent = Base_url + "event/editEvent";

  static String uploadMutlipeImage = Base_url + "event/uploadMutlipeImage";

  static String filterEvent = Base_url + "event/filterEvent";

  static String getDocumentType = Base_url + "document_management_system/getDocumentType";

  static String deleteDocumentType = Base_url + "document_management_system/deleteDocumentType";

  static String addDocumentType = Base_url + "document_management_system/addDocumentType";

  static String editDocumentType = Base_url + "document_management_system/editDocumentType";

  static String multipleDocument = Base_url + "document_management_system/multipleDocument";

  static String addDocument = Base_url + "document_management_system/addDocument";

  static String editDocument = Base_url + "document_management_system/editDocument";

  static String getAllDocument = Base_url + "document_management_system/getAllDocument";

  static String getAllUploadDocument = Base_url + "document_management_system/getAllUploadDocument";

  static String deleteUploadDocument = Base_url + "document_management_system/deleteUploadDocument";

  static String shareDocument = Base_url + "document_management_system/shareDocument";

  static String getClient = Base_url + "document_management_system/getClient";

  static String getUserBasedOnUsertype = Base_url + "document_management_system/getUserBasedOnUsertype";

  static String getClientForFilter = Base_url + "document_management_system/getClientForFilter";

  static String getDocTypeForFilter = Base_url + "document_management_system/getDocTypeForFilter";

  static String getDataByFilterdms = Base_url + "document_management_system/getDataByFilter";

  static String getAllOutboxData = Base_url + "outbox/getAllOutboxData";

  static String deleteOutboxData = Base_url + "outbox/deleteOutboxData";

  static String outboxMessageDetail = Base_url + "outbox/outboxMessageDetail";

  static String getFilterMessagesout = Base_url + "outbox/getFilterMessages";

  static String getMessageToUserout = Base_url + "outbox/getMessageFromUser";

  static String multipleUploadDocumentInMessage = Base_url + "compose/multipleUploadDocumentInMessage";

  static String addAchievement = Base_url + "achievement/addAchievement";

  static String editAchievement = Base_url + "achievement/editAchievement";

  static String deleteAchievement = Base_url + "achievement/deleteAchievement";

  static String addAchievementImages = Base_url + "achievement/addAchievementImages";

  static String deleteAchievementImage = Base_url + "achievement/deleteAchievementImage";

  static String listAchievementImages = Base_url + "achievement/listAchievementImages";

  static String getAchievementDataByFilter = Base_url + "achievement/getAchievementDataByFilter";

  static String getPackageName = Base_url + "payment/getPackageName";

  static String razorpayPayment = Base_url + "payment/razorpayPayment";

  static String getPackageFacility = Base_url + "payment/getPackageFacility";

  static String getRequestedLawyer = Base_url + "profile/getRequestedLawyer";

  static String lawyerApprove = Base_url + "profile/lawyerApprove";

  static String lawyerUnapprove = Base_url + "profile/lawyerUnapprove";

  static String getRequestedStudent = Base_url + "profile/getRequestedStudent";

  static String studentApprove = Base_url + "profile/studentApprove";

  static String studentUnapprove = Base_url + "profile/studentUnapprove";

  static String getPackageSubscription = Base_url + "profile/getPackageSubscription";

  static String getAllDesignation = Base_url + "designation/getAllDesignation";

  static String deleteDesignation = Base_url + "designation/deleteDesignation";

  static String addDesignation = Base_url + "designation/addDesignation";

  static String editDesignation = Base_url + "designation/editDesignation";

  static String addCommittee = Base_url + "committee/addCommittee";

  static String editCommittee = Base_url + "committee/editCommittee";

  static String deleteCommittee = Base_url + "committee/deleteCommittee";

  static String addCommitteeMember = Base_url + "committee_member/addCommitteeMember";

  static String committeeMemberListForAdd = Base_url + "committee_member/committeeMemberListForAdd";

  static String deleteCommitteeMember = Base_url + "committee_member/deleteCommitteeMember";

  static String editCommitteeMember = Base_url + "committee_member/editCommitteeMember";

  static String addUser = Base_url + "createuser/addUser";

  static String getAllUser = Base_url + "createuser/getAllUser";

  static String editUser = Base_url + "createuser/editUser";

  static String deleteUser = Base_url + "createuser/deleteUser";

  static String getCityForFilter = Base_url + "createuser/getCityForFilter";

  static String getDataByFilter = Base_url + "createuser/getDataByFilter";

  static String addParticipant = Base_url + "participant/addParticipant";

  static String editParticipant = Base_url + "participant/editParticipant";

  static String deleteParticipant = Base_url + "participant/deleteParticipant";

  static String addParticipantImages = Base_url + "participant/addParticipantImages";

  static String deleteParticipantImage = Base_url + "participant/deleteParticipantImage";

  static String listParticipantImages = Base_url + "participant/listParticipantImages";

  static String getParticipationDataByFilter = Base_url + "participant/getParticipationDataByFilter";

  static String getLawFirmMember = Base_url + "member/getLawFirmMember";

  static String filterMember = Base_url + "member/filterMember";

  static String getAllMenu = Base_url + "menu/getAllMenu";

  static String getAllService = Base_url + "service/getAllService";

  static String addService = Base_url + "service/addService";

  static String editService = Base_url + "service/editService";

  static String deleteService = Base_url + "service/deleteService";

  static String serviceSubCategory = Base_url + "service/serviceSubCategory";

  static String addRefer = Base_url + "refer/addRefer";

  static String editRefer = Base_url + "refer/editRefer";

  static String deleteRefer = Base_url + "refer/deleteRefer";

  static String getLawyerClient = Base_url + "case_master/getLawyerClient";

  static String getAllPoliceStation = Base_url + "case_master/getAllPoliceStation";

  static String getAllCourt = Base_url + "case_master/getAllCourt";

  static String getLawSection = Base_url + "case_master/getLawSection";

  static String getAllAct = Base_url + "case_master/getAllAct";

  static String  getCaseList = Base_url + "case_management/getCaseList";

  static String addCaseDetails = Base_url + "case_management/addCaseDetails";

  static String editCaseDetails = Base_url + "case_management/editCaseDetails";

  static String deleteCaseDetail = Base_url + "case_management/deleteCaseDetail";

  static String getCaseTransactionList = Base_url + "case_management/getCaseTransactionList";

  static String addCaseTransaction = Base_url + "case_management/addCaseTransaction";

  static String editCaseTransaction = Base_url + "case_management/editCaseTransaction";

  static String deleteCaseTransaction = Base_url + "case_management/deleteCaseTransaction";

  static String getAllCaseStage = Base_url + "case_master/getAllCaseStage";


  static String getCaseDocumentList = Base_url + "case_management/getCaseDocumentList";
  static String addCaseDocument = Base_url + "case_management/addCaseDocument";
  static String editCaseDocument = Base_url + "case_management/editCaseDocument";
  static String deleteCaseDocument = Base_url + "case_management/deleteCaseDocument";


  static String getAllDegree = Base_url + "course_configuration/getAllDegree";
  static String addDegree = Base_url + "course_configuration/addDegree";
  static String editDegree = Base_url + "course_configuration/editDegree";
  static String deleteDegree = Base_url + "course_configuration/deleteDegree";

  static String getAllSemester = Base_url + "course_configuration/getAllSemester";
  static String addSemester = Base_url + "course_configuration/addSemester";
  static String editSemester = Base_url + "course_configuration/editSemester";
  static String deleteSemester = Base_url + "course_configuration/deleteSemester";

  static String getAllSubject = Base_url + "course_configuration/getAllSubject";
  static String addSubject = Base_url + "course_configuration/addSubject";
  static String editSubject = Base_url + "course_configuration/editSubject";
  static String deleteSubject = Base_url + "course_configuration/deleteSubject";

  static String getAllAcademicYear = Base_url + "course_configuration/getAllAcademicYear";
  static String addAcademicYear = Base_url + "course_configuration/addAcademicYear";
  static String editAcademicYear = Base_url + "course_configuration/editAcademicYear";
  static String deleteAcademicYear = Base_url + "course_configuration/deleteAcademicYear";
  static String getSubjectBasedOnDegree = Base_url + "course_configuration/getSubjectBasedOnDegree";



  static String getAllFessList = Base_url + "Fees_master/getAllFessList";
  static String addFees = Base_url + "fees_master/addFees";
  static String editFees = Base_url + "fees_master/editFees";
  static String deleteFees = Base_url + "fees_master/deleteFees";

  static String lawyerFeesList = Base_url + "fees_master/lawyerFeesList";
  static String lawyerFees = Base_url + "fees_master/lawyerFees";

  static String getAllLawCourses = Base_url + "course_configuration/getAllLawCourses";
  static String addLawCourse = Base_url + "course_configuration/addLawCourse";
  static String editLawCourse = Base_url + "course_configuration/editLawCourse";
  static String deleteLawCourse = Base_url + "course_configuration/deleteLawCourse";




  static String getAllProduct = Base_urlpk + "product/getAllProduct";

  static String getAllCategorypk = Base_urlpk + "category/productCategoryList";

  static String getCart = Base_urlpk + "cart/getCart";

  static String addToCart = Base_urlpk + "cart/addToCart";

  static String getAllAddress = Base_urlpk + "address/getAllAddress";

  static String addAddress = Base_urlpk + "address/addAddress";

  static String editAddress = Base_urlpk + "address/editAddress";

  static String deleteAddress = Base_urlpk + "address/deleteAddress";

  static String getAllOrder = Base_urlpk + "order/getAllOrder";

  static String addOrder = Base_urlpk + "order/addOrder";

  static String orderDetail = Base_urlpk + "order/orderDetail";

  static String placeOrder = Base_urlpk + "order/placeOrder";

  static String orderOtpSend = Base_urlpk + "order/orderOtpSend";

  static String orderOtpVerify = Base_urlpk + "order/orderOtpVerify";

  static String deleteCartProduct = Base_urlpk + "cart/deleteCartProduct";

  static String updateCart = Base_urlpk + "cart/updateCart";

  static String giveRiderCurrentLocation = Base_urlpk + "rider_order/giveRiderCurrentLocation";

  static String getOrderFilterData = Base_url + "order/getOrderFilterData";

  static String getAllAds = Base_url + "notice/getAllAds";

  static String lawyerFullView = Base_url + "register/lawyerFullView";

  static String contactAdmin = Base_url + "contact/contactAdmin";

//    public static String Base_url = "https://vakalat.com/api/";
//    public static String Base_url = "https://testapp.vakalat.com/api/";
//    public static String imgpath = "https://testapp.vakalat.com/public/upload/";
//    public static String imagepath = "https://vakalat.com/public/upload/";
//    public static String getAllPoliceStation = Base_url + "case_master/getAllPoliceStation";
//    public static String getAllCourt = Base_url + "case_master/getAllCourt";
//    public static String getLawSection = Base_url + "case_management/getLawSection";
//    public static String getCaseList = Base_url + "case_management/addCaseDetails";
}