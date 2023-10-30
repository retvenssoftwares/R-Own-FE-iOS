//
//  EditCommunityDetailView.swift
//  R-own
//
//  Created by Aman Sharma on 29/06/23.
//

import SwiftUI
import Shimmer
import AlertToast

struct EditCommunityDetailView: View {
    
    @StateObject var globalVM: GlobalViewModel
    @StateObject var loginData: LoginViewModel
    @StateObject var communityVM: CommunityViewModel
    @StateObject var mesiboVM: MesiboViewModel
    
    @State var communityPic: String
    @State var communityName: String
    @State var communityDescription: String
    @State var groupID: String
    
    //Image Var
    @State private var showPicker: Bool = false
    @State private var croppedImage: UIImage?
    @State var imageNotSelected: Bool = false
    
    @StateObject var communityService = CommunityService()
    
    @FocusState private var isKeyboardShowing: Bool
    
    @State var updatedGroupInfo: Bool = false
    @State var alertFailed: Bool = false
    
    var body: some View {
        VStack{
            VStack{
                BasicNavbarView(navbarTitle: "Edit community details")
            }
            VStack{
                
//                VStack{
//                    Image("ProfilePicCircle")
//                        .overlay{
//                            if let croppedImage{
//                                Image(uiImage: croppedImage)
//                                    .resizable()
//                                    .scaledToFit()
//                                    .frame(width: 230, height: 230)
//                                    .clipShape(Circle())
//                                    .overlay{
//                                        Image("ProfilePicCamera")
//                                            .offset(x:80,y:80)
//                                            .onTapGesture {
//                                                showPicker.toggle()
//                                            }
//                                    }
//                            } else {
//                                if communityPic == "" {
//                                    Image("ProfilePicUser")
//                                        .resizable()
//                                        .scaledToFit()
//                                        .frame(width: 230, height: 230)
//                                        .clipShape(Circle())
//                                        .offset(y:8)
//                                        .overlay{
//                                            Image("ProfilePicCamera")
//                                                .offset(x:80,y:80)
//                                                .onTapGesture {
//                                                    showPicker.toggle()
//                                                }
//                                        }
//                                } else {
//                                    AsyncImage(url: URL(string: communityPic)) { image in
//                                        image
//                                            .resizable()
//                                            .scaledToFit()
//                                            .frame(width: 230, height: 230)
//                                            .clipShape(Circle())
//                                    } placeholder: {
//                                        Circle()
//                                            .fill(lightGreyUi)
//                                            .frame(width: 230, height: 230)
//                                            .shimmering(active: true)
//                                    }
//                                }
//                            }
//                        }
//                }
//                .padding(.vertical,40)
                
                EditFPPProfilePicView(loginData: loginData, globalVM: globalVM, newHotelLogo: $croppedImage, currentLogoURL: communityPic)
                    .padding(.vertical,40)
                
                TextField("Enter Name", text: $communityName)
                    .padding()
                    .cornerRadius(7)
                    .overlay {
                        
                        // apply a rounded border
                        RoundedRectangle(cornerRadius: 6)
                            .stroke(.gray, lineWidth: 0.5)
                    }
                    .overlay{
                        VStack{
                            HStack{
                                Text("Community Name")
                                    .font(.body)
                                    .background(Color.white)
                                    .padding(.horizontal,5)
                                    .fontWeight(.ultraLight)
                                    .offset(x: UIScreen.screenWidth/30, y: -27)
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
                //text field (description)
                
                TextField("Description", text: $communityDescription, axis: .vertical)
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
                            HStack{
                                Text("Community Description")
                                    .font(.body)
                                    .background(Color.white)
                                    .padding(.horizontal,5)
                                    .fontWeight(.ultraLight)
                                    .offset(x: UIScreen.screenWidth/30, y: -27)
                                Spacer()
                            }
                            Spacer()
                        }
                    }
                    .focused($isKeyboardShowing)
                    .padding(.vertical, UIScreen.screenHeight/60)
                    .padding(.horizontal, UIScreen.screenWidth/40)
            }
            Button(action: {
                Task {
                    communityService.updateGroupInfo(loginData: loginData, communityVM: communityVM, groupID: groupID, communityName: communityName, communityLocation: "", communityLat: "", communityLong: "", communityType: "", commuinityDescp: communityDescription, communityImage: croppedImage){ result in
                        switch result {
                        case .success(let message):
                            print("Update successful: \(message)")
                            mesiboVM.settings.name = communityName
                            mesiboVM.mProfile.getGroupProfile()?.setProperties(mesiboVM.settings)
                            updatedGroupInfo = true
                        case .failure(let error):
                            print("Update failed with error: \(error)")
                            alertFailed = true
                        }
                    }
                }
            }, label: {
                Text("Update Details")
                    .font(.body)
                    .fontWeight(.semibold)
                    .foregroundColor(greenUi)
                    .padding(.horizontal, UIScreen.screenWidth/40)
                    .padding(.vertical, UIScreen.screenHeight/60)
                    .background(jobsDarkBlue)
                    .cornerRadius(10)
                
            })
            Spacer()
        }
        .onChange(of: globalVM.keyboardVisibility) { newValue in
            
                            isKeyboardShowing = false
                            globalVM.keyboardVisibility = false
        }
        .toast(isPresenting: $updatedGroupInfo, duration: 2, tapToDismiss: true){
            AlertToast( type: .systemImage("checkmark.square.fill", greenUi), title: "Group Info Updated")
        }
        .toast(isPresenting: $alertFailed, duration: 2, tapToDismiss: true){
            AlertToast( type: .systemImage("exclamationmark.triangle.fill", .red), title: "Try Again")
        }
        .navigationBarBackButtonHidden()
    }
}

//struct EditCommunityDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        EditCommunityDetailView()
//    }
//}
