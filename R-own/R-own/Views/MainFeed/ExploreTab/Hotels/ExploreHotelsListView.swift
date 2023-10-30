//
//  ExploreHotelsListView.swift
//  R-own
//
//  Created by Aman Sharma on 27/05/23.
//

import SwiftUI
import AlertToast

struct ExploreHotelsListView: View {
    
    @StateObject var loginData: LoginViewModel
    @StateObject var globalVM: GlobalViewModel
    @StateObject var exploreVM: ExploreViewModel
    
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
                TextField("Search", text: $exploreVM.exploreHotelsSearchText )
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
                    .onChange(of: exploreVM.exploreHotelsSearchText) { newValue in
                        searchPost()
                    }
                    .focused($isKeyboardShowing)
                
                ScrollView {
                    VStack{
                        if exploreVM.exploreHotelsSearchText == "" {
                            LazyVGrid(columns: columns, spacing: 10) {
                                
                                if globalVM.exploreHotelList[0].posts.count > 0 {
                                    ForEach(0..<globalVM.exploreHotelList[0].posts.count, id: \.self) { id in
                                        if globalVM.exploreHotelList[0].posts[id].displayStatus == "1"{
                                            ExploreHotelsTabView(hotel: globalVM.exploreHotelList[0].posts[id], globalVM: globalVM, loginData: loginData)
                                                .onAppear{
                                                    print(id)
                                                    if id == globalVM.exploreHotelList[0].posts.count - 2 {
                                                        print(counter1)
                                                        counter1 = counter1 + 1
                                                        exploreService.getExploreHotel(globalVM: globalVM, userID: loginData.mainUserID, pageNumber: String(counter1))
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
                            .padding(.horizontal)
                        } else {
                            LazyVGrid(columns: columns, spacing: 10) {
                                
                                if globalVM.exploreSearchHotelList[0].posts.count > 0 {
                                    ForEach(0..<globalVM.exploreSearchHotelList[0].posts.count, id: \.self) { id in
                                        if globalVM.exploreSearchHotelList[0].posts[id].displayStatus == "1"{
                                            ExploreHotelsTabView(hotel: globalVM.exploreSearchHotelList[0].posts[id], globalVM: globalVM, loginData: loginData)
                                                .onAppear{
                                                    print(id)
                                                    if globalVM.exploreSearchHotelList[0].posts.count > 10 {
                                                        if id == globalVM.exploreSearchHotelList[0].posts.count - 3 {
                                                            print(counter2)
                                                            counter2 = counter2 + 1
                                                            exploreService.getExploreSearchHotel(globalVM: globalVM, userID: loginData.mainUserID, pageNumber: String(counter2), keyword: exploreVM.exploreHotelsSearchText)
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
    }
    func searchPost() {
        globalVM.exploreSearchHotelList = [ExploreHotelModel(page: 0, pageSize: 0, posts: [ExploreHotelPost]())]
        exploreService.getExploreSearchHotel(globalVM: globalVM, userID: loginData.mainUserID, pageNumber: String(1), keyword: exploreVM.exploreHotelsSearchText)
    }
}

//struct ExploreHotelsListView_Previews: PreviewProvider {
//    static var previews: some View {
//        ExploreHotelsListView()
//    }
//}
