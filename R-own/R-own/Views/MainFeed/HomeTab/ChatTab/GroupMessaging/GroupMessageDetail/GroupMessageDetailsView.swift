//
//  GroupMessageDetailsView.swift
//  R-own
//
//  Created by Aman Sharma on 10/05/23.
//

import SwiftUI
import AlertToast

struct GroupMessageDetailsView: View {
    
    //Login Var
    @StateObject var loginData: LoginViewModel
    
    //Community Var
    @StateObject var communityVM: CommunityViewModel
    
    //Mesibo Var
    @StateObject var mesiboVM: MesiboViewModel
    @State var groupID: String
    
    @StateObject var globalVM: GlobalViewModel
    
    @StateObject var profileVM: ProfileViewModel
    
    @StateObject var communityService = CommunityService()
    
    @State var groupDetailSelectedTab: String = "Members"
    
    
    @State var totalUsers: [MesiboGroupUser] = []
    @State var hotelOwnersMember: [MesiboGroupUser] = []
    @State var vendorMember: [MesiboGroupUser] = []
    @State var hotelierMember: [MesiboGroupUser] = []
    @State var normalUserMember: [MesiboGroupUser] = []
    
    @Environment(\.dismiss) private var dismiss
    
    @State var adminStatus: Bool = false
    @State var memberStatus: Bool = false
    
    @State var isLoading: Bool = false
    
    @State var navigateToEditCommunityView: Bool = false
    @State var navigateToAddNewCommunityView: Bool = false
    
    @State var switchedClosedComm: Bool = false
    @State var switchedOpenComm: Bool = false
    
    @State private var currentUrl: URL?
    
