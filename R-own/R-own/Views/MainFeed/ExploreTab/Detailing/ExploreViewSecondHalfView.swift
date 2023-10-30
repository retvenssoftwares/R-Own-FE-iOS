//
//  ExploreViewSecondHalfView.swift
//  R-own
//
//  Created by Aman Sharma on 29/04/23.
//

import SwiftUI

struct ExploreViewSecondHalfView: View {
    
    @StateObject var loginData: LoginViewModel
    @StateObject var globalVM: GlobalViewModel
    @StateObject var exploreVM: ExploreViewModel
    @StateObject var exploreService = ExploreService()
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 10){
                Button(action: {
                    exploreVM.exploreCategorySelected = "Posts"
                }, label: {
                    HStack{
                        Image("ExplorePosts")
                            .resizable()
                            .scaledToFit()
                            .frame(width: UIScreen.screenHeight/60, height: UIScreen.screenHeight/60)
                        Text("Posts")
                            .foregroundColor(.black)
                            .font(.headline)
                            .fontWeight(.light)
                            .multilineTextAlignment(.leading)
                            .frame(alignment: .leading)
                    }
                    .padding()
                    .background(.white)
                    .border(width: exploreVM.exploreCategorySelected == "Posts" ? 2 : 0,edges: [.top], color: greenUi)
                    .cornerRadius(5)
                    .clipped()
                    .shadow(color: .black.opacity(0.12), radius: 2, x: 2)
                    
                })
                
                if loginData.isHiddenKPI{
                    Button(action: {
                        exploreVM.exploreCategorySelected = "Jobs"
                    }, label: {
                        HStack{
                            Image("ExploreAppliedJobs")
                                .resizable()
                                .scaledToFit()
                                .frame(width: UIScreen.screenHeight/60, height: UIScreen.screenHeight/60)
                            Text("Jobs")
                                .foregroundColor(.black)
                                .font(.headline)
                                .fontWeight(.light)
                                .multilineTextAlignment(.leading)
                                .frame(alignment: .leading)
                        }
                        .padding()
                        .background(.white)
                        .border(width: exploreVM.exploreCategorySelected == "Jobs" ? 2 : 0,edges: [.top], color: greenUi)
                        .cornerRadius(5)
                        .clipped()
                        .shadow(color: .black.opacity(0.12), radius: 2, x: 2)
                        
                    })
                }
                Button(action: {
                    exploreVM.exploreCategorySelected = "People"
                }, label: {
                    HStack{
                        Image("ExploreAppliedJobs")
                            .resizable()
                            .scaledToFit()
                            .frame(width: UIScreen.screenHeight/60, height: UIScreen.screenHeight/60)
                        Text("People")
                            .foregroundColor(.black)
                            .font(.headline)
                            .fontWeight(.light)
                            .multilineTextAlignment(.leading)
                            .frame(alignment: .leading)
                    }
                    .padding()
                    .background(.white)
                    .border(width: exploreVM.exploreCategorySelected == "People" ? 2 : 0,edges: [.top], color: greenUi)
                    .cornerRadius(5)
                    .clipped()
                    .shadow(color: .black.opacity(0.12), radius: 2, x: 2)
                    
                })
                
                Button(action: {
                    exploreVM.exploreCategorySelected = "Blogs"
                }, label: {
                    HStack{
                        Image("ExploreBlogs")
                            .resizable()
                            .scaledToFit()
                            .frame(width: UIScreen.screenHeight/60, height: UIScreen.screenHeight/60)
                        Text("Blogs")
                            .foregroundColor(.black)
                            .font(.headline)
                            .fontWeight(.light)
                            .multilineTextAlignment(.leading)
                            .frame(alignment: .leading)
                    }
                    .padding()
                    .background(.white)
                    .border(width: exploreVM.exploreCategorySelected == "Blogs" ? 2 : 0,edges: [.top], color: greenUi)
                    .cornerRadius(5)
                    .clipped()
                    .shadow(color: .black.opacity(0.12), radius: 2, x: 2)
                    
                })
                if loginData.isHiddenKPI{
                    Button(action: {
                        exploreVM.exploreCategorySelected = "Events"
                    }, label: {
                        HStack{
                            Image("ExploreEvents")
                                .resizable()
                                .scaledToFit()
                                .frame(width: UIScreen.screenHeight/60, height: UIScreen.screenHeight/60)
                            Text("Events")
                                .foregroundColor(.black)
                                .font(.headline)
                                .fontWeight(.light)
                                .multilineTextAlignment(.leading)
                                .frame(alignment: .leading)
                        }
                        .padding()
                        .background(.white)
                        .border(width: exploreVM.exploreCategorySelected == "Events" ? 2 : 0,edges: [.top], color: greenUi)
                        .cornerRadius(5)
                        .clipped()
                        .shadow(color: .black.opacity(0.12), radius: 2, x: 2)
                        
                    })
                }
                Button(action: {
                    exploreVM.exploreCategorySelected = "Hotels"
                }, label: {
                    HStack{
                        Image("ExploreHotels")
                            .resizable()
                            .scaledToFit()
                            .frame(width: UIScreen.screenHeight/60, height: UIScreen.screenHeight/60)
                        Text("Hotels")
                            .foregroundColor(.black)
                            .font(.headline)
                            .fontWeight(.light)
                            .multilineTextAlignment(.leading)
                            .frame(alignment: .leading)
                    }
                    .padding()
                    .background(.white)
                    .border(width: exploreVM.exploreCategorySelected == "Hotels" ? 2 : 0,edges: [.top], color: greenUi)
                    .cornerRadius(5)
                    .clipped()
                    .shadow(color: .black.opacity(0.12), radius: 2, x: 2)
                    
                })
                Button(action: {
                    exploreVM.exploreCategorySelected = "Services"
                }, label: {
                    HStack{
                        Image(systemName: "gearshape")
                            .resizable()
                            .scaledToFit()
                            .foregroundColor(.black)
                            .frame(width: UIScreen.screenHeight/60, height: UIScreen.screenHeight/60)
                        Text("Services")
                            .foregroundColor(.black)
                            .font(.headline)
                            .fontWeight(.light)
                            .multilineTextAlignment(.leading)
                            .frame(alignment: .leading)
                    }
                    .padding()
                    .background(.white)
                    .border(width: exploreVM.exploreCategorySelected == "Services" ? 2 : 0,edges: [.top], color: greenUi)
                    .cornerRadius(5)
                    .clipped()
                    .shadow(color: .black.opacity(0.12), radius: 2, x: 2)
                    
                })
                Button(action: {
                    exploreVM.exploreCategorySelected = "Communities"
                }, label: {
                    HStack{
                        Image("SidebarMyConnections")
                            .resizable()
                            .scaledToFit()
                            .foregroundColor(.black)
                            .frame(width: UIScreen.screenHeight/60, height: UIScreen.screenHeight/60)
                        Text("Communities")
                            .foregroundColor(.black)
                            .font(.headline)
                            .fontWeight(.light)
                            .multilineTextAlignment(.leading)
                            .frame(alignment: .leading)
                    }
                    .padding()
                    .background(.white)
                    .border(width: exploreVM.exploreCategorySelected == "Communities" ? 2 : 0,edges: [.top], color: greenUi)
                    .cornerRadius(5)
                    .clipped()
                    .shadow(color: .black.opacity(0.12), radius: 2, x: 2)
                    
                })
            }
            .padding(.vertical, UIScreen.screenHeight/90)
            .padding(.horizontal, UIScreen.screenWidth/30)
        }
    }
}

//struct ExploreViewSecondHalfView_Previews: PreviewProvider {
//    static var previews: some View {
//        ExploreViewSecondHalfView()
//    }
//}
