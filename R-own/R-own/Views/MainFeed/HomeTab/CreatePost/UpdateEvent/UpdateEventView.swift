//
//  UpdateEventView.swift
//  R-own
//
//  Created by Aman Sharma on 10/05/23.
//

import SwiftUI

struct UpdateEventView: View {
    
    //Login Var
    @StateObject var loginData: LoginViewModel
    
    //Create Post Var
    @StateObject var locationVM = LocationViewModel()
    @StateObject var createPostVM: CreatePostViewModel
    @StateObject var profileVM: ProfileViewModel
    @StateObject var postService = PostsService()
    
    @State var navigateToUpdateEventPostView: Bool = false
    @State var globalVM: GlobalViewModel
    @State var countryCode: String = ""
    @State var stateCode: String = ""
    @State var eventID: String = ""
    
    @State var country: String = ""
    @State var state: String = ""
    @State var city: String = ""
    
    @FocusState private var isKeyboardShowing: Bool
    
    @State var canSeeAudienceName: String = ""
    @State var canCommentAudienceName: String = ""
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack{
            ZStack{
                VStack{
                    //nav
                    HStack{
                        Button(action: {
                            dismiss()
                        }, label: {
                            Image(systemName: "arrow.left.circle")
                                .resizable()
                                .scaledToFit()
                                .foregroundColor(.black)
                                .frame(width: UIScreen.screenHeight/50, height: UIScreen.screenHeight/50)
                        })
                        Spacer()
                    }
                    .padding(.horizontal, UIScreen.screenWidth/40)
                    .frame(width: UIScreen.screenWidth, height: UIScreen.screenHeight/15)
                    .background(.white)
                    .shadow(color: .black.opacity(0.2), radius: 5, x: 2, y: 2)
                    
                    //postview
                    HStack{
                        //profilepic
                        if loginData.mainUserProfilePic == "" {
                            Image("UserIcon")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: UIScreen.screenHeight/15, height: UIScreen.screenHeight/15)
                                .padding(.trailing, 10)
                        } else {
                            AsyncImage(url: URL(string: loginData.mainUserProfilePic)) { image in
                                image
                                    .resizable()
                                    .scaledToFit()
                            } placeholder: {
                                Color.purple.opacity(0.1)
                            }
                            .frame(width: UIScreen.screenHeight/15, height: UIScreen.screenHeight/15)
                            .clipShape(Circle())
                            .padding(.trailing, 10)
                        }
                        
                        Spacer()
                    }
                    .padding(.horizontal, UIScreen.screenWidth/40)
                    .padding(.vertical, UIScreen.screenHeight/20)
                    
                    Text("What do want to share today ?")
                        .font(.body)
                        .fontWeight(.regular)
                    
                    //location
                    VStack{
                        TextField("Enter your location", text: $createPostVM.postLocation)
                            .disabled(true)
                            .padding()
                            .cornerRadius(7)
                            .overlay{
                                // apply a rounded border
                                RoundedRectangle(cornerRadius: 6)
                                    .stroke(.gray, lineWidth: 0.5)
                                Text("Location")
                                    .font(.system( size: 14))
                                    .foregroundColor(.black)
                                    .background(Color.white)
                                    .padding(.horizontal,5)
                                    .fontWeight(.ultraLight)
                                    .offset(x: -UIScreen.screenWidth/3.2, y: -27)
                            }
                            .focused($isKeyboardShowing)
                            .padding(.vertical, UIScreen.screenHeight/50)
                            .padding(.horizontal, UIScreen.screenWidth/30)
                            .onTapGesture {
                                createPostVM.checkinLocationBottomSheet.toggle()
                            }
                    }
                    
                    //venue
                    VStack{
                        TextField("Enter your event", text: $createPostVM.postEvent)
                            .disabled(true)
                            .padding()
                            .cornerRadius(7)
                            .overlay{
                                // apply a rounded border
                                RoundedRectangle(cornerRadius: 6)
                                    .stroke(.gray, lineWidth: 0.5)
                                Text("What event are you going to ?")
                                    .font(.headline)
                                    .foregroundColor(.black)
                                    .background(Color.white)
                                    .padding(.horizontal,5)
                                    .fontWeight(.ultraLight)
                                    .offset(x: -UIScreen.screenWidth/3.2, y: -27)
                                
                            }
                            .focused($isKeyboardShowing)
                            .padding(.vertical, UIScreen.screenHeight/50)
                            .padding(.horizontal, UIScreen.screenWidth/30)
                            .onTapGesture {
                                postService.getEventListWhilePosting(globalVM: globalVM, createPostVM: createPostVM)
                                createPostVM.updateEventBottomSheet.toggle()
                            }
                    }
                    Button(action: {
                        navigateToUpdateEventPostView.toggle()
                    }, label: {
                        Text("Next")
                            .font(.body)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding(.horizontal, UIScreen.screenWidth/50)
                            .padding(.vertical, UIScreen.screenHeight/80)
                            .background(greenUi)
                            .cornerRadius(5)
                    })
                    .navigationDestination(isPresented: $navigateToUpdateEventPostView, destination: {
                        UpdateEventPostView(loginData: loginData, createPostVM: createPostVM, globalVM: globalVM, profileVM: profileVM)
                    })
                    Spacer()
                }
//                CheckinLocationBottomSheet(loginData: loginData, globalVM: globalVM, locationVM: locationVM, createPostVM: createPostVM, country: $country, state: $state, city: $city , countryCode: $countryCode, stateCode: $stateCode)
                UpdateEventBottomSheet(loginData: loginData, createPostVM: createPostVM, globalVM: globalVM)
                CountryBottomSheetView(loginData: loginData, globalVM: globalVM, country: $country, countryCode: $countryCode)
                StateBottomSheetView(loginData: loginData, globalVM: globalVM, state: $state, stateCode: $stateCode, countryCode: countryCode)
                CityBottomSheetView(loginData: loginData, globalVM: globalVM, city: $city, countryCode: countryCode, stateCode: stateCode)
            }
        }
        .onChange(of: globalVM.keyboardVisibility) { newValue in
            
                            isKeyboardShowing = false
                            globalVM.keyboardVisibility = false
        }
        .navigationBarBackButtonHidden()
    }
}

//struct UpdateEventView_Previews: PreviewProvider {
//    static var previews: some View {
//        UpdateEventView()
//    }
//}
