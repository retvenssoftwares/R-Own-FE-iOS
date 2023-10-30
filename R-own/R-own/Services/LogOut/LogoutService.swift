//
//  LogoutService.swift
//  R-own
//
//  Created by Aman Sharma on 10/06/23.
//

import Foundation
import FirebaseAuth

class LogOutService: ObservableObject{
    
    // MARK: - logout service


    func logoutFirebase() {
        print("firebase log out")
        let firebaseAuth = Auth.auth()
        do {
          try firebaseAuth.signOut()
        } catch let signOutError as NSError {
          print("Error signing out: %@", signOutError)
        }
    }
    
    func logoutApp(loginData: LoginViewModel) {
        print("trying to logging out of application")
        
        //App Database
        loginData.otpStatus = false
        loginData.logStatusviaEmail = false
        loginData.logStatusviaNumber = false
        loginData.onboardingCompleted = false
        loginData.interestSelected = false
        loginData.contactsUploaded = false
        loginData.loginStatus = false
        loginData.loginStatusFinal = false
        loginData.userAlreadyExist = false
        loginData.connectUserModal = true
        loginData.mesiboInitializeOnce = true
        loginData.basicProfileInfoCompleted = false
        loginData.profileLocationInfoCompleted = false
        loginData.roleSelectionInfo = false
        loginData.profileCompleted = false
        loginData.jobRequested = false
        
        //App User Data
        loginData.mainUserPhoneNumber = ""
        loginData.mainUserMesiboToken = ""
        loginData.mainUserMesiboUID = 0
        loginData.mainUserID = ""
        loginData.mainUserFullName = ""
        loginData.mainUserEmail = ""
        loginData.mainUserProfilePic = ""
        loginData.mainUserDOB = ""
        loginData.mainUserFirstName = ""
        loginData.mainUserLastName = ""
        loginData.mainUserUserName = ""
        loginData.mainUserLocationCountry = ""
        loginData.mainUserLocationState = ""
        loginData.mainUserLocationCity = ""
        loginData.mainUserRole = ""
        loginData.mainUserJobTitle = ""
        loginData.mainUserCollege = ""
        loginData.mainUserSessionStart = ""
        loginData.mainUserSessionEnd = ""
        loginData.mainUserEmploymentType = ""
        loginData.mainUserJobStart = ""
        loginData.mainUserJobEnd = ""
        loginData.mainUserCompany = ""
        loginData.apnToken = ""
        loginData.profileCompletionPercentage = ""
        loginData.logOut = true
    }
    
    
}
    
