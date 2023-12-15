//
//  SideBarTilesView.swift
//  R-own
//
//  Created by Aman Sharma on 28/04/23.
//

import SwiftUI

struct SideBarTilesView: View {
    
    @State var tileImage: String
    @State var tileText: String
    
    var body: some View {
        
        HStack{
            Image(tileImage)
                .resizable()
                .scaledToFit()
                .frame(width: UIScreen.screenHeight/50, height: UIScreen.screenHeight/50)
                .padding(.leading, UIScreen.screenWidth/20)
                .padding(.trailing, UIScreen.screenWidth/60)
            Text(tileText)
                .foregroundColor(.black)
                .font(.subheadline)
                .fontWeight(.bold)
            Spacer()
        }
        .frame(width: UIScreen.screenWidth/1.4, height: UIScreen.screenHeight/30)
        .padding(.vertical, 7)
        .background(.white)
        .cornerRadius(7)
        .clipped()
        .shadow(color: .black.opacity(0.2), radius: 5, x: 2, y: 2)
    }
}


struct SideBarTilePnSDropDownView: View {
    
    @State var showDropDown: Bool = false
    @State var navigateToTermsnConditionView: Bool = false
    @State var navigateToPrivacyPoliciesView: Bool = false
    @State var navigateToAccountDataPoliciesView: Bool = false
    
    var body: some View {
        NavigationStack{
            VStack{
                Button(action: {
                    withAnimation{
                        showDropDown.toggle()
                    }
                }, label: {
                    HStack{
                        Image("SidebarPrivacynSecurity")
                            .resizable()
                            .scaledToFit()
                            .frame(width: UIScreen.screenHeight/50, height: UIScreen.screenHeight/50)
                            .padding(.leading, UIScreen.screenWidth/20)
                            .padding(.trailing, UIScreen.screenWidth/60)
                        Text("Privacy & Security")
                            .foregroundColor(.black)
                            .font(.subheadline)
                            .fontWeight(.bold)
                        Spacer()
                        if showDropDown{
                            Image(systemName: "chevron.down")
                                .resizable()
                                .scaledToFit()
                                .foregroundColor(.black)
                                .frame(width: UIScreen.screenHeight/60, height: UIScreen.screenHeight/70)
                                .padding(.trailing, 20)
                        }else{
                            Image(systemName: "chevron.right")
                                .resizable()
                                .scaledToFit()
                                .foregroundColor(.black)
                                .frame(width: UIScreen.screenHeight/60, height: UIScreen.screenHeight/70)
                                .padding(.trailing, 20)
                        }
                    }
                })
                .frame(width: UIScreen.screenWidth/1.4, height: UIScreen.screenHeight/30)
                .padding(.vertical, 7)
                .background(.white)
                .cornerRadius(7)
                .clipped()
                .shadow(color: .black.opacity(0.2), radius: 5, x: 2, y: 2)
            
            if showDropDown{
                Link(destination: URL(string: "https://www.r-own.com/terms-and-conditions")!) {
                    HStack{
                        Image("SidebarTermsnConditions")
                            .resizable()
                            .scaledToFit()
                            .frame(width: UIScreen.screenHeight/50, height: UIScreen.screenHeight/50)
                            .padding(.leading, UIScreen.screenWidth/20)
                            .padding(.trailing, UIScreen.screenWidth/60)
                        Text("Terms & Conditions")
                            .foregroundColor(.black)
                            .font(.subheadline)
                            .fontWeight(.bold)
                        Spacer()
                        
                    }
                }
                .frame(width: UIScreen.screenWidth/1.6, height: UIScreen.screenHeight/30)
                .padding(.vertical, 7)
                .background(lightGreyUi)
                .cornerRadius(7)
                .clipped()
                .shadow(color: .black.opacity(0.2), radius: 5, x: 2, y: 2)
                
                Link(destination: URL(string: "https://www.r-own.com/privacy-policy")!) {
                    HStack{
                        Image("SidebarPrivacyPolicies")
                            .resizable()
                            .scaledToFit()
                            .frame(width: UIScreen.screenHeight/50, height: UIScreen.screenHeight/50)
                            .padding(.leading, UIScreen.screenWidth/20)
                            .padding(.trailing, UIScreen.screenWidth/60)
                        Text("Privacy Policies")
                            .foregroundColor(.black)
                            .font(.subheadline)
                            .fontWeight(.bold)
                        Spacer()
                        
                    }
                }
                .frame(width: UIScreen.screenWidth/1.6, height: UIScreen.screenHeight/30)
                .padding(.vertical, 7)
                .background(lightGreyUi)
                .cornerRadius(7)
                .clipped()
                .shadow(color: .black.opacity(0.2), radius: 5, x: 2, y: 2)
                
                
                Link(destination: URL(string: "https://www.r-own.com/privacy-policy")!) {
                    HStack{
                        Image("SidebarAccountDataPolicies")
                            .resizable()
                            .scaledToFit()
                            .frame(width: UIScreen.screenHeight/50, height: UIScreen.screenHeight/50)
                            .padding(.leading, UIScreen.screenWidth/20)
                            .padding(.trailing, UIScreen.screenWidth/60)
                        Text("Account Data Policies")
                            .foregroundColor(.black)
                            .font(.subheadline)
                            .fontWeight(.bold)
                        Spacer()
                        
                    }
                }
                .frame(width: UIScreen.screenWidth/1.6, height: UIScreen.screenHeight/30)
                .padding(.vertical, 7)
                .background(lightGreyUi)
                .cornerRadius(7)
                .clipped()
                .shadow(color: .black.opacity(0.2), radius: 5, x: 2, y: 2)
            }
            
            }
        }
        }
    }

