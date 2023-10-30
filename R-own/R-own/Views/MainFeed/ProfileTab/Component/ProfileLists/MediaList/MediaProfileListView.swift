//
//  MediaListView.swift
//  R-own
//
//  Created by Aman Sharma on 16/05/23.
//

import SwiftUI

struct MediaProfileListView: View {
    @StateObject var globalVM: GlobalViewModel
    @StateObject var loginData: LoginViewModel
    @State var profileVM: ProfileViewModel
    @State var mesiboVM: MesiboViewModel
    
    @State var role: String
    @State var mainUser: Bool
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        ScrollView {
            VStack{
                if globalVM.getMediaPost.count > 0 {
                    VStack{
                        LazyVGrid(columns: columns, spacing: 10) {
                            ForEach(0..<globalVM.getMediaPost[0].posts.count, id: \.self) { id in
                                MediaProfilePostView(post: globalVM.getMediaPost[0].posts[id], imgData: globalVM.getMediaPost[0].posts[id].media, loginData: loginData, profileVM: profileVM, mesiboVM: mesiboVM, globalVM: globalVM, mainUser: mainUser)
                            }
                        }
                        Spacer(minLength: UIScreen.screenHeight/10)
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
            .padding(.horizontal)
        }
    }
}

//struct MediaListView_Previews: PreviewProvider {
//    static var previews: some View {
//        MediaListView()
//    }
//}
