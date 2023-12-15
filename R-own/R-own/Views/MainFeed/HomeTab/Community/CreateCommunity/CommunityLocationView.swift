//
//  CommunityLocationView.swift
//  R-own
//
//  Created by Aman Sharma on 09/05/23.
//

import SwiftUI
import Combine
import AlertToast

struct CommunityLocationView: View {
    
    //naviagtion var
    @State var navigateToSelectMembers: Bool = false
    
    //Login Var
    @StateObject var loginData: LoginViewModel
    
    //Community Var
    @StateObject var communityVM: CommunityViewModel
    
    //Mesibo Var
    @StateObject var mesiboVM: MesiboViewModel
    @StateObject var globalVM: GlobalViewModel
    @FocusState private var isKeyboardShowing: Bool
    @StateObject var profileVM: ProfileViewModel
    
    //auto detect location
    @StateObject var deviceLocationService = DeviceLocationService.shared
    @State var tokens: Set<AnyCancellable> = []
    @State var coordinates: (lat: Double, lon: Double) = (0, 0)
    
    @State var navigateToCommunitySelectUserView: Bool = false
    
    @State var countryCode: String = ""
    @State var stateCode: String = ""
    @State var locationNotSelected: Bool = false
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack {
            ZStack {
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
                    
                    ScrollView{
                        VStack{
                            //headingnav
                            Text("Visibility Settings for your Community")
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
                            
                            //Text
                            Text("Where do want your community to be visible ?")
                                .foregroundColor(communityTextGreenColorUI)
                                .font(.body)
                                .fontWeight(.bold)
                                .multilineTextAlignment(.center)
                                .frame(width: UIScreen.screenWidth/2)
                                .padding(.top, UIScreen.screenHeight/40)
                            
                            VStack{
                                //Location Field=
                                
                                AutoFetchLocationTab(autoLocation: $communityVM.communityLocation, loginData: loginData, globalVM: globalVM, width: UIScreen.screenWidth/1.2)
                                
                            }
                            .padding(.vertical, UIScreen.screenHeight/60)
                            
                            
                            //button
                            HStack{
                                Spacer()
                                Button(action: {
                                    if communityVM.communityLocation == "" {
                                        locationNotSelected.toggle()
                                    } else {
                                        communityVM.communityLatitude = String(loginData.coordinates.latitude)
                                        communityVM.communityLongitude = String(loginData.coordinates.longitude)
                                        
                                        navigateToSelectMembers = true
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
                                .navigationDestination(isPresented: $navigateToSelectMembers, destination: {CommunitySelectUserView(loginData: loginData, communityVM: communityVM, mesiboVM: mesiboVM, globalVM: globalVM, profileVM: profileVM)})
                                NavigationLink(isActive: $navigateToSelectMembers, destination: {
                                    CommunitySelectUserView(loginData: loginData, communityVM: communityVM, mesiboVM: mesiboVM, globalVM: globalVM, profileVM: profileVM)
                                }, label: {
                                    Text("")
                                })
                            }
                        }
                    }
                    Spacer()
                }
                .padding(UIScreen.screenHeight/50)
                MainLocationBottomSheetView(loginData: loginData, globalVM: globalVM, location: $communityVM.communityLocation)
            }
            .toast(isPresenting: $locationNotSelected, duration: 2, tapToDismiss: true){
                AlertToast( type: .systemImage("exclamationmark.triangle.fill", .red), title: "Select location of your community", subTitle: (""))
            }
        }
        .onChange(of: globalVM.keyboardVisibility) { newValue in
            
                            isKeyboardShowing = false
                            globalVM.keyboardVisibility = false
        }
        .navigationBarBackButtonHidden()
        .onAppear{
            navigateToSelectMembers = false
        }
    }
}

//
//struct CommunityLocationView_Previews: PreviewProvider {
//    static var previews: some View {
//        CommunityLocationView()
//    }
//}
