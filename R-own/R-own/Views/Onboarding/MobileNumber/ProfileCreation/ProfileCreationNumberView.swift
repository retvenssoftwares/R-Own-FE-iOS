//
//  ProfileCreationNumberView.swift
//  R-own
//
//  Created by Aman Sharma on 07/04/23.
//

import SwiftUI

struct ProfileCreationNumberView: View {
    
    
    //Login Var
    @StateObject var loginData: LoginViewModel
    @StateObject var globalVM: GlobalViewModel
    @StateObject var profileVM: ProfileViewModel
    @StateObject var mesiboData = MesiboViewModel()
    @StateObject var userVM = UserViewModel()
    @StateObject var feedService = MainFeedService()
    
    @StateObject var userData = UserCreationService()
    
    @State var isDataLoading: Bool = false
    @Binding var isLoading: Bool
    @StateObject var newFeedService = NewFeedServices()
    
    @State var encodedStatus: String = ""
    
    var body: some View {
        NavigationStack{
            if isDataLoading {
                ScrollView{
                    VStack{
                        ZStack{
                            VStack{
                                ProfileCreationNumFirstHalf()
                                ProfileCreationNumSecondHalf(loginData: loginData, globalVM: globalVM, profileVM: profileVM)
                                Spacer()
                            }
//                            EmailSentBottomSheetView(loginData: loginData, globalVM: globalVM, profileVM: profileVM)
                        }
                    }
                    .frame(width: UIScreen.screenWidth,height: UIScreen.screenHeight)
                    .edgesIgnoringSafeArea(.top)
                }
            }
        }
        .onAppear {
            Task{
                if loginData.userAlreadyExist {
                    loginData.showLoader = true
                    let res = await userData.getUserDetails(loginData: loginData)
                    if res == "Success" {
                        print(loginData.mainUserPhoneNumber)
                        print(loginData.mainUserFullName)
                        print(loginData.mainUserProfilePic)
                        loginData.showLoader = false
                        print(1)
//                        mesiboData.mesiboInitalize(loginData.mainUserMesiboToken, address: loginData.mainUserPhoneNumber, remoteUserName: loginData.mainUserFullName)
//                        print(2)
//                        mesiboData.mesiboSetSelfProfile(loginData.mainUserPhoneNumber)
//                        print(3)
//                        encodedStatus = encodeStatusData(userID: loginData.mainUserID, userRole: loginData.mainUserRole == "" ? "Normal User" : loginData.mainUserRole)
//                        print(4)
//                        mesiboData.mSelfProfile.setName(loginData.mainUserFullName)
//                        print(5)
//                        mesiboData.mSelfProfile.setStatus(encodedStatus)
//                        print(6)
//                        mesiboData.mSelfProfile.setImageUrl(loginData.mainUserProfilePic)
//                        print(7)
//                        mesiboData.mSelfProfile.save()
//                        print(8)
//                        print("printing mesibo data down there:")
//                        print(mesiboData.mSelfProfile.getAddress())
//                        print(mesiboData.mSelfProfile.getName())
//                        print(mesiboData.mSelfProfile.getStatus())
//                        print(mesiboData.mSelfProfile.getImage())
//                        print(mesiboData.mSelfProfile.getImageUrl())
//                        print(mesiboData.mSelfProfile.getAddress())
//                        mesiboData.addUserToMesiboModelFunc(loginData: loginData)
                        globalVM.newFeedList = [NewFeedModel(posts: [NewFeedPost](), blogs: [NewFeedBlog](), hotels: [NewFeedHotel](), communities: [NewFeedCommunity](), services: [NewFeedService]())]
                        Task{
                            loginData.isLoadingNewFeed = false
                            let res = await newFeedService.getNewFeed(globalVM: globalVM, userID: loginData.mainUserID)
                            if res == "Success"{
                                loginData.isLoadingNewFeed = true
                                loginData.isServerError = false
                            } else if res == "Server Error" {
                                loginData.isServerError = true
                            } else if res == "Try again" {
                                loginData.isLoadingNewFeed = false
                                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                    Task {
                                        let res = await newFeedService.getNewFeed(globalVM: globalVM, userID: loginData.mainUserID)
                                        if res == "Success"{
                                            loginData.isLoadingNewFeed = true
                                            loginData.isServerError = false
                                        } else if res == "Server Error" {
                                            loginData.isServerError = true
                                        } else {
                                            loginData.isLoadingNewFeed = true
                                            loginData.isServerError = false
                                        }
                                    }
                                }
                            } else {
                                print("Try again")
                            }
                        }
                        print(loginData.apnToken)
                        isDataLoading = true
                    } else {
                        loginData.isServerError = false
                    }
                } else{
                    isDataLoading = true
                }
            }
        }
    }
    func encodeStatusString(input: String, shift: Int) -> String {
        var encodedData = ""
        for char in input {
            let encodedChar: Character
            if char.isLetter {
                let base = char.isLowercase ? Character("a") : Character("A")
                let encodedAscii = (Int(char.asciiValue ?? 0) - Int(base.asciiValue ?? 0) + shift) % 26
                encodedChar = Character(UnicodeScalar(encodedAscii + Int(base.asciiValue ?? 0))!)
            } else {
                encodedChar = char
            }
            encodedData.append(encodedChar)
        }
        return encodedData
    }
    func encodeStatusData(userID: String, userRole: String) -> String {
        let encodedUserID = encodeStatusString(input: userID, shift: 5)
        let encodedUserRole = encodeStatusString(input: userRole, shift: 6)
        return "\(encodedUserID)|\(encodedUserRole)"
    }
}

//struct ProfileCreationNumberView_Previews: PreviewProvider {
//    static var previews: some View {
//        ProfileCreationNumberView()
//    }
//}
