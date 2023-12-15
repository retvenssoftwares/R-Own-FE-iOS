//
//  VisibilitySettingCommunityView.swift
//  R-own
//
//  Created by Aman Sharma on 04/05/23.
//

import SwiftUI
import AlertToast

struct VisibilitySettingCommunityView: View {
    
    //keyboard var
    @FocusState private var isKeyboardShowing: Bool
    
    //naviagtion var
    @State var navigateToCommunityLocation: Bool = false
    
    //Login Var
    @StateObject var loginData: LoginViewModel
    
    //Community Var
    @StateObject var communityVM: CommunityViewModel
    
    //Mesibo Var
    @StateObject var mesiboVM: MesiboViewModel
    
    @StateObject var globalVM: GlobalViewModel
    @StateObject var profileVM: ProfileViewModel
    
    
    @State var communityStatusNotSelected: Bool = false
    
    @Environment(\.dismiss) private var dismiss
    
    
    var body: some View {
        NavigationStack{
            //topnav
            VStack{
                HStack{
                    //BackButton
                    
                    //Text
                    Spacer()
                    Text("Create Community")
                        .foregroundColor(.black)
                        .font(.body)
                        .fontWeight(.bold)
                        .frame(alignment: .leading)
                    Spacer()
                }
                .padding(.vertical, UIScreen.screenHeight/50)
                .overlay{
                    HStack{
                        
                        Button(action: {
                            dismiss()
                        }, label: {
                            Circle()
                                .strokeBorder(Color.black,lineWidth: 1)
                                .background(Circle().foregroundColor(Color.white))
                                .frame(width: UIScreen.screenHeight/40, height: UIScreen.screenHeight/40)
                                .overlay{
                                    Image(systemName: "arrow.left")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: UIScreen.screenHeight/60, height: UIScreen.screenHeight/60)
                                        .foregroundColor(.black)
                                }
                        })
                        .padding(.leading, UIScreen.screenWidth/20)
                        Spacer()
                    }
                }
                //headingnav
                ScrollView{
                    VStack{
                        Text("Visibility Setting for your community")
                            .foregroundColor(communityTextGreenColorUI)
                            .font(.headline)
                            .fontWeight(.bold)
                            .padding(.vertical, UIScreen.screenHeight/50)
                            .frame(alignment: .leading)
                            .frame(width: UIScreen.screenWidth)
                            .background(communityBGBlueColorUI)
                            .border(width: 1, edges: [.bottom], color: greenUi)
                            .cornerRadius(3, corners: .bottomLeft)
                            .cornerRadius(3, corners: .bottomRight)
                        
                        //image
                        Image("CommunityBG2")
                            .resizable()
                            .scaledToFit()
                            .frame(height: UIScreen.screenHeight/3)
                        
                        //TextHeading
                        Text("Who can be a part of your community?")
                            .font(.body)
                            .fontWeight(.bold)
                            .foregroundColor(greenUi)
                            .padding(.vertical, UIScreen.screenHeight/50)
                        
                        //CommunityButton
                        HStack{
                            Spacer()
                            Button(action: {
                                communityVM.communityType = "Closed Community"
                            }, label: {
                                if communityVM.communityType == "Closed Community" {
                                    VStack{
                                        Text("Closed Community")
                                            .font(.body)
                                            .fontWeight(.semibold)
                                            .foregroundColor(communityTextGreenColorUI)
                                        Text("Only you would be able to let the person in your community")
                                            .font(.footnote)
                                            .fontWeight(.thin)
                                            .foregroundColor(communityTextGreenColorUI)
                                    }
                                    .frame(width: UIScreen.screenWidth/1.2)
                                    .padding(.horizontal, UIScreen.screenHeight/50)
                                    .padding(.vertical, 10)
                                    .background(communityBGBlueColorUI)
                                    .cornerRadius(15)
                                } else {
                                    VStack{
                                        Text("Closed Community")
                                            .font(.body)
                                            .fontWeight(.semibold)
                                            .foregroundColor(communityTextGreenColorUI)
                                    }
                                    .frame(width: UIScreen.screenWidth/1.2)
                                    .padding(.horizontal, UIScreen.screenHeight/50)
                                    .padding(.vertical, 10)
                                    .background(communityTextGreyColorUI)
                                    .cornerRadius(15)
                                    
                                }
                                
                            })
                            Spacer()
                        }
                        
                        //CommunityButton
                        HStack{
                            Spacer()
                            Button(action: {
                                communityVM.communityType = "Open Community"
                            }, label: {
                                if communityVM.communityType == "Open Community" {
                                    VStack{
                                        Text("Open Community")
                                            .font(.body)
                                            .fontWeight(.semibold)
                                            .foregroundColor(communityTextGreenColorUI)
                                        Text("Anyone can request to join your community")
                                            .font(.footnote)
                                            .fontWeight(.thin)
                                            .foregroundColor(communityTextGreenColorUI)
                                    }
                                    .frame(width: UIScreen.screenWidth/1.2)
                                    .padding(.horizontal, UIScreen.screenHeight/50)
                                    .padding(.vertical, 10)
                                    .background(communityBGBlueColorUI)
                                    .cornerRadius(15)
                                } else {
                                    VStack{
                                        Text("Open Community")
                                            .font(.body)
                                            .fontWeight(.semibold)
                                            .foregroundColor(communityTextGreenColorUI)
                                    }
                                    .frame(width: UIScreen.screenWidth/1.2)
                                    .padding(.horizontal, UIScreen.screenHeight/50)
                                    .padding(.vertical, 10)
                                    .background(communityTextGreyColorUI)
                                    .cornerRadius(15)
                                }
                            })
                            Spacer()
                        }
                        //button
                        HStack{
                            Spacer()
                            Button(action: {
                                if communityVM.communityType == "" {
                                    communityStatusNotSelected = true
                                } else {
                                    navigateToCommunityLocation = true
                                }
                            }, label: {
                                Circle()
                                    .strokeBorder(Color.white,lineWidth: 1)
                                    .background(Circle().foregroundColor(Color.green))
                                    .frame(width: UIScreen.screenHeight/20, height: UIScreen.screenHeight/20)
                                    .overlay{
                                        Image(systemName: "arrow.right")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: UIScreen.screenHeight/60, height: UIScreen.screenHeight/60)
                                            .foregroundColor(.white)
                                    }
                            })
                            .padding(.trailing, UIScreen.screenWidth/30)
                            .navigationDestination(isPresented: $navigateToCommunityLocation, destination: {
                                CommunityLocationView(loginData: loginData, communityVM: communityVM, mesiboVM: mesiboVM, globalVM: globalVM, profileVM: profileVM)
                            })
                            NavigationLink(isActive: $navigateToCommunityLocation, destination: {
                                CommunityLocationView(loginData: loginData, communityVM: communityVM, mesiboVM: mesiboVM, globalVM: globalVM, profileVM: profileVM)
                            }, label: {
                                Text("")
                            })
                        }
                    }
                }
                Spacer()
            }
            .toast(isPresenting: $communityStatusNotSelected, duration: 2, tapToDismiss: true){
                AlertToast( type: .systemImage("exclamationmark.triangle.fill", .red), title: "Select your community status", subTitle: (""))
            }
            //Location
            //AutoDetect
            //NextButton
        }
        .onChange(of: globalVM.keyboardVisibility) { newValue in
            
                            isKeyboardShowing = false
                            globalVM.keyboardVisibility = false
        }
        .navigationBarBackButtonHidden()
        .onAppear{
            navigateToCommunityLocation = false
        }
    }
}

//struct VisibilitySettingCommunityView_Previews: PreviewProvider {
//    static var previews: some View {
//        VisibilitySettingCommunityView()
//    }
//}
