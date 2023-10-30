//
//  LoginViewModel.swift
//  R-own
//
//  Created by Aman Sharma on 08/04/23.
//


import SwiftUI
import Firebase
import CryptoKit
import AuthenticationServices
import GoogleSignIn
import mesibo
import CoreLocation

class LoginViewModel: ObservableObject{
    
    //Hiding object var
    @AppStorage("hidden_kpi") var isHiddenKPI: Bool = false
    
    
    //View Properties
    @Published var otpCode: String = ""
    @Published var CLIENT_CODE: String = ""
    @Published var username: String = ""
    @Published var contactPhoneNumber: String = ""
    @Published var usernameStatus: String = ""
    @Published var hotelType: String = ""
    @Published var hotelName: String = ""
    @Published var hotelAddress: String = ""
    @Published var hotelRating: String = ""
    @Published var noOfHotels: String = "1"
    @Published var hotelChainName: String = ""
    @Published var hotelWebsiteLink: String = ""
    @Published var hotelBookingEngineLink: String = ""
    @Published var hotelLocationCountry: String = ""
    @Published var hotelLocationState: String = ""
    @Published var hotelLocationCity: String = ""
    @Published var hotelLocation: String = ""
    @Published var hotelLogoURL: String = ""
    @Published var hotelDescription: String = ""
    @Published var hotelProfilepicURL: String = ""
    @Published var hotelCoverpicURL: String = ""
    @Published var brandName: String = ""
    @Published var brandDescription: String = ""
    @Published var brandPortfolioLink: String = ""
    @Published var brandWebsiteLink: String = ""
    @Published var brandServices: String = ""
    @Published var userBio: String = ""
    @Published var userGender: String = ""
    @Published var coordinates: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 0, longitude: 0)
    
    @Published var rownLogoXOffset: CGFloat = UIScreen.screenHeight/15
    @Published var rownLogoOpacity: CGFloat = 0
    @Published var rownLogoPosChange: Bool = false
    
    
    @Published var countriesList = [CountriesForBar]()
    
    
    @Published var interestList = [GetInterest]()
    @Published var selectedInterestList = [GetInterest]()
    @Published var hotelChainList = [Hotel]()
    @Published var selectedBrandServiceList = [String]()
    
    @Published var userImage: UIImage?
    
    @Published var showSheet: Bool = false
    @Published var showCountrySheet: Bool = false
    @Published var showStateSheet: Bool = false
    @Published var showRoleSheet: Bool = false
    @Published var showJobSheet: Bool = false
    @Published var showCitySheet: Bool = false
    @Published var showCompanySheet: Bool = false
    @Published var showEmploymentTypeSheet: Bool = false
    @Published var showBrandServiceSheet: Bool = false
    @Published var showHotelLocationSheet: Bool = false
    @Published var showHotelRatingSheet: Bool = false
    @Published var showHotelSheet: Bool = false
    @Published var showHotelTypeSheet: Bool = false
    @Published var goToVerify: Bool = false
    @Published var otpSent: Bool = false
    @Published var wrongOTP: Bool = false
    @Published var emailVerification: Bool = false
    @Published var userAccountStatus: Bool = false
    @Published var navigateToInterestView: Bool = false
    @Published var contactsUploadDenied: Bool = false
    @Published var contactsNotAvailable: Bool = false
    @Published var contactsSettingInfo: Bool = false
    @Published var mainLocationBottomSheet: Bool = false
    @Published var nTPPProfileSettingBottomSheet: Bool = false
    @Published var openShareToConnectionBottomSheet: Bool = false
    @Published var showNewUserConnectionBottomSheet: Bool = false
    @Published var showNewUserConnectionBottomSheetShownOnce: Bool = false
    @Published var callActivated: Bool = false
    @Published var deleteAccountBottomSheetToggle: Bool = false
    @Published var isLoadingNewFeed: Bool = true
    @Published var isServerError: Bool = false
    @Published var isAppUpdate: Bool = false
    @Published var showProfileMax: Bool = false
    @Published var selectedProfilePicMax: String = ""
    
    //Notification
    @AppStorage("notificationMessageView") var notificationMessageView: Bool = false
    @AppStorage("notificationPostView") var notificationPostView: Bool = false
    @AppStorage("notificationPostView") var notificationNormalPostPostView: Bool = false
    @AppStorage("notificationPostView") var notificationCheckInPostView: Bool = false
    @AppStorage("notificationProfileView") var notificationProfileView: Bool = false
    @AppStorage("notificationUserpostID") var notificationUserpostID: String = ""
    @AppStorage("notificationUserpostType") var notificationUserpostType: String = ""
    @AppStorage("notificationUserAddress") var notificationUserAddress: String = ""
    @AppStorage("notificationUseruserID") var notificationUseruserID: String = ""
    @AppStorage("notificationUserrole") var notificationUserrole: String = ""
    @AppStorage("contactText") var contactsText: String = ""
    
    
    
    @Published var longTapActiveMessage: Bool = false
    @Published var longTapActiveMessageText: MesiboMessage = MesiboMessage()
    
    //Loader Var
    @Published var showLoader: Bool = false
    
    //Error Properties
    @Published var showError: Bool = false
    @Published var errorMessage: String = ""
    
    //App Database
    @AppStorage("otp_status") var otpStatus: Bool = false
    @AppStorage("log_status_email") var logStatusviaEmail: Bool = false
    @AppStorage("log_status_number") var logStatusviaNumber: Bool = false
    @AppStorage("onboarding_completed") var onboardingCompleted: Bool = false
    @AppStorage("interest_selected") var interestSelected: Bool = false
    @AppStorage("contacts_uploaded") var contactsUploaded: Bool = false
    @AppStorage("login_status") var loginStatus: Bool = false
    @AppStorage("login_status_final") var loginStatusFinal: Bool = false
    @AppStorage("user_already_exist")  var userAlreadyExist: Bool = false
    @AppStorage("connect_user_modal") var connectUserModal: Bool = true
    @AppStorage("mesibo_initalize_once") var mesiboInitializeOnce: Bool = true
    @AppStorage("basic_Profile_Info_Completed") var basicProfileInfoCompleted: Bool = false
    @AppStorage("profileLocationInfoCompleted") var profileLocationInfoCompleted: Bool = false
    @AppStorage("roleSelectionInfo") var roleSelectionInfo: Bool = false
    @AppStorage("profile_completed") var profileCompleted: Bool = false
    @AppStorage("job_requested") var jobRequested: Bool = false
    @AppStorage("log_out") var logOut: Bool = false
    
    //App User Data
    @AppStorage("main_user_phone_number") var mainUserPhoneNumber: String = ""
    @AppStorage("mai_user_mesibo_token") var mainUserMesiboToken: String = ""
    @AppStorage("main_user_mesibo_uid") var mainUserMesiboUID: Int = 0
    @AppStorage("main_user_id") var mainUserID: String = ""
    @AppStorage("main_user_full_name") var mainUserFullName: String = ""
    @AppStorage("main_user_email") var mainUserEmail: String = ""
    @AppStorage("main_user_profile_pic") var mainUserProfilePic: String = ""
    @AppStorage("main_user_dob") var mainUserDOB: String = ""
    @AppStorage("main_user_fName") var mainUserFirstName: String = ""
    @AppStorage("main_user_lName") var mainUserLastName: String = ""
    @AppStorage("main_user_userName") var mainUserUserName: String = ""
    @AppStorage("main_user_location_country") var mainUserLocationCountry: String = ""
    @AppStorage("main_user_location_state") var mainUserLocationState: String = ""
    @AppStorage("main_user_location_city") var mainUserLocationCity: String = ""
    @AppStorage("main_user_location_city") var mainUserLocation: String = ""
    @AppStorage("main_user_role") var mainUserRole: String = ""
    @AppStorage("main_user_job_title") var mainUserJobTitle: String = ""
    @AppStorage("main_user_college") var mainUserCollege: String = ""
    @AppStorage("main_user_session_start") var mainUserSessionStart: String = ""
    @AppStorage("main_user_session_end") var mainUserSessionEnd: String = ""
    @AppStorage("main_user_employment_type") var mainUserEmploymentType: String = ""
    @AppStorage("main_user_job_start") var mainUserJobStart: String = ""
    @AppStorage("main_user_job_end") var mainUserJobEnd: String = ""
    @AppStorage("main_user_company") var mainUserCompany: String = ""
    @AppStorage("main_user_hotel_logo") var mainUserHotelLogo: String = ""
    @AppStorage("apn_token") var apnToken: String = ""
    @AppStorage("profile_completion_percentage") var profileCompletionPercentage: String = ""
    @AppStorage("verificationStatus") var mainUserVerificationStatus: String = ""
    @AppStorage("connectionCount") var mainUserConnectionCount: Int = 0
    
    
    @AppStorage("contactsSync") var contactsSynced: String = ""
    
    
    @Published var appUpdate = [AppUpdateModel]()
    
    @Published var userDOB = Date()
    
    //AppleSignin Properties
    @Published var nonce: String = ""
    
    //Mesibo Variable
    @StateObject var mesiboData = MesiboViewModel()
