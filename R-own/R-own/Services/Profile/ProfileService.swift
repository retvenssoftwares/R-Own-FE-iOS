//
//  ProfileService.swift
//  R-own
//
//  Created by Aman Sharma on 29/05/23.
//

import Foundation
import SwiftUI
import Alamofire

class ProfileService: ObservableObject{
    
    
    // MARK: - fetch service


    func getMediaPosts(loginData: LoginViewModel, globalVM: GlobalViewModel, userID: String) {
        
            loginData.showLoader.toggle()
        globalVM.getMediaPost = [ProfileMediaPostModel]()
        //Updating the user Interest
        print("Starting to get media posts")
    
        guard let url = URL(string: "http://64.227.150.47/main/getPostMedia/\(userID)/\(userID)") else {
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
                    let decodedData = try decoder.decode([ProfileMediaPostModel].self, from: data)
                    globalVM.getMediaPost = decodedData
                    print("Users media posts fetched ")
    
                } catch {
                    print("Error: Trying to convert JSON data to string")
                    return
                }
            }
        }
        task.resume()
        loginData.showLoader.toggle()
    }

    
    // MARK: - fetch service


    func getPollsPosts(globalVM: GlobalViewModel, userID: String, pageNumber: Int, loginData: LoginViewModel) {
    
        //Updating the user Interest
        print("Starting to get polls posts")
    
        guard let url = URL(string: "http://64.227.150.47/main/getPolls/\(userID)/\(loginData.mainUserID)?page=\(pageNumber)") else {
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
                    let decodedData = try decoder.decode([ProfilePollsPostModel].self, from: data)
                    globalVM.getPollPost[0].posts = globalVM.getPollPost[0].posts + decodedData[0].posts
                    print("User polls fetched")
                } catch {
                    print("Error: Trying to convert JSON data to string")
                    return
                }
            }
        }
        task.resume()
    }
    
    // MARK: - fetch service


    func getStatusPosts(globalVM: GlobalViewModel, userID: String, loginData: LoginViewModel, page: String) {
    
        //Updating the user Interest
        print("Starting to get status posts ")
    
        guard let url = URL(string: "http://64.227.150.47/main/getStatus/\(userID)/\(loginData.mainUserID)?page=\(page)") else {
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
                    let decodedData = try decoder.decode([ProfileStatusPostModel].self, from: data)
                    for i in 0..<decodedData[0].posts.count {
                        globalVM.getStatusPostList[0].posts.append(decodedData[0].posts[i])
                    }
                    print("User status posts fetched")
                } catch {
                    print("Error: Trying to convert JSON data to string")
                    if globalVM.getStatusPostList.count > 0 {
                        if globalVM.getStatusPostList[0].posts != nil {
                            if globalVM.getStatusPostList[0].posts.count == 0 {
                                globalVM.getStatusPostList = []
                            }
                        }
                    }
                    return
                }
            }
        }
        task.resume()
    }
    
    // MARK: - fetch service


    func getHotelPosts(globalVM: GlobalViewModel, userID: String) {
    
        //Updating the user Interest
        print("Starting to get hotel posts")
    
        guard let url = URL(string: "http://64.227.150.47/main/getHotel/\(userID)") else {
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
                    let decodedData = try decoder.decode(ProfileHotelPostModel.self, from: data)
                    print("Users Hotels Fetched ")
    
                } catch {
                    print("Error: Trying to convert JSON data to string")
                    return
                }
            }
        }
        task.resume()
    }
    
    // MARK: - fetch service


    func getServicePosts(globalVM: GlobalViewModel, userID: String) {
    
        //Updating the user Interest
        print("Starting to get service posts")
    
        guard let url = URL(string: "http://64.227.150.47/main/getService/\(userID)") else {
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
                    let decodedData = try decoder.decode(ProfileServicesPostModel.self, from: data)
                    
                    print("Service posts fetched ")
    
                } catch {
                    print("Error: Trying to convert JSON data to string")
                    return
                }
            }
        }
        task.resume()
    }
    
    // MARK: - fetch service


    func getEventPosts(globalVM: GlobalViewModel, userID: String) {
    
        //Updating the user Interest
        print("Starting to get event posts")
    
        guard let url = URL(string: "http://64.227.150.47/main/getEvent/\(userID)") else {
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
                    let decodedData = try decoder.decode(ProfileEventsPostModel.self, from: data)
                    print("users event posts fetched ")
    
                } catch {
                    print("Error: Trying to convert JSON data to string")
                    return
                }
            }
        }
        task.resume()
    }
    
    // MARK: - fetch service

    func getRequestsList(globalVM: GlobalViewModel, userID: String) async -> String {
        DispatchQueue.main.async {
            globalVM.getRequestList = ProfileRequestListModel(conns: [])
        }
        
        print("Starting to get user request lists")
        
        guard let url = URL(string: "http://64.227.150.47/main/allRequests/\(userID)") else {
            print("Error: cannot create URL")
            return "Failure: Invalid URL"
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            guard let httpResponse = response as? HTTPURLResponse, (200 ..< 299) ~= httpResponse.statusCode else {
                print("Error: HTTP request failed")
                return "Failure: HTTP request failed"
            }
            
            let decoder = JSONDecoder()
            let decodedData = try decoder.decode(ProfileRequestListModel.self, from: data)
            
            DispatchQueue.main.async {
                globalVM.getRequestList = decodedData
            }
            print("Users Request list fetched")
            
            return "Success"
        } catch {
            print("Error: \(error.localizedDescription)")
            return "Failure: \(error.localizedDescription)"
        }
    }

    
    // MARK: - fetch service

    
    func getConnectionsList(globalVM: GlobalViewModel, userID: String) async -> String {
        
        
        DispatchQueue.main.async {
            globalVM.getConnectionList = [ProfileConnectionListModel]()
        }
        
        print("Starting to get users connections list")
        
        guard let url = URL(string: "http://64.227.150.47/main/connectionList/\(userID)") else {
            print("Error: cannot create URL")
            return "Failure: Invalid URL"
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            guard let httpResponse = response as? HTTPURLResponse, (200 ..< 299) ~= httpResponse.statusCode else {
                print("Error: HTTP request failed")
                return "Failure: HTTP request failed"
            }
            
            let decoder = JSONDecoder()
            let decodedData = try decoder.decode([ProfileConnectionListModel].self, from: data)
            
            
            // Update the ViewModel on the main thread
            DispatchQueue.main.async {
                globalVM.getConnectionList = decodedData
            }
            print("Users connection lists fetched")
            
            return "Success"
        } catch {
            print("Error: \(error.localizedDescription)")
            return "Failure: \(error.localizedDescription)"
        }
    }


    
    // MARK: - fetch service

    func getNormalProfileHeader(loginData: LoginViewModel, globalVM: GlobalViewModel, userID: String, connectionUserID: String) async -> String {
        
        print("Starting to get normal user profile header details ")
        
        DispatchQueue.main.async {
            globalVM.getNormalProfileHeader = NormalProfileHeaderModel(data: DataClass543(profile: Profile543(id: "", fullName: "", profilePic: "", verificationStatus: "", userBio: "", userName: "", location: "", normalUserInfo: [NormalUserInfo543](), mesiboAccount: [MesiboAccount](), userID: "", postCount: [PostCount543](), createdOn: ""), postCountLength: 0, connCountLength: 0, reqsCountLength: 0, connectionStatus: ""))
        }
        
        print("Starting to get profile header")
        print("http://64.227.150.47/main/normalProfile/\(userID)/\(connectionUserID)")
        
        guard let url = URL(string: "http://64.227.150.47/main/normalProfile/\(userID)/\(connectionUserID)") else {
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
            let decodedData = try decoder.decode(NormalProfileHeaderModel.self, from: data)
            
            print("Users normal profile header fetched")
            
            DispatchQueue.main.async{
                globalVM.getNormalProfileHeader = decodedData
                print("normal profile header")
                print(globalVM.getNormalProfileHeader)
            }
            return "Success"
        } catch {
            print("Error: \(error)")
            return "Failure: \(error.localizedDescription)"
        }
    }

    
    // MARK: - fetch service

    func getVendorProfileHeader(globalVM: GlobalViewModel, userID: String, connectionUserID: String) async -> String {
        DispatchQueue.main.async {
            globalVM.getVendorProfileHeader = VendorProfileHeaderModel(roleDetails: RoleDetails321(vendorInfo: VendorInfo321(vendorImage: "", vendorName: "", vendorDescription: "", websiteLink: "", vendorServices: [VendorService321](), portfolioLink: [PortfolioLink321]()), id: "", fullName: "", profilePic: "", mesiboAccount: [MesiboAccount](), verificationStatus: "", userBio: "", createdOn: "", userName: "", location: "", role: "", postCount: [JSONAny]()), postcount: 0, connectioncount: 0, requestcount: 0, connectionStatus: "")
        }
        
        print("Starting to get vendor profile header ")
        
        guard let url = URL(string: "http://64.227.150.47/main/vendorInfo/\(userID)/\(connectionUserID)") else {
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
            let decodedData = try decoder.decode(VendorProfileHeaderModel.self, from: data)
            
            DispatchQueue.main.async{
                globalVM.getVendorProfileHeader = decodedData
            }
            
            print("Vendors profile header fetched ")
            
            return "Success"
        } catch {
            print("Error: \(error)")
            return "Failure: \(error.localizedDescription)"
        }
    }

    
    // MARK: - fetch service

    func getHotelOwnerProfileHeader(globalVM: GlobalViewModel, userID: String, connectionUserID: String) async -> String {
        
        print("Starting to get hotel owner profile header details")
        
        DispatchQueue.main.async {
            globalVM.getHotelOwnerProfileHeader = HotelOwnerProfileHeaderModel(profiledata: Profiledata3433(id: "", fullName: "", profilePic: "", mesiboAccount: [MesiboAccount](), userBio: "", userName: "", postCount: [PostCount3433]()), hotellogo: Hotellogo3433(id: "", hotelLogoURL: ""), connectionCount: 0, requestsCount: 0, postCount: 0, profile: Profile3433(hotelOwnerInfo: HotelOwnerInfo3433(hotelDescription: "", websiteLink: ""), id: "", verificationStatus: "", createdOn: "", location: ""), connectionStatus: "")
        }
        
        print("Starting to get hotel owner profile")
        guard let url = URL(string: "http://64.227.150.47/main/hotelInfo/\(userID)/\(connectionUserID)") else {
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
            let decodedData = try decoder.decode(HotelOwnerProfileHeaderModel.self, from: data)
            print("Hotel owner profile header details fetched")
            
            DispatchQueue.main.async{
                globalVM.getHotelOwnerProfileHeader = decodedData
            }
            return "Success"
        } catch {
            print("Error: \(error)")
            return "Failure: \(error.localizedDescription)"
        }
    }

    
    
    // MARK: - patch service

    func sendRequest(loginData: LoginViewModel, senderID: String, receiverID: String) {
    
        //Updating the user Interest
        print("Sending request to user")
        
        guard let url = URL(string: "http://64.227.150.47/main/sendRequest/\(receiverID)") else {
            print("Error: cannot create URL")
            return
        }
    
        // Create & Add data to the model
        let body: [String: AnyHashable] = [
            "user_id": senderID
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
                    
                    print("request sent")
                } catch {
                    print("Error: Trying to convert JSON data to string")
                    return
                }
            }
        }
        task.resume()
    
    }
    
    // MARK: - patch service
    
    func acceptRequest(loginData: LoginViewModel, senderID: String, receiverID: String) async -> String {
        do {
            // Updating the user Interest
            print("Accepting request of another user")
            
            
            guard let url = URL(string: "http://64.227.150.47/main/acceptRequest/\(senderID)") else {
                print("Error: cannot create URL")
                return "Failure: Cannot create URL"
            }

            // Create & Add data to the model
            let body: [String: AnyHashable] = [
                "user_id": receiverID
            ]

            // Create the request
            var request = URLRequest(url: url)
            request.httpMethod = "PATCH"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")

            // Convert request to JSON data
            request.httpBody = try JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)

            do {
                let (data, response) = try await URLSession.shared.data(for: request)

                guard (200 ..< 299) ~= (response as? HTTPURLResponse)?.statusCode ?? 0 else {
                    print("Error: HTTP request failed")
                    return "Failure: HTTP request failed"
                }

                let decoder = JSONDecoder()
                let decodedData = try decoder.decode(NormalMessageResponse.self, from: data)
                
                print("request accepeted")

                return "Success"
            } catch {
                print("Error: \(error)")
                return "Failure: \(error.localizedDescription)"
            }
        } catch {
            print("Error: \(error)")
            return "Failure: \(error.localizedDescription)"
        }
    }



    
    
    // MARK: - patch service
    func cancelRequest(loginData: LoginViewModel, senderID: String, receiverID: String) async -> String {
        
        print("Starting to cancel request ")
        
        guard let url = URL(string: "http://64.227.150.47/main/deleteRequest/\(senderID)") else {
            print("Error: cannot create URL")
            return "Failure: Cannot create URL"
        }
        
        let body: [String: AnyHashable] = [
            "user_id": receiverID
        ]
        
        var request = URLRequest(url: url)
        request.httpMethod = "PATCH"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)
        } catch {
            print("Error: Unable to serialize JSON data")
            return "Failure: Unable to serialize JSON data"
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            guard (200 ..< 299) ~= (response as? HTTPURLResponse)!.statusCode else {
                print("Error: HTTP request failed")
                return "Failure: HTTP request failed"
            }
            
            do {
                let decoder = JSONDecoder()
                let decodedData = try decoder.decode(NormalMessageResponse.self, from: data)
                
                print("request cancelled")
                return "Success"
            } catch {
                print("Error: Trying to convert JSON data to string")
                return "Failure: JSON decoding error"
            }
        } catch {
            print("Error: Error calling PATCH")
            print(error)
            return "Failure: Error calling PATCH"
        }
    }

    
    // MARK: - patch service

    func removeConnection(loginData: LoginViewModel, senderID: String, receiverID: String) {
    
        //Updating the user Interest
        
        print("Starting to remove connection")
    
        guard let url = URL(string: "http://64.227.150.47/main/deleteConn/\(receiverID)") else {
            print("Error: cannot create URL")
            return
        }
    
        // Create & Add data to the model
        let body: [String: AnyHashable] = [
            "user_id": senderID
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
                    
                    print("connection removed")
                    
                } catch {
                    print("Error: Trying to convert JSON data to string")
                    return
                }
            }
        }
        task.resume()
    
    }
    
    // MARK: - patch service

    func removeRequest(loginData: LoginViewModel, senderID: String, receiverID: String) {
    
        //Updating the user Interest
        
        print("Starting to remove request")
        
    
        guard let url = URL(string: "http://64.227.150.47/main/deleteConn/\(receiverID)") else {
            print("Error: cannot create URL")
            return
        }
    
        // Create & Add data to the model
        let body: [String: AnyHashable] = [
            "user_id": senderID
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
                    
                    print("request removed")
                } catch {
                    print("Error: Trying to convert JSON data to string")
                    return
                }
            }
        }
        task.resume()
    
    }
    
    // MARK: - fetch service


    func getPollVotes(globalVM: GlobalViewModel, postID: String) {
    
        globalVM.getPollVotes = [PollVotesModel]()
        //Updating the user Interest
        print("Starting to get poll votes")
    
        guard let url = URL(string: "http://64.227.150.47/main/getPollsVotes/\(postID)") else {
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
                    let decodedData = try decoder.decode([PollVotesModel].self, from: data)
                    globalVM.getPollVotes = decodedData
                    
                    print("Poll votes fetched")
                    
                } catch {
                    print("Error: Trying to convert JSON data to string")
                    return
                }
            }
        }
        task.resume()
    }
    
    
    // MARK: - patch service
    func updateExperienceforHotelier(userID: String, index: String, userDescription: String, jobType: String, jobTitle: String, hotelCompany: String, jobStartYear: String, jobEndYear: String) async -> String {
        
        print("Updating hotelier job list")
        
        guard let url = URL(string: "http://64.227.150.47/main/update/\(userID)") else {
            print("Error: cannot create URL")
            return "Failure: Invalid URL"
        }
        
        let body: [String: AnyHashable] = [
            "index": index,
            "userDescription": userDescription,
            "jobtype": jobType,
            "jobtitle": jobTitle,
            "hotelCompany": hotelCompany,
            "jobstartYear": jobStartYear,
            "jobendYear": jobEndYear
        ]
        
        var request = URLRequest(url: url)
        request.httpMethod = "PATCH"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)
            
            let (data, response) = try await URLSession.shared.data(for: request)
            guard let httpResponse = response as? HTTPURLResponse, (200 ..< 299) ~= httpResponse.statusCode else {
                print("Error: HTTP request failed")
                return "Failure: HTTP request failed"
            }
            
            let decoder = JSONDecoder()
            let decodedData = try decoder.decode(NormalMessageResponse.self, from: data)
            
            print("user job data updated on server")
            
            return "Success"
        } catch {
            print("Error: \(error)")
            return "Failure: \(error.localizedDescription)"
        }
    }

    
    // MARK: - patch service
    func updateExperienceforNormalUser(userID: String, index: String, userDescription: String, jobType: String, jobTitle: String, hotelCompany: String, jobStartYear: String, jobEndYear: String) async -> String {
        
        print("Updating normal user job")
        
        guard let url = URL(string: "http://64.227.150.47/main/update/\(userID)") else {
            print("Error: cannot create URL")
            return "Failure: Invalid URL"
        }
        
        let body: [String: AnyHashable] = [
            "index": index,
            "userDescription": userDescription,
            "jobType": jobType,
            "jobTitle": jobTitle,
            "jobCompany": hotelCompany,
            "jobStartYear": jobStartYear,
            "jobEndYear": jobEndYear
        ]
        
        var request = URLRequest(url: url)
        request.httpMethod = "PATCH"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)
            
            let (data, response) = try await URLSession.shared.data(for: request)
            guard let httpResponse = response as? HTTPURLResponse, (200 ..< 299) ~= httpResponse.statusCode else {
                print("Error: HTTP request failed")
                return "Failure: HTTP request failed"
            }
            
            let decoder = JSONDecoder()
            let decodedData = try decoder.decode(NormalMessageResponse.self, from: data)
            
            print("user data updated on server")
            
            return "Success"
        } catch {
            print("Error: \(error)")
            return "Failure: \(error.localizedDescription)"
        }
    }

    
    // MARK: - patch service
    func updateEducationofUser(userID: String, index: String, educationPlace: String, education_session_start: String, education_session_end: String) async -> String {
        
        print("Updating user education")
        
        guard let url = URL(string: "http://64.227.150.47/main/update/\(userID)") else {
            print("Error: cannot create URL")
            return "Failure: Invalid URL"
        }
        
        let body: [String: AnyHashable] = [
            "index": index,
            "educationPlace": educationPlace,
            "education_session_start": education_session_start,
            "education_session_end": education_session_end,
        ]
        
        var request = URLRequest(url: url)
        request.httpMethod = "PATCH"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)
            
            let (data, response) = try await URLSession.shared.data(for: request)
            guard let httpResponse = response as? HTTPURLResponse, (200 ..< 299) ~= httpResponse.statusCode else {
                print("Error: HTTP request failed")
                return "Failure: HTTP request failed"
            }
            
            let decoder = JSONDecoder()
            let decodedData = try decoder.decode(NormalMessageResponse.self, from: data)
            
            print("user education data updated on server")
            return "Success"
        } catch {
            print("Error: \(error)")
            return "Failure: \(error.localizedDescription)"
        }
    }

    
    // MARK: - patch service
