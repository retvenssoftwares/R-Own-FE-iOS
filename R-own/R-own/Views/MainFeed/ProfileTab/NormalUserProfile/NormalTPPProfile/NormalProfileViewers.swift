//
//  NormalProfileViewers.swift
//  R-own
//
//  Created by Aman Sharma on 12/05/23.
//

import SwiftUI

struct NormalProfileViewers: View {
    
    @State var profileTabSelected: String = "Media"
    
    var body: some View {
        NavigationStack{
            ScrollView{
                VStack(alignment: .leading){
                    
                    //Navbar
                    HStack{
                        //button
                        Button(action: {
                            
                        }, label: {
                            Image(systemName: "chevron.backward")
                                .resizable()
                                .scaledToFit()
                                .frame(width: UIScreen.screenWidth/40, height: UIScreen.screenHeight/70)
                        })
                        
                        //text
                        Text("User_Name")
                            .font(.body)
                            .fontWeight(.bold)
                        
                        Spacer()
                        
                        //Setting icon
                        Button(action: {
                            print("opening more bottom sheet")
                        }, label: {
                            Image(systemName: "slider.vertical.3")
                                .resizable()
                                .scaledToFit()
                                .frame(width: UIScreen.screenWidth/40, height: UIScreen.screenHeight/70)
                        })
                    }
                    
                    
                    HStack{
                        // profile picture
                        Image("UserIcon")
                            .resizable()
                            .scaledToFit()
                            .frame(width: UIScreen.screenHeight/60, height: UIScreen.screenHeight/60)
                        
                        Spacer()
                        
                        //post count
                        VStack{
                            Text("150")
                                .font(.body)
                                .fontWeight(.bold)
                            
                            Text("Posts")
                                .font(.body)
                                .fontWeight(.light)
                        }
                        
                        //connection count
                        VStack{
                            Text("150")
                                .font(.body)
                                .fontWeight(.bold)
                            
                            Text("Connections")
                                .font(.body)
                                .fontWeight(.light)
                        }
                    }
                    //text name
                    Text("User Full Name")
                        .font(.body)
                        .fontWeight(.bold)
                    
                    //text bio
                    Text("Are you ready to begin your hospitality adventures with us ?")
                        .multilineTextAlignment(.leading)
                        .font(.body)
                        .fontWeight(.light)
                    
                    HStack{
                        
                        Spacer()
                        
                        //button
                        Button(action: {
                            
                        }, label: {
                            Text("CONNECT")
                                .font(.body)
                                .fontWeight(.light)
                                .foregroundColor(greenUi)
                                .frame(width: UIScreen.screenWidth/4)
                                .background(jobsDarkBlue)
                        })
                        
                        Spacer()
                        
                        //button
                        Button(action: {
                            
                        }, label: {
                            Text("SHARE PROFILE")
                                .font(.body)
                                .fontWeight(.light)
                                .padding(.horizontal, UIScreen.screenWidth/50)
                                .padding(.vertical, UIScreen.screenHeight/70)
                                .border(.black)
                        })
                        
                        Spacer()
                        
                    }
                    
                    //divider with textoverlay
                    Divider()
                        .overlay{
                            Text("Posts")
                                .font(.body)
                                .fontWeight(.light)
                                .padding()
                                .background(.white)
                        }
                    
                    //tabs view
                    NormalProfileTPPTabBarView(profileTabSelected: $profileTabSelected)
                    
                    //tabs content
                    
                    ZStack{
                        TabView(selection: $profileTabSelected){
                            NormalProfileMediaTabView()
                                .ignoresSafeArea(.all, edges: .all)
                                .tag("Media")
                            
//                            NormalProfilePollsTabView()
//                                .ignoresSafeArea(.all, edges: .all)
//                                .tag("Polls")
                        }
                    }
                }
            }
        }
    }
}

//struct NormalProfileViewers_Previews: PreviewProvider {
//    static var previews: some View {
//        NormalProfileViewers()
//    }
//}
