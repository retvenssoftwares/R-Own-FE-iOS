//
//  SideMenuView.swift
//  R-own
//
//  Created by Aman Sharma on 28/04/23.
//

import SwiftUI
import FirebaseAuth
import Shimmer

struct SideMenuView: View {
    
    
    var edges = UIApplication.shared.windows.first?.safeAreaInsets
    
    @StateObject var loginData: LoginViewModel
    @StateObject var globalVM: GlobalViewModel
    @StateObject var jobsVM: JobsViewModel
    
    @StateObject var feedData: MainFeedViewModel
    
    @StateObject var notificationVM: NotificationViewModel
    @StateObject var blogsVM: BlogsViewModel
    @Binding var mainFeedTab: String
    @StateObject var profileVM: ProfileViewModel
    @StateObject var mesiboVM: MesiboViewModel
    @State var logoutService = LogOutService()
    @State var navigateToCompleteYourProfile: Bool = false
    @State var navigateToNotificationsView: Bool = false
    @State var navigateToMyConnectionView: Bool = false
    @State var navigateToJobsAppliedView: Bool = false
    @State var navigateToEventsNearMe: Bool = false
    @State var navigateToBlogsView: Bool = false
    
    
    @State var navigateToTermsnConditionsView: Bool = false
    @State var navigateToBecomeOurPartnerView: Bool = false
    @State var navigateToLearnWithRownView: Bool = false
    @State var navigateToKnowHospitalityWithAIView: Bool = false
    
    @State private var currentUrl: URL?
    
