//
//  ExplorePeopleView.swift
//  R-own
//
//  Created by Aman Sharma on 25/05/23.
//

import SwiftUI
import AlertToast

struct ExplorePeopleView: View {
    
    @StateObject var globalVM: GlobalViewModel
    @StateObject var loginData: LoginViewModel
    @StateObject var profileVM: ProfileViewModel
    @StateObject var exploreVM: ExploreViewModel
    @StateObject var mesiboVM: MesiboViewModel
    
    @StateObject var exploreService = ExploreService()
    
    @FocusState private var isKeyboardShowing: Bool
    
    @State var counter1: Int = 1
    @State var counter2: Int = 1
    @State var isLoading: Bool = false
    
    var body: some View {
        NavigationStack{
            VStack{
                TextField("Search", text: $exploreVM.explorePeopleSearchText )
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
                    .onChange(of: exploreVM.explorePeopleSearchText) { newValue in
                        searchPost()
                    }
                    .focused($isKeyboardShowing)
                ScrollView{
                    LazyVStack{
                        if exploreVM.explorePeopleSearchText == "" {
                            if globalVM.explorePeopleList.count > 0 {
                                ForEach(0..<globalVM.explorePeopleList[0].posts.count, id: \.self) { id in
                                    if globalVM.explorePeopleList[0].posts[id].displayStatus == "1"{
                                        if globalVM.explorePeopleList[0].posts[id].userID != loginData.mainUserID {
                                            if globalVM.explorePeopleList[0].posts[id].fullName != "" {
                                                if globalVM.explorePeopleList[0].posts[id].blockbyuser == "no" {
                                                    ExplorePeopleListView(loginData: loginData, people: globalVM.explorePeopleList[0].posts[id], globalVM: globalVM, profileVM: profileVM, mesiboVM: mesiboVM)
                                                        .onAppear{
                                                            if globalVM.explorePeopleList[0].posts.count > 6 {
                                                                if id == globalVM.explorePeopleList[0].posts.count - 2 {
                                                                    counter1 = counter1 + 1
                                                                    exploreService.getExplorePeople(globalVM: globalVM, userID: loginData.mainUserID, pageNumber: String(counter1))
                                                                }
                                                            }
                                                        }
                                                    Divider()
                                                }
                                            }
                                        }
                                    }
                                }
                            }else {
                                VStack{
                                    Spacer()
                                    Image("NothingToSeeHereIllustration")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: UIScreen.screenWidth/1.5, height: UIScreen.screenHeight/2)
                                    Spacer()
                                }
                            }
                        } else {
                            if isLoading {
                                ProgressView()
                            } else {
                                if globalVM.exploreSearchPeopleList.count > 0 {
                                    ForEach(0..<globalVM.exploreSearchPeopleList[0].posts.count, id: \.self) { id in
                                        if globalVM.exploreSearchPeopleList[0].posts[id].displayStatus == "1"{
                                            if globalVM.exploreSearchPeopleList[0].posts[id].userID != loginData.mainUserID {
                                                if globalVM.exploreSearchPeopleList[0].posts[id].fullName != "" {
                                                    ExplorePeopleSearchListView(loginData: loginData, people: globalVM.exploreSearchPeopleList[0].posts[id], globalVM: globalVM, profileVM: profileVM, mesiboVM: mesiboVM)
                                                        .onAppear{
                                                            if globalVM.exploreSearchPeopleList[0].posts.count > 6 {
                                                                if id == globalVM.exploreSearchPeopleList[0].posts.count - 2 {
                                                                    counter2 = counter2 + 1
                                                                    exploreService.getExplorePeopleBySearch(globalVM: globalVM, userID: loginData.mainUserID, keyword: exploreVM.explorePeopleSearchText, pageNumber: String(counter2))
                                                                }
                                                            }
                                                        }
                                                    Divider()
                                                }
                                            }
                                        }
                                    }
                                } else {
                                    VStack{
                                        Spacer()
                                        Image("NothingToSeeHereIllustration")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: UIScreen.screenWidth/1.5, height: UIScreen.screenHeight/2)
                                        Spacer()
                                    }
                                }
                            }
                        }
                        Rectangle()
                            .fill(.white)
                            .frame(width: UIScreen.screenWidth, height: UIScreen.screenHeight/12)
                    }
                }
            }
        }
        .onChange(of: globalVM.keyboardVisibility) { newValue in
            isKeyboardShowing = false
            globalVM.keyboardVisibility = false
        }
        .onAppear{
            exploreVM.explorePeopleSearchText = ""
            globalVM.exploreSearchPeopleList = [ExplorePeopleSearchModel(page: 0, pageSize: 0, posts: [Post344]())]
            globalVM.explorePeopleList = [ExplorePeopleModel(page: 0, pageSize: 0, posts: [Post34]())]
            exploreService.getExplorePeople(globalVM: globalVM, userID: loginData.mainUserID, pageNumber: "1")
            
        }
    }
    func searchPost() {
        if globalVM.toastSearchLoading == false {
            globalVM.toastSearchLoading.toggle()
        }
        isLoading = true
        
        exploreService.getExplorePeopleBySearch(globalVM: globalVM, userID: loginData.mainUserID, keyword: exploreVM.explorePeopleSearchText, pageNumber: String(1))
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            isLoading = false
        }
        
    }
}


//struct ExplorePeopleView_Previews: PreviewProvider {
//    static var previews: some View {
//        ExplorePeopleView()
//    }
//}