    var body: some View {
        NavigationStack{
            if isLoading {
                ZStack{
                    VStack{
                        //nav
                        VStack{
                            HStack{
                                Button(action: {
                                    dismiss()
                                }, label: {
                                    Image(systemName: "chevron.backward")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: UIScreen.screenHeight/50, height: UIScreen.screenHeight/50)
                                        .foregroundColor(greenUi)
                                })
                                
                                Spacer()
                                
                                HStack(spacing: UIScreen.screenWidth/50){
                                    if adminStatus {
                                        Image("CommunityEditIcon")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: UIScreen.screenHeight/30, height: UIScreen.screenHeight/30)
                                            .foregroundColor(.black)
                                            .padding(.leading, UIScreen.screenWidth/30)
                                            .onTapGesture {
                                                navigateToEditCommunityView = true
                                            }
                                            .navigationDestination(isPresented: $navigateToEditCommunityView, destination: {
                                                EditCommunityDetailView(globalVM: globalVM, loginData: loginData, communityVM: communityVM, mesiboVM: mesiboVM, communityPic: globalVM.communityDetail.profilePic, communityName: globalVM.communityDetail.groupName, communityDescription: globalVM.communityDetail.description, groupID: groupID)
                                            })
                                        NavigationLink(isActive: $navigateToEditCommunityView, destination: {
                                            EditCommunityDetailView(globalVM: globalVM, loginData: loginData, communityVM: communityVM, mesiboVM: mesiboVM, communityPic: globalVM.communityDetail.profilePic, communityName: globalVM.communityDetail.groupName, communityDescription: globalVM.communityDetail.description, groupID: groupID)
                                        }, label: {
                                            Text("")
                                        })
                                        
                                        Image("CommunityUserAdd")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: UIScreen.screenHeight/30, height: UIScreen.screenHeight/30)
                                            .foregroundColor(.black)
                                            .padding(.leading, UIScreen.screenWidth/30)
                                            .onTapGesture {
                                                navigateToAddNewCommunityView = true
                                            }
                                            .navigationDestination(isPresented: $navigateToAddNewCommunityView, destination: {
                                                EditAddNewMemberGroup(loginData: loginData, communityVM: communityVM, mesiboVM: mesiboVM, globalVM: globalVM, profileVM: profileVM, totalUsers: totalUsers)
                                            })
                                        NavigationLink(isActive: $navigateToAddNewCommunityView, destination: {
                                            EditAddNewMemberGroup(loginData: loginData, communityVM: communityVM, mesiboVM: mesiboVM, globalVM: globalVM, profileVM: profileVM, totalUsers: totalUsers)
                                        }, label: {
                                            Text("")
                                        })
                                        
                                        
                                        Button(action: {
                                            communityVM.showRemoveCommunityBottomSheet.toggle()
                                        }, label: {
                                            Image("CommunityDeleteIcon")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: UIScreen.screenHeight/30, height: UIScreen.screenHeight/30)
                                                .foregroundColor(.black)
                                                .padding(.leading, UIScreen.screenWidth/30)
                                        })
                                        
                                    }
                                }
                                
                                
                            }
                            .padding(.horizontal, UIScreen.screenWidth/30)
                            .padding(.top, UIScreen.screenHeight/20)
                            .padding(.bottom, UIScreen.screenHeight/50)
                            .frame(width: UIScreen.screenWidth)
                            .background(jobsDarkBlue)
                        }
                        ScrollView{
                            VStack{
                                VStack{
                                    //groupIcon
                                    AsyncImage(url: currentUrl) { image in
                                        image
                                            .resizable()
                                            .scaledToFit()
                                    } placeholder: {
                                        Color.purple.opacity(0.1)
                                    }
                                    .frame(width: UIScreen.screenHeight/5, height: UIScreen.screenHeight/5)
                                    .clipShape(Circle())
                                    .padding(.vertical, UIScreen.screenHeight/50)
                                    .shadow(color: .black.opacity(0.2), radius: 2, y: 2)
                                    .onAppear {
                                        if currentUrl == nil {
                                            DispatchQueue.main.async {
                                                currentUrl = URL(string: globalVM.communityDetail.profilePic)
                                            }
                                        }
                                    }
                                    
                                    //groupname
                                    VStack(alignment: .center){
                                        Text(globalVM.communityDetail.groupName)
                                            .font(.body)
                                            .fontWeight(.bold)
                                        Text("\(globalVM.communityDetail.totalmember) members")
                                            .font(.body)
                                            .fontWeight(.regular)
                                    }
                                    .padding(.bottom, UIScreen.screenHeight/60)
                                }
                                .frame(width: UIScreen.screenWidth)
                                .background(.white)
                                
                                if adminStatus {
                                    Button(action: {
                                        if globalVM.communityDetail.communityType == "Close Community" {
                                            communityVM.showOpenCommunityBottomSheet = true
                                        } else if globalVM.communityDetail.communityType == "Open Community" {
                                            communityVM.showCloseCommunityBottomSheet = true
                                        }
                                    }, label: {
                                        Text( globalVM.communityDetail.communityType == "Close Community" ? "Switch To Open Community" : "Switch To Closed Community")
                                            .font(.body)
                                            .fontWeight(.semibold)
                                            .foregroundColor(greenUi)
                                            .frame(width: UIScreen.screenWidth/1.2, height: UIScreen.screenHeight/20)
                                            .background(jobsDarkBlue)
                                            .cornerRadius(10)
                                            .padding(.vertical, UIScreen.screenHeight/60)
                                    })
                                } else if memberStatus {
                                    
                                    Button(action: {
                                        communityVM.showLeaveCommunityBottomSheet = true
                                    }, label: {
                                        Text("Leave Community")
                                            .font(.body)
                                            .fontWeight(.semibold)
                                            .foregroundColor(greenUi)
                                            .frame(width: UIScreen.screenWidth/1.2, height: UIScreen.screenHeight/20)
                                            .background(jobsDarkBlue)
                                            .cornerRadius(10)
                                            .padding(.vertical, UIScreen.screenHeight/60)
                                    })
                                } else {
                                    Button(action: {
                                        if globalVM.communityDetail.communityType == "" {
                                            communityVM.showOpenCommunityBottomSheet = true
                                        } else if globalVM.communityDetail.communityType == "" {
                                            communityVM.showCloseCommunityBottomSheet = true
                                        }
                                        
                                        communityService.addMemberInMesiboGroup(loginData: loginData, groupID: groupID, userAttribute: loginData.mainUserPhoneNumber)
                                        communityService.addMemberInCommunity(communityID: groupID, userID: loginData.mainUserID)
                                        globalVM.communityDetail.members.append(MesiboGroupUser(userID: loginData.mainUserID, fullName: loginData.mainUserFullName, address: loginData.mainUserPhoneNumber, uid: 0, profilePic: loginData.mainUserProfilePic, verificationStatus: loginData.mainUserVerificationStatus, location: loginData.mainUserLocation, role: loginData.mainUserRole, admin: "false"))
                                        memberStatus = true
                                    }, label: {
                                        Text( "Join")
                                            .font(.body)
                                            .fontWeight(.semibold)
                                            .foregroundColor(greenUi)
                                            .frame(width: UIScreen.screenWidth/2, height: UIScreen.screenHeight/20)
                                            .background(jobsDarkBlue)
                                            .cornerRadius(10)
                                            .padding(.vertical, UIScreen.screenHeight/60)
                                    })
                                }
                                VStack(alignment: .leading, spacing: 3){
                                    
                                    //groupDescription
                                    HStack{
                                        Text("Group Description")
                                            .font(.body)
                                            .fontWeight(.bold)
                                            .padding(.horizontal, UIScreen.screenWidth/40)
                                            .padding(.top, UIScreen.screenHeight/70)
                                        Spacer()
                                    }
                                    
                                    HStack{
                                        Text(globalVM.communityDetail.description)
                                            .font(.body)
                                            .fontWeight(.regular)
                                            .multilineTextAlignment(.leading)
                                            .padding(.horizontal, UIScreen.screenWidth/40)
                                        Spacer()
                                    }
                                    
                                    HStack{
                                        //Created by
                                        Text("Created By \(globalVM.communityDetail.creatorName) on \(formattedDate(from: globalVM.communityDetail.dateAdded))")
                                            .font(.body)
                                            .fontWeight(.light)
                                            .padding(.horizontal, UIScreen.screenWidth/40)
                                            .padding(.vertical, UIScreen.screenHeight/70)
                                        Spacer()
                                    }
                                    
                                }
                                .frame(width: UIScreen.screenWidth)
                                .background(.white)
                                .shadow(color: .black.opacity(0.2), radius: 2, y: 2)
                                
                                //map
                                VStack{
                                    HStack{
                                        Text("We are here")
                                            .font(.body)
                                            .fontWeight(.bold)
                                            .padding(.horizontal, UIScreen.screenWidth/40)
                                            .padding(.top, UIScreen.screenHeight/70)
                                        Spacer()
                                    }
                                    MapDisplay(locations: [MapLocation( latitude: Double(globalVM.communityDetail.latitude) ?? 0.0, longitude: Double(globalVM.communityDetail.longitude) ?? 0.0)])
                                        .frame(height: UIScreen.screenHeight/4)
                                        .padding(.horizontal, UIScreen.screenWidth/30)
                                        .padding(.vertical, UIScreen.screenHeight/60)
                                        .cornerRadius(15)
                                }
                                .frame(width: UIScreen.screenWidth)
                                .background(.white)
                                .shadow(color: .black.opacity(0.2), radius: 5, y: 5)
                                
                                //tabs
                                GroupChatTabView(communityTabSelected: $groupDetailSelectedTab, adminStatus: adminStatus, memberStatus: memberStatus)
                                
                                if groupDetailSelectedTab == "Members"{
                                    GroupUsersDetailView(loginData: loginData, globalVM: globalVM, communityVM: communityVM, profileVM: profileVM, mesiboVM: mesiboVM, totalUsers: totalUsers, adminStatus: adminStatus, memberStatus: memberStatus, hotelOwnersMember: hotelOwnersMember, vendorMember: vendorMember, hotelierMember: hotelierMember, normalUserMember: normalUserMember)
                                } else if groupDetailSelectedTab == "Media"{
                                    GroupMediaDetailView(loginData: loginData, mesiboVM: mesiboVM)
                                }
                            }
                        }
                    }
                    .toast(isPresenting: $switchedOpenComm, duration: 2, tapToDismiss: true){
                        AlertToast( type: .systemImage("checkmark.square.fill", greenUi), title: "Switched to open community")
                    }
                    .toast(isPresenting: $switchedClosedComm, duration: 2, tapToDismiss: true){
                        AlertToast( type: .systemImage("checkmark.square.fill", greenUi), title: "Switched to closed community")
                    }
                    ToOpenCommunityBottomSheet(communityVM: communityVM, globalVM: globalVM, loginData: loginData, switchToggle: $switchedOpenComm)
                    ToCloseCommunityBottomSheet(communityVM: communityVM, globalVM: globalVM, loginData: loginData, switchToggle: $switchedClosedComm)
                    RemoveCommunityBottomSheet(loginData: loginData, communityVM: communityVM, groupID: groupID, globalVM: globalVM)
                    CommunityMemberBottomSheet(loginData: loginData, globalVM: globalVM, profileVM: profileVM, mesiboVM: mesiboVM, communityVM: communityVM, totalUsers: totalUsers, groupID: groupID)
                    
