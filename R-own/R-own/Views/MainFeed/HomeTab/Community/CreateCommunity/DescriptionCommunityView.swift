//
//  DescriptionCommunityView.swift
//  R-own
//
//  Created by Aman Sharma on 04/05/23.
//

import SwiftUI
import AlertToast

struct DescriptionCommunityView: View {
    
    //keyboard var
    @FocusState private var isKeyboardShowing: Bool
    
    //naviagtion var
    @State var navigateToVisibilitySetting: Bool = false
    
    //Login Var
    @StateObject var loginData: LoginViewModel
    
    //Community Var
    @StateObject var communityVM: CommunityViewModel
    
    //Mesibo Var
    @StateObject var mesiboVM: MesiboViewModel
    @StateObject var globalVM: GlobalViewModel
    @StateObject var profileVM: ProfileViewModel
    
    @State var nameNotPresent: Bool = false
    @State var descriptionNotPresent: Bool = false
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack{
            VStack{
                //topnav
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
                .padding(.vertical, UIScreen.screenHeight/70)
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
                        
                        Text("Name and describe your community")
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
                        Image("CommunityBG1")
                            .resizable()
                            .scaledToFit()
                            .frame(height: UIScreen.screenHeight/3)
                        
                        //text field (community name)
                        
                        TextField("Enter Name", text: $communityVM.communityName)
                            .padding()
                            .cornerRadius(7)
                            .overlay{
                                // apply a rounded border
                                RoundedRectangle(cornerRadius: 6)
                                    .stroke(.gray, lineWidth: 0.5)
                            }
                            .overlay{
                                VStack{
                                    HStack{
                                        Text("Community Name")
                                            .font(.footnote)
                                            .background(Color.white)
                                            .padding(.horizontal,5)
                                            .fontWeight(.ultraLight)
                                            .offset(x: UIScreen.screenWidth/30, y: -10)
                                        Spacer()
                                    }
                                    Spacer()
                                }
                            }
                            .focused($isKeyboardShowing)
                            .padding(.vertical, UIScreen.screenHeight/60)
                            .padding(.horizontal, UIScreen.screenWidth/40)
                        //text field (description)
                        TextField("Description", text: $communityVM.communityDescription, axis: .vertical)
                            .lineLimit(5...10)
                            .padding()
                            .cornerRadius(7)
                            .overlay{
                                // apply a rounded border
                                RoundedRectangle(cornerRadius: 6)
                                    .stroke(.gray, lineWidth: 0.5)
                            }
                            .overlay{
                                VStack{
                                    HStack {
                                        Text("Community Description")
                                            .font(.footnote)
                                            .background(Color.white)
                                            .padding(.horizontal,5)
                                            .fontWeight(.ultraLight)
                                            .offset(x: UIScreen.screenWidth/30, y: -10)
                                        Spacer()
                                    }
                                    Spacer()
                                }
                            }
                            .focused($isKeyboardShowing)
                            .toolbar {
                                ToolbarItemGroup(placement: .keyboard) {
                                    Spacer()
                                    Button("Done") {
                                        isKeyboardShowing = false
                                        globalVM.keyboardVisibility = false
                                    }
                                }
                            }
                            .padding(.vertical, UIScreen.screenHeight/60)
                            .padding(.horizontal, UIScreen.screenWidth/40)
                        //button
                        HStack{
                            Spacer()
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
                                .onTapGesture {
                                    if communityVM.communityName == "" {
                                        nameNotPresent.toggle()
                                    } else if communityVM.communityDescription == "" {
                                        descriptionNotPresent.toggle()
                                    } else {
                                        navigateToVisibilitySetting.toggle()
                                    }
                                }
                                .padding(.trailing, UIScreen.screenWidth/30)
                                .navigationDestination(isPresented: $navigateToVisibilitySetting, destination: {VisibilitySettingCommunityView(loginData: loginData, communityVM: communityVM , mesiboVM: mesiboVM, globalVM: globalVM, profileVM: profileVM)})
                        }
                        
                    }
                }
                Spacer()
            }
            .toast(isPresenting: $nameNotPresent, duration: 2, tapToDismiss: true){
                AlertToast( type: .systemImage("exclamationmark.triangle.fill", .red), title: "Name id empty", subTitle: ("Enter your community name"))
            }
            .toast(isPresenting: $descriptionNotPresent, duration: 2, tapToDismiss: true){
                AlertToast( type: .systemImage("exclamationmark.triangle.fill", .red), title: "Description not found", subTitle: ("Enter your community description to proceed"))
            }
        }
        .onChange(of: globalVM.keyboardVisibility) { newValue in
            isKeyboardShowing = false
            globalVM.keyboardVisibility = false
        }
        .navigationBarBackButtonHidden()
    }
}

//struct DescriptionCommunityView_Previews: PreviewProvider {
//    static var previews: some View {
//        DescriptionCommunityView()
//    }
//}
