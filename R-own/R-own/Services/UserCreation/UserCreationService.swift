//
//  UserCreationService.swift
//  R-own
//
//  Created by Aman Sharma on 10/04/23.
//


import Foundation
import SwiftUI
import Alamofire


class UserCreationService: ObservableObject{
    
    
    //Mesibo Var
    @StateObject var userVM = UserViewModel()

    
    
    func addUserToServerViaNum(loginData: LoginViewModel) {

        print("Creating rown user with this number:")
//        let userphonenumber: Int = (loginData.mainUserPhoneNumber.deletingPrefix("+") as NSString).integerValue
//        print(userphonenumber)

        guard let url = URL(string: "http://64.227.150.47/main/profile") else {
            print("unable to rectify string in url for api call")
            return
        }

        print("Making API Call to register user...........")

        var request = URLRequest(url: url)

        //method, body, headers

        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let body: [String: AnyHashable] = [
            "Phone": loginData.mainUserPhoneNumber
        ]
        

        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)
        print(1)
        //Make the request

        let task = URLSession.shared.dataTask(with: request){ data, _, error in
            DispatchQueue.main.async{
                guard let data = data, error == nil else{
                    return
                }
                do{
                    let decoder = JSONDecoder()
                    let decodedData = try decoder.decode(AddUserToServerViaNumResponse.self, from: data)
                    
                    withAnimation(.easeInOut){
                        if decodedData.message != "User created successfully" {
                            loginData.userAlreadyExist = true
                            print("User Already Exist")
                        }
                        loginData.mainUserID = decodedData.userID
                        loginData.logStatusviaNumber = true
                        loginData.showLoader = false
                    }
//                    loginData.mesiboToken = addUserResponse.token
                    return
                } catch {
                    print(error)
                }
            }
        }
        task.resume()

    }
    
    
    func getUserDetails(loginData: LoginViewModel) async -> String {
        print("Getting rown user with this id:")
        print(loginData.mainUserID)
        
        var urlString = "http://64.227.150.47/main/profile/\(loginData.mainUserID)"
        print(urlString)
        
        guard let url = URL(string: urlString) else {
            print("Unable to create URL for API call")
            return "Failure: Invalid URL"
        }
        
        print("Making API Call to register user...........")

        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decoder = JSONDecoder()
            let decodedData = try decoder.decode(UserDataFromServer.self, from: data)
            
            
            loginData.mainUserEmail = decodedData.email
            loginData.mainUserProfilePic = decodedData.profilePic
            loginData.mainUserFullName = decodedData.fullName
            loginData.profileCompletionPercentage = decodedData.profileCompletionStatus
            loginData.mainUserRole = decodedData.role
            loginData.mainUserPhoneNumber = decodedData.phone
            loginData.mainUserVerificationStatus = decodedData.verificationStatus
            loginData.showLoader = false
            loginData.logStatusviaNumber = true
            loginData.mainUserVerificationStatus = decodedData.verificationStatus
            if decodedData.mesiboAccount.count > 0 {
                loginData.mainUserMesiboToken = decodedData.mesiboAccount[0].token
            }
            
            print("Successfully fetched data")
            return "Success"
        } catch {
            print("Error: \(error)")
            return "Failure: \(error.localizedDescription)"
        }
    }


    
    //multipart api call to send picture over server
    
    func updateUserDataAfterLogin(loginData: LoginViewModel, profilePic: UIImage?, fullName: String, email: String, apnToken: String) {
//          let userphonenumber: Int = (loginData.mainUserPhoneNumber.deletingPrefix("+") as NSString).integerValue
        //Set Your URL
            let api_url = "http://64.227.150.47/main/update/\(loginData.mainUserID)"
            guard let url = URL(string: api_url) else {
                return
            }

            var urlRequest = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 10.0 * 1000)
            urlRequest.httpMethod = "PATCH"
            urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")

            //Set Image Data
           // Now Execute
            AF.upload(multipartFormData: { multiPart in
                multiPart.append((fullName).data(using: String.Encoding.utf8)!, withName: "Full_name")
                multiPart.append((email).data(using: String.Encoding.utf8)!, withName: "Email")
                if apnToken != "" {
                    multiPart.append((apnToken).data(using: String.Encoding.utf8)!, withName: "device_token")
                }
                if profilePic != nil {
                    let uiImage: UIImage = profilePic!
                    let imgData = uiImage.jpegData(compressionQuality: 0.5)!
                    multiPart.append(imgData, withName: "Profile_pic", fileName: randomString(length: 6)+"profilepic.png", mimeType: "image/png")
                }
            }, with: urlRequest)
                .uploadProgress(queue: .main, closure: { progress in
                    //Current upload progress of file
                    print("Upload Progress: \(progress.fractionCompleted)")
                })
                .responseJSON(completionHandler: { data in

                           switch data.result {

                           case .success(_):

                            do {

                            let dictionary = try JSONSerialization.jsonObject(with: data.data!, options: .fragmentsAllowed) as! NSDictionary

                                print("Success!")
                                print(dictionary)
                                self.updateMesiboDataOnUserProfile(loginData: loginData)
                           }
                           catch {
                              // catch error.
                            print("catch error")

                                  }
                            break

                           case .failure(_):
                            print("failure")

                            break

                        }


                })
    }
    
    func updateuserDataAfterLoginWithoutImage(loginData: LoginViewModel) {
        
        //Updating the user Interest
        print("Starting to update user profile without image")
        print("using these info to update: ")
        print(loginData.mainUserFullName)
        print(loginData.mainUserEmail)
        print(loginData.mainUserProfilePic)
        
        guard let url = URL(string: "http://64.227.150.47/main/update/\(loginData.mainUserID)") else {
            print("Error: cannot create URL")
            return
        }
        
        // Create & Add data to the model
        let body: [String: AnyHashable] = [
            "Full_name": loginData.mainUserFullName,
            "Email": loginData.mainUserEmail,
            "Profile_pic": loginData.mainUserProfilePic,
            "device_token": loginData.apnToken
        ]
        
        
        
        // Create the request
        var request = URLRequest(url: url)
        request.httpMethod = "PATCH"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // Convert request to JSON data
        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            DispatchQueue.main.async {
                guard error == nil else {
                    print("Error: error calling PATCH")
                    print(error!)
                    return
                }
                guard let data = data else {
                    print("Error: Did not receive data")
                    return
                }
                guard let response = response as? HTTPURLResponse, (200 ..< 299) ~= response.statusCode else {
                    print("Error: HTTP request failed")
                    return
                }
                do {
                    let decoder = JSONDecoder()
                    let decodedData = try decoder.decode(NormalMessageResponse.self, from: data)
                    
                    print("user data updated on server")
                    self.updateMesiboDataOnUserProfile(loginData: loginData)
                } catch {
                    print("Error: Trying to convert JSON data to string")
                    return
                }
            }
        }
        task.resume()
        
    }
    
    func updateMesiboDataOnUserProfile(loginData: LoginViewModel) {
        
        //Updating the user Interest
        print("Starting to update mesibo data in user profile")
        print("using these interestId to update: ")
        print(loginData.mainUserMesiboToken)
        print(loginData.mainUserPhoneNumber)
        print(loginData.mainUserMesiboUID)
        
        guard let url = URL(string: "http://64.227.150.47/main/update/\(loginData.mainUserID)") else {
            print("Error: cannot create URL")
            return
        }
        
        // Create & Add data to the model
        let mesibobody: [String: AnyHashable] = [
            "uid": loginData.mainUserMesiboUID,
            "address": loginData.mainUserPhoneNumber,
            "token": loginData.mainUserMesiboToken
          ]
        let body: [String: AnyHashable] = [
            "Mesibo_account": mesibobody
        ]
        
        
        
        // Create the request
        var request = URLRequest(url: url)
        request.httpMethod = "PATCH"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // Convert request to JSON data
        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            DispatchQueue.main.async {
                guard error == nil else {
                    print("Error: error calling PATCH")
                    print(error!)
                    return
                }
                guard let data = data else {
                    print("Error: Did not receive data")
                    return
                }
                guard let response = response as? HTTPURLResponse, (200 ..< 299) ~= response.statusCode else {
                    print("Error: HTTP request failed")
                    return
                }
                do {
                    let decoder = JSONDecoder()
                    let decodedData = try decoder.decode(NormalMessageResponse.self, from: data)
                    
                    print("mesibo data updated on server")
                } catch {
                    print("Error: Trying to convert JSON data to string")
                    return
                }
            }
        }
        task.resume()
    }
    
    func getUserList() {
        
    }
    
    
    
    // MARK: - patch service
    func blockUserAPI(blockedID: String, blockerID: String) async -> String {
        print("Blocking ID")
        
        guard let url = URL(string: "http://64.227.150.47/main/block/\(blockerID)") else {
            print("Error: cannot create URL")
            return "Failure: Invalid URL"
        }
        
        // Create & Add data to the model
        let body: [String: AnyHashable] = [
            "user_id": blockedID
        ]
        
        
        // Create the request
        var request = URLRequest(url: url)
        request.httpMethod = "PATCH"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // Convert request to JSON data
        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            guard let httpResponse = response as? HTTPURLResponse, (200 ..< 299) ~= httpResponse.statusCode else {
                print("Error: HTTP request failed")
                return "Failure: HTTP request failed"
            }
            
            let decoder = JSONDecoder()
            let decodedData = try decoder.decode(NormalMessageResponse.self, from: data)
            
            print("user is blocked")
            return "Success"
        } catch {
            print("Error: \(error)")
            return "Failure: \(error.localizedDescription)"
        }
    }

    // MARK: - fetch service

    func getBlockedUsers(userID: String, globalVM: GlobalViewModel) async -> String {
        globalVM.blockedUserList = [BlockedUserListModel]()
        
        print("Starting to get blocked users")
        guard let url = URL(string: "http://64.227.150.47/main/userList/\(userID)") else {
            print("Error: cannot create URL")
            return "Failure: Invalid URL"
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            let (data, response) = try await URLSession.shared.data(for: urlRequest)
            guard let httpResponse = response as? HTTPURLResponse, (200 ..< 299) ~= httpResponse.statusCode else {
                print("Error: HTTP request failed")
                return "Failure: HTTP request failed"
            }
            
            let decoder = JSONDecoder()
            let decodedData = try decoder.decode([BlockedUserListModel].self, from: data)
            
            globalVM.blockedUserList = decodedData
            return "Success"
        } catch {
            print("Error: \(error)")
            return "Failure: \(error.localizedDescription)"
        }
    }

    
    // MARK: - patch service
    func unblockUserAPI(blockedID: String, blockerID: String) async -> String {
        print("unBlocking ID")
        
        guard let url = URL(string: "http://64.227.150.47/main/unblock/\(blockerID)") else {
            print("Error: cannot create URL")
            return "Failure: Invalid URL"
        }
        
        // Create & Add data to the model
        let body: [String: AnyHashable] = [
            "user_id": blockedID
        ]
        
        
        // Create the request
        var request = URLRequest(url: url)
        request.httpMethod = "PATCH"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // Convert request to JSON data
        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            guard let httpResponse = response as? HTTPURLResponse, (200 ..< 299) ~= httpResponse.statusCode else {
                print("Error: HTTP request failed")
                return "Failure: HTTP request failed"
            }
            
            let decoder = JSONDecoder()
            let decodedData = try decoder.decode(NormalMessageResponse.self, from: data)
            
            print("user is unblocked")
            return "Success"
        } catch {
            print("Error: \(error)")
            return "Failure: \(error.localizedDescription)"
        }
    }
    
}