struct SideBarTileHnSDropDownView: View {
    
    @StateObject var globalVM: GlobalViewModel
    @State var showDropDown: Bool = false
    @State var navigateToChatWithUsView: Bool = false
    @State var navigateToDropUsAMailView: Bool = false
    @State var navigateToFAQsView: Bool = false
    @State var navigateToSpottedABugView: Bool = false
    
    @State var isShowingMailView = false
    
    var body: some View {
        VStack{
            Button(action: {
                withAnimation{
                    showDropDown.toggle()
                }
            }, label: {
                HStack{
                    Image("SidebarHelpnSupport")
                        .resizable()
                        .scaledToFit()
                        .frame(width: UIScreen.screenHeight/50, height: UIScreen.screenHeight/50)
                        .padding(.leading, UIScreen.screenWidth/20)
                        .padding(.trailing, UIScreen.screenWidth/60)
                    Text("Help & Support")
                        .foregroundColor(.black)
                        .font(.subheadline)
                        .fontWeight(.bold)
                    Spacer()
                    if showDropDown{
                        Image(systemName: "chevron.down")
                            .resizable()
                            .scaledToFit()
                            .foregroundColor(.black)
                            .frame(width: UIScreen.screenHeight/50, height: UIScreen.screenHeight/60)
                            .padding(.trailing, 20)
                    }else{
                        Image(systemName: "chevron.right")
                            .resizable()
                            .scaledToFit()
                            .foregroundColor(.black)
                            .frame(width: UIScreen.screenHeight/50, height: UIScreen.screenHeight/60)
                            .padding(.trailing, 20)
                    }
                }
            })
            .frame(width: UIScreen.screenWidth/1.4, height: UIScreen.screenHeight/30)
            .padding(.vertical, 7)
            .background(.white)
            .cornerRadius(7)
            .clipped()
            .shadow(color: .black.opacity(0.2), radius: 5, x: 2, y: 2)
            
            if showDropDown{
                //        Button(action: {
                //            navigateToChatWithUsView.toggle()
                //        }, label: {
                //            HStack{
                //                Image("SidebarChatWithUs")
                //                    .resizable()
                //                    .scaledToFit()
                //                    .frame(width: UIScreen.screenHeight/50, height: UIScreen.screenHeight/50)
                //                    .padding(.leading, UIScreen.screenWidth/20)
                //                    .padding(.trailing, UIScreen.screenWidth/60)
                //                Text("Chat With Us")
                //                    .foregroundColor(.black)
                ////                                    .font(.system(size: 19))
                //                    .fontWeight(.bold)
                //                Spacer()
                //
                //            }
                //        })
                //        .frame(width: UIScreen.screenWidth/1.6, height: UIScreen.screenHeight/30)
                //        .padding(.vertical, 7)
                //        .background(lightGreyUi)
                //        .cornerRadius(7)
                //        .clipped()
                //        .shadow(color: Color.black.opacity(0.5), radius: 5)
                //        .navigationDestination(isPresented: $navigateToChatWithUsView, destination: {
                //            ChatWithUsView()
                //        })
                
                Button(action: {
                    isShowingMailView.toggle()
                }, label: {
                    HStack{
                        Image("SidebarDropUsAMail")
                            .resizable()
                            .scaledToFit()
                            .frame(width: UIScreen.screenHeight/50, height: UIScreen.screenHeight/50)
                            .padding(.leading, UIScreen.screenWidth/20)
                            .padding(.trailing, UIScreen.screenWidth/60)
                        Text("Drop Us A Mail")
                            .foregroundColor(.black)
                            .font(.subheadline)
                            .fontWeight(.bold)
                        Spacer()
                        
                    }
                })
                .frame(width: UIScreen.screenWidth/1.6, height: UIScreen.screenHeight/30)
                .padding(.vertical, 7)
                .background(lightGreyUi)
                .cornerRadius(7)
                .clipped()
                .shadow(color: .black.opacity(0.2), radius: 5, x: 2, y: 2)
                .sheet(isPresented: $isShowingMailView) {
                    MailView(isShowingMailView: $isShowingMailView,
                             recipient: "rown@retvensservices.com",
                             subject: "", body: "")
                }
                
                
                
                Button(action: {
                    navigateToFAQsView = true
                }, label: {
                    HStack{
                        Image("SidebarFAQs")
                            .resizable()
                            .scaledToFit()
                            .frame(width: UIScreen.screenHeight/50, height: UIScreen.screenHeight/50)
                            .padding(.leading, UIScreen.screenWidth/20)
                            .padding(.trailing, UIScreen.screenWidth/60)
                        Text("FAQ's")
                            .foregroundColor(.black)
                            .font(.subheadline)
                            .fontWeight(.bold)
                        Spacer()
                        
                    }
                })
                .frame(width: UIScreen.screenWidth/1.6, height: UIScreen.screenHeight/30)
                .padding(.vertical, 7)
                .background(lightGreyUi)
                .cornerRadius(7)
                .clipped()
                .shadow(color: .black.opacity(0.2), radius: 5, x: 2, y: 2)
                .navigationDestination(isPresented: $navigateToFAQsView, destination: {
                    FAQsView(globalVM: globalVM)
                })
                NavigationLink(isActive: $navigateToFAQsView, destination: {
                    FAQsView(globalVM: globalVM)
                }, label: {
                    Text("")
                })
                
                Button(action: {
                    navigateToSpottedABugView = true
                }, label: {
                    HStack{
                        Image("SidebarSpottedABug")
                            .resizable()
                            .scaledToFit()
                            .frame(width: UIScreen.screenHeight/50, height: UIScreen.screenHeight/50)
                            .padding(.leading, UIScreen.screenWidth/20)
                            .padding(.trailing, UIScreen.screenWidth/60)
                        Text("Spotted A Bug ?")
                            .foregroundColor(.black)
                            .font(.subheadline)
                            .fontWeight(.bold)
                        Spacer()
                        
                    }
                })
                .frame(width: UIScreen.screenWidth/1.6, height: UIScreen.screenHeight/30)
                .padding(.vertical, 7)
                .background(lightGreyUi)
                .cornerRadius(7)
                .clipped()
                .shadow(color: .black.opacity(0.2), radius: 5, x: 2, y: 2)
                .navigationDestination(isPresented: $navigateToSpottedABugView, destination: {
                    SpottedABugView(globalVM: globalVM)
                })
                NavigationLink(isActive: $navigateToSpottedABugView, destination: {
                    SpottedABugView(globalVM: globalVM)
                }, label: {
                    Text("")
                })
            }
        }
        .onAppear{
            navigateToFAQsView = false
            navigateToSpottedABugView = false
        }
    }
}
