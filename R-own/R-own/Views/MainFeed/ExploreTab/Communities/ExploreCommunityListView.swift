//
//  ExploreCommunityListView.swift
//  R-own
//
//  Created by Aman Sharma on 19/08/23.
//

import SwiftUI

struct ExploreCommunityListView: View {
    
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
                    //Search Field
                    TextField("Search", text: $communitySearchText)
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
                Rectangle()
                    .fill(.white)
                    .frame(width: UIScreen.screenWidth, height: UIScreen.screenHeight/12)
            }
        }
        .onChange(of: globalVM.keyboardVisibility) { newValue in
            isKeyboardShowing = false
            globalVM.keyboardVisibility = false
        }
        .onAppear{
            globalVM.openCommunityModelList = [OwnCommunityGroupDetailsModel]()
            communityService.getCommunitiesNotJoined(globalVM: globalVM, userID: loginData.mainUserID)
        }
        .navigationBarBackButtonHidden()
    }
}

//struct ExploreCommunityListView_Previews: PreviewProvider {
//    static var previews: some View {
//        ExploreCommunityListView()
//    }
//}
