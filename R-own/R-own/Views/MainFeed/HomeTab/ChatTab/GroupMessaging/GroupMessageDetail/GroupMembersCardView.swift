//
//  GroupMembersCardView.swift
//  R-own
//
//  Created by Aman Sharma on 27/06/23.
//

import SwiftUI
import Shimmer

struct GroupMembersCardView: View {
    
    @State var communityVM: CommunityViewModel
    @State var user: MesiboGroupUser
    @State var loginData: LoginViewModel
    @State var profileVM: ProfileViewModel
    @State var globalVM: GlobalViewModel
    @State var mesiboVM: MesiboViewModel
    
    @State var navigateToProfileView: Bool = false
    
    @State var adminStatus: Bool
    @State var memberStatus: Bool
    
    @State private var currentUrl: URL?
    
    var body: some View {
        NavigationStack{
            HStack{
                AsyncImage(url: currentUrl) { image in
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: UIScreen.screenHeight/20, height: UIScreen.screenHeight/20)
                        .clipShape(Circle())
                } placeholder: {
                    Circle()
                        .fill(lightGreyUi)
                        .frame(width: UIScreen.screenHeight/20, height: UIScreen.screenHeight/20)
                        .shimmering(active: true)
                }
                .onAppear {
                    if currentUrl == nil {
                        DispatchQueue.main.async {
                            currentUrl = URL(string: user.profilePic)
                        }
                    }
                }
                VStack(alignment: .leading){
                    Text(user.fullName)
                        .font(.body)
                        .fontWeight(.semibold)
                    
                    if user.location != "" {
                        HStack(spacing:4){
                            Image("LocationIcon")
                                .resizable()
                                .scaledToFit()
                                .frame(width: UIScreen.screenHeight/80, height: UIScreen.screenHeight/80)
                            Text(user.location)
                                .font(.body)
                                .fontWeight(.light)
                        }
                    }
                }
                .padding(.leading, UIScreen.screenWidth/40)
                Spacer()
                if user.admin == "true" {
                    Text("Admin")
                        .font(.body)
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                }
            }
            .padding(.horizontal, UIScreen.screenWidth/30)
            .padding(.vertical, UIScreen.screenHeight/60)
            .frame(width: UIScreen.screenWidth/1.1)
            .background(lightGreyUi)
            .clipped()
            .shadow(color: .black.opacity(0.2), radius: 5, x: 2, y: 2)
            .cornerRadius(15)
            .padding(.vertical, UIScreen.screenHeight/90)
            .onTapGesture {
                if user.userID != loginData.mainUserID{
                    if adminStatus {
                        communityVM.selectedGroupUserRole = user.role
                        communityVM.selectedGroupUserID = user.userID
                        communityVM.selectedGRoupUserAddress = user.address
                        communityVM.showAdminMemberSettingBottomSheet = true
                    } else {
                        navigateToProfileView.toggle()
                    }
                }
            }
            .navigationDestination(isPresented: $navigateToProfileView, destination: {
                ProfileView(loginData: loginData, profileVM: profileVM, globalVM: globalVM, mesiboVM: mesiboVM, role: user.role, mainUser: false, userID: user.userID)
            })
        }
    }
    
}

//struct GroupMembersCardView_Previews: PreviewProvider {
//    static var previews: some View {
//        GroupMembersCardView()
//    }
//}