    var body: some View {
        NavigationStack {
            HStack {
                VStack(alignment: .leading){
                        VStack {
                            VStack{
                                HStack{
//                                    VStack(spacing: 0){
//                                        Text("Share Profile")
//                                            .foregroundColor(.black)
//                                            .font(.system(size: UIScreen.screenHeight/90))
//                                            .fontWeight(.bold)
//                                            .frame(alignment: .leading)
//                                        Image("SampleQR")
//                                            .resizable()
//                                            .scaledToFit()
//                                            .frame(width: UIScreen.screenHeight/8, height: UIScreen.screenHeight/8)
//                                        HStack{
//                                            Text("Copy profile URL")
//                                                .foregroundColor(.white)
//                                                .font(.system(size: UIScreen.screenHeight/110))
//                                                .fontWeight(.bold)
//                                                .frame(alignment: .leading)
//                                            Image(systemName: "link")
//                                                .resizable()
//                                                .scaledToFit()
//                                                .foregroundColor(.white)
//                                                .frame(width: UIScreen.screenHeight/60, height: UIScreen.screenHeight/60)
//                                        }
//                                        .padding(.horizontal, 5)
//                                        .padding(.vertical, 3)
//                                        .background(greenUi)
//                                        .cornerRadius(4)
//                                    }
//                                    Divider()
//                                        .overlay(greenUi)
//                                        .frame(height: UIScreen.screenHeight/7)
//                                        .padding(.trailing, UIScreen.screenWidth/20)
                                    VStack{
                                        HStack{
                                            VStack{
                                                if loginData.mainUserProfilePic == "" {
                                                    Image("UserIcon")
                                                        .resizable()
                                                        .aspectRatio(contentMode: .fit)
                                                        .frame(width: UIScreen.screenHeight/12, height: UIScreen.screenHeight/12)
                                                } else {
                                                    AsyncImage(url: currentUrl) { image in
                                                        image
                                                            .resizable()
                                                            .scaledToFit()
                                                    } placeholder: {
                                                        Color.purple.opacity(0.1)
                                                    }
                                                    .frame(width: UIScreen.screenHeight/10, height: UIScreen.screenHeight/10)
                                                    .clipShape(Circle())
                                                    .onAppear {
                                                        if currentUrl == nil {
                                                            DispatchQueue.main.async {
                                                                currentUrl = URL(string: loginData.mainUserProfilePic)
                                                            }
                                                        }
                                                    }
                                                }
                                            }
                                            VStack(alignment: .leading, spacing: UIScreen.screenHeight/80){
                                                VStack(alignment: .leading){
                                                    Text(loginData.mainUserFullName)
                                                        .foregroundColor(.black)
                                                        .font(.title2)
                                                        .fontWeight(.bold)
                                                        .frame(alignment: .leading)
                                                        .multilineTextAlignment(.leading)
                                                    Text(loginData.mainUserPhoneNumber)
                                                        .foregroundColor(.black)
                                                        .font(.title3)
                                                        .fontWeight(.light)
                                                        .frame(alignment: .leading)
                                                        .multilineTextAlignment(.leading)
                                                }
                                            }
                                            Spacer()
                                        }
                                        .padding(.vertical, UIScreen.screenHeight/90)
                                        
                                        VStack(alignment: .leading, spacing: 0){
                                            Text("Your Profile is \(loginData.profileCompletionPercentage)% complete")
                                                .foregroundColor(.black)
                                                .font(.subheadline)
                                                .fontWeight(.bold)
                                                .frame(alignment: .leading)
                                            
                                            ProgressView("", value: Float(loginData.profileCompletionPercentage), total: 100)
                                                .tint(greenUi)
                                                .shimmering(active: true)
                                                .padding(.bottom, UIScreen.screenHeight/60)
                                            
                                            if loginData.profileCompletionPercentage != "100" {
                                                Button(action: {
                                                    navigateToCompleteYourProfile = true
                                                }, label: {
                                                    HStack{
                                                        Text("Complete your profile")
                                                            .foregroundColor(.black)
                                                            .font(.subheadline)
                                                            .fontWeight(.light)
                                                            .frame(alignment: .leading)
                                                        Spacer()
                                                        Image(systemName: "chevron.right")
                                                            .resizable()
                                                            .scaledToFit()
                                                            .foregroundColor(.black)
                                                            .frame(width: UIScreen.screenHeight/90, height: UIScreen.screenHeight/90)
                                                    }
                                                })
                                                .navigationDestination(isPresented: $navigateToCompleteYourProfile, destination: {
                                                    
                                                    if loginData.profileCompletionPercentage == "90"{
                                                        if loginData.mainUserRole == "Normal User" {
                                                            NormalUserBasicInfoView(loginData: loginData, globalVM: globalVM, profileVM: profileVM)
                                                        } else if loginData.mainUserRole == "Hospitality Expert" {
                                                            HospitalityExpertBasicInfoView(loginData: loginData, globalVM: globalVM, profileVM: profileVM)
                                                        } else if loginData.mainUserRole == "Business Vendor / Freelancer" {
                                                            VendorBasicInfoView(loginData: loginData, globalVM: globalVM, profileVM: profileVM)
                                                        } else if loginData.mainUserRole == "Hotel Owner" {
                                                            HotelOwnerBasicInfoView(loginData: loginData, profileVM: profileVM, globalVM: globalVM)
                                                        }
                                                    } else if loginData.profileCompletionPercentage == "60" {
                                                        UserBioAndGenderProfileCompletion(loginData: loginData, globalVM: globalVM, profileVM: profileVM)
                                                    } else if loginData.profileCompletionPercentage == "80" {
                                                        UserRoleView(loginData: loginData, globalVM: globalVM, profileVM: profileVM)
                                                    } else if loginData.profileCompletionPercentage == "70" {
                                                        LocationProfileCompletionView(loginData: loginData, globalVM: globalVM, profileVM: profileVM)
                                                    } else if loginData.profileCompletionPercentage == "50"{
                                                        BasicInfoProfileView(loginData: loginData, globalVM: globalVM, profileVM: profileVM)
                                                    }
                                                })
                                            }
                                        }
                                        .padding(.vertical, UIScreen.screenHeight/90)
                                    }
                                    .frame(height: UIScreen.screenHeight/7)
                                }
                                .padding(.horizontal, 20)
                                .padding(.vertical, 40)
                                .frame(width: UIScreen.screenWidth/1.4)
                                .background(.white)
                                .cornerRadius(7)
                                .clipped()
                                .shadow(color: .black.opacity(0.2), radius: 5, x: 2, y: 2)
                                .padding(.top, UIScreen.screenHeight/30)
                                .padding()
                                Button(action: {
                                    //tab is changed
                                    feedData.sidebarX = UIScreen.screenWidth/7 - UIScreen.screenWidth 
                                    mainFeedTab = "Profile"
                                }, label: {
                                    Text("MY ACCOUNT")
                                        .padding(.vertical, 7)
                                        .foregroundColor(.black)
                                        .font(.body)
                                        .fontWeight(.medium)
                                        .frame(width: UIScreen.screenWidth/1.4, height: UIScreen.screenHeight/30)
                                        .background(.white)
                                        .cornerRadius(7)
                                        .clipped()
                                        .shadow(color: .black.opacity(0.2), radius: 5, x: 2, y: 2)
                                })
                                .padding(.bottom, 20)
                            }
                            .frame(width: UIScreen.screenWidth - UIScreen.screenWidth/7)
                            .background(Color.white)
                            ScrollView{
                                VStack{
                                    VStack{
                                        SideBarTilesView(tileImage: "SidebarNotificationIcon", tileText: "Notifications")
                                            .onTapGesture {
                                                navigateToNotificationsView = true
                                            }
                                            .navigationDestination(isPresented: $navigateToNotificationsView, destination: {
                                                NotificationsView(loginData: loginData, notificationVM: notificationVM, globalVM: globalVM, profileVM: profileVM, mesiboVM: mesiboVM)
                                            })
                                        NavigationLink(isActive: $navigateToNotificationsView, destination: {
                                            NotificationsView(loginData: loginData, notificationVM: notificationVM, globalVM: globalVM, profileVM: profileVM, mesiboVM: mesiboVM)
                                        }, label: {
                                            Text("")
                                        })
                                        SideBarTilesView(tileImage: "SidebarMyConnections", tileText: "My Connections")
                                            .onTapGesture {
                                                navigateToMyConnectionView = true
                                            }
                                            .navigationDestination(isPresented: $navigateToMyConnectionView, destination: {
                                                ConnectionsProfileListView(connectionOwnerName: "My", loginData: loginData, globalVM: globalVM, mainUser: true, profileVM: profileVM, mesiboVM: mesiboVM)
                                            })
                                        NavigationLink(isActive: $navigateToMyConnectionView, destination: {
                                            ConnectionsProfileListView(connectionOwnerName: "My", loginData: loginData, globalVM: globalVM, mainUser: true, profileVM: profileVM, mesiboVM: mesiboVM)
                                        }, label: {
                                            Text("")
                                        })
                                        if loginData.isHiddenKPI{
                                            if loginData.mainUserRole == "Hotel Owner" {
                                                SideBarTilesView(tileImage: "SidebarJobsAppliedFor", tileText: "Jobs Posted")
                                                    .onTapGesture {
                                                        feedData.sidebarX = UIScreen.screenWidth/7 - UIScreen.screenWidth
                                                        mainFeedTab = "Jobs"
                                                    }
                                            } else {
                                                SideBarTilesView(tileImage: "SidebarJobsAppliedFor", tileText: "Jobs Applied")
                                                    .onTapGesture {
                                                        feedData.sidebarX = UIScreen.screenWidth/7 - UIScreen.screenWidth
                                                        mainFeedTab = "Jobs"
                                                        jobsVM.jobsUserTabSelected = "AppliedJobs"
                                                    }
                                            }
                                        }
                                        if loginData.isHiddenKPI{
                                            SideBarTilesView(tileImage: "SidebarEventsNearMe", tileText: "Events Near Me")
                                                .onTapGesture {
                                                    navigateToEventsNearMe = true
                                                }
                                                .navigationDestination(isPresented: $navigateToEventsNearMe, destination: {
                                                    NearestConcertListView(loginData: loginData, globalVM: globalVM)
                                                })
                                            NavigationLink(isActive: $navigateToEventsNearMe, destination: {
                                                NearestConcertListView(loginData: loginData, globalVM: globalVM)
                                            }, label: {
                                                Text("")
                                            })
                                        }
                                        SideBarTilesView(tileImage: "SidebarBlogs", tileText: "Blogs")
                                            .onTapGesture {
                                                navigateToBlogsView = true
                                            }
                                            .navigationDestination(isPresented: $navigateToBlogsView, destination: {
                                                AllBlogsView(blogsVM: blogsVM, globalVM: globalVM, loginData: loginData)
                                            })
                                        NavigationLink(isActive: $navigateToBlogsView, destination: {
                                            AllBlogsView(blogsVM: blogsVM, globalVM: globalVM, loginData: loginData)
                                        }, label: {
                                            Text("")
                                        })
                                    }
                                    VStack{
                                        SideBarTilePnSDropDownView()
                                        SideBarTileHnSDropDownView(globalVM: globalVM)
                                    }
                                    
//                                    Button(action: {
//                                        logoutService.logoutFirebase()
//                                        logoutService.logoutApp(loginData: loginData)
//                                    }, label: {
//                                        Text("Logout")
//                                            .font(.system(size: UIScreen.screenHeight/60))
//                                            .foregroundColor(.white)
//                                    })
                                    
                                    Spacer()
                                    
                                }
                                .frame(width: UIScreen.screenWidth - UIScreen.screenWidth/7)
                            }
                        }
                }
                .padding(.horizontal, 20)
                .padding(.vertical)
                .frame(width: UIScreen.screenWidth - UIScreen.screenWidth/7, height: UIScreen.screenHeight)
                .background(sidebarBGGreyColorUI)
                .ignoresSafeArea(.all, edges: .vertical)
                
                Spacer()
            }
            .frame(height: UIScreen.screenHeight)
        }
        .onAppear{
            navigateToNotificationsView = false
            navigateToMyConnectionView = false
            navigateToEventsNearMe = false
            navigateToBlogsView = false
        }
    }
}

//struct SideMenuView_Previews: PreviewProvider {
//    static var previews: some View {
//        SideMenuView()
//    }
//}
