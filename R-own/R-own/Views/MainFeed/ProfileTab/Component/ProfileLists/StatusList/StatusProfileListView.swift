//
//  StatusListView.swift
//  R-own
//
//  Created by Aman Sharma on 16/05/23.
//

import SwiftUI

struct StatusProfileListView: View {
    @StateObject var loginData: LoginViewModel
    @StateObject var globalVM: GlobalViewModel
    
    @State var role: String
    @State var mainUser: Bool
    @State var userID: String
    @State var postType: String = "text"
    
    @StateObject var profileService = ProfileService()
    
    var body: some View {
        VStack{
            if globalVM.getStatusPostList.count > 0 {
                VStack{
                    ForEach(0..<globalVM.getStatusPostList[0].posts.count, id: \.self){ count in
                        if globalVM.getStatusPostList[0].posts[count].displayStatus != "0" {
                            VStack{
                                if globalVM.getStatusPostList[0].posts[count].postType == "normal status"{
                                    HStack{
                                        Spacer()
                                        NormalStatusPostView(globalVM: globalVM, loginData: loginData, post: globalVM.getStatusPostList[0].posts[count], mainUser: mainUser)
                                        Spacer()
                                    }
                                } else if globalVM.getStatusPostList[0].posts[count].postType == "Check-in"{
                                    HStack{
                                        Spacer()
                                        CheckInPostDisplayView(globalVM: globalVM, loginData: loginData, post: globalVM.getStatusPostList[0].posts[count], mainUser: mainUser)
                                        Spacer()
                                    }
                                } else if globalVM.getStatusPostList[0].posts[count].postType == "Update about an event"{
                                    if loginData.isHiddenKPI{
                                        EventPostView(globalVM: globalVM, loginData: loginData, post: globalVM.getStatusPostList[0].posts[count])
                                    }
                                }
                            }
                            .onAppear{
                                if count == globalVM.getStatusPostList[0].posts.count - 2 {
                                    profileService.getStatusPosts(globalVM: globalVM, userID: userID, loginData: loginData, page: String(count))
                                }
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
                                Text("You have not posted anything yet")
                                    .font(.title3)
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
                                    Text("\(globalVM.getNormalProfileHeader.data.profile.fullName) have not posted anything yet")
                                        .font(.title3)
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
                                    Text("\(globalVM.getVendorProfileHeader.roleDetails.fullName) have not posted anything yet")
                                        .font(.title3)
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
                                    Text("\(globalVM.getHotelOwnerProfileHeader.profiledata.fullName) have not posted anything yet")
                                        .font(.title3)
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
                                    Text("\(globalVM.getNormalProfileHeader.data.profile.fullName) have not posted anything yet")
                                        .font(.title3)
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
}

//struct StatusListView_Previews: PreviewProvider {
//    static var previews: some View {
//        StatusListView()
//    }
//}