                    RownLoaderView(loginData: loginData)
                }
            } else {
                VStack{
                    ProgressView()
                }
            }
        }
        .navigationBarBackButtonHidden()
        .onAppear{
            navigateToEditCommunityView = false
            navigateToAddNewCommunityView = false
            Task{
                print(memberStatus)
                adminStatus = false
                memberStatus = false
                globalVM.communityDetail = CommunityDetailModel(profilePic: "", groupName: "", description: "", dateAdded: "", creatorName: "", admin: [MesiboGroupUser](), members: [MesiboGroupUser](), latitude: "", longitude: "", communityType: "", totalmember: 0, location: "")
                communityVM.selectedGroupID = groupID
                let res = await communityService.getCommunityDetailByGroupID(globalVM: globalVM, groupID: groupID)
                if res == "Success"{
                    for i in 0..<globalVM.communityDetail.admin.count {
                        totalUsers.append(globalVM.communityDetail.admin[i])
                        if globalVM.communityDetail.admin[i].userID == loginData.mainUserID {
                            adminStatus = true
                        }
                        if globalVM.communityDetail.admin[i].role == "Hotel Owner" {
                            hotelOwnersMember.append(globalVM.communityDetail.admin[i])
                        } else if globalVM.communityDetail.admin[i].role == "Business Vendor / Freelancer" {
                            vendorMember.append(globalVM.communityDetail.admin[i])
                        } else if globalVM.communityDetail.admin[i].role == "Hotelier" {
                            hotelierMember.append(globalVM.communityDetail.admin[i])
                        } else if globalVM.communityDetail.admin[i].role == "Normal User" {
                            normalUserMember.append(globalVM.communityDetail.admin[i])
                        }
                    }
                    for i in 0..<globalVM.communityDetail.members.count{
                        totalUsers.append(globalVM.communityDetail.members[i])
                        if globalVM.communityDetail.members[i].userID == loginData.mainUserID {
                            memberStatus = true
                            print(globalVM.communityDetail.members[i].userID)
                            print(loginData.mainUserID)
                            print(memberStatus)
                        }
                        if globalVM.communityDetail.members[i].role == "Hotel Owner" {
                            hotelOwnersMember.append(globalVM.communityDetail.members[i])
                        } else if globalVM.communityDetail.members[i].role == "Business Vendor / Freelancer" {
                            vendorMember.append(globalVM.communityDetail.members[i])
                        } else if globalVM.communityDetail.members[i].role == "Hotelier" {
                            hotelierMember.append(globalVM.communityDetail.members[i])
                        } else if globalVM.communityDetail.members[i].role == "Normal User" {
                            normalUserMember.append(globalVM.communityDetail.members[i])
                        }
                    }
                    print("total user count")
                    print(totalUsers.count)
                    print(totalUsers)
                    isLoading = true
                } else {
                    
                }
            }
        }
    }
}

//struct GroupMessageDetailsView_Previews: PreviewProvider {
//    //Login Var
//    @StateObject var loginData = LoginViewModel()
//
//    //Community Var
//    @StateObject var communityVM: CommunityViewModel()
//
//    //Mesibo Var
//    @StateObject var mesiboVM: MesiboViewModel
//    @State var groupID: String
//
//    @StateObject var globalVM: GlobalViewModel
//
//    @StateObject var profileVM: ProfileViewModel
//    static var previews: some View {
//        GroupMessageDetailsView()
//    }
//}