//    @State var addUserResponse: AddUserResponse = AddUserResponse(address: String, token: String, uid: Int)
    
    //Mesibo Variable
    @StateObject var userVM = UserViewModel()
    
    // MARK: User Variable
    @Published var totalUserList = [UserDataFromServer]()
    @Published var userData = UserDataFromServer(hotelOwnerInfo: HotelOwnerInfo(hotelownerName: "", hotelDescription: "", hotelType: "", hotelCount: "", websiteLink: "", bookingEngineLink: "", hotelownerid: "", hotelInfo: [JSONAny]()), vendorInfo: VendorInfo(vendorImage: "", vendorName: "", vendorDescription: "", websiteLink: "", vendorServices: [JSONAny](), portfolioLink: [JSONAny]()), id: "", fullName: "", email: "", phone: "", profilePic: "", resume: "", mesiboAccount: [MesiboAccount](), interest: [Interest](), verificationStatus: "", userBio: "", createdOn: "", savedPost: [JSONAny](), likedPost: [LikedPost?](), userName: "", dob: "", location: "", profileCompletionStatus: "", role: "", deviceToken: "", studentEducation: [StudentEducation?](), normalUserInfo: [NormalUserInfoProfile?](), hospitalityExpertInfo: [HospitalityExpertInfoProfile?](), displayStatus: "", userID: "", bookmarkjob: [JSONAny](), postCount: [PostCount?](), connections: [Connection?](), pendingRequest: [Connection?](), requests: [Connection?](), v: 0, gender: "")
    
    // MARK: Contacts Variable
    @Published var contactsList = [AnyHashable]()
    
    //MAIN FEED
    @Published var selectedMainFeedTab: String = "Home"
    
    @Published var otpResent: Bool = false
    
    //firbase APIs
    
    //Firebase mobile number getOtp API
    func getOTPCode(loginData: LoginViewModel) async -> String {
        print(loginData.mainUserPhoneNumber)
        
        do {
            let code = try await withCheckedThrowingContinuation { continuation in
                PhoneAuthProvider.provider().verifyPhoneNumber("\(loginData.mainUserPhoneNumber)", uiDelegate: nil)
                { (Code, err) in
                    if let error = err {
                        print(error.localizedDescription)
                        continuation.resume(returning: "Failure: \(error.localizedDescription)")
                    } else {
                        self.CLIENT_CODE = Code ?? ""
                        withAnimation(.easeInOut){
                            self.otpStatus = true
                            print("otp sent")
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                                loginData.showLoader = false
                            }
                        }
                        continuation.resume(returning: "Success")
                    }
                }
            }
            
            return code
        } catch {
            return "Failure"
        }
    }

    
    //Firebase mobile number getOtp API
    func resendOTPCode(loginData: LoginViewModel){
        print(mainUserPhoneNumber)
        PhoneAuthProvider.provider().verifyPhoneNumber("\(loginData.mainUserPhoneNumber)", uiDelegate: nil){ (Code, err) in
            if let error = err{
                print(error.localizedDescription)
            }
            self.CLIENT_CODE = Code ?? ""
            withAnimation(.easeInOut){
                self.otpSent = true
                self.otpStatus = true
                self.otpResent = true
                print("otp sent")
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    loginData.showLoader = false
                }
            }
        }
    }
    
    //Firebase mobile number verify OTP API
    func verifyOTPCode(trylogindata: LoginViewModel) {
        print("verification of otp started")
        let credential = PhoneAuthProvider.provider().credential(withVerificationID: CLIENT_CODE, verificationCode: trylogindata.otpCode)
        print("credential provided")
        print(credential)
         Auth.auth().signIn(with: credential){ (result,err) in
            if let error = err{
                print("Wrong OTP")
                print(error.localizedDescription)
                print("wrong OTP")
                trylogindata.wrongOTP = true
                trylogindata.otpCode = ""
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    trylogindata.showLoader = false
                }
                
            } else {
                print("----result of otp validation-----")
                print(result as Any)
                print("----result of otp validation-----")
                self.userVM.addUserToServerModelFunc(loginData: trylogindata)
                
                withAnimation(.easeInOut){
                    print("otp verified")
                    print("Success")
                }
            }
        }
    }
    
    
    
    //Handling Errors
