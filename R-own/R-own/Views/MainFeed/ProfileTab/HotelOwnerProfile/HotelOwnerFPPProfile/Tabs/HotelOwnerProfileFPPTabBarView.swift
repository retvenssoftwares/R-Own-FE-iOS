//
//  HotelOwnerProfileFPPTabBarView.swift
//  R-own
//
//  Created by Aman Sharma on 08/06/23.
//

import SwiftUI

struct HotelOwnerProfileFPPTabBarView: View {
    
    @Binding var profileTabSelected: String
    @StateObject var loginData: LoginViewModel
    @StateObject var globalVM: GlobalViewModel
    @StateObject var profileService = ProfileService()
    
    var body: some View {
        HStack{
            ScrollView(.horizontal){
                HStack{
                    Button(action: {
                        withAnimation{
                            profileTabSelected = "Media"
                        }
                    }, label: {
                        Text("Media")
                            .font(.body)
                            .fontWeight(.medium)
                            .foregroundColor(.black)
                            .frame(width: UIScreen.screenWidth/4, height: UIScreen.screenHeight/40)
                            .padding(.horizontal, UIScreen.screenWidth/20)
                            .padding(.vertical, UIScreen.screenHeight/85)
                            .background(profileTabSelected == "Media" ? .white : .white.opacity(0))
                            .cornerRadius(8)
                    })
                    
                    Button(action: {
                        withAnimation{
                            profileTabSelected = "Polls"
                        }
                    }, label: {
                        Text("Polls")
                            .font(.body)
                            .fontWeight(.medium)
                            .foregroundColor(.black)
                            .frame(width: UIScreen.screenWidth/4, height: UIScreen.screenHeight/40)
                            .padding(.horizontal, UIScreen.screenWidth/20)
                            .padding(.vertical, UIScreen.screenHeight/85)
                            .background(profileTabSelected == "Polls" ? .white : .white.opacity(0))
                            .cornerRadius(8)
                    })
                    
                    Button(action: {
                        withAnimation{
                            profileTabSelected = "Status"
                        }
                    }, label: {
                        Text("Status")
                            .font(.body)
                            .fontWeight(.medium)
                            .foregroundColor(.black)
                            .frame(width: UIScreen.screenWidth/4, height: UIScreen.screenHeight/40)
                            .padding(.horizontal, UIScreen.screenWidth/20)
                            .padding(.vertical, UIScreen.screenHeight/85)
                            .background(profileTabSelected == "Status" ? .white : .white.opacity(0))
                            .cornerRadius(8)
                    })
                    
                    if loginData.isHiddenKPI{
                        Button(action: {
                            withAnimation{
                                profileTabSelected = "Events"
                            }
                        }, label: {
                            Text("Events")
                                .font(.body)
                                .fontWeight(.light)
                                .foregroundColor(.black)
                                .frame(width: UIScreen.screenWidth/6, height: UIScreen.screenHeight/40)
                                .padding(.horizontal, UIScreen.screenWidth/20)
                                .padding(.vertical, UIScreen.screenHeight/85)
                                .background(profileTabSelected == "Events" ? .white : .white.opacity(0))
                                .cornerRadius(8)
                        })
                    }
                    
                    Button(action: {
                        withAnimation{
                            profileTabSelected = "Hotels"
                        }
                    }, label: {
                        Text("Hotels")
                            .font(.body)
                            .fontWeight(.medium)
                            .foregroundColor(.black)
                            .frame(width: UIScreen.screenWidth/4, height: UIScreen.screenHeight/40)
                            .padding(.horizontal, UIScreen.screenWidth/20)
                            .padding(.vertical, UIScreen.screenHeight/85)
                            .background(profileTabSelected == "Hotels" ? .white : .white.opacity(0))
                            .cornerRadius(8)
                    })
                    
                }
                .padding(.vertical, UIScreen.screenHeight/60)
            }
            .padding(.horizontal, UIScreen.screenWidth/10)
            .frame(width: UIScreen.screenWidth)
        }
    }
}

//struct HotelOwnerProfileFPPTabBarView_Previews: PreviewProvider {
//    static var previews: some View {
//        HotelOwnerProfileFPPTabBarView()
//    }
//}
