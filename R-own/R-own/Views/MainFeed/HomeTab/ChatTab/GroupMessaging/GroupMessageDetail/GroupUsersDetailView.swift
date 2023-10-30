//
//  GroupUsersDetailView.swift
//  R-own
//
//  Created by Aman Sharma on 27/06/23.
//

import SwiftUI

struct GroupUsersDetailView: View {
    @StateObject var loginData: LoginViewModel
    @StateObject var globalVM: GlobalViewModel
    
    @StateObject var communityVM: CommunityViewModel
    @StateObject var profileVM: ProfileViewModel
    @StateObject var mesiboVM: MesiboViewModel
    
    @State var navigateToUserDetailList: Bool = false
    
    @State var selectedUserType: String = ""
    @State var selectedUserNav: String = ""
    
    @State var totalUsers: [MesiboGroupUser]
    
    @State var adminStatus: Bool 
    @State var memberStatus: Bool
    @State var hotelOwnersMember: [MesiboGroupUser]
    @State var vendorMember: [MesiboGroupUser]
    @State var hotelierMember: [MesiboGroupUser]
    @State var normalUserMember: [MesiboGroupUser]
    
    var body: some View {
        NavigationStack{
            VStack(alignment: .leading, spacing: UIScreen.screenHeight/60){
                if hotelOwnersMember.count > 0 {
                    VStack(alignment: .leading){
                        Text("Businesses in community")
                            .font(.body)
                            .fontWeight(.semibold)
                            .padding(.vertical, UIScreen.screenHeight/90)
                        ForEach(0..<(hotelOwnersMember.count > 5 ? 5 : hotelOwnersMember.count), id: \.self){ count in
                            GroupMembersCardView(communityVM: communityVM, user: hotelOwnersMember[count], loginData: loginData, profileVM: profileVM, globalVM: globalVM, mesiboVM: mesiboVM, adminStatus: adminStatus, memberStatus: memberStatus)
                        }
                        if totalUsers.count > 5 {
                            Button(action: {
                                selectedUserType = "Hotel Owner"
                                selectedUserNav = "View all Business"
                                navigateToUserDetailList.toggle()
                            }, label: {
                                HStack{
                                    Text("View all Business")
                                        .font(.body)
                                        .foregroundColor(.black)
                                        .fontWeight(.bold)
                                        .padding(.vertical, UIScreen.screenHeight/80)
                                        .frame(width: UIScreen.screenWidth/1.4)
                                        .cornerRadius(15)
                                        .shadow(color: .black.opacity(0.2), radius: 5, x: 2, y: 2)
                                        .padding(.vertical, UIScreen.screenHeight/70)
                                    Spacer()
                                }
                                .padding(.horizontal, UIScreen.screenWidth/30)
                            })
                            .navigationDestination(isPresented: $navigateToUserDetailList, destination: {
                                GroupUserDetailListView(loginData: loginData, globalVM: globalVM, communityVM: communityVM, profileVM: profileVM, mesiboVM: mesiboVM, totalUsers: hotelOwnersMember, adminStatus: adminStatus, memberStatus: memberStatus, selectedUserNav: selectedUserNav)
                            })
                        }
                    }
                }
                if vendorMember.count > 0 {
                    VStack(alignment: .leading){
                        Text("Vendors in community")
                            .font(.body)
                            .fontWeight(.semibold)
                            .padding(.vertical, UIScreen.screenHeight/90)
                        ForEach(0..<vendorMember.count, id: \.self){ count in
                            GroupMembersCardView(communityVM: communityVM, user: vendorMember[count], loginData: loginData, profileVM: profileVM, globalVM: globalVM, mesiboVM: mesiboVM, adminStatus: adminStatus, memberStatus: memberStatus)
                        }
                        if vendorMember.count > 5 {
                            Button(action: {
                                selectedUserType = "Business Vendor / Freelancer"
                                selectedUserNav = "View all Vendors"
                                navigateToUserDetailList.toggle()
                            }, label: {
                                HStack{
                                    Text("View all Vendors")
                                        .font(.body)
                                        .foregroundColor(.black)
                                        .fontWeight(.bold)
                                        .padding(.vertical, UIScreen.screenHeight/80)
                                        .frame(width: UIScreen.screenWidth/1.4)
                                        .cornerRadius(15)
                                        .shadow(color: .black.opacity(0.2), radius: 5, x: 2, y: 2)
                                        .padding(.vertical, UIScreen.screenHeight/70)
                                    Spacer()
                                }
                                .padding(.horizontal, UIScreen.screenWidth/30)
                            })
                            .navigationDestination(isPresented: $navigateToUserDetailList, destination: {
                                GroupUserDetailListView(loginData: loginData, globalVM: globalVM, communityVM: communityVM, profileVM: profileVM, mesiboVM: mesiboVM, totalUsers: vendorMember, adminStatus: adminStatus, memberStatus: memberStatus, selectedUserNav: selectedUserNav)
                            })
                        }
                    }
                }
                if hotelierMember.count > 0 {
                    VStack(alignment: .leading){
                        Text("Hoteliers in community")
                            .font(.body)
                            .fontWeight(.semibold)
                            .padding(.vertical, UIScreen.screenHeight/90)
                        ForEach(0..<hotelierMember.count, id: \.self){ count in
                            if hotelierMember[count].role == "Hotelier" {
                                GroupMembersCardView(communityVM: communityVM, user: hotelierMember[count], loginData: loginData, profileVM: profileVM, globalVM: globalVM, mesiboVM: mesiboVM, adminStatus: adminStatus, memberStatus: memberStatus)
                            }
                        }
                        if totalUsers.count > 5 {
                            Button(action: {
                                selectedUserType = "Hotelier"
                                selectedUserNav = "View all Hoteliers"
                                navigateToUserDetailList.toggle()
                            }, label: {
                                HStack{
                                    Text("View all Hoteliers")
                                        .font(.body)
                                        .foregroundColor(.black)
                                        .fontWeight(.bold)
                                        .padding(.vertical, UIScreen.screenHeight/80)
                                        .frame(width: UIScreen.screenWidth/1.4)
                                        .cornerRadius(15)
                                        .shadow(color: .black.opacity(0.2), radius: 5, x: 2, y: 2)
                                        .padding(.vertical, UIScreen.screenHeight/70)
                                    Spacer()
                                }
                                .padding(.horizontal, UIScreen.screenWidth/30)
                            })
                            .navigationDestination(isPresented: $navigateToUserDetailList, destination: {
                                GroupUserDetailListView(loginData: loginData, globalVM: globalVM, communityVM: communityVM, profileVM: profileVM, mesiboVM: mesiboVM, totalUsers: hotelierMember, adminStatus: adminStatus, memberStatus: memberStatus, selectedUserNav: selectedUserNav)
                            })
                        }
                    }
                }
                if normalUserMember.count > 0 {
                    VStack(alignment: .leading){
                        Text("Others in community")
                            .font(.body)
                            .fontWeight(.semibold)
                            .padding(.vertical, UIScreen.screenHeight/90)
                        ForEach(0..<normalUserMember.count, id: \.self){ count in
                            if normalUserMember[count].role == "Normal User" {
                                GroupMembersCardView(communityVM: communityVM, user: normalUserMember[count], loginData: loginData, profileVM: profileVM, globalVM: globalVM, mesiboVM: mesiboVM, adminStatus: adminStatus, memberStatus: memberStatus)
                            }
                        }
                        if totalUsers.count > 5 {
                            Button(action: {
                                selectedUserType = "Normal User"
                                selectedUserNav = "View all other members"
                                navigateToUserDetailList.toggle()
                            }, label: {
                                HStack{
                                    Text("View all the other members")
                                        .font(.body)
                                        .foregroundColor(.black)
                                        .fontWeight(.bold)
                                        .padding(.vertical, UIScreen.screenHeight/80)
                                        .frame(width: UIScreen.screenWidth/1.4)
                                        .cornerRadius(15)
                                        .shadow(color: .black.opacity(0.2), radius: 5, x: 2, y: 2)
                                        .padding(.vertical, UIScreen.screenHeight/70)
                                    Spacer()
                                }
                                .padding(.horizontal, UIScreen.screenWidth/30)
                            })
                            .navigationDestination(isPresented: $navigateToUserDetailList, destination: {
                                GroupUserDetailListView(loginData: loginData, globalVM: globalVM, communityVM: communityVM, profileVM: profileVM, mesiboVM: mesiboVM, totalUsers: normalUserMember, adminStatus: adminStatus, memberStatus: memberStatus, selectedUserNav: selectedUserNav)
                            })
                        }
                    }
                }
            }
        }
        .onAppear{
        }
    }
}

//struct GroupUsersDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        GroupUsersDetailView()
//    }
//}
