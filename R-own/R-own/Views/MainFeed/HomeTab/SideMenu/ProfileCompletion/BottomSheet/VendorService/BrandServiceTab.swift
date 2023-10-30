//
//  BrandServiceTab.swift
//  R-own
//
//  Created by Aman Sharma on 25/05/23.
//

import SwiftUI

struct BrandServiceTab: View {
    
    @StateObject var globalVM: GlobalViewModel
    @State var service: VendorService
    @StateObject var loginData: LoginViewModel
    
    @State var serviceSelected: Bool = false
    
    
    
    var body: some View {
        VStack{
            HStack{
                Button(action: {
                    //logic for adding service and removing service by selecting and diselecting
                    serviceSelected.toggle()
                    if serviceSelected {
                        globalVM.selectedVendorServicesList.append(service.serviceID)
                        globalVM.selectedVendorServicesNameList.append(service.serviceName ?? "Fetching User")
                        loginData.brandServices = globalVM.selectedVendorServicesNameList.joined(separator:",")
                    } else if !serviceSelected {
                        if let index = globalVM.selectedVendorServicesList.firstIndex(of: service.serviceID) {
                            globalVM.selectedVendorServicesList.remove(at: index)
                            globalVM.selectedVendorServicesNameList.remove(at: index)
                            loginData.brandServices = globalVM.selectedVendorServicesNameList.joined(separator:", ")
                        }
                    }
                    print(globalVM.selectedVendorServicesList)
                    print(loginData.brandServices)
                }, label: {
                    HStack{
                        Text(service.serviceName ?? "Fetching User")
                            .foregroundColor(.black)
                        Spacer()
                        if globalVM.selectedVendorServicesList.contains(service.serviceID){
                            Image("SelectedCheckBox")
                                .resizable()
                                .scaledToFit()
                                .frame(width: UIScreen.screenHeight/40, height: UIScreen.screenHeight/40)
                        } else {
                            Image("UnselectedCheckBox")
                                .resizable()
                                .scaledToFit()
                                .frame(width: UIScreen.screenHeight/40, height: UIScreen.screenHeight/40)
                        }
                    }
                })
            }
            .padding(.horizontal, UIScreen.screenWidth/40)
            .padding(.vertical, UIScreen.screenHeight/80)
            .frame(width: UIScreen.screenWidth)
            Divider()
        }
    }
}

//struct BrandServiceTab_Previews: PreviewProvider {
//    static var previews: some View {
//        BrandServiceTab()
//    }
//}
