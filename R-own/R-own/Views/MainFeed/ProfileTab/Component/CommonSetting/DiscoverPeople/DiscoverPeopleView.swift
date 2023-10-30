//
//  DiscoverPeopleView.swift
//  R-own
//
//  Created by Aman Sharma on 18/05/23.
//

import SwiftUI

struct DiscoverPeopleView: View {
    
    @StateObject var loginData: LoginViewModel
    @StateObject var globalVM: GlobalViewModel
    @StateObject var profileVM: ProfileViewModel
    @StateObject var mesiboVM: MesiboViewModel
    @State var searchNewConnectionUsers: String = ""
    
    @StateObject var exploreService = ExploreService()
    @StateObject var profileService = ProfileService()
    @StateObject var contactService = ContactService()
    @StateObject var contactVM = ContactsViewModel()
    
    @State var selectedUserID: String = ""
    
    @State var offset : CGFloat = 0
    @FocusState private var isKeyboardShowing: Bool
    
    @State var navigateToROwnProfileView: Bool = false
    @State var selectedProfile: Int = 0
    @State var selectedProfile2: Int = 0
    
    @State var isLoadingContact: Bool = false
    @State var isLoadingUser: Bool = false
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    var filteredOwnConnections: [MatchedContact] {
        searchNewConnectionUsers.isEmpty ? globalVM.userContactConnectionList.matchedContacts! : globalVM.userContactConnectionList.matchedContacts!.filter { $0.matchedNumber.fullName.localizedCaseInsensitiveContains(searchNewConnectionUsers) }
    }
    var filteredRownConnections: [Post34] {
        searchNewConnectionUsers.isEmpty ? globalVM.explorePeopleList[0].posts : globalVM.explorePeopleList[0].posts.filter { $0.fullName.localizedCaseInsensitiveContains(searchNewConnectionUsers) }
    }
    
    var body: some View {
        VStack{
            BasicNavbarView(navbarTitle: "Discover People")
            ScrollView{
                VStack{
                    VStack{
                        Text("Connect with them and build your own community ")
                            .font(.body)
                            .fontWeight(.bold)
                            .padding(.vertical, UIScreen.screenHeight/50)
                            .padding(.leading, UIScreen.screenWidth/30)
                            .multilineTextAlignment(.leading)
                    }
                    //SearchField
                    
                    VStack{
                        
                        TextField("Search", text: $searchNewConnectionUsers )
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
                            
                        
                    }
                    ScrollView{
                        VStack{
                            //users from contacts
                            if isLoadingContact{
                                VStack{
                                    
                                    Divider()
                                        .overlay{
                                            HStack{
                                                Text("R-Own users from your contacts")
                                                    .font(.body)
                                                    .foregroundColor(.black)
                                                    .background(BlurView().opacity(0.7))
                                                Spacer()
                                            }
                                            .padding(.horizontal, UIScreen.screenWidth/20)
                                        }
                                    VStack{
                                        if globalVM.userContactConnectionList.message == "Please sync your contacts" {
                                            Text("Contacts are not synced yet")
                                            Button(action: {
                                                Task.init{
                                                    loginData.showLoader = true
                                                    await contactVM.fetchContactsFromPhone(loginData: loginData, globalVM: globalVM)
                                                }
                                            }, label: {
                                                Text("Click here to sync your contacts now!")
                                                    .font(.body)
                                                    .fontWeight(.semibold)
                                                    .foregroundColor(greenUi)
                                                    .padding(.horizontal, UIScreen.screenWidth/40)
                                                    .padding(.vertical, UIScreen.screenHeight/80)
                                                    .background(jobsDarkBlue)
                                                    .cornerRadius(10)
                                            })
                                        } else {
                                            LazyVGrid(columns: columns, spacing: 20) {
                                                if globalVM.userContactConnectionList.matchedContacts != nil {
                                                    if globalVM.userContactConnectionList.matchedContacts!.count > 0 {
                                                        ForEach(0..<filteredOwnConnections.count, id: \.self) { id in
                                                            if filteredOwnConnections[id].matchedNumber.fullName != "" {
                                                                if filteredOwnConnections[id].connectionStatus == "Not connected" || filteredOwnConnections[id].connectionStatus == "Requested"{
                                                                    NewConnectionUsersTab(loginData: loginData, globalVM: globalVM, profileVM: profileVM, mesiboVM: mesiboVM, user: filteredOwnConnections[id])
                                                                }
                                                            }
                                                        }
                                                    }else {
                                                        Text("No People to show")
                                                    }
                                                }
                                            }
                                        }
                                    }
                                    .padding(.vertical, UIScreen.screenHeight/50)
                                }
                            } else {
                                ProgressView()
                            }
                            
                            //users from rown
                            if isLoadingUser{
                                VStack{
                                    
                                    Divider()
                                        .overlay{
                                            HStack{
                                                Text("R-Own users")
                                                    .font(.body)
                                                    .foregroundColor(.black)
                                                    .background(BlurView().opacity(0.7))
                                                Spacer()
                                            }
                                            .padding(.horizontal, UIScreen.screenWidth/20)
                                        }
                                    
                                    VStack{
                                        LazyVGrid(columns: columns, spacing: 20) {
                                            if globalVM.explorePeopleList.count > 0 {
                                                ForEach(0..<filteredRownConnections.count, id: \.self) { id in
                                                    if filteredRownConnections[id].fullName != "" {
                                                        if filteredRownConnections[id].displayStatus == "1"{
                                                            if filteredRownConnections[id].userID != loginData.mainUserID {
                                                                NewRownUsersTab(loginData: loginData, globalVM: globalVM, profileVM: profileVM, mesiboVM: mesiboVM, user: filteredRownConnections[id])
                                                            }
                                                        }
                                                    }
                                                }
                                            } else {
                                                Text("No People to show")
                                            }
                                        }
                                    }
                                    .padding(.vertical, UIScreen.screenHeight/50)
                                }
                            } else {
                                ProgressView()
                            }
                        }
                        .padding(.vertical, UIScreen.screenHeight/70)
                    }
                }
                .onAppear{
                    
                    makeAPICall(globalVM: globalVM, userID: loginData.mainUserID)
                    
                    Task{
                        let res = await contactService.getContactsConnections(globalVM: globalVM, userID: loginData.mainUserID, loginData: loginData)
                        if res == "Success" {
                            exploreService.getExplorePeople(globalVM: globalVM, userID: loginData.mainUserID, pageNumber: "1")
                            
                            if globalVM.getConnectionList.count > 0 {
                                if globalVM.getConnectionList[0].conns.count > 0{
                                    loginData.mainUserConnectionCount = globalVM.getConnectionList[0].conns.count
                                    loginData.showNewUserConnectionBottomSheet = false
                                }
                            }
                            isLoadingUser.toggle()
                        } else {
                            
                        }
                    }
                }
            }
        }
        .onChange(of: globalVM.keyboardVisibility) { newValue in
            
                            isKeyboardShowing = false
                            globalVM.keyboardVisibility = false
        }
        .navigationBarBackButtonHidden()
    }
    
    func makeAPICall(globalVM: GlobalViewModel, userID: String) {
        
            Task{
                loginData.showLoader = true
                let res = await contactService.getContactsConnections(globalVM: globalVM, userID: userID, loginData: loginData)
                if res == "Success" {
                    isLoadingContact.toggle()
                } else {
                    makeAPICall(globalVM: globalVM, userID: userID)
                }
            }
        
    }
}



//struct DiscoverPeopleView_Previews: PreviewProvider {
//    static var previews: some View {
//        DiscoverPeopleView()
//    }
//}
