//
//  GlobalViewModel.swift
//  R-own
//
//  Created by Aman Sharma on 13/05/23.
//

import Foundation


class GlobalViewModel: ObservableObject {
    
    @Published var postCounter: Int = 0
    @Published var jobsCounter: Int = 0
    @Published var peopleCounter: Int = 0
    @Published var blogsCounter: Int = 0
    
    
    @Published var newFeedblog: Int = 0
    @Published var newFeedcommunities: Int = 0
    @Published var newFeedhotel: Int = 0
    @Published var newFeedservices: Int = 0
    
    
    @Published var totalUsersInRown: UserCountModel = UserCountModel(count: "0")
    
    @Published var viewingUserRole: String = ""
    @Published var viewingNormalUserID: String = ""
    @Published var viewingVendorUserID: String = ""
    @Published var viewingHotelOwnerUserID: String = ""
    
    @Published var verificationStatusResponse: String = ""
    
    @Published var showDesignationBottomSheet: Bool = false
    
    @Published var showSharePostBottomSheet: Bool = false
    
    
    @Published var keyboardVisibility: Bool = false
    
    @Published var countriesList = [CountryModel]()
    @Published var stateList = [StateModel]()
    @Published var cityList = [CityModel]()
    
    @Published var faqList = [FAQModel]()
    
    
    
    @Published var postDetails = [GetPostModel]()
    
    @Published var newFeedList = [NewFeedModel(posts: [NewFeedPost](), blogs: [NewFeedBlog](), hotels: [NewFeedHotel](), communities: [NewFeedCommunity](), services: [NewFeedService]())]
    
    @Published var blockedUserList = [BlockedUserListModel]()
    
    @Published var designationList = [Designation]()
    @Published var companyList = [Company]()
    @Published var hotelNameList = [HotelNameModel]()
    @Published var vendorServicesList = [VendorService]()
    @Published var selectedVendorServicesList = [String]()
    @Published var selectedVendorServicesNameList = [String]()
    @Published var hotelDataModelList = [HotelDataModel]()
    
    @Published var recentJobs = [RecentJobsModel]()
    @Published var fetchedDepartments = [DepartmentModel]()
    @Published var appliedJobs = [AppliedJobsModel]()
    @Published var matchesJobCriteriaList = [MatchesJobCriteriaModel]()
    @Published var jobApplicantsList = [JobApplicantsModel]()
    @Published var designationnList = [DesignationnModel]()
    @Published var jobDetails = JobDetailsModel(id: "", userID: "", jobApplicants: [JSONAny](), jid: "", jobTitle: "", companyName: "", workplaceType: "", jobType: "", designationType: "", noticePeriod: "", expectedCTC: "", jobLocation: "", jobDescription: "", skillsRecq: "", bookmarked: [JSONAny](), displayStatus: "", hotelLogoURL: "", hotelID: "", v: 0)
    @Published var jobListByHotelOwner = [JobsByHotelOwnerModel]()
    @Published var requestedUsersList = [RequestedUsersModel]()
    
    @Published var nearestConcertList = [NearestConcertModel]()
    @Published var eventCategoryList = [EventCategoryModel]()
    @Published var ongoingEventList = [OngoingEventModel]()
    @Published var eventInfo = [EventsByUserIDModel]()
    @Published var eventsByCategory = [NearestConcertModel]()
    @Published var eventDetailsByEventID = [EventDetailsByEventIDModel]()
    @Published var eventDetailsByEventIDForEdit = [EventDetailsByEventIDModel(id: "", categoryID: "", profilePic: "", userName: "", categoryName: "", userID: "", location: "", venue: "", country: "", state: "", city: "", eventTitle: "", eventDescription: "", eventCategory: "", email: "", phone: "", websiteLink: "", bookingLink: "", price: "", eventThumbnail: "", eventStartDate: "", eventStartTime: "", eventEndDate: "", eventEndTime: "", registrationStartDate: "", registrationStartTime: "", registrationEndDate: "", registrationEndTime: "", eventID: "", dateAdded: "", v: 0)]
    
    @Published var blogsList: BlogsModel?
    @Published var blogsCategory = [BlogsCategoryModel]()
    @Published var blogsListByCategory = [BlogListModel]()
    @Published var blogByBlogID = [BlogByBlogIDModel]()
    @Published var blogList = [BlogListModel]()
    
