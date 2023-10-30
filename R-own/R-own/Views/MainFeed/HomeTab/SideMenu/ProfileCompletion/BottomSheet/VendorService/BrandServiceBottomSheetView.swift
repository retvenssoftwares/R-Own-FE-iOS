//
//  BrandServiceBottomSheetView.swift
//  R-own
//
//  Created by Aman Sharma on 05/05/23.
//

import SwiftUI

struct BrandServiceBottomSheetView: View {
    
    @StateObject var loginData: LoginViewModel
    @StateObject var globalVM: GlobalViewModel
    
    @State var serviceSearch: String = ""
    
    @FocusState private var isKeyboardShowing: Bool
    
    var edges = UIApplication.shared.windows.first?.safeAreaInsets
    
    @State var offset : CGFloat = 0
    
    var filteredServices: [VendorService] {
        if serviceSearch.isEmpty {
            return globalVM.vendorServicesList
        } else {
            return globalVM.vendorServicesList.filter { $0.serviceName?.localizedCaseInsensitiveContains(serviceSearch) ?? false }
        }
    }
    
    var body: some View {
            VStack{
                Spacer()
                VStack(spacing: 12){
                    Capsule()
                        .fill(Color.gray)
                        .frame(width:60, height: 4)
                        
                        VStack(spacing: 20){
                            HStack{
                                Text("Select your brand services?")
                                    .foregroundColor(.black)
                                    .font(.title3)
                                    .fontWeight(.bold)
                                    .multilineTextAlignment(.center)
                                Spacer()
                                VStack{
                                    CustomGreenButton(title: "Done",width: UIScreen.screenWidth/5, height: UIScreen.screenHeight/35,  action: {
                                        loginData.showBrandServiceSheet.toggle()
                                    })
                                    CustomBlueButton(title: "Reset",width: UIScreen.screenWidth/5, height: UIScreen.screenHeight/35,  action: {
                                        globalVM.selectedVendorServicesList = [String]()
                                        loginData.brandServices = ""
                                    })
                                    
                                }
                                    
                            }
                            .padding(.top,30)
                            .padding(.horizontal, UIScreen.screenWidth/30)
                            
                            TextField("Search Service", text: $serviceSearch)
                                .font(.body)
                                .frame(width: UIScreen.screenWidth/1.2)
                                .overlay(alignment: .trailing, content: {
                                    Image(systemName: "magnifyingglass")
                                })
                                .focused($isKeyboardShowing)
                                .padding()
                                .overlay{
                                    RoundedRectangle(cornerRadius: 5)
                                        .stroke(lineWidth: 2)
                                        .foregroundColor(lightGreyUi)
                                }
                            
                            
                            //Location Array
                            ScrollView{
                                VStack(alignment: .leading){
                                    ForEach(filteredServices, id: \.self){ service in
                                        BrandServiceTab(globalVM: globalVM, service: service, loginData: loginData)
                                    }
                                }
                            }
                        }
                        .padding(.horizontal)
                        .padding(.bottom)
                        .padding(.bottom,edges?.bottom)
                        .frame(width: UIScreen.screenWidth ,height: UIScreen.screenHeight/1.3)
                }
                .padding(.top)
                .background(BlurView().clipShape(CustomCorner(corners: [.topLeft, .topRight])))
                .offset(y: offset)
                .gesture(DragGesture().onChanged(onChanged(value:)).onEnded(onEnded(value: )))
                .offset(y: loginData.showBrandServiceSheet ? 0 : UIScreen.main.bounds.height)
                .onChange(of: globalVM.keyboardVisibility) { newValue in
                    isKeyboardShowing = false
                    globalVM.keyboardVisibility = false
                }
            }
            .ignoresSafeArea()
            .background(Color.black.opacity(loginData.showBrandServiceSheet ? 0.3 : 0).ignoresSafeArea()
                .onTapGesture {
                    withAnimation{
                        loginData.showBrandServiceSheet.toggle()
                    }
                }
            )
    }
    func onChanged(value: DragGesture.Value){
        if value.translation.height > 0{
            offset = value.translation.height
        }
    }
    
    func onEnded(value: DragGesture.Value){
        if value.translation.height > 0{
            withAnimation(Animation.easeInOut(duration: 0.2)){
                
                //onChecking
                
                let height = UIScreen.screenHeight/3
                
                if value.translation.height > height/1.5 {
                    loginData.showBrandServiceSheet.toggle()
                }
                
                offset = 0
            }
        }
    }
}

//struct BrandServiceBottomSheetView_Previews: PreviewProvider {
//    static var previews: some View {
//        BrandServiceBottomSheetView()
//    }
//}
