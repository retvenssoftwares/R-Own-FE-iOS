//
//  CompanySelectBottomSheet.swift
//  R-own
//
//  Created by Aman Sharma on 05/05/23.
//

import SwiftUI

struct CompanySelectBottomSheet: View {
    
    @StateObject var loginData: LoginViewModel
    @StateObject var globalVM: GlobalViewModel
    
    @State var companySearch: String = ""
    
    @FocusState private var isKeyboardShowing: Bool
    
    var edges = UIApplication.shared.windows.first?.safeAreaInsets
    
    @State var offset : CGFloat = 0
    
    @State var isLoading: Bool = false
    
    var filteredCompanies: [Company] {
        if companySearch.isEmpty {
            return globalVM.companyList
        } else {
            return globalVM.companyList.filter { $0.companyName.lowercased().contains(companySearch.lowercased()) }
        }
    }
    @StateObject var userPCS = UserProfileCompletionService()
    
    var body: some View {
            VStack{
                Spacer()
                VStack(spacing: 12){
                    Capsule()
                        .fill(Color.gray)
                        .frame(width:60, height: 4)
                        
                        VStack(spacing: 20){
                            Text("Please select your company here")
                                .foregroundColor(.black)
                                .font(.body)
                                .fontWeight(.bold)
                                .multilineTextAlignment(.center)
                                .padding(.top,30)
                            
                            TextField("Search Company", text: $companySearch)
                                .font(.body)
                                .frame(width: UIScreen.screenWidth/1.2)
                                .overlay(alignment: .trailing, content: {
                                    Image(systemName: "magnifyingglass")
                                })
                                .focused($isKeyboardShowing)
                                .padding()
                                .overlay{
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(lineWidth: 1)
                                        .foregroundColor(lightGreyUi)
                                }
                            
                            
                            //Location Array
                            ScrollView{
                                VStack(alignment: .leading){
                                    if isLoading{
                                        if filteredCompanies.count == 0 {
                                            if companySearch != "" {
                                                Button(action: {
                                                    loginData.mainUserRole = "Normal User"
                                                    loginData.mainUserCompany = companySearch
                                                    loginData.showCompanySheet.toggle()
                                                }, label: {
                                                    HStack{
                                                        Text("Add \(companySearch)")
                                                            .foregroundColor(.black)
                                                            .padding(.vertical, 10)
                                                            .fontWeight(.medium)
                                                            .padding(.top, UIScreen.screenHeight/90)
                                                    }
                                                    .frame(width: UIScreen.screenWidth)
                                                })
                                            }
                                        } else {
                                            ForEach(filteredCompanies, id: \.self){ company in
                                                VStack{
                                                    Button(action: {
                                                        loginData.mainUserRole = "Normal User"
                                                        loginData.mainUserCompany = company.companyName
                                                        loginData.showCompanySheet.toggle()
                                                    }, label: {
                                                        Text(company.companyName)
                                                            .foregroundColor(.black)
                                                            .padding(.vertical, 10)
                                                    })
                                                    Divider()
                                                }
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
                        .padding(.horizontal)
                        .padding(.bottom)
                        .padding(.bottom,edges?.bottom)
                        .frame(width: UIScreen.screenWidth ,height: UIScreen.screenHeight/1.3)
                        .onAppear{
                            isLoading = false
                            Task{
                                let res = await userPCS.getCompanyList(globalVM: globalVM)
                                if res == "Success"{
                                    isLoading = true
                                } else {
                                    isLoading = true
                                    
                                }
                            }
                        }
                }
                .padding(.top)
                .background(BlurView().clipShape(CustomCorner(corners: [.topLeft, .topRight])))
                .offset(y: offset)
                .gesture(DragGesture().onChanged(onChanged(value:)).onEnded(onEnded(value: )))
                .offset(y: loginData.showCompanySheet ? 0 : UIScreen.main.bounds.height)
            }
            .onChange(of: globalVM.keyboardVisibility) { newValue in
                
                            isKeyboardShowing = false
                            globalVM.keyboardVisibility = false
            }
            .ignoresSafeArea()
            .background(Color.black.opacity(loginData.showCompanySheet ? 0.3 : 0).ignoresSafeArea()
                .onTapGesture {
                    withAnimation{
                        loginData.showCompanySheet.toggle()
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
                    loginData.showCompanySheet.toggle()
                }
                
                offset = 0
            }
        }
    }
}

//struct CompanySelectBottomSheet_Previews: PreviewProvider {
//    static var previews: some View {
//        CompanySelectBottomSheet()
//    }
//}
