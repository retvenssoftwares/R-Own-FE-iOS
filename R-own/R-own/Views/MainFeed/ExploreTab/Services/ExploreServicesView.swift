//
//  ExploreServicesView.swift
//  R-own
//
//  Created by Aman Sharma on 25/05/23.
//

import SwiftUI
import AlertToast

struct ExploreServicesView: View {
    
    @StateObject var loginData: LoginViewModel
    @StateObject var globalVM: GlobalViewModel
    @StateObject var exploreVM: ExploreViewModel
    @StateObject var profileVM: ProfileViewModel
    @StateObject var mesiboVM: MesiboViewModel
    
    @StateObject var exploreService = ExploreService()
    
    @FocusState private var isKeyboardShowing: Bool
    
    @State var counter1: Int = 1
    @State var counter2: Int = 1
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
        ]
    
    var body: some View {
            VStack{
                TextField("Search", text: $exploreVM.exploreServicesSearchText )
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.default)
                    .frame(width: UIScreen.screenWidth/1.1)
                    .cornerRadius(5)
                    .overlay{
                        HStack{
                            Spacer()
                            Image("ExploreSearchIcon")
                                .resizable()
                                .scaledToFit()
                                .frame(width: UIScreen.screenHeight/50, height: UIScreen.screenHeight/50)
                                .padding(.trailing, UIScreen.screenWidth/20)
                        }
                    }
                    .onChange(of: exploreVM.exploreServicesSearchText) { newValue in
                        globalVM.exploreSearchServiceList = [ExploreServiceSearchModel(page: 0, pageSize: 0, posts: [ExploreServiceSearch]())]
                        searchPost()
                    }
                    .focused($isKeyboardShowing)
                
                ScrollView{
                    VStack{
                        if exploreVM.exploreServicesSearchText == "" {
                            LazyVGrid(columns: columns, spacing: 20) {
                                
                                if globalVM.exploreServiceList[0].vendors.count > 0 {
                                    ForEach(0..<globalVM.exploreServiceList[0].vendors.count, id: \.self) { id in
                                        if globalVM.exploreServiceList[0].vendors[id].displayStatus == "1" {
                                            ExploreServicesTabView(vendor: globalVM.exploreServiceList[0].vendors[id], loginData: loginData, globalVM: globalVM, profileVM: profileVM, mesiboVM: mesiboVM)
                                                .onAppear{
                                                    if globalVM.exploreServiceList[0].vendors.count > 4 {
                                                        if id == globalVM.exploreServiceList[0].vendors.count - 2 {
                                                            counter1 = counter1 + 1
                                                            exploreService.getExploreServices(globalVM: globalVM, userID: loginData.mainUserID, pageNumber: String(counter1))
                                                        }
                                                    }
                                                }
                                        }
                                    }
                                }else {
                                    VStack{
                                    }
                                }
                            }
                            .padding(.bottom, UIScreen.screenHeight/9)
                        } else {
                            LazyVGrid(columns: columns, spacing: 20) {
                                
                                if globalVM.exploreSearchServiceList[0].posts.count > 0 {
                                    ForEach(0..<globalVM.exploreSearchServiceList[0].posts.count, id: \.self) { id in
                                        if globalVM.exploreSearchServiceList[0].posts[id].displayStatus == "1" {
                                            ExploreSearchServicesTabView(vendor: globalVM.exploreSearchServiceList[0].posts[id], loginData: loginData, globalVM: globalVM, profileVM: profileVM, mesiboVM: mesiboVM)
                                                .onAppear{
                                                    if globalVM.exploreSearchServiceList[0].posts.count > 6 {
                                                        if id == globalVM.exploreSearchServiceList[0].posts.count - 2 {
                                                            counter2 = counter2 + 1
                                                            exploreService.getExploreSearchServices(globalVM: globalVM, userID: loginData.mainUserID, pageNumber: String(counter2), keyword: exploreVM.exploreServicesSearchText)
                                                        }
                                                    }
                                                }
                                        }
                                    }
                                }else {
                                    VStack{
                                        Spacer()
                                        HStack{
                                            Spacer()
                                            Image("NothingToSeeHereIllustration")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: UIScreen.screenWidth/1.5, height: UIScreen.screenHeight/2)
                                            Spacer()
                                        }
                                        Spacer()
                                    }
                                }
                            }
                            .padding(.bottom, UIScreen.screenHeight/9)
                            .padding(.horizontal)
                        }
                        Rectangle()
                            .fill(.white)
                            .frame(width: UIScreen.screenWidth, height: UIScreen.screenHeight/12)
                    }
                }
            } 
            .onChange(of: globalVM.keyboardVisibility) { newValue in
                            isKeyboardShowing = false
                            globalVM.keyboardVisibility = false
            }
        .onAppear{
            globalVM.exploreSearchServiceList = [ExploreServiceSearchModel(page: 0, pageSize: 0, posts: [ExploreServiceSearch]())]
            globalVM.exploreServiceList = [ExploreServicesModel(page: 0, pageSize: 0, vendors: [ExploreVendor]())]
            exploreService.getExploreServices(globalVM: globalVM, userID: loginData.mainUserID, pageNumber: "1")
        }
    }
    func searchPost() {
        if globalVM.toastSearchLoading == false {
            globalVM.toastSearchLoading.toggle()
        }
        globalVM.exploreSearchServiceList = [ExploreServiceSearchModel(page: 0, pageSize: 0, posts: [ExploreServiceSearch]())]
        exploreService.getExploreSearchServices(globalVM: globalVM, userID: loginData.mainUserID, pageNumber: String(1), keyword: exploreVM.exploreServicesSearchText)
    }
}


//struct ExploreServicesView_Previews: PreviewProvider {
//    static var previews: some View {
//        ExploreServicesView()
//    }
//}
