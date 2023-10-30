//
//  CommunityDetailsView.swift
//  R-own
//
//  Created by Aman Sharma on 22/05/23.
//

import SwiftUI

struct CommunityDetailsView: View {
    
    @State var memberType: String
    
    @StateObject var communityVM: CommunityViewModel
    
    @State var communityStatus: String = "Closed Community"
    
    var body: some View {
        NavigationStack{
            ZStack{
                VStack{
                    //nav
                    HStack{
                        Image(systemName: "arrow.backward.circle")
                            .resizable()
                            .scaledToFit()
                            .frame(width: UIScreen.screenHeight/50, height: UIScreen.screenHeight/50)
                            .foregroundColor(greenUi)
                        Spacer()
                        
                        if memberType == "Admin" {
                            Image(systemName: "pencil.line")
                                .resizable()
                                .scaledToFit()
                                .frame(width: UIScreen.screenHeight/50, height: UIScreen.screenHeight/50)
                                .foregroundColor(greenUi)
                                .padding(.horizontal, UIScreen.screenWidth/50)
                        }
                        Image("CommunityAddUser")
                            .resizable()
                            .scaledToFit()
                            .frame(width: UIScreen.screenHeight/50, height: UIScreen.screenHeight/50)
                            .foregroundColor(greenUi)
                            .padding(.horizontal, UIScreen.screenWidth/50)
                        
                        if memberType == "Admin" {
                            Image(systemName: "xmark.bin")
                                .resizable()
                                .scaledToFit()
                                .frame(width: UIScreen.screenHeight/50, height: UIScreen.screenHeight/50)
                                .foregroundColor(greenUi)
                                .padding(.horizontal, UIScreen.screenWidth/50)
                        }
                        
                    }
                    .padding(.horizontal, UIScreen.screenWidth/40)
                    .frame(width: UIScreen.screenWidth, height: UIScreen.screenHeight/40)
                    .background(greenUi)
                    
                    ScrollView{
                        VStack{
                            ProfilePictureView(profilePic: "", verified: false, height: UIScreen.screenHeight/30, width: UIScreen.screenHeight/30)
                                .padding(.vertical, UIScreen.screenHeight/60)
                            Text("Retvens Director")
                                .font(.body)
                                .fontWeight(.bold)
                                .padding(.vertical, UIScreen.screenHeight/60)
                            Text("5 Members")
                                .font(.body)
                                .fontWeight(.thin)
                        }
                        if memberType == "Admin" {
                            VStack{
                                if communityStatus == "Closed Community" {
                                    Button(action: {
                                        communityStatus = "Open Community"
                                    }, label: {
                                        Text("Switch to Closed Community")
                                            .font(.body)
                                            .fontWeight(.bold)
                                            .foregroundColor(greenUi)
                                            .frame(width: UIScreen.screenWidth/1.3, height: UIScreen.screenWidth/40)
                                            .background(jobsDarkBlue)
                                            .cornerRadius(15)
                                            .padding(10)
                                            
                                    })
                                } else if communityStatus == "Open Community" {
                                    Button(action: {
                                        communityStatus = "Closed Community"
                                    }, label: {
                                        Text("Switch to Open Community")
                                            .font(.body)
                                            .fontWeight(.bold)
                                            .foregroundColor(greenUi)
                                            .frame(width: UIScreen.screenWidth/1.3, height: UIScreen.screenWidth/40)
                                            .background(jobsDarkBlue)
                                            .cornerRadius(15)
                                            .padding(10)
                                    })
                                }
                            }
                        }
                        VStack(alignment: .leading, spacing: 10){
                            VStack(alignment: .leading, spacing: 5){
                                Text("Group Description")
                                    .font(.body)
                                    .fontWeight(.light)
                                Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit.")
                                    .font(.body)
                                    .fontWeight(.light)
                            }
                            Text("Created by Prashant Mishra | 06/04/2023")
                                .font(.body)
                                .fontWeight(.light)
                        }
                        VStack{
                            Text("We are here")
                                .font(.body)
                                .fontWeight(.light)
                            //Map
                            
                        }
                        
                        CommunityTabView(communityVM: communityVM)
                        
                        TabView(selection: $communityVM.selectedCommunityTab){
                            
                            CommunityUsersTabView()
                                .ignoresSafeArea(.all, edges: .all)
                                .tag("Users")
                            
                            CommunityMediaTabView()
                                .ignoresSafeArea(.all, edges: .all)
                                .tag("Media")
                            
                        }
                        
                    }
                }
                SwitchClosedCommunityBottomSheet(communityVM: communityVM)
                SwitchOpenCommunityBottomSheet(communityVM: communityVM)
                RemoveMemberBottomSheet(communityVM: communityVM)
            }
        }
    }
}

//struct CommunityDetailsView_Previews: PreviewProvider {
//    static var previews: some View {
//        CommunityDetailsView()
//    }
//}
