//
//  MainUserService.swift
//  R-own
//
//  Created by Aman Sharma on 12/04/23.
//

import Foundation


class MainUserService: ObservableObject{
    
    
    
    func getUser(loginData: LoginViewModel) {
        
        loginData.totalUserList = [UserDataFromServer]()
        print("Fetching total users from Server")
        guard let url = URL(string: "http://64.227.150.47/main/profile") else {
            print("unable to rectify string in url for api call")
            return
        }
        let task = URLSession.shared.dataTask(with: url){ data, _, error in
            DispatchQueue.main.async{
                guard let data = data, error == nil else{
                    return
                }
                do{
                    let decoder = JSONDecoder()
                    let decodedData = try decoder.decode([UserDataFromServer].self, from: data)
                    loginData.totalUserList = decodedData
                    loginData.showLoader = false
                    print("Users fetched.")
                    return
                } catch {
                    print(error)
                }
            }
        }
        
        task.resume()
    }
    
    func getUserProfile(loginData: LoginViewModel, userID: String) async -> String {
        DispatchQueue.main.async {
            loginData.userData = UserDataFromServer(hotelOwnerInfo: HotelOwnerInfo(hotelownerName: "", hotelDescription: "", hotelType: "", hotelCount: "", websiteLink: "", bookingEngineLink: "", hotelownerid: "", hotelInfo: [JSONAny]()), vendorInfo: VendorInfo(vendorImage: "", vendorName: "", vendorDescription: "", websiteLink: "", vendorServices: [JSONAny](), portfolioLink: [JSONAny]()), id: "", fullName: "", email: "", phone: "", profilePic: "", resume: "", mesiboAccount: [MesiboAccount](), interest: [Interest](), verificationStatus: "", userBio: "", createdOn: "", savedPost: [JSONAny](), likedPost: [LikedPost?](), userName: "", dob: "", location: "", profileCompletionStatus: "", role: "", deviceToken: "", studentEducation: [StudentEducation?](), normalUserInfo: [NormalUserInfoProfile?](), hospitalityExpertInfo: [HospitalityExpertInfoProfile?](), displayStatus: "", userID: "", bookmarkjob: [JSONAny](), postCount: [PostCount?](), connections: [Connection?](), pendingRequest: [Connection?](), requests: [Connection?](), v: 0, gender: "")
        }
        
        print("Fetching total users from Server")
        
        guard let url = URL(string: "http://64.227.150.47/main/profile/\(userID)") else {
            print("Error: unable to create URL for API call")
            return "Failure: Invalid URL"
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            
            let decoder = JSONDecoder()
            let decodedData = try decoder.decode(UserDataFromServer.self, from: data)
            DispatchQueue.main.async {
                loginData.userData = decodedData
                loginData.showLoader = false
            }
            print("Users fetched.")
            
            return "Success"
        } catch {
            print("Error: \(error)")
            return "Failure: \(error.localizedDescription)"
        }
    }

    
    
    // MARK: - fetch service
    func getTotalUserCount(globalVM: GlobalViewModel) async -> String {
        //Updating the user Interest
        print("Starting to get no of users")
        
        guard let url = URL(string: "http://64.227.150.47/main/count") else {
            print("Error: cannot create URL")
            return "Failure"
        }
        
        // Create the request
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            guard let response = response as? HTTPURLResponse, (200 ..< 299) ~= response.statusCode else {
                print("Error: HTTP request failed")
                return "Failure"
            }
            
            let decoder = JSONDecoder()
            let decodedData = try decoder.decode(UserCountModel.self, from: data)
            
            DispatchQueue.main.async {
                
                globalVM.totalUsersInRown = decodedData
            }
            
            return "Success"
        } catch {
            print("Error: \(error)")
            return "Failure"
        }
    }

    // MARK: - post service
    
    func reportUser(reportType: String, reporterUserID: String, reportedUserID: String, postID: String, reason: String) async -> String {
        // Updating the user Interest
        print("Starting to update user profile without image")
        
        guard let url = URL(string: "http://64.227.150.47/main/report") else {
            print("Error: cannot create URL")
            return "API Error"
        }
        
        // Create & Add data to the model
        let body: [String: AnyHashable] = [
            "reportType": reportType,
            "reporterUserId": reporterUserID,
            "reportedUserId": reportedUserID,
            "post_id": postID,
            "Reason": reason
        ]
        
        
        // Create the request
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)
        } catch {
            return "Error: \(error)"
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            if let httpResponse = response as? HTTPURLResponse, (200 ..< 299) ~= httpResponse.statusCode {
                do {
                    let decoder = JSONDecoder()
                    let decodedData = try decoder.decode(NormalMessageResponse.self, from: data)
                    
                    return "Success"
                } catch {
                    print("Error: Trying to convert JSON data to string")
                    return "Failure"
                }
            } else {
                print("Error: HTTP request failed")
                return "Failure"
            }
        } catch {
            print("Error: error calling PATCH")
            print(error)
            return "Failure"
        }
    }


}
