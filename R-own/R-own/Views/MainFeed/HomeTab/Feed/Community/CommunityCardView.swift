//
//  CommunityCardView.swift
//  R-own
//
//  Created by Aman Sharma on 12/04/23.
//

import SwiftUI
import Shimmer

struct CommunityCardView: View {
    
    @State var community: OwnCommunityGroupDetailsModel
    
    @StateObject var loginData: LoginViewModel
    @StateObject var communityVM: CommunityViewModel
    @StateObject var mesiboVM: MesiboViewModel
    @StateObject var globalVM: GlobalViewModel
    
    @StateObject var profileVM: ProfileViewModel
    
    @State var navigateToGroupChatView: Bool = false
    
    @State private var currentUrl: URL?
    
    var body: some View {
        NavigationStack{
            VStack(spacing: 0){
                AsyncImage(url: currentUrl) { image in
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: UIScreen.screenHeight/14, height: UIScreen.screenHeight/14)
                        .clipShape(Circle())
                        .padding(.vertical, 10)
                } placeholder: {
                    Circle()
                        .fill(lightGreyUi)
                        .frame(width: UIScreen.screenHeight/14, height: UIScreen.screenHeight/14)
                        .padding(.vertical, 10)
                        .shimmering(active: true)
                }
                .onAppear {
                    if currentUrl == nil {
                        DispatchQueue.main.async {
                            currentUrl = URL(string: community.profilePic)
                        }
                    }
                }
                VStack(spacing: 0){
                    Text(community.groupName)
                        .foregroundColor(.black)
                        .font(.subheadline)
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
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .frame(alignment: .leading)
                }
                .padding(.vertical, 2)
                Spacer()
                Text("CHAT")
                    .frame(width: UIScreen.screenWidth/3)
                    .padding(.vertical, 5)
                    .foregroundColor(.white)
                    .background(Color.black)
                    .font(.body)
                    .fontWeight(.bold)
                    .frame(alignment: .center)
            }
            .frame(width: UIScreen.screenWidth/3, height: UIScreen.screenHeight/4.5)
            .background(Color.white)
            .cornerRadius(10)
            .shadow(color: .black.opacity(0.2), radius: 2, x: 2, y: 2)
            .padding(.horizontal, 5)
            .padding(.top, UIScreen.screenHeight/80)
            .onTapGesture {
                navigateToGroupChatView.toggle()
            }
            .navigationDestination(isPresented: $navigateToGroupChatView, destination: {
                GroupMessageView(loginData: loginData, communityVM: communityVM, mesiboVM: mesiboVM, groupID: community.groupID, communityName: community.groupName, communityPic: community.profilePic, globalVM: globalVM, profileVM: profileVM)
            })
            NavigationLink(isActive: $navigateToGroupChatView, destination: {
                GroupMessageView(loginData: loginData, communityVM: communityVM, mesiboVM: mesiboVM, groupID: community.groupID, communityName: community.groupName, communityPic: community.profilePic, globalVM: globalVM, profileVM: profileVM)
            }, label: {Text("")})
        }
    }
}

//struct CommunityCardView_Previews: PreviewProvider {
//    static var previews: some View {
//        CommunityCardView()
//    }
//}
