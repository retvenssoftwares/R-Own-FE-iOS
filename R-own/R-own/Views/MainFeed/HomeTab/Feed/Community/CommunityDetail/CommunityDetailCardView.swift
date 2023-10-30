//
//  CommunityDetailCardView.swift
//  R-own
//
//  Created by Aman Sharma on 28/06/23.
//

import SwiftUI

struct CommunityDetailCardView: View {
    
    @State var community: OwnCommunityGroupDetailsModel
    
    @StateObject var loginData: LoginViewModel
    @StateObject var communityVM: CommunityViewModel
    @StateObject var mesiboVM: MesiboViewModel
    @StateObject var globalVM: GlobalViewModel
    @StateObject var profileVM: ProfileViewModel
    
    @State var navigateToGroupDetailView: Bool = false
    @State var navigateToGroupChatView: Bool = false
    
    var body: some View {
        VStack{
            HStack{
                ProfilePictureView(profilePic: community.profilePic, verified: false, height: UIScreen.screenHeight/20, width: UIScreen.screenHeight/20)
                    .padding(.horizontal, UIScreen.screenWidth/30)
                VStack(alignment: .leading){
                    Text(community.groupName)
                        .font(.headline)
                        .fontWeight(.bold)
                    HStack{
                        Image("LocationIcon")
                            .resizable()
                            .scaledToFit()
                            .frame(width: UIScreen.screenHeight/50, height: UIScreen.screenHeight/50)
                        Text(extractFirstWord(from: community.location) ?? community.location)
                            .font(.body)
                            .fontWeight(.light)
                    }
                    HStack{
                        Button(action: {
                            navigateToGroupDetailView.toggle()
                        }, label: {
                            Text("VIEW")
                                .font(.body)
                                .fontWeight(.light)
                                .foregroundColor(.black)
                                .padding(.horizontal, UIScreen.screenWidth/40)
                                .padding(.vertical, UIScreen.screenHeight/70)
                                .background(greenUi)
                                .cornerRadius(10)
                        })
                        .navigationDestination(isPresented: $navigateToGroupDetailView, destination: {
                            GroupMessageDetailsView(loginData: loginData, communityVM: communityVM, mesiboVM: mesiboVM, groupID: community.groupID, globalVM: globalVM, profileVM: profileVM, memberStatus: true)
                        })
                        
                        Button(action: {
                            navigateToGroupChatView.toggle()
                        }, label: {
                            Text("CHAT")
                                .font(.body)
                                .fontWeight(.light)
                                .foregroundColor(.black)
                                .padding(.horizontal, UIScreen.screenWidth/40)
                                .padding(.vertical, UIScreen.screenHeight/70)
                                .background(greenUi)
                                .cornerRadius(10)
                        })
                        .navigationDestination(isPresented: $navigateToGroupChatView, destination: {
                            GroupMessageView(loginData: loginData, communityVM: communityVM, mesiboVM: mesiboVM, groupID: community.groupID, communityName: community.groupName, communityPic: community.profilePic, globalVM: globalVM, profileVM: profileVM)
                        })
                    }
                }
                Spacer()
                VStack{
                    Text("\(community.admin.count + community.members.count)")
                        .font(.body)
                        .fontWeight(.light)
                    Text("Members")
                        .font(.body)
                        .fontWeight(.light)
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

//struct CommunityDetailCardView_Previews: PreviewProvider {
//    static var previews: some View {
//        CommunityDetailCardView()
//    }
//}
