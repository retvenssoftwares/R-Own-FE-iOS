//
//  ProfileSavedTabsView.swift
//  R-own
//
//  Created by Aman Sharma on 18/05/23.
//

import SwiftUI

struct ProfileSavedTabsView: View {

    @Binding var savedCategorySelected: String
    @StateObject var loginData: LoginViewModel
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack{
                Button(action: {
                    savedCategorySelected = "Posts"
                }, label: {
                    HStack{
                        Image("ExplorePosts")
                            .resizable()
                            .scaledToFit()
                            .frame(width: UIScreen.screenHeight/70, height: UIScreen.screenHeight/70)
                        Text("Posts")
                            .foregroundColor(.black)
                            .font(.body)
                            .fontWeight(.bold)
                            .multilineTextAlignment(.leading)
                            .frame(alignment: .leading)
                    }
                    .padding(.horizontal, 10)
                    .padding()
                    .background(.white)
                    .cornerRadius(4)
                    .clipped()
                    .shadow(color: .black.opacity(0.2), radius: 5, x: 2, y: 2)
                    .border(width: savedCategorySelected == "Posts" ? 2 : 0,edges: [.top], color: greenUi)
                    
                })
//                if loginData.mainUserRole != "Business Vendor / Freelancer" && loginData.mainUserRole != "Hotel Owner" {
//                    Button(action: {
//                        savedCategorySelected = "Jobs"
//                    }, label: {
//                        HStack{
//                            Image("ExploreAppliedJobs")
//                                .resizable()
//                                .scaledToFit()
//                                .frame(width: UIScreen.screenHeight/70, height: UIScreen.screenHeight/70)
//                            Text("Jobs")
//                                .foregroundColor(.black)
//                                .font(.system(size: UIScreen.screenHeight/100))
//                                .fontWeight(.bold)
//                                .multilineTextAlignment(.leading)
//                                .frame(alignment: .leading)
//                        }
//                        .padding(.horizontal, 10)
//                        .padding()
//                        .background(.white)
//                        .cornerRadius(4)
//                        .clipped()
//                        .shadow(radius: 4)
//                        .border(width: savedCategorySelected == "Jobs" ? 2 : 0,edges: [.top], color: greenUi)
//
//                    })
//                }
                Button(action: {
                    savedCategorySelected = "Blogs"
                }, label: {
                    HStack{
                        Image("ExploreBlogs")
                            .resizable()
                            .scaledToFit()
                            .frame(width: UIScreen.screenHeight/70, height: UIScreen.screenHeight/70)
                        Text("Blogs")
                            .foregroundColor(.black)
                            .font(.body)
                            .fontWeight(.bold)
                            .multilineTextAlignment(.leading)
                            .frame(alignment: .leading)
                    }
                    .padding(.horizontal, 10)
                    .padding()
                    .background(.white)
                    .cornerRadius(4)
                    .clipped()
                    .shadow(color: .black.opacity(0.2), radius: 5, x: 2, y: 2)
                    .border(width: savedCategorySelected == "Blogs" ? 2 : 0,edges: [.top], color: greenUi)
                    
                })
//                Button(action: {
//                    savedCategorySelected = "Events"
//                }, label: {
//                    HStack{
//                        Image("ExploreEvents")
//                            .resizable()
//                            .scaledToFit()
//                            .frame(width: UIScreen.screenHeight/70, height: UIScreen.screenHeight/70)
//                        Text("Events")
//                            .foregroundColor(.black)
//                            .font(.system(size: UIScreen.screenHeight/100))
//                            .fontWeight(.bold)
//                            .multilineTextAlignment(.leading)
//                            .frame(alignment: .leading)
//                    }
//                    .padding(.horizontal, 10)
//                    .padding()
//                    .background(.white)
//                    .cornerRadius(4)
//                    .clipped()
//                    .shadow(radius: 4)
//                    .border(width: savedCategorySelected == "Events" ? 2 : 0,edges: [.top], color: greenUi)
//
//                })
                Button(action: {
                    savedCategorySelected = "Hotels"
                }, label: {
                    HStack{
                        Image("ExploreHotels")
                            .resizable()
                            .scaledToFit()
                            .frame(width: UIScreen.screenHeight/70, height: UIScreen.screenHeight/70)
                        Text("Hotels")
                            .foregroundColor(.black)
                            .font(.body)
                            .fontWeight(.bold)
                            .multilineTextAlignment(.leading)
                            .frame(alignment: .leading)
                    }
                    .padding(.horizontal, 10)
                    .padding()
                    .background(.white)
                    .cornerRadius(4)
                    .clipped()
                    .shadow(color: .black.opacity(0.2), radius: 5, x: 2, y: 2)
                    .border(width: savedCategorySelected == "Hotels" ? 2 : 0,edges: [.top], color: greenUi)
                    
                })
//                Button(action: {
//                    savedCategorySelected = "Services"
//                }, label: {
//                    HStack{
//                        Image("ExploreServices")
//                            .resizable()
//                            .scaledToFit()
//                            .frame(width: UIScreen.screenHeight/70, height: UIScreen.screenHeight/70)
//                        Text("Services")
//                            .foregroundColor(.black)
//                            .font(.system(size: UIScreen.screenHeight/100))
//                            .fontWeight(.bold)
//                            .multilineTextAlignment(.leading)
//                            .frame(alignment: .leading)
//                    }
//                    .padding(.horizontal, 10)
//                    .padding()
//                    .background(.white)
//                    .cornerRadius(4)
//                    .clipped()
//                    .shadow(radius: 4)
//                    .border(width: savedCategorySelected == "Services" ? 2 : 0,edges: [.top], color: greenUi)
//                    
//                })
            }
            .padding(.vertical, 4)
            .padding(.leading, 10)
        }
    }
}

//struct ProfileSavedTabsView_Previews: PreviewProvider {
//    static var previews: some View {
//        ProfileSavedTabsView()
//    }
//}