    @Published var explorePostList = [ExplorePostModel(page: 0, pageSize: 0, posts: [ExplorePost]()) ]
    @Published var exploreJobList = [ExploreJobModel(posts: [ExploreJobPost]())]
    @Published var explorePeopleList = [ExplorePeopleModel(page: 0, pageSize: 0, posts: [Post34]())]
    @Published var exploreEventList = [ExploreEventModel(events: [ExploreEvent]())]
    @Published var exploreBlogList = [ExploreBlogModel(page: 0, pageSize: 0, blogs: [ExploreBlog]())]
    @Published var exploreHotelList = [ExploreHotelModel(page: 0, pageSize: 0, posts: [ExploreHotelPost]())]
    @Published var exploreServiceList = [ExploreServicesModel(page: 0, pageSize: 0, vendors: [ExploreVendor]())]
    
    
    @Published var toastSearchLoading: Bool = false
    
    @Published var exploreSearchPostList = [ExplorePostModel(page: 0, pageSize: 0, posts: [ExplorePost]()) ]
    @Published var exploreSearchJobList = [ExploreJobModel(posts: [ExploreJobPost]())]
    @Published var exploreSearchPeopleList = [ExplorePeopleSearchModel(page: 0, pageSize: 0, posts: [Post344]())]
    @Published var exploreSearchEventList = [ExploreEventModel(events: [ExploreEvent]())]
    @Published var exploreSearchBlogList = [ExploreBlogSearchModel(page: 0, pageSize: 0, blogs: [ExploreBlogSearch]())]
    @Published var exploreSearchHotelList = [ExploreHotelModel(page: 0, pageSize: 0, posts: [ExploreHotelPost]())]
    @Published var exploreSearchServiceList = [ExploreServiceSearchModel(page: 0, pageSize: 0, posts: [ExploreServiceSearch]())]
    
    @Published var getNormalProfileHeader = NormalProfileHeaderModel(data: DataClass543(profile: Profile543(id: "", fullName: "", profilePic: "", verificationStatus: "", userBio: "", userName: "", location: "", normalUserInfo: [NormalUserInfo543](), mesiboAccount: [MesiboAccount](), userID: "", postCount: [PostCount543](), createdOn: ""), postCountLength: 0, connCountLength: 0, reqsCountLength: 0, connectionStatus: ""))
    @Published var getVendorProfileHeader: VendorProfileHeaderModel = VendorProfileHeaderModel(roleDetails: RoleDetails321(vendorInfo: VendorInfo321(vendorImage: "", vendorName: "", vendorDescription: "", websiteLink: "", vendorServices: [VendorService321](), portfolioLink: [PortfolioLink321]()), id: "", fullName: "", profilePic: "", mesiboAccount: [MesiboAccount](), verificationStatus: "", userBio: "", createdOn: "", userName: "", location: "", role: "", postCount: [JSONAny]()), postcount: 0, connectioncount: 0, requestcount: 0, connectionStatus: "")
    
    @Published var getHotelOwnerProfileHeader: HotelOwnerProfileHeaderModel = HotelOwnerProfileHeaderModel(profiledata: Profiledata3433(id: "", fullName: "", profilePic: "", mesiboAccount: [MesiboAccount](), userBio: "", userName: "", postCount: [PostCount3433]()), hotellogo: Hotellogo3433(id: "", hotelLogoURL: ""), connectionCount: 0, requestsCount: 0, postCount: 0, profile: Profile3433(hotelOwnerInfo: HotelOwnerInfo3433(hotelDescription: "", websiteLink: ""), id: "", verificationStatus: "", createdOn: "", location: ""), connectionStatus: "")
    
    @Published var getConnectionList = [ProfileConnectionListModel]()
    @Published var getRequestList = ProfileRequestListModel(conns: [Conn342]())
    
    
    @Published var getPollVotes = [PollVotesModel]()
    
    @Published var hotelData: HotelDataModel = HotelDataModel(id: "", userID: "", hotelName: "", hotelAddress: "", hotelRating: "", hotelLogoURL: "", hotelCoverpicURL: "", bookingengineLink: "", dateAdded: "", hoteldescription: "", displayStatus: "", hotelID: "", gallery: [Gallery](), v: 0)
    
