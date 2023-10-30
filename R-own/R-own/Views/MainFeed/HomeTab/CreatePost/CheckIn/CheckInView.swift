//
//  CheckInView.swift
//  R-own
//
//  Created by Aman Sharma on 10/05/23.
//

import SwiftUI
import AlertToast

struct CheckInView: View {
    
    //Login Var
    @StateObject var loginData: LoginViewModel
    @StateObject var globalVM = GlobalViewModel()
    @StateObject var locationVM = LocationViewModel()
    
    //Create Post Var
    @StateObject var createPostVM: CreatePostViewModel
    
    @State var navigateToCheckinPostView: Bool = false
    
    
    @State var canSeeAudienceName: String = ""
    @State var canCommentAudienceName: String = ""
    @StateObject var venueService = HotelService()
    
    @State var country: String = ""
    @State var state: String = ""
    @State var city: String = ""
    @State var countryCode: String = ""
    @State var stateCode: String = ""
    
    @State var alertNoHotel: Bool = false
    
    
    @Environment(\.dismiss) private var dismiss
    
    @State private var currentUrl: URL?
    
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
                                .frame(width: UIScreen.screenHeight/40, height: UIScreen.screenHeight/40)
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
                        ProfilePictureView(profilePic: loginData.mainUserProfilePic, verified: false, height: UIScreen.screenHeight/15, width: UIScreen.screenHeight/15)
                        
                        //profile
                        VStack(alignment: .leading){
                            Text(loginData.mainUserFullName)
                                .font(.headline)
                                .fontWeight(.bold)
                        }
                        Spacer()
                    }
                    .padding(.horizontal, UIScreen.screenWidth/40)
                    .padding(.vertical, UIScreen.screenHeight/20)
                    
                    Text("Where are you checking-in ?")
                        .font(.headline)
                        .fontWeight(.regular)
                    
                    
                    //venue
                    VStack{
                        TextField("Enter your venue", text: $createPostVM.checkinHotelName)
                            .disabled(true)
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
                                        Text("Venue")
                                            .font(.body)
                                            .foregroundColor(.black)
                                            .background(Color.white)
                                            .padding(.horizontal,5)
                                            .fontWeight(.ultraLight)
                                            .offset(x: UIScreen.screenWidth/40, y: -UIScreen.screenHeight/100)
                                        Spacer()
                                    }
                                    Spacer()
                                }
                                
                            }
                            .padding(.vertical, UIScreen.screenHeight/50)
                            .padding(.horizontal, UIScreen.screenWidth/30)
                            .onTapGesture {
                                createPostVM.venuePostBottomSheet.toggle()
                            }
                    }
                    Button(action: {
                        if createPostVM.checkinHotelID != "" {
                            navigateToCheckinPostView.toggle()
                        } else {
                            alertNoHotel = true
                        }
                    }, label: {
                        Text("Next")
                            .font(.body)
                            .fontWeight(.bold)
                            .foregroundColor(jobsDarkBlue)
                            .padding(.horizontal, UIScreen.screenWidth/10)
                            .padding(.vertical, UIScreen.screenHeight/80)
                            .background(greenUi)
                            .cornerRadius(5)
                    })
                    .navigationDestination(isPresented: $navigateToCheckinPostView, destination: {
                        CheckInPostView(loginData: loginData, createPostVM: createPostVM, globalVM: globalVM)
                    })
                    Spacer()
                }
                CheckVenueBottomSheet(loginData: loginData, createPostVM: createPostVM, globalVM: globalVM)
            }
            .onAppear{
                createPostVM.checkinHotelID = ""
                createPostVM.checkinHotelLogo = ""
                createPostVM.checkinHotelName = ""
                createPostVM.checkinHotelRating = ""
                createPostVM.checkinHotelAddress = ""
                createPostVM.checkinHotelCoverPic = ""
            }
            .toast(isPresenting: $alertNoHotel, duration: 2, tapToDismiss: true){
                AlertToast( type: .systemImage("exclamationmark.triangle.fill", .red), title: "Hotel not selected", subTitle: ("Select a hotel to post"))
            }
        }
        .navigationBarBackButtonHidden()
        .onAppear{
        }
    }
}

//struct CheckInView_Previews: PreviewProvider {
//    static var previews: some View {
//        CheckInView()
//    }
//}