//    func handleError(error: Error)async{
//        await MainActor.run(body: {
//            errorMessage = error.localizedDescription
//            showError.toggle()
//        })
//    }
    
    //One Tap Apple Authentication
//    func appleAuthenticate(credential: ASAuthorizationAppleIDCredential){
//
//        //getting token
//        guard let token = credential.identityToken else{
//            print("error with firebase")
//
//            return
//        }
//        //Token String
//        guard let tokenString = String(data: token, encoding: .utf8) else{
//            print("Error with apple token")
//            return
//        }
//        let firebaseCredential = OAuthProvider.credential(withProviderID: "apple.com", idToken: tokenString, rawNonce: nonce)
//        Auth.auth().signIn(with: firebaseCredential) {(result, err) in
//            if let error = err{
//                print(error.localizedDescription)
//                return
//            }
//            //User successfully logged into firebase
//            print("Logged in Success")
//            withAnimation(.easeInOut){
//                self.logStatusviaEmail = true
//            }
//        }
//    }
    
    // One Tap Google Sign In firebase API
  
//    func signInWithGoogle(){
//        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
//
//        // Create Google Sign In configuration object.
//        let config = GIDConfiguration(clientID: clientID)
//        GIDSignIn.sharedInstance.configuration = config
//
//        // Start the sign in flow!
//        GIDSignIn.sharedInstance.signIn(withPresenting: UIApplication.shared.rootController()) { user, error in
//
//            if let error = error {
//                print(error.localizedDescription)
//
//                return
//            }
//            guard
//                let user = user?.user,
//                let idToken = user.idToken else {return}
//
//            let accessToken = user.accessToken
//            let credential = GoogleAuthProvider.credential(withIDToken: idToken.tokenString,
//                                                         accessToken: accessToken.tokenString)
//            Auth.auth().signIn(with: credential) { res, error in
//                if let error = error {
//                    print(error.localizedDescription)
//                    return
//                }
//                guard let user = res?.user else{
//                    return
//                }
//                print(user)
//                withAnimation(.easeInOut){
//                    self.logStatusviaEmail = true
//                }
//            }
//        }
//    }
    
    //NumberFormatter
    
    var formatter: NumberFormatter = {
        var formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }()
    
    func testotp(){
        otpSent.toggle()
    }
    
    func testverifyotp(){
        logStatusviaNumber.toggle()
    }
    
    func testverifyemail(loginData: LoginViewModel){
//        userVM.addUserToServerModelFunc(loginData: loginData)
        loginStatus = true
    }
}


    //Apple SignIn Helpers

//func sha256(_ input: String) -> String {
//  let inputData = Data(input.utf8)
//  let hashedData = SHA256.hash(data: inputData)
//  let hashString = hashedData.compactMap {
//    String(format: "%02x", $0)
//  }.joined()
//
//  return hashString
//}
//
//
//func randomNonceString(length: Int = 32) -> String {
//  precondition(length > 0)
//  let charset: [Character] =
//    Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
//  var result = ""
//  var remainingLength = length
//
//  while remainingLength > 0 {
//    let randoms: [UInt8] = (0 ..< 16).map { _ in
//      var random: UInt8 = 0
//      let errorCode = SecRandomCopyBytes(kSecRandomDefault, 1, &random)
//      if errorCode != errSecSuccess {
//        fatalError(
//          "Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)"
//        )
//      }
//      return random
//    }
//
//    randoms.forEach { random in
//      if remainingLength == 0 {
//        return
//      }
//
//      if random < charset.count {
//        result.append(charset[Int(random)])
//        remainingLength -= 1
//      }
//    }
//  }
//
//  return result
//}
