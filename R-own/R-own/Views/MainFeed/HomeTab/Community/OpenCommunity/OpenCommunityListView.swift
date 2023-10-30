//
//  OpenCommunityListView.swift
//  R-own
//
//  Created by Aman Sharma on 11/08/23.
//

import SwiftUI

struct OpenCommunityListView: View {
    
    @StateObject var loginData: LoginViewModel
    @StateObject var globalVM: GlobalViewModel
    @StateObject var communityVM: CommunityViewModel
    @StateObject var mesiboVM: MesiboViewModel
    @StateObject var profileVM: ProfileViewModel
    
    @State var communitySearchText: String = ""
    @FocusState private var isKeyboardShowing: Bool
    
    @StateObject var communityService = CommunityService()
    
    
    var filteredGroups: [OwnCommunityGroupDetailsModel] {
        if communitySearchText.isEmpty {
            return globalVM.openCommunityModelList
        } else {
            return globalVM.openCommunityModelList.filter { $0.groupName.localizedCaseInsensitiveContains(communitySearchText) }
        }
    }
    
    var body: some View {
        NavigationStack{
            VStack{
                VStack{
                    BasicNavbarView(navbarTitle: "Open Communities")
                }
                VStack{
                    //Search Field
                    TextField("Search", text: $communitySearchText)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.default)
                        .padding()
                        .frame(width: UIScreen.screenWidth/1.2)
                        .cornerRadius(5)
                        .overlay{
                            Image("ExploreSearchIcon")
                                .resizable()
                                .scaledToFit()
                                .frame(width: UIScreen.screenHeight/50, height: UIScreen.screenHeight/50)
                                .offset(x: UIScreen.screenWidth/2.9)
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
                }
                ScrollView{
                    VStack{
                        if globalVM.openCommunityModelList.count > 0 {
                            ForEach(0..<filteredGroups.count, id: \.self){ count in
                                OpenCommunityDetailCard(community: filteredGroups[count], loginData: loginData, communityVM: communityVM, mesiboVM: mesiboVM, globalVM: globalVM, profileVM: profileVM)
                            }
                        }
                    }
                }
            }
        }
        .onChange(of: globalVM.keyboardVisibility) { newValue in
            isKeyboardShowing = false
            globalVM.keyboardVisibility = false
        }
        .onAppear{
            communityService.getCommunitiesNotJoined(globalVM: globalVM, userID: loginData.mainUserID)
        }
        .navigationBarBackButtonHidden()
    }
}

//struct OpenCommunityListView_Previews: PreviewProvider {
//    static var previews: some View {
//        OpenCommunityListView()
//    }
//}