    @Published var getMediaPost = [ProfileMediaPostModel]()
//    (posts: [Post643(id: "", userID: "", caption: "", location: "", postType: "", canSee: "", canComment: "", eventLocation: "", eventName: "", checkinLocation: "", checkinVenue: "", pollQuestion: [], displayStatus: "", media: [], profilePic: "", userName: "", fullName: "", eventThumbnail: "", price: "", eventStartDate: "", verificationStatus: "", postID: "", savedPost: [], v: 0, saved: "", liked: "", likeCount: 0, commentCount: 0)])
    
    @Published var getPollPost = [ProfilePollsPostModel(page: 0, pageSize: 0, posts: [Post434]())]
//    (posts: [Post434(id: "", userID: "", location: "", postType: "", eventLocation: "", eventName: "", checkinLocation: "", checkinVenue: "", pollQuestion: [PollQuestion434(question: "", id: "", questionID: "", dateAdded: "", options: [])], displayStatus: "", media: [], profilePic: "", userName: "", fullName: "", eventThumbnail: "", price: "", eventStartDate: "", verificationStatus: "", postID: "", savedPost: [], v: 0)])
    
    @Published var getStatusPostList = [ProfileStatusPostModel(page: 0, pageSize: 0, posts: [Post583]())]
    
    @Published var eventListWhilePostingList = [EventListWhilePostingModel]()
    
    @Published var feedList = [FeedModel(posts: [Post535]())]
    @Published var likesList = LikesModel(post: Post0343(id: "", postID: "", userID: "", likes: [Like0343](), v: 0), likeCount: 0)
    @Published var commentList = CommentServiceModel(post: Post5355(id: "", userID: "", postID: "", comments: [Comment5355](), v: 0), commentCount: 0)
    
    @Published var personalNotificationList = [GetPersonalNotification]()
    @Published var connectionNotificationList = [GetConnectionNotification]()
    
    
    @Published var vendorServicesListByID = [ServiceByIDModel]()
    
    @Published var hotelListByID = [HotelDataByUserID]()
    @Published var getHotelOwnerInfo =  GetHotelOwnerInfoModel(hotelOwnerInfo: [HotelOwnerInfoElement23](), hotelID: "", hotelLogoURL: "") 
    
    
    @Published var getSavePostList = [GetSavePostModel(posts: [PostSave](), page: 0, pageSize: 0)]
    @Published var getSaveJobList = [GetSaveJobModel(page: 0, pageSize: 0, jobs: [JobSave]())]
    @Published var getSaveEventList = [GetSaveEventModel(page: 0, pageSize: 0, events: [EventSave]())]
    @Published var getSaveServiceList = [GetSaveServiceModel(page: 0, pageSize: 0, services: [ServiceSave]())]
    @Published var getSaveHotelList = [GetSaveHotelModel(page: 0, pageSize: 0, hotels: [HotelSave]())]
    @Published var getSaveBlogList = [GetSaveBlogModel(page: 0, pageSize: 0, blogs: [BlogSave]())]
    
    @Published var communityDetail: CommunityDetailModel = CommunityDetailModel(profilePic: "", groupName: "", description: "", dateAdded: "", creatorName: "", admin: [MesiboGroupUser](), members: [MesiboGroupUser](), latitude: "", longitude: "", communityType: "", totalmember: 0, location: "")
    @Published var ownCommunityModelList: [OwnCommunityGroupDetailsModel] = [OwnCommunityGroupDetailsModel]()
    @Published var openCommunityModelList: [OwnCommunityGroupDetailsModel] = [OwnCommunityGroupDetailsModel]()
    
    @Published var userContactConnectionList: ContactsUserConnectionModel = ContactsUserConnectionModel(message: "", matchedContacts: [MatchedContact(matchedNumber: MatchedNumber(id: "", fullName: "", profilePic: "", mesiboAccount: [MesiboAccount](), verificationStatus: "", userBio: "", role: "", normalUserInfo: [NormalUserInfo](), hospitalityExpertInfo: [JSONAny](), userID: "", connections: [Connection](), requests: [Connection]()), connectionStatus: "")])
}

