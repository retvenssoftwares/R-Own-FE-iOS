//
//  OpenCommunityCardTab.swift
//  R-own
//
//  Created by Aman Sharma on 12/07/23.
//

import SwiftUI
import Shimmer

struct OpenCommunityCardTab: View {
    
    @State var community: NewFeedCommunity
    
    @StateObject var loginData: LoginViewModel
    @StateObject var communityVM: CommunityViewModel
    @StateObject var mesiboVM: MesiboViewModel
    @StateObject var globalVM: GlobalViewModel
    
    @StateObject var profileVM: ProfileViewModel
    
    @State var joinStatus: Bool = false
    
    @State var communityService = CommunityService()
    
    @State var navigateToGroupDetailView: Bool = false
    @State var navigateToGroupChatView: Bool = false
    
    
    @State private var currentUrl: URL?
    
    var body: some View {
        NavigationStack{
                VStack(spacing: 0){
                    VStack{
                        AsyncImage(url: currentUrl) { image in
                            image
                                .resizable()
                                .scaledToFill()
                                .frame(width: UIScreen.screenHeight/10, height: UIScreen.screenHeight/10)
                                .clipShape(Circle())
                                .padding(.vertical, 10)
                        } placeholder: {
                            Circle()
                                .fill(lightGreyUi)
                                .frame(width: UIScreen.screenHeight/10, height: UIScreen.screenHeight/10)
                                .padding(.vertical, 10)
                                .shimmering(active: true)
                        }
                        .onAppear {
                            if currentUrl == nil {
                                DispatchQueue.main.async {
                                    currentUrl = URL(string: community.profilePic.replacingOccurrences(of: " ", with: "%20"))
                                }
                            }
                        }
                        VStack(spacing: 0){
                            Text(community.groupName)
                                .foregroundColor(.black)
                                .font(.body)
                                .fontWeight(.bold)
                                .multilineTextAlignment(.center)
                                .frame(alignment: .center)
                            
                            //                HStack(spacing: 0){
                            //                    Image("BottomNavUser")
                            //                        .resizable()
                            //                        .aspectRatio(contentMode: .fit)
                            //                        .frame(width: UIScreen.screenWidth/30, height: UIScreen.screenHeight/30)
                            //                        .overlay{
                            //                            Image("BottomNavUser")
                            //                                .resizable()
                            //                                .aspectRatio(contentMode: .fit)
                            //                                .frame(width: UIScreen.screenWidth/30, height: UIScreen.screenHeight/30)
                            //                                .offset(x: 10)
                            //                                .overlay{
                            //                                    Image("BottomNavUser")
                            //                                        .resizable()
                            //                                        .aspectRatio(contentMode: .fit)
                            //                                        .frame(width: UIScreen.screenWidth/30, height: UIScreen.screenHeight/30)
                            //                                        .offset(x: 20)
                            //                                }
                            //                        }
                            //                }
                            Text("\(community.admin.count + community.members.count) Members")
                                .foregroundColor(.black)
                                .font(.footnote)
                                .fontWeight(.semibold)
                                .frame(alignment: .leading)
                        }
                        .padding(.vertical, 2)
                        Spacer()
                    }
                    Button(action: {
                        if !joinStatus {
                            joinStatus = true
                            communityService.addMemberInMesiboGroup(loginData: loginData, groupID: community.groupID, userAttribute: loginData.mainUserPhoneNumber)
                            communityService.addMemberInCommunity(communityID: community.groupID, userID: loginData.mainUserID)
                            community.members.append(Admin(userID: loginData.mainUserID, admin: "false", address: loginData.mainUserPhoneNumber, uid: 0, profilePic: loginData.mainUserProfilePic, fullName: loginData.mainUserFullName, role: loginData.mainUserRole, verificationStatus: loginData.mainUserVerificationStatus, location: ""))
                        } else {
                            navigateToGroupChatView = true
                        }
                    }, label: {
                        Text(joinStatus ? "CHAT" : "JOIN")
                            .frame(width: UIScreen.screenWidth/3)
                            .padding(.vertical, 5)
                            .foregroundColor(.white)
                            .background(Color.black)
                            .font(.body)
                            .fontWeight(.bold)
                            .frame(alignment: .center)
                    })
                    .navigationDestination(isPresented: $navigateToGroupChatView, destination: {
                        GroupMessageView(loginData: loginData, communityVM: communityVM, mesiboVM: mesiboVM, groupID: community.groupID, communityName: community.groupName, communityPic: community.profilePic, globalVM: globalVM, profileVM: profileVM)
                    })
                    NavigationLink(isActive: $navigateToGroupChatView, destination: {
                        GroupMessageView(loginData: loginData, communityVM: communityVM, mesiboVM: mesiboVM, groupID: community.groupID, communityName: community.groupName, communityPic: community.profilePic, globalVM: globalVM, profileVM: profileVM)
                    }, label: {
                        Text("")
                    })
                }
                .frame(width: UIScreen.screenWidth/3, height: UIScreen.screenHeight/4)
                .background(Color.white)
                .cornerRadius(10)
                .shadow(color: .black.opacity(0.2), radius: 1)
                .padding(.horizontal, 5)
                .onTapGesture {
                    navigateToGroupDetailView = true
                }
            NavigationLink(isActive: $navigateToGroupDetailView, destination: {
                GroupMessageDetailsView(loginData: loginData, communityVM: communityVM, mesiboVM: mesiboVM, groupID: community.groupID, globalVM: globalVM, profileVM: profileVM)
            }, label: {
                Text("")
            })
        }
        .onAppear{
            navigateToGroupChatView = false
            navigateToGroupDetailView = false
        }
    }
}
//struct OpenCommunityCardTab_Previews: PreviewProvider {
//    static var previews: some View {
//        OpenCommunityCardTab()
//    }
//}
