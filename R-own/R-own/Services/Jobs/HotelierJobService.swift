//
//  HotelierJobService.swift
//  R-own
//
//  Created by Aman Sharma on 28/05/23.
//


import Foundation
import SwiftUI
import Alamofire

class HotelierJobService: ObservableObject{
    
    
//MARK: - fetch service


    func getMAtchesJobCriteria(globalVM: GlobalViewModel, loginData: LoginViewModel) {
    
        globalVM.matchesJobCriteriaList = [MatchesJobCriteriaModel]()
        //Updating the user Interest
        print("Starting to get jobs")
    
        guard let url = URL(string: "http://64.227.150.47/main/getrequestedjob") else {
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
                    let decodedData = try decoder.decode([MatchesJobCriteriaModel].self, from: data)
                    
                    globalVM.matchesJobCriteriaList = decodedData
    
                } catch {
                    print("Error: Trying to convert JSON data to string")
                    return
                }
            }
        }
        task.resume()
    }
    
//
////MARK: - fetch service
//
//
//    func getCandidates(globalVM: GlobalViewModel, loginData: LoginViewModel) {
//
//        //Updating the user Interest
//        print("Starting to get jobs")
//
//        guard let url = URL(string: "http://64.227.150.47/main/getrequestedjob") else {
//            print("Error: cannot create URL")
//            return
//        }
//
//
//
//        // Create the request
//        var request = URLRequest(url: url)
//        request.httpMethod = "GET"
//        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//
//
//        let task = URLSession.shared.dataTask(with: request) { data, response, error in
//
//            DispatchQueue.main.async {
//                guard error == nil else {
//                    print("Error: error calling GET")
//                    print(error!)
//                    return
//                }
//                guard let data = data else {
//                    print("Error: Did not receive data")
//                    return
//                }
//                guard let response = response as? HTTPURLResponse, (200 ..< 299) ~= response.statusCode else {
//                    print("Error: HTTP request failed")
//                    return
//                }
//                do {
//                    let decoder = JSONDecoder()
//                    let decodedData = try decoder.decode([MatchesJobCriteriaModel].self, from: data)
//                    
//                    globalVM.matchesJobCriteriaList = decodedData
//
//                } catch {
//                    print("Error: Trying to convert JSON data to string")
//                    return
//                }
//            }
//        }
//        task.resume()
//    }
    
//MARK: - fetch service


    func getApplicantsFromJID(globalVM: GlobalViewModel, loginData: LoginViewModel, jobID: String) {
    
        globalVM.jobApplicantsList = [JobApplicantsModel]()
        //Updating the user Interest
        print("Starting to get applicants")
    
        guard let url = URL(string: "http://64.227.150.47/main/getapplicant/\(jobID)") else {
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
                    let decodedData = try decoder.decode([JobApplicantsModel].self, from: data)
                    
                    globalVM.jobApplicantsList = decodedData
    
                } catch {
                    print("Error: Trying to convert JSON data to string")
                    return
                }
            }
        }
        task.resume()
    }
    
    
//MARK: - fetch service


    func getApplicantInfoFromAppID(globalVM: GlobalViewModel, loginData: LoginViewModel, AppID: String, status: String) {
    
        //Updating the user Interest
        print("Starting to get applicants")
    
        guard let url = URL(string: "http://64.227.150.47/main/updatejob/\(AppID)") else {
            print("Error: cannot create URL")
            return
        }
    
    
        // Create & Add data to the model
        let body: [String: AnyHashable] = [
            "user_id": loginData.mainUserID,
            "jobCategory": "",
            "jobTitle": "",
            "companyName": "",
            "workplaceType": "",
            "jobType": "",
            "designationType": "",
            "noticePeriod": "",
            "expectedCTC": "",
            "jobLocation": "",
            "jobDescription": "",
            "skillsRecq": ""
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
                    
    
                } catch {
                    print("Error: Trying to convert JSON data to string")
                    return
                }
            }
        }
        task.resume()
    }
    
    
    // MARK: - patch service

    func postJob(loginData: LoginViewModel, jobsVM: JobsViewModel) {
    
        //Updating the user Interest
        print("Starting to update user profile without image")
        print("using these info to update: ")
        print(loginData.mainUserFullName)
        print(loginData.mainUserEmail)
        print(loginData.mainUserProfilePic)
    
        guard let url = URL(string: "http://64.227.150.47/main/jobpost/\(loginData.mainUserID)") else {
            print("Error: cannot create URL")
            return
        }
    
        // Create & Add data to the model
        let body: [String: AnyHashable] = [
            "user_id": loginData.mainUserID,
            "jobTitle": jobsVM.postAjobTitle,
            "companyName": jobsVM.postAcompany,
            "workplaceType": jobsVM.postAworkplaceType,
            "jobType": jobsVM.postAjobType,
            "designationType": jobsVM.postAJobDesignation,
            "noticePeriod": jobsVM.postAJobNoticePeriod,
            "expectedCTC": jobsVM.postAminSalary+"-"+jobsVM.postAmaxSalary+" LPA" ,
            "jobLocation": jobsVM.postAjobLocation,
            "jobDescription": jobsVM.postAjobDescription,
            "skillsRecq": jobsVM.postAskillRecquired,
            "hotel_id": jobsVM.postAcompanyID
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
                    
                } catch {
                    print("Error: Trying to convert JSON data to string")
                    return
                }
            }
        }
        task.resume()
    
    }
    
    
    // MARK: - post service

    func updateStatusOfApplicantID(loginData: LoginViewModel) {
    
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
            "Profile_pic": loginData.mainUserProfilePic
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
                    
                    print("user data updated on server")
                } catch {
                    print("Error: Trying to convert JSON data to string")
                    return
                }
            }
        }
        task.resume()
    
    }
    
//MARK: - fetch service


    func getJobRequests(globalVM: GlobalViewModel, loginData: LoginViewModel) {
    
        globalVM.requestedUsersList = [RequestedUsersModel]()
        //Updating the user Interest
        print("Starting to get requesters")
    
        guard let url = URL(string: "http://64.227.150.47/main/getrequestjob") else {
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
                        let decodedData = try decoder.decode([RequestedUsersModel].self, from: data)
                        
                        globalVM.requestedUsersList = decodedData
        
                    } catch {
                        print("Error: Trying to convert JSON data to string")
                        return
                    }
                }
            }
            task.resume()
        }
    
//MARK: - fetch service


    func getJobsByUserID(globalVM: GlobalViewModel, loginData: LoginViewModel) {
    
        globalVM.jobListByHotelOwner = [JobsByHotelOwnerModel]()
        //Updating the user Interest
        print("Starting to get requesters")
    
        guard let url = URL(string: "http://64.227.150.47/main/job/\(loginData.mainUserID)") else {
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
                        let decodedData = try decoder.decode([JobsByHotelOwnerModel].self, from: data)
                        
                        globalVM.jobListByHotelOwner = decodedData
        
                    } catch {
                        print("Error: Trying to convert JSON data to string")
                        return
                    }
                }
            }
            task.resume()
        }
}
