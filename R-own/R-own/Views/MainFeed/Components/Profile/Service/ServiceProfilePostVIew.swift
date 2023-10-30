//
//  ServicePostVIew.swift
//  R-own
//
//  Created by Aman Sharma on 17/05/23.
//

import SwiftUI
import AlertToast

struct ServiceProfilePostVIew: View {
    @State var loginData: LoginViewModel
    @State var services: ServiceByIDModel
    @State var role: String
    @State var mainUser: Bool
    
    @State var editServiceBottomSheet: Bool = false
    @State var deleteServiceBottomSheet: Bool = false
    @State var addNewServiceBottomSheet: Bool = false
    
    @State var servicePrice: String = ""
    
    @StateObject var vendorService = VendorProfileService()
    @State var alertDeleted: Bool = false
    @State var alertFailed: Bool = false
    @FocusState private var isKeyboardShowing: Bool
    @StateObject var globalVM: GlobalViewModel
    
    @State var count: Int
    
    var body: some View {
        VStack{
            HStack{
                ProfilePictureView(profilePic: services.vendorImage, verified: false, height: UIScreen.screenHeight/10, width: UIScreen.screenHeight/10)
                    .frame(width: UIScreen.screenWidth/4)
                VStack{
                    HStack{
                        VStack(alignment: .leading){
                            Text(services.vendorName)
                                .font(.body)
                                .fontWeight(.bold)
                            Text("@\(services.userName)")
                                .font(.body)
                                .fontWeight(.thin)
                        }
                        Spacer()
                        
                        if mainUser{
                            HStack{
                                
                                if loginData.isHiddenKPI{
                                    Button(action: {
                                        editServiceBottomSheet.toggle()
                                    }, label: {
                                        HStack{
                                            Image("EditPenIcon")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: UIScreen.screenHeight/80, height: UIScreen.screenHeight/80)
                                            Text("Edit")
                                                .font(.body)
                                                .foregroundColor(.black)
                                        }
                                        .padding(7)
                                        .overlay{
                                            RoundedRectangle(cornerRadius: 20)
                                                .stroke(Color.black, lineWidth: 1)
                                        }
                                    })
                                    .sheet(isPresented: $editServiceBottomSheet) {
                                        VStack{
                                            Text("Please state the estimated price for your service")
                                                .font(.body)
                                                .fontWeight(.bold)
                                                .padding(.vertical, UIScreen.screenHeight/70)
                                                .multilineTextAlignment(.center)
                                            
                                            VStack{
                                                
                                                TextField("Estimated Price", text: $servicePrice)
                                                    .padding()
                                                    .cornerRadius(7)
                                                    .overlay{
                                                        // apply a rounded border
                                                        RoundedRectangle(cornerRadius: 6)
                                                            .stroke(.gray, lineWidth: 0.5)
                                                        Text("Enter your service price")
                                                            .font(.body)
                                                            .foregroundColor(.black)
                                                            .background(Color.white)
                                                            .padding(.horizontal,5)
                                                            .fontWeight(.ultraLight)
                                                            .offset(x: -UIScreen.screenWidth/3.4, y: -27)
                                                        
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
                                                    .padding(.vertical, UIScreen.screenHeight/50)
                                                    .padding(.horizontal, UIScreen.screenWidth/30)
                                                
                                            }
                                            
                                            Button(action: {
                                                vendorService.updateServicePrice(loginData: loginData, vendorServiceID: services.vendorServiceID, updatedPrice: servicePrice, displayStatus: "1")
                                                servicePrice = ""
                                                editServiceBottomSheet.toggle()
                                            }, label: {
                                                Text("Save")
                                                    .font(.body)
                                                    .fontWeight(.thin)
                                                    .foregroundColor(.black)
                                                    .frame(width: UIScreen.screenWidth/2, height: UIScreen.screenHeight/35)
                                                    .background(greenUi)
                                            })
                                            Spacer()
                                        }
                                        .presentationDetents([.medium, .large])
                                    }
                                }
                                Button(action: {
                                    deleteServiceBottomSheet.toggle()
                                }, label: {
                                    Image("DeleteIcon")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: UIScreen.screenHeight/60, height: UIScreen.screenHeight/60)
                                })
                                .sheet(isPresented: $deleteServiceBottomSheet) {
                                    VStack{
                                        Text("Do you really want to delete this service?")
                                            .font(.body)
                                            .fontWeight(.bold)
                                            .padding(.vertical, UIScreen.screenHeight/70)
                                            .multilineTextAlignment(.center)
                                        
                                        VStack{
                                            Button(action: {
                                                Task {
                                                    let result = await vendorService.deleteVendorService(vendorServiceID: services.vendorServiceID)
                                                    switch result {
                                                    case .success(let message):
                                                        print("API call successful: \(message)")
                                                        globalVM.vendorServicesListByID.remove(at: count)
                                                        deleteServiceBottomSheet.toggle()
                                                        alertDeleted = true
                                                    case .failure(let error):
                                                        print("API call failed with error: \(error)")
                                                        alertFailed = true
                                                        deleteServiceBottomSheet.toggle()
                                                    }
                                                }

                                                
                                            }, label: {
                                                Text("Yes, I'm sure")
                                                    .font(.body)
                                                    .fontWeight(.medium)
                                                    .foregroundColor(.black)
                                                    .frame(width: UIScreen.screenWidth/2, height: UIScreen.screenHeight/30)
                                                    .background(greenUi)
                                                    .cornerRadius(10)
                                            })
                                            
                                            Button(action: {
                                                deleteServiceBottomSheet.toggle()
                                            }, label: {
                                                Text("No")
                                                    .font(.body)
                                                    .fontWeight(.medium)
                                                    .foregroundColor(greenUi)
                                                    .frame(width: UIScreen.screenWidth/2, height: UIScreen.screenHeight/30)
                                                    .background(jobsDarkBlue)
                                                    .cornerRadius(10)
                                            })
                                            
                                            
                                        }
                                        
                                        Spacer()
                                    }
                                    .presentationDetents([.medium, .large])
                                }
                            }
                        } 
                    }
                    HStack{
                        VStack(alignment: .leading){
                            HStack{
                                Image("SettingIcon")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: UIScreen.screenHeight/80, height: UIScreen.screenHeight/80)
                                Text(services.serviceName)
                                    .font(.body)
                                    .fontWeight(.bold)
                                    .foregroundColor(.black)
                            }
                            .padding(5)
                            .overlay(
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(Color.black, lineWidth: 1)
                            )
                            .padding(3)
                            HStack{
                                Image("MapIcon")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: UIScreen.screenHeight/80, height: UIScreen.screenHeight/80)
                                Text(services.location)
                                    .font(.body)
                                    .fontWeight(.bold)
                            }
                            .padding(5)
                            .overlay(
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(Color.black, lineWidth: 1)
                            )
                        }
                        Spacer()
                        if loginData.isHiddenKPI{
                            if services.vendorServicePrice == "" {
                                Text("Price not decided")
                                    .font(.body)
                                    .fontWeight(.bold)
                                    .foregroundColor(greenUi)
                                    .padding(.horizontal, UIScreen.screenWidth/40)
                                    .padding(.vertical, UIScreen.screenHeight/80)
                                    .background(jobsDarkBlue)
                                    .cornerRadius(15)
                            } else {
                                Text("\(services.vendorServicePrice) INR")
                                    .font(.body)
                                    .fontWeight(.bold)
                                    .foregroundColor(greenUi)
                                    .padding(.horizontal, UIScreen.screenWidth/40)
                                    .padding(.vertical, UIScreen.screenHeight/80)
                                    .background(jobsDarkBlue)
                                    .cornerRadius(15)
                            }
                        }
                    }
                }
                .padding(.horizontal, UIScreen.screenWidth/20)
                .frame(height: UIScreen.screenHeight/8)
                .background(.white)
            }
        }
        .onChange(of: globalVM.keyboardVisibility) { newValue in
            
                            isKeyboardShowing = false
                            globalVM.keyboardVisibility = false
        }
        .padding(.vertical, UIScreen.screenHeight/70)
        .background(.white)
        .cornerRadius(15)
        .clipped()
        .shadow(color: .black.opacity(0.2), radius: 5, x: 2, y: 2)
        .padding(.vertical, UIScreen.screenHeight/70)
        .padding(.horizontal, UIScreen.screenWidth/30)
        .frame(width: UIScreen.screenWidth)
        .toast(isPresenting: $alertFailed, duration: 2, tapToDismiss: true){
            AlertToast( type: .systemImage("exclamationmark.triangle.fill", .red), title: "Try Again")
        }
        .toast(isPresenting: $alertDeleted, duration: 2, tapToDismiss: true){
            AlertToast( type: .systemImage("checkmark.square.fill", greenUi), title: "Deleted")
        }
    }
}

//struct ServicePostVIew_Previews: PreviewProvider {
//    static var previews: some View {
//        ServicePostVIew()
//    }
//}
