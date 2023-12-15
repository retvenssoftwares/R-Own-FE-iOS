//
//  CommunityService.swift
//  R-own
//
//  Created by Aman Sharma on 26/06/23.
//

import SwiftUI
import Alamofire

class CommunityService: ObservableObject{
    
    
    
    
    // MARK: - post service

    func createMesiboGroup(loginData: LoginViewModel, communityVM: CommunityViewModel, image: UIImage?) async -> String {
        print("Starting to create community in mesibo")
        
        let userID = await loginData.mainUserID
        
        guard let url = URL(string: "http://64.227.150.47/main/createGroup/\(userID)") else {
            print("Error: cannot create URL")
            return "Failure: Invalid URL"
        }

        // Create & Add data to the model
        let body: [String: AnyHashable] = [
            "attribute": communityVM.communityName
        ]
        // Create the request
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
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
            let decodedData = try decoder.decode(CreateCommunityMesiboResponse.self, from: data)
            print("mesibo group created")
            print("Now adding group in collection of db")
            DispatchQueue.main.async {
                communityVM.communityJustMadeID = decodedData.group.gid
                self.addCommunity(loginData: loginData, communityVM: communityVM, groupID: String(decodedData.group.gid), image: image)
            }
            return "Success"
        } catch {
            print("Error: \(error)")
            return "Failure: \(error.localizedDescription)"
        }
    }

    
    
    // MARK: - multipart service


    func addCommunity(loginData: LoginViewModel, communityVM: CommunityViewModel, groupID: String, image: UIImage?) {
    //        let userphonenumber: Int = (loginData.mainUserPhoneNumber.deletingPrefix("+") as NSString).integerValue
        //Set Your URL
        
        print("Starting to add community ")
            let api_url = "http://64.227.150.47/main/userGroup"
            guard let url = URL(string: api_url) else {
                return
            }
    
            var urlRequest = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 10.0 * 1000)
            urlRequest.httpMethod = "POST"
            urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
    
            //Set Image Data
            let uiImage: UIImage = image!
            let imgData = uiImage.jpegData(compressionQuality: 0.5)!
           // Now Execute
            AF.upload(multipartFormData: { multiPart in
                multiPart.append((loginData.mainUserID).data(using: String.Encoding.utf8)!, withName: "creatorID")
                multiPart.append((communityVM.communityName).data(using: String.Encoding.utf8)!, withName: "group_name")
                multiPart.append((groupID).data(using: String.Encoding.utf8)!, withName: "group_id")
                multiPart.append((communityVM.communityLocation).data(using: String.Encoding.utf8)!, withName: "location")
                multiPart.append((communityVM.communityLatitude).data(using: String.Encoding.utf8)!, withName: "latitude")
                multiPart.append((communityVM.communityLongitude).data(using: String.Encoding.utf8)!, withName: "longitude")
                multiPart.append((communityVM.communityType).data(using: String.Encoding.utf8)!, withName: "community_type")
                multiPart.append((communityVM.communityDescription).data(using: String.Encoding.utf8)!, withName: "description")
                multiPart.append(imgData, withName: "Profile_pic", fileName: randomString(length: 6)+"groupProfilePic.png", mimeType: "image/png")
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
    
                                print("Success! Community Created in the database")
                                print(dictionary)
                                
                                for i in 0..<communityVM.selectedGroupMember.count {
                                    if communityVM.selectedGroupMember[i].userID != loginData.mainUserID {
                                        self.addMemberInCommunity(communityID: groupID, userID: communityVM.selectedGroupMember[i].userID)
                                    }
                                }
                                
                                self.addMemberInMesiboGroup(loginData: loginData, groupID: groupID, userAttribute: self.extractAddresses(from: communityVM.selectedGroupMember))
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
    
    // MARK: - patch service

    func addMemberInCommunity(communityID: String, userID: String) {
        
        
        //Updating the user Interest
        print("Starting to add members to community")
    
        guard let url = URL(string: "http://64.227.150.47/main/addUser/\(communityID)") else {
            print("Error: cannot create URL")
            return
        }
    
        // Create & Add data to the model
        let body: [String: AnyHashable] = [
            "user_id": userID
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
                    print("user data updated on db")
                    print("adding user on mesibo group")
                } catch {
                    print("Error: Trying to convert JSON data to string")
                    return
                }
            }
        }
        task.resume()
    
    }
    
    // MARK: - post service

    func addMemberInMesiboGroup(loginData: LoginViewModel, groupID: String, userAttribute: String) {
    
        //Updating the user Interest
        print("Starting to add member in community in mesibo")
    
        guard let url = URL(string: "http://64.227.150.47/main/addMember") else {
            print("Error: cannot create URL")
            return
        }
    
        // Create & Add data to the model
        let body: [String: AnyHashable] = [
            "group_id": groupID,
            "user": userAttribute
        ]
    
    
        // Create the request
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
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
                    
                    print("Added member to mesibo group")
                } catch {
                    print("Error: Trying to convert JSON data to string")
                    return
                }
            }
        }
        task.resume()
    
    }
    
    
    // MARK: - multipart service

    func updateGroupInfo(loginData: LoginViewModel, communityVM: CommunityViewModel, groupID: String, communityName: String, communityLocation: String, communityLat: String, communityLong: String, communityType: String, commuinityDescp: String, communityImage: UIImage?, completion: @escaping (Result<String, Error>) -> Void) {
        // Set Your URL
        print("Starting to update group/ community info")
        let api_url = "http://64.227.150.47/main/updateGroup/\(groupID)"
        guard let url = URL(string: api_url) else {
            completion(.failure(NSError(domain: "Invalid URL", code: -1, userInfo: nil)))
            return
        }

        var urlRequest = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 10.0 * 1000)
        urlRequest.httpMethod = "PATCH"
        urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")

        // Set Image Data
        // Now Execute
        AF.upload(multipartFormData: { multiPart in
            if communityName != "" {
                multiPart.append((communityName).data(using: String.Encoding.utf8)!, withName: "group_name")
            }
            if communityLocation != "" {
                multiPart.append((communityLocation).data(using: String.Encoding.utf8)!, withName: "location")
                multiPart.append((communityLat).data(using: String.Encoding.utf8)!, withName: "latitude")
                multiPart.append((communityLong).data(using: String.Encoding.utf8)!, withName: "longitude")
            }
            if communityType != "" {
                multiPart.append((communityType).data(using: String.Encoding.utf8)!, withName: "community_type")
            }
            if commuinityDescp != "" {
                multiPart.append((commuinityDescp).data(using: String.Encoding.utf8)!, withName: "description")
            }
            if let image = communityImage {
                if let imageData = image.jpegData(compressionQuality: 0.5) {
                    multiPart.append(imageData, withName: "Profile_pic", fileName: randomString(length: 6) + "groupProfilePic.png", mimeType: "image/png")
                }
            }
        }, with: urlRequest)
        .uploadProgress(queue: .main, closure: { progress in
            // Current upload progress of file
            print("Upload Progress: \(progress.fractionCompleted)")
        })
        .responseJSON(completionHandler: { response in
            switch response.result {
            case .success:
                if let data = response.data {
                    do {
                        let dictionary = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed) as! NSDictionary
                        print("Success! Community Updated")
                        print(dictionary)
                        completion(.success("Success"))
                    } catch {
                        print("Catch error")
                        completion(.failure(error))
                    }
                }
            case .failure(let error):
                print("Failure")
                completion(.failure(error))
            }
        })
    }

    
    // MARK: - multipart service

    func updateNewGroupInfo(loginData: LoginViewModel, communityVM: CommunityViewModel, groupID: String, communityName: String, commuinityDescp: String, communityImage: UIImage?, completion: @escaping (Result<String, Error>) -> Void) {
        // Set Your URL
        print("Starting to update group/ community info")
        let api_url = "http://64.227.150.47/main/editGroup"
        guard let url = URL(string: api_url) else {
            completion(.failure(NSError(domain: "Invalid URL", code: -1, userInfo: nil)))
            return
        }

        var urlRequest = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 10.0 * 1000)
        urlRequest.httpMethod = "PATCH"

        // Set Image Data
        // Now Execute
        AF.upload(multipartFormData: { multiPart in
            if groupID != "" {
                multiPart.append((groupID).data(using: String.Encoding.utf8)!, withName: "grp_id")
            }
            if communityName != "" {
                multiPart.append((communityName).data(using: String.Encoding.utf8)!, withName: "attribute")
            }
            if commuinityDescp != "" {
                multiPart.append((commuinityDescp).data(using: String.Encoding.utf8)!, withName: "description")
            }
            if let image = communityImage {
                if let imageData = image.jpegData(compressionQuality: 0.5) {
                    multiPart.append(imageData, withName: "image", fileName: randomString(length: 6) + "groupProfilePic.png", mimeType: "image/png")
                }
            }
        }, with: urlRequest)
        .uploadProgress(queue: .main, closure: { progress in
            // Current upload progress of file
            print("Upload Progress: \(progress.fractionCompleted)")
        })
        .responseJSON(completionHandler: { response in
            switch response.result {
            case .success:
                if let data = response.data {
                    do {
                        let dictionary = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed) as! NSDictionary
                        print("Success! Community Updated")
                        print(dictionary)
                        completion(.success("Success"))
                    } catch {
                        print("Catch error")
                        completion(.failure(error))
                    }
                }
            case .failure(let error):
                print("Failure")
                completion(.failure(error))
            }
        })
    }
    
    
    // MARK: - patch service

    func changeUserToAdmin(loginData: LoginViewModel, communityID: String, memberID: String) {
        
        print("Starting to change user status to admin ")
        //Updating the user Interest
        print("Starting to add members to community")
    
        guard let url = URL(string: "http://64.227.150.47/main/addUserId/\(communityID)") else {
            print("Error: cannot create URL")
            return
        }
    
        // Create & Add data to the model
        let body: [String: AnyHashable] = [
            "user_id": memberID
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
                } catch {
                    print("Error: Trying to convert JSON data to string")
                    return
                }
            }
        }
        task.resume()
    
    }

    
    // MARK: - fetch service

    func getCommunityDetailByGroupID(globalVM: GlobalViewModel, groupID: String) async -> String {
        
        print("Starting to get community details via groupID")
        DispatchQueue.main.async {
                
            globalVM.communityDetail = CommunityDetailModel(profilePic: "", groupName: "", description: "", dateAdded: "", creatorName: "", admin: [MesiboGroupUser](), members: [MesiboGroupUser](), latitude: "", longitude: "", communityType: "", totalmember: 0, location: "")
        }
        
        print("Starting to get group detailsss")
        guard let url = URL(string: "http://64.227.150.47/main/getGroup/\(groupID)") else {
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
            let decodedData = try decoder.decode(CommunityDetailModel.self, from: data)
            
            DispatchQueue.main.async {
                globalVM.communityDetail = decodedData
            }
            return "Success"
        } catch {
            print("Error: \(error)")
            return "Failure: \(error.localizedDescription)"
        }
    }

    
    // MARK: - fetch service


    func getCommunitiesNotJoined(globalVM: GlobalViewModel, userID: String) {
        
        print("Starting to get community that are not joined yet")
        globalVM.openCommunityModelList = [OwnCommunityGroupDetailsModel]()
        //Updating the user Interest
        print("Starting to get group details")
    
        guard let url = URL(string: "http://64.227.150.47/main/fetchCommunity/\(userID)") else {
            print("Error: cannot create URL")
            return
        }
    
    
    
        // Create the request
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    
    
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
    
            DispatchQueue.main.async {
                guard error == nil else {
                    print("Error: error calling GET")
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
                    let decodedData = try decoder.decode([OwnCommunityGroupDetailsModel].self, from: data)
                    
                    globalVM.openCommunityModelList = decodedData
    
                } catch {
                    print("Error: Trying to convert JSON data to string")
                    return
                }
            }
        }
        task.resume()
    }
    
    
    // MARK: - fetch service


    func getOwnedCommunities(globalVM: GlobalViewModel, userID: String) {
        
        print("Starting to get owned communities")
        
        globalVM.ownCommunityModelList = [OwnCommunityGroupDetailsModel]()
        //Updating the user Interest
        print("Starting to get own group details")
    
        guard let url = URL(string: "http://64.227.150.47/main/fetchGroup/\(userID)") else {
            print("Error: cannot create URL")
            return
        }
    
    
    
        // Create the request
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    
    
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
    
            DispatchQueue.main.async {
                guard error == nil else {
                    print("Error: error calling GET")
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
                    let decodedData = try decoder.decode([OwnCommunityGroupDetailsModel].self, from: data)
                    
                    globalVM.ownCommunityModelList = decodedData
    
                } catch {
                    print("Error: Trying to convert JSON data to string")
                    return
                }
            }
        }
        task.resume()
    }
    
    // MARK: - patch service

    func deleteCommunity(loginData: LoginViewModel, groupID: String) {
        
        print("Starting to delete community")
        
        //Updating the user Interest
        print("Starting to delete the community")
    
        guard let url = URL(string: "http://64.227.150.47/main/deleteData") else {
            print("Error: cannot create URL")
            return
        }
    
        // Create & Add data to the model
        let body: [String: AnyHashable] = [
            "groupid": groupID
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
                    print("group deleted")
                } catch {
                    print("Error: Trying to convert JSON data to string")
                    return
                }
            }
        }
        task.resume()
    
    }
    
    
    func ownDetailToMakeCommunity(loginData: LoginViewModel, communityVM: CommunityViewModel) {
        
        print("Starting to get own details to get users in it to make community")
        
        let urlString = "http://64.227.150.47/main/profile/\(loginData.mainUserID)"
        
        guard let url = URL(string: urlString) else {
            print("unable to rectify string in url for api call")
            return
        }
        
        print("Making API Call to register user...........")

        let request = URLRequest(url: url)


        //Make the request

        let task = URLSession.shared.dataTask(with: request){ data, response, error in
            DispatchQueue.main.async{
                guard let data = data, error == nil else{
                    return
                }
                do{
                    let decoder = JSONDecoder()
                    let decodedData = try decoder.decode(UserDataFromServer.self, from: data)
                    communityVM.selectedGroupMember.append(Conn334(id: decodedData.id, fullName: decodedData.fullName, phone: decodedData.phone, profilePic: decodedData.profilePic, mesiboAccount: [MesiboAccount4325(uid: decodedData.mesiboAccount[0].uid, address: decodedData.mesiboAccount[0].address, token: decodedData.mesiboAccount[0].token, id: decodedData.mesiboAccount[0].id)], verificationStatus: decodedData.verificationStatus, role: decodedData.role, userID: decodedData.userID, userName: loginData.mainUserUserName))
                    print("SUccesfully updated the list of members")
                    return
                } catch {
                    print(error)
                }
            }
        }
        task.resume()
    }
    
    //function used for add member of mesibo group api
    func extractAddresses(from conns: [Conn334]) -> String {
        var addresses: [String] = []
        
        for conn in conns {
            if let account = conn.mesiboAccount.first {
                addresses.append(account.address)
            }
        }
        
        let concatenatedAddresses = addresses.joined(separator: ",")
        return concatenatedAddresses
    }

    
    // MARK: - patch service
    
    func removeCommunityMember(groupID: String, userID: String) async -> String {
        
        print("Starting to remove community members")
        
        guard let url = URL(string: "http://64.227.150.47/main/removeMember/\(groupID)") else {
            print("Error: cannot create URL")
            return "Failure: Invalid URL"
        }

        // Create & Add data to the model
        let body: [String: AnyHashable] = [
            "user_id": userID
        ]

        // Create the request
        var request = URLRequest(url: url)
        request.httpMethod = "PATCH"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        // Convert request to JSON data
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)
        } catch {
            print("Error: Failed to serialize JSON data")
            return "Failure: Failed to serialize JSON data"
        }

        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            guard let httpResponse = response as? HTTPURLResponse, (200 ..< 299) ~= httpResponse.statusCode else {
                print("Error: HTTP request failed")
                return "Failure: HTTP request failed"
            }

            let decoder = JSONDecoder()
            do {
                let decodedData = try decoder.decode(NormalMessageResponse.self, from: data)
                print("Member removed")
                return "Success"
            } catch {
                print("Error: Trying to convert JSON data to string")
                return "Failure: \(error.localizedDescription)"
            }
        } catch {
            print("Error: \(error)")
            return "Failure: \(error.localizedDescription)"
        }
    }
    
    
    
    
    // MARK: - multipart service


    func sendGroupNotificationWithImage(loginData: LoginViewModel, title: String, body: String, groupID: String, senderUserID: String, messageImage: UIImage?) {
    //        let userphonenumber: Int = (loginData.mainUserPhoneNumber.deletingPrefix("+") as NSString).integerValue
        //Set Your URL
            let api_url = "http://64.227.150.47/main/sendGroupNotification"
        
            guard let url = URL(string: api_url) else {
                print("wrong url")
                return
            }
    
            var urlRequest = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 10.0 * 1000)
            urlRequest.httpMethod = "POST"
            urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
    
            //Set Image Data
           // Now Execute
            AF.upload(multipartFormData: { multiPart in
                multiPart.append((title).data(using: String.Encoding.utf8)!, withName: "title")
                print(22)
                multiPart.append((body).data(using: String.Encoding.utf8)!, withName: "body")
                print(23)
                multiPart.append((groupID).data(using: String.Encoding.utf8)!, withName: "group_id")
                print(24)
                multiPart.append((senderUserID).data(using: String.Encoding.utf8)!, withName: "sender_user_id")
                print(25)
                if let image = messageImage {
                    if let imageData = image.jpegData(compressionQuality: 0.3) {
                        multiPart.append(imageData, withName: "image", fileName: randomString(length: 6) + "groupMessageImage.png", mimeType: "image/png")
                    }
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

    // MARK: - post service

    func sendGroupNotificationWithoutImage(loginData: LoginViewModel, title: String, body: String, groupID: String, senderUserID: String) {
    
        //Updating the user Interest
        print("Starting to send message without image")
        
        guard let url = URL(string: "http://64.227.150.47/main/sendGroupNotificationWithoutImage") else {
            print("Error: cannot create URL")
            return
        }
    
        // Create & Add data to the model
        let body: [String: AnyHashable] = [
            "title": title,
            "body": body,
            "group_id": groupID,
            "sender_user_id": senderUserID
        ]
    
    
    
        // Create the request
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
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
    
                    print("sent notification")
                } catch {
                    print("Error: Trying to convert JSON data to string")
                    return
                }
            }
        }
        task.resume()
    
    }
}
