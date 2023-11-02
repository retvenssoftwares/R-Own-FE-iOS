//
//  NormalProfileFPPPollsTabView.swift
//  R-own
//
//  Created by Aman Sharma on 13/05/23.
//

import SwiftUI

struct NormalProfileFPPPollsTabView: View {
    
    @StateObject var loginData: LoginViewModel
    @StateObject var globalVM: GlobalViewModel
    @State var role: String
    @State var mainUser: Bool
    @State var userID: String
    @StateObject var profileService = ProfileService()
    @StateObject var profileVM: ProfileViewModel
    @StateObject var mesiboVM: MesiboViewModel
    
    var body: some View {
        ScrollView{
            VStack{
                if globalVM.getPollPost.count > 0 && globalVM.getPollPost[0].posts.count > 0 {
                    VStack{
                        ForEach(0..<globalVM.getPollPost[0].posts.count, id: \.self) { item in
                            if globalVM.getPollPost[0].posts[item].displayStatus != "0"{
                                if globalVM.getPollPost[0].posts[item].pollQuestion.count > 0 {
                                        NormalProfileFPPPollsView(post: globalVM.getPollPost[0].posts[item], role: role, mainUser: mainUser, globalVM: globalVM, loginData: loginData, profileVM: profileVM, mesiboVM: mesiboVM)
                                } else {
                                    Text("Poll data not available")
                                }
                            }
                        }
                    }
                } else {
                    HStack{
                        Spacer()
                        if mainUser {
                            Image("NoPostScreen")
                                .resizable()
                                .scaledToFit()
                                .frame(width: UIScreen.screenWidth/1.5, height: UIScreen.screenHeight/2.5)
                                .overlay{
                                    Text("You have not posted any poll yet")
                                        .font(.body)
                                        .frame(width: UIScreen.screenWidth/4)
                                        .fontWeight(.bold)
                                        .foregroundColor(greenUi)
                                        .multilineTextAlignment(.leading)
                                        .offset(x: UIScreen.screenWidth/12, y: -UIScreen.screenHeight/20)
                                }
                        } else {
                            if role == "Hotelier" {
                                Image("NoPostScreen")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: UIScreen.screenWidth/1.5, height: UIScreen.screenHeight/2.5)
                                    .overlay{
                                        Text("\(globalVM.getNormalProfileHeader.data.profile.fullName) have not posted any poll yet")
                                            .font(.body)
                                            .frame(width: UIScreen.screenWidth/4)
                                            .fontWeight(.bold)
                                            .foregroundColor(greenUi)
                                            .multilineTextAlignment(.leading)
                                            .offset(x: UIScreen.screenWidth/12, y: -UIScreen.screenHeight/20)
                                    }
                            } else if role == "Business Vendor / Freelancer" {
                                Image("NoPostScreen")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: UIScreen.screenWidth/1.5, height: UIScreen.screenHeight/2.5)
                                    .overlay{
                                        Text("\(globalVM.getVendorProfileHeader.roleDetails.fullName) have not posted any poll yet")
                                            .font(.body)
                                            .frame(width: UIScreen.screenWidth/4)
                                            .fontWeight(.bold)
                                            .foregroundColor(greenUi)
                                            .multilineTextAlignment(.leading)
                                            .offset(x: UIScreen.screenWidth/12, y: -UIScreen.screenHeight/20)
                                    }
                            } else if role == "Hotel Owner" {
                                Image("NoPostScreen")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: UIScreen.screenWidth/1.5, height: UIScreen.screenHeight/2.5)
                                    .overlay{
                                        Text("\(globalVM.getHotelOwnerProfileHeader.profiledata.fullName) have not posted any poll yet")
                                            .font(.body)
                                            .frame(width: UIScreen.screenWidth/4)
                                            .fontWeight(.bold)
                                            .foregroundColor(greenUi)
                                            .multilineTextAlignment(.leading)
                                            .offset(x: UIScreen.screenWidth/12, y: -UIScreen.screenHeight/20)
                                    }
                            } else {
                                Image("NoPostScreen")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: UIScreen.screenWidth/1.5, height: UIScreen.screenHeight/2.5)
                                    .overlay{
                                        Text("\(globalVM.getNormalProfileHeader.data.profile.fullName) have not posted any poll yet")
                                            .font(.body)
                                            .frame(width: UIScreen.screenWidth/4)
                                            .fontWeight(.bold)
                                            .foregroundColor(greenUi)
                                            .multilineTextAlignment(.leading)
                                            .offset(x: UIScreen.screenWidth/12, y: -UIScreen.screenHeight/20)
                                    }
                            }
                        }
                        Spacer()
                    }
                }
            }
        }
        .onAppear{
            globalVM.getPollPost = [ProfilePollsPostModel(page: 0, pageSize: 0, posts: [Post434]())]
            profileService.getPollsPosts(globalVM: globalVM, userID: userID, pageNumber: 1, loginData: loginData)
        }
    }
}

//struct NormalProfileFPPPollsTabView_Previews: PreviewProvider {
//    static var previews: some View {
//        NormalProfileFPPPollsTabView()
//    }
//}
