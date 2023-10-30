//
//  UserViewModel.swift
//  R-own
//
//  Created by Aman Sharma on 10/04/23.
//

import SwiftUI


class UserViewModel: ObservableObject{
    
    // MARK: Mesibo Var
    @StateObject var mainUserData = MainUserService()
    @StateObject var userData = UserCreationService()
    @StateObject var interestData = InterestService()
    
    
// MARK: - Functions of Login
    func addUserToServerModelFunc(loginData: LoginViewModel) {
        userData.addUserToServerViaNum(loginData: loginData)
    }
//    func getUserDetailsFunc(loginData: LoginViewModel) {
//        userData.getUserDetails(loginData: loginData)
//    }
//    func updateUserDetailsAfterLogin(loginData: LoginViewModel) {
//        userData.updateUserDataAfterLogin(loginData: loginData)
//    }
    func updateUserDetailsAfterLoginWithoutPic(loginData: LoginViewModel) {
        userData.updateuserDataAfterLoginWithoutImage(loginData: loginData)
    }
//    func updateMesiboDataAfterLogin(loginData: LoginViewModel) {
//        userData.updateMesiboDataOnUserProfile(loginData: loginData)
//    }
    
// MARK: - Interest Manipulation
    
    func getInterestDetailsAfterLogin(loginData: LoginViewModel) {
        interestData.fetchInterests(loginData: loginData)
    }
    func updateInterestDataToServer(loginData: LoginViewModel) {
        print("updating interest data on server")
        for Interest in loginData.selectedInterestList{
            interestData.updateInterestInUser(loginData: loginData, Interest: Interest)
            interestData.updateUserInInterest(loginData: loginData, Interest: Interest)
        }
        loginData.showLoader = false
    }
    
// MARK: - Functions needed after login
    
    func fetchTotalUserList(loginData: LoginViewModel) {
        mainUserData.getUser(loginData: loginData)
    }
    
    
}

//struct UserViewModel_Previews: PreviewProvider {
//    static var previews: some View {
//        UserViewModel()
//    }
//}
