//
//  ServiceProfileListView.swift
//  R-own
//
//  Created by Aman Sharma on 17/05/23.
//

import SwiftUI

struct ServiceProfileListView: View {
    
    @StateObject var loginData: LoginViewModel
    @StateObject var globalVM: GlobalViewModel
    @State var role: String
    @State var mainUser: Bool
    
    
    @State var openAddServiceBS: Bool = false
    @State var isLoading: Bool = false
    
    @State var serviceSearch: String = ""
    
    @FocusState private var isKeyboardShowing: Bool
    
    @StateObject var vendorPCS = VendorUserProfileCompletionService()
    
    var filteredServices: [VendorService] {
        if serviceSearch.isEmpty {
            return globalVM.vendorServicesList
        } else {
            return globalVM.vendorServicesList.filter { $0.serviceName?.localizedCaseInsensitiveContains(serviceSearch) ?? false }
        }
    }
    
    @StateObject var vendorProfileService = VendorProfileService()
    
    var body: some View {
        ScrollView{
            VStack{
                if globalVM.vendorServicesListByID.count > 0 {
                    VStack{
                        ForEach(0..<globalVM.vendorServicesListByID.count, id: \.self){ count in
                            HStack{
                                Spacer()
                                ServiceProfilePostVIew(loginData: loginData, services: globalVM.vendorServicesListByID[count], role: role, mainUser: mainUser, globalVM: globalVM, count: count-1)
                                Spacer()
                            }
                        }
                        if mainUser {
                            Button(action: {
                                openAddServiceBS = true
                            }, label: {
                                Text("Add Service")
                                    .font(.body)
                                    .fontWeight(.light)
                                    .foregroundColor(.black)
                                    .padding(.horizontal, UIScreen.screenWidth/30)
                                    .padding(.vertical, UIScreen.screenHeight/60)
                                    .background(greenUi)
                                    .cornerRadius(10)
                                    .padding()
                            })
                            .sheet(isPresented: $openAddServiceBS, content: {
                                VStack{
                                    HStack{
                                        Text("Select your brand services?")
                                            .foregroundColor(.black)
                                            .font(.body)
                                            .fontWeight(.bold)
                                            .multilineTextAlignment(.center)
                                            .padding(.top,30)
                                        Spacer()
                                        VStack(spacing: 5){
                                            Button(action: {
                                                for i in 0..<globalVM.selectedVendorServicesList.count {
                                                    let serviceName = globalVM.selectedVendorServicesList[i]
                                                    Task{
                                                        await vendorPCS.updateVendorService(loginData: loginData, serviceID: serviceName)
                                                        
                                                    }
                                                }
                                            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0){
                                                vendorProfileService.getVendorServicesByID(loginData: loginData, globalVM: globalVM, userID: loginData.mainUserID)
                                            }
                                            openAddServiceBS = false
                                        }, label: {
                                                Text("Done")
                                                    .foregroundColor(.black)
                                                    .font(.body)
                                                    .fontWeight(.semibold)
                                                    .multilineTextAlignment(.center)
                                                    .padding(.top,30)
                                            })
                                            
                                            Button(action: {
                                                globalVM.selectedVendorServicesList = [String]()
                                            }, label: {
                                                Text("Reset")
                                                    .foregroundColor(.black)
                                                    .font(.body)
                                                    .fontWeight(.semibold)
                                                    .multilineTextAlignment(.center)
                                                    .padding(.top,30)
                                            })
                                        }
                                            
                                    }
                                    .padding(.horizontal, UIScreen.screenWidth/30)
                                    HStack{
                                        Text("Select your preferd services -")
                                            .foregroundColor(.black)
                                            .font(.body)
                                            .fontWeight(.bold)
                                            .multilineTextAlignment(.center)
                                            .padding(.top,30)
                                        Spacer()
                                    }
                                    .padding(.horizontal, UIScreen.screenWidth/30)
                                    TextField("Search Service", text: $serviceSearch)
                                        .font(.system(size: 14))
                                        .frame(width: UIScreen.screenWidth/1.2)
                                        .overlay(alignment: .trailing, content: {
                                            Image(systemName: "magnifyingglass")
                                        })
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
                                        .padding()
                                        .border(.black.opacity(0.5))
                                    
                                    
                                    //Location Array
                                    ScrollView{
                                        VStack(alignment: .leading){
                                            if isLoading {
                                                VStack {
                                                    ForEach(filteredServices, id: \.self){ service in
                                                        BrandServiceTab(globalVM: globalVM, service: service, loginData: loginData)
                                                    }
                                                }
                                            } else {
                                                Spacer()
                                                ProgressView()
                                                Spacer()
                                            }
                                        }
                                    }
                                }
                                .padding(.horizontal, UIScreen.screenWidth/8)
                                .frame(width: UIScreen.screenWidth)
                                .onAppear{
                                    Task {
                                        isLoading = false
                                        globalVM.vendorServicesList = [VendorService]()
                                        let res = await vendorPCS.getServicesList(globalVM: globalVM)
                                        if res == "Success" {
                                            isLoading = true
                                        } else {
                                            let res = await vendorPCS.getServicesList(globalVM: globalVM)
                                            if res == "Success" {
                                                isLoading = true
                                            } else {
                                                isLoading = false
                                            }
                                        }
                                    }
                                }
                            })
                        }
                        Spacer(minLength: UIScreen.screenHeight/10)
                    }
                } else {
                    if mainUser {
                        Image("NoPostScreen")
                            .resizable()
                            .scaledToFit()
                            .frame(width: UIScreen.screenWidth/1.5, height: UIScreen.screenHeight/2.5)
                            .overlay{
                                Text("Complete your profile to add services.")
                                    .font(.body)
                                    .frame(width: UIScreen.screenWidth/4)
                                    .fontWeight(.bold)
                                    .foregroundColor(greenUi)
                                    .multilineTextAlignment(.leading)
                                    .offset(x: UIScreen.screenWidth/12, y: -UIScreen.screenHeight/20)
                            }
                    } else {
                            if role == "Hotelier" {
                                Image("NoPostScreen")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: UIScreen.screenWidth/1.5, height: UIScreen.screenHeight/2.5)
                                        .overlay{
                                            Text("\(globalVM.getNormalProfileHeader.data.profile.fullName) have not posted any services yet")
                                                .font(.body)
                                                .frame(width: UIScreen.screenWidth/4)
                                                .fontWeight(.bold)
                                                .foregroundColor(greenUi)
                                                .multilineTextAlignment(.leading)
                                                .offset(x: UIScreen.screenWidth/12, y: -UIScreen.screenHeight/20)
                                        }
                            } else if role == "Business Vendor / Freelancer" {
                                Image("NoPostScreen")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: UIScreen.screenWidth/1.5, height: UIScreen.screenHeight/2.5)
                                        .overlay{
                                            Text("\(globalVM.getVendorProfileHeader.roleDetails.fullName) have not posted any services yet")
                                                .font(.body)
                                                .frame(width: UIScreen.screenWidth/4)
                                                .fontWeight(.bold)
                                                .foregroundColor(greenUi)
                                                .multilineTextAlignment(.leading)
                                                .offset(x: UIScreen.screenWidth/12, y: -UIScreen.screenHeight/20)
                                        }
                            } else if role == "Hotel Owner" {
                                Image("NoPostScreen")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: UIScreen.screenWidth/1.5, height: UIScreen.screenHeight/2.5)
                                        .overlay{
                                            Text("\(globalVM.getHotelOwnerProfileHeader.profiledata.fullName) have not posted any services yet")
                                                .font(.body)
                                                .frame(width: UIScreen.screenWidth/4)
                                                .fontWeight(.bold)
                                                .foregroundColor(greenUi)
                                                .multilineTextAlignment(.leading)
                                                .offset(x: UIScreen.screenWidth/12, y: -UIScreen.screenHeight/20)
                                        }
                            } else {
                                Image("NoPostScreen")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: UIScreen.screenWidth/1.5, height: UIScreen.screenHeight/2.5)
                                        .overlay{
                                            Text("\(globalVM.getNormalProfileHeader.data.profile.fullName) have not posted any services yet")
                                                .font(.body)
                                                .frame(width: UIScreen.screenWidth/4)
                                                .fontWeight(.bold)
                                                .foregroundColor(greenUi)
                                                .multilineTextAlignment(.leading)
                                                .offset(x: UIScreen.screenWidth/12, y: -UIScreen.screenHeight/20)
                                        }
                            }
                    }
                }
            }
        }
    }
}

//struct ServiceProfileListView_Previews: PreviewProvider {
//    static var previews: some View {
//        ServiceProfileListView()
//    }
//}
