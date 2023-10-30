//
//  OpenCommunityDetailCard.swift
//  R-own
//
//  Created by Aman Sharma on 11/08/23.
//

import SwiftUI

struct OpenCommunityDetailCard: View {
    
    @State var community: OwnCommunityGroupDetailsModel
    
    @StateObject var loginData: LoginViewModel
    @StateObject var communityVM: CommunityViewModel
    @StateObject var mesiboVM: MesiboViewModel
    @StateObject var globalVM: GlobalViewModel
    @StateObject var profileVM: ProfileViewModel
    
    @State var navigateToGroupDetailView: Bool = false
    @State var navigateToGroupChatView: Bool = false
    
    @StateObject var communityService = CommunityService()
    
    
    @State var joinToggle: Bool = true
    
    var body: some View {
        VStack{
            HStack{
                ProfilePictureView(profilePic: community.profilePic, verified: false, height: UIScreen.screenHeight/15, width: UIScreen.screenHeight/15)
                    .padding(.horizontal, UIScreen.screenWidth/30)
                VStack(alignment: .leading, spacing: UIScreen.screenHeight/90){
                    Text(community.groupName)
                        .font(.headline)
                        .fontWeight(.bold)
                    HStack{
                        Image("LocationIcon")
                            .resizable()
                            .scaledToFit()
                            .frame(width: UIScreen.screenHeight/50, height: UIScreen.screenHeight/50)
                        Text(extractFirstWord(from: community.location) ?? community.location)
                            .font(.footnote)
                            .fontWeight(.light)
                    }
                    HStack{
                        
                        Button(action: {
                            communityService.addMemberInMesiboGroup(loginData: loginData, groupID: community.groupID, userAttribute: loginData.mainUserPhoneNumber)
                            communityService.addMemberInCommunity(communityID: community.groupID, userID: loginData.mainUserID)
                            community.members.append(Admin(userID: loginData.mainUserID, admin: "false", address: loginData.mainUserPhoneNumber, uid: 0, profilePic: loginData.mainUserProfilePic, fullName:loginData.mainUserFullName , role: loginData.mainUserRole, verificationStatus: loginData.mainUserVerificationStatus, location: ""))
                            joinToggle = false
                        }, label: {
                            Text("JOIN")
                                .font(.footnote)
                                .fontWeight(.semibold)
                                .foregroundColor(greenUi)
                                .padding(.horizontal, UIScreen.screenWidth/40)
                                .padding(.vertical, UIScreen.screenHeight/90)
                                .background(jobsDarkBlue)
                                .cornerRadius(5)
                        })
                        
                        if joinToggle {
                            Button(action: {
                                navigateToGroupDetailView.toggle()
                            }, label: {
                                Text("VIEW")
                                    .font(.footnote)
                                    .fontWeight(.semibold)
                                    .foregroundColor(.black)
                                    .padding(.horizontal, UIScreen.screenWidth/40)
                                    .padding(.vertical, UIScreen.screenHeight/90)
                                    .background(greenUi)
                                    .cornerRadius(5)
                            })
                            .navigationDestination(isPresented: $navigateToGroupDetailView, destination: {
                                GroupMessageDetailsView(loginData: loginData, communityVM: communityVM, mesiboVM: mesiboVM, groupID: community.groupID, globalVM: globalVM, profileVM: profileVM, memberStatus: true)
                            })
                        } else {
                            Button(action: {
                                navigateToGroupChatView.toggle()
                            }, label: {
                                Text("CHAT")
                                    .font(.footnote)
                                    .fontWeight(.semibold)
                                    .foregroundColor(.black)
                                    .padding(.horizontal, UIScreen.screenWidth/40)
                                    .padding(.vertical, UIScreen.screenHeight/90)
                                    .background(greenUi)
                                    .cornerRadius(5)
                            })
                            .navigationDestination(isPresented: $navigateToGroupChatView, destination: {
                                GroupMessageView(loginData: loginData, communityVM: communityVM, mesiboVM: mesiboVM, groupID: community.groupID, communityName: community.groupName, communityPic: community.profilePic, globalVM: globalVM, profileVM: profileVM)
                            })
                        }
                    }
                }
                Spacer()
                VStack{
                    HStack{
                        Image(systemName: "person.2")
                            .resizable()
                            .scaledToFit()
                            .frame(width: UIScreen.screenHeight/40, height: UIScreen.screenHeight/40)
                            .foregroundColor(greenUi)
                        Text("\(community.admin.count + community.members.count)")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                    }
                    Spacer()
                }
            }
            .padding(.horizontal, UIScreen.screenWidth/40)
            .padding(.vertical, UIScreen.screenHeight/60)
            .frame(width: UIScreen.screenWidth/1.1, height: UIScreen.screenHeight/7)
            .background(.white)
            .cornerRadius(10)
            .shadow(color: .black.opacity(0.2), radius: 5, x: 2, y: 2)
            .padding(.vertical, UIScreen.screenHeight/70)
            
            Divider()
        }
    }
}

//struct OpenCommunityDetailCard_Previews: PreviewProvider {
//    static var previews: some View {
//        OpenCommunityDetailCard()
//    }
//}
