//
//  NewUserConnectionBottomSheetView.swift
//  R-own
//
//  Created by Aman Sharma on 12/07/23.
//

import SwiftUI

struct NewUserConnectionBottomSheetView: View {
    
    //Login Var
    @StateObject var loginData: LoginViewModel
    @StateObject var globalVM: GlobalViewModel
    @StateObject var profileVM: ProfileViewModel
    @StateObject var mesiboVM: MesiboViewModel
    @State var searchNewConnectionUsers: String = ""
    
    @StateObject var exploreService = ExploreService()
    @StateObject var profileService = ProfileService()
    @StateObject var contactService = ContactService()
    @StateObject var contactVM = ContactsViewModel()
    
    @State var loadingContact: Bool = false
    @State var loadingUser: Bool = false
    
    
    var edges = UIApplication.shared.windows.first?.safeAreaInsets
    
    @State var selectedUserID: String = ""
    
    @State var offset : CGFloat = 0
    @FocusState private var isKeyboardShowing: Bool
    
    @State var navigateToROwnProfileView: Bool = false
    @State var selectedProfile: Int = 0
    @State var selectedProfile2: Int = 0
    
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
        NavigationStack{
            ZStack{
                VStack{
                    Spacer()
                    VStack(spacing: 12){
                        Capsule()
                            .fill(Color.gray)
                            .frame(width:60, height: 4)
                        
                        VStack(alignment: .leading, spacing: 20){
                            VStack{
                                Text("Connect with them and build your own community ")
                                    .font(.title)
                                    .fontWeight(.bold)
                                    .padding(.top, UIScreen.screenHeight/50)
                                    .padding(.bottom, UIScreen.screenHeight/70)
                                    .padding(.leading, UIScreen.screenWidth/30)
                                    .multilineTextAlignment(.leading)
                            }
                            //SearchField
                            
                            VStack{
                                if globalVM.userContactConnectionList.message != "Please sync your contacts" {
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
                                
                            }
                            ScrollView{
                                VStack{
                                    //users from contacts
                                    if loadingContact{
                                        VStack{
                                            
                                            Divider()
                                                .overlay{
                                                    HStack{
                                                        Text("R-Own users from your contacts")
                                                            .font(.headline)
                                                            .foregroundColor(.black)
                                                            .background(BlurView().opacity(0.7))
                                                        Spacer()
                                                    }
                                                    .padding(.horizontal, UIScreen.screenWidth/20)
                                                }
                                            VStack{
                                                if globalVM.userContactConnectionList.message == "Please sync your contacts" {
                                                    CustomBlueButton(title: "Click here to sync your contacts now!",width: UIScreen.screenWidth/1.2, action: {
                                                        Task.init{
                                                            loginData.showLoader = true
                                                            let res = await contactVM.fetchContactsFromPhone(loginData: loginData, globalVM: globalVM)
                                                            if res == "Failure" {
                                                                print("Fail")
                                                            }
                                                        }
                                                    })
                                                } else {
                                                    LazyVGrid(columns: columns, spacing: 20) {
                                                        if globalVM.userContactConnectionList.message != "No match found" {
                                                            if filteredOwnConnections.count > 0 {
                                                                ForEach(0..<filteredOwnConnections.count, id: \.self) { id in
                                                                    if filteredOwnConnections[id].matchedNumber.fullName != "" {
                                                                        if filteredOwnConnections[id].matchedNumber.fullName != "" {
                                                                            if filteredOwnConnections[id].connectionStatus == "Not connected" || filteredOwnConnections[id].connectionStatus == "Requested"{
                                                                                NewConnectionUsersTab(loginData: loginData, globalVM: globalVM, profileVM: profileVM, mesiboVM: mesiboVM, user: filteredOwnConnections[id])
                                                                            }
                                                                        }
                                                                    }
                                                                }
                                                            }
                                                        } else {
                                                            Text("No People to show")
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
                                    if loadingUser {
                                        VStack{
                                            
                                            Divider()
                                                .overlay{
                                                    HStack{
                                                        Text("R-Own users")
                                                            .font(.headline)
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
                                        .padding(.top, UIScreen.screenHeight/80)
                                    } else {
                                        ProgressView()
                                    }
                                }
                                .padding(.vertical, UIScreen.screenHeight/70)
                            }
                        }
                        .padding(.horizontal)
                        .padding(.bottom)
                        .padding(.bottom,edges?.bottom)
                        .frame(width: UIScreen.screenWidth ,height: UIScreen.screenHeight/1.3)
                        .onAppear{
                            globalVM.userContactConnectionList = ContactsUserConnectionModel(message: "", matchedContacts: [MatchedContact(matchedNumber: MatchedNumber(id: "", fullName: "", profilePic: "", mesiboAccount: [MesiboAccount](), verificationStatus: "", userBio: "", role: "", normalUserInfo: [NormalUserInfo](), hospitalityExpertInfo: [JSONAny](), userID: "", connections: [Connection](), requests: [Connection]()), connectionStatus: "")])
                            Task{
                                
                                makeAPICall(globalVM: globalVM, userID: loginData.mainUserID)
                                let res = await contactService.getContactsConnections(globalVM: globalVM, userID: loginData.mainUserID, loginData: loginData)
                                if res == "Success"{
                                    exploreService.getExplorePeople(globalVM: globalVM, userID: loginData.mainUserID, pageNumber: "1")
                                    
                                    if globalVM.getConnectionList.count > 0 {
                                        if globalVM.getConnectionList[0].conns.count > 0{
                                            loginData.mainUserConnectionCount = globalVM.getConnectionList[0].conns.count
                                            loginData.showNewUserConnectionBottomSheet = false
                                        }
                                    }
                                    loadingUser = true
                                    loadingContact = true
                                }
                            }
                        }
                    }
                    .padding(.top)
                    .background(BlurView().clipShape(CustomCorner(corners: [.topLeft, .topRight])))
                    .offset(y: offset)
                    .gesture(DragGesture().onChanged(onChanged(value:)).onEnded(onEnded(value: )))
                    .offset(y: loginData.showNewUserConnectionBottomSheet ? 0 : UIScreen.main.bounds.height)
                }
                .ignoresSafeArea()
                .background(Color.white.opacity(loginData.showNewUserConnectionBottomSheet ? 0 : 0).ignoresSafeArea()
                    .onTapGesture {
                        withAnimation{
                            loginData.showNewUserConnectionBottomSheet.toggle()
                        }
                    }
                )
            }
        }
        .onChange(of: globalVM.keyboardVisibility) { newValue in
            
                            isKeyboardShowing = false
                            globalVM.keyboardVisibility = false
        }
    }
    func makeAPICall(globalVM: GlobalViewModel, userID: String){
        
            Task{
                loginData.showLoader = true
                let res = await profileService.getConnectionsList(globalVM: globalVM, userID: userID)
                if res == "Success" {
                    loginData.showLoader = false
                } else {
                    makeAPICall(globalVM: globalVM, userID: userID)
                }
            }
    }
    func onChanged(value: DragGesture.Value){
        if value.translation.height > 0 {
            offset = value.translation.height
        }
    }
    
    func onEnded(value: DragGesture.Value){
        if value.translation.height > 0{
            withAnimation(Animation.easeInOut(duration: 0.2)){
                
                //onChecking
                
                let height = UIScreen.screenHeight/3
                
                if value.translation.height > height/1.5 {
                    loginData.showNewUserConnectionBottomSheet.toggle()
                }
                
                offset = 0
            }
        }
    }
    
    
    
}
func findAndUpdateInContactsConnection(status: String, globalVM: GlobalViewModel, selectedUserID: String) {
    if globalVM.userContactConnectionList.matchedContacts != nil {
        if globalVM.userContactConnectionList.matchedContacts!.count > 0{
            for i in 0..<globalVM.userContactConnectionList.matchedContacts!.count {
                if globalVM.userContactConnectionList.matchedContacts![i].matchedNumber.userID == selectedUserID {
                    globalVM.userContactConnectionList.matchedContacts![i].connectionStatus = status
                }
            }
        }
    }
}
func findAndUpdateInRownConnection(status: String, globalVM: GlobalViewModel, selectedUserID: String) {
    if globalVM.explorePeopleList[0].posts != nil {
        if globalVM.explorePeopleList[0].posts.count > 0{
            for i in 0..<globalVM.explorePeopleList[0].posts.count {
                if globalVM.explorePeopleList[0].posts[i].userID == selectedUserID {
                    globalVM.explorePeopleList[0].posts[i].connectionStatus = status
                }
            }
        }
    }
}

//struct NewUserConnectionBottomSheetView_Previews: PreviewProvider {
//    static var previews: some View {
//        NewUserConnectionBottomSheetView()
//    }
//}