//    func updateEducationofUser(userID: String, index: String, educationPlace: String, education_session_start: String, education_session_end: String) async -> String {
//        print("Updating hotelier job")
//        guard let url = URL(string: "http://64.227.150.47/main/update/\(userID)") else {
//            print("Error: cannot create URL")
//            return "Failure: Invalid URL"
//        }
//
//        let body: [String: AnyHashable] = [
//            "index": index,
//            "educationPlace": educationPlace,
//            "education_session_start": education_session_start,
//            "education_session_end": education_session_end,
//        ]
//        
//
//        var request = URLRequest(url: url)
//        request.httpMethod = "PATCH"
//        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//
//        do {
//            request.httpBody = try JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)
//
//            let (data, response) = try await URLSession.shared.data(for: request)
//            guard let httpResponse = response as? HTTPURLResponse, (200 ..< 299) ~= httpResponse.statusCode else {
//                print("Error: HTTP request failed")
//                return "Failure: HTTP request failed"
//            }
//
//            let decoder = JSONDecoder()
//            let decodedData = try decoder.decode(NormalMessageResponse.self, from: data)
//            
//            print("user data updated on server")
//            return "Success"
//        } catch {
//            print("Error: \(error)")
//            return "Failure: \(error.localizedDescription)"
//        }
//    }
    
    func updateEditNormalUser(userID: String, userBio: String, userIdentity: String, profileImage: UIImage!) async -> String {
        
        print("trying to edit normal user details ")
        
        let api_url = "http://64.227.150.47/main/update/\(userID)"
        guard let url = URL(string: api_url) else {
            return "API Error"
        }

        var urlRequest = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 10.0 * 1000)
        urlRequest.httpMethod = "PATCH"
        urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")

        do {
            let response = try await withUnsafeThrowingContinuation { continuation in
                AF.upload(multipartFormData: { multiPart in
                    multiPart.append((userBio).data(using: String.Encoding.utf8)!, withName: "userBio")
                    multiPart.append((userIdentity).data(using: String.Encoding.utf8)!, withName: "Gender")
                    if profileImage != nil {
                        //Set Image Data
                        let uiImage: UIImage = profileImage!
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
                            continuation.resume(returning: "Success")
                        } catch {
                            // catch error.
                            print("catch error")
                            continuation.resume(returning: "Failure")
                        }
                    case .failure(let error):
                        print("failure")
                        print(error)
                        if let data = data.data, let responseString = String(data: data, encoding: .utf8) {
                            print(responseString)
                        }
                        continuation.resume(returning: "Failure")
                    }
                })
            }

            return response
        } catch {
            return "Error: \(error)"
        }
    }
    
    
    // MARK: - fetch service

    func getPostByID(globalVM: GlobalViewModel, userID: String, postID: String) async -> String {
        
        print("Starting to get post data by ID")
        
        DispatchQueue.main.async {
            globalVM.postDetails = [GetPostModel]()
        }
        
        guard let url = URL(string: "http://64.227.150.47/main/getPost/\(userID)/\(postID)") else {
            print("Error: cannot create URL")
            return "Failure: Invalid URL"
        }
        
        // Create the request
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            guard let httpResponse = response as? HTTPURLResponse, (200 ..< 299) ~= httpResponse.statusCode else {
                print("Error: HTTP request failed")
                return "Failure: HTTP request failed"
            }
            
            let decoder = JSONDecoder()
            let decodedData = try decoder.decode([GetPostModel].self, from: data)
            
            DispatchQueue.main.async {
                globalVM.postDetails = decodedData
            }
            print("fetched post data ")
            
            return "Success"
        } catch {
            print("Error: \(error)")
            return "Failure: \(error.localizedDescription)"
        }
    }


}
