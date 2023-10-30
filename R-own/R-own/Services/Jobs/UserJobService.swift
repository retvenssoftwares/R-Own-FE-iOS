//
//  UserJobService.swift
//  R-own
//
//  Created by Aman Sharma on 28/05/23.
//

import Foundation
import SwiftUI
import Alamofire

class UserJobService: ObservableObject{
    
//MARK: - fetch service


    func getRecentJobs(globalVM: GlobalViewModel, loginData: LoginViewModel) {
    
        globalVM.recentJobs = [RecentJobsModel]()
        //Updating the user Interest
        print("Starting to get jobs")
    
        guard let url = URL(string: "http://64.227.150.47/main/getJob/\(loginData.mainUserID)") else {
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
                    let decodedData = try decoder.decode([RecentJobsModel].self, from: data)
                    
                    globalVM.recentJobs = decodedData
    
                } catch {
                    print("Error: Trying to convert JSON data to string")
                    return
                }
            }
        }
        task.resume()
    }
    
    
    // MARK: - post service

    func postRequestJob(loginData: LoginViewModel, designationType: String, noticePeriod: String, preferredLocation: String,  expectedCTC: String, employmentType: String, department: String) {
    
        //Updating the user Interest
        print("Starting to request job")
        print("using these info to update: ")
    
        guard let url = URL(string: "http://64.227.150.47/main/requestJob") else {
            print("Error: cannot create URL")
            return
        }
    
        // Create & Add data to the model
        let body: [String: AnyHashable] = [
            "userID": loginData.mainUserID,
            "designationType": designationType,
            "noticePeriod": noticePeriod,
            "preferredLocation": preferredLocation,
            "expectedCTC": expectedCTC,
            "employmentType": employmentType,
            "department": department
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
                    
                    print("user job request is posted")
                } catch {
                    print("Error: Trying to convert JSON data to string")
                    return
                }
            }
        }
        task.resume()
    
    }
    
    // MARK: - patch service

    func updateJobRequest(loginData: LoginViewModel, designationType: String, noticePeriod: String, preferredLocation: String,  expectedCTC: String, employmentType: String, department: String) {
    
        //Updating the user Interest
        print("Starting to update user profile without image")
        print("using these info to update: ")
        print(loginData.mainUserFullName)
        print(loginData.mainUserEmail)
        print(loginData.mainUserProfilePic)
    
        guard let url = URL(string: "http://64.227.150.47/main/jobupdate/\(loginData.mainUserID)") else {
            print("Error: cannot create URL")
            return
        }
    
        // Create & Add data to the model
        let body: [String: AnyHashable] = [
            "designationType": designationType,
            "noticePeriod": noticePeriod,
            "preferredLocation": preferredLocation,
            "expectedCTC": expectedCTC,
            "department": department
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

    
//MARK: - fetch service


    func getJobRequest(globalVM: GlobalViewModel, loginData: LoginViewModel, jobsVM: JobsViewModel) {
    
        //Updating the user Interest
        print("Starting to get departments")
    
        guard let url = URL(string: "http://64.227.150.47/main/reqjobofuser/\(loginData.mainUserID)") else {
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
                    loginData.jobRequested = false
                    return
                }
                do {
                    let decoder = JSONDecoder()
                    let decodedData = try decoder.decode([GetJobRequestModel].self, from: data)
                    
                    jobsVM.designationRequestedFor = decodedData[0].designationType
                    jobsVM.noticePeriodRequestedFor = decodedData[0].noticePeriod
                    jobsVM.jobLocationRequestedFor = decodedData[0].preferredLocation
                    jobsVM.expectedCTCRequestedFor = decodedData[0].expectedCTC
                    jobsVM.employmentTypeRequestedFor = decodedData[0].employmentType
                    jobsVM.departmentRequestedFor = decodedData[0].department
                    loginData.jobRequested = true
                } catch {
                    print("Error: Trying to convert JSON data to string")
                    return
                }
            }
        }
        task.resume()
    }
    
    
//MARK: - fetch service


    func getDepartment(globalVM: GlobalViewModel, loginData: LoginViewModel) {
    
        globalVM.fetchedDepartments = [DepartmentModel]()
        //Updating the user Interest
        print("Starting to get departments")
    
        guard let url = URL(string: "http://64.227.150.47/main/fetchdepartment") else {
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
                    let decodedData = try decoder.decode([DepartmentModel].self, from: data)
                    
                    globalVM.fetchedDepartments = decodedData
    
                } catch {
                    print("Error: Trying to convert JSON data to string")
                    return
                }
            }
        }
        task.resume()
    }
    
    
    // MARK: - multipart service


    func applyJob(loginData: LoginViewModel) {

        //Set Your URL
            let api_url = "http://64.227.150.47/main/applyjob"
            guard let url = URL(string: api_url) else {
                return
            }
    
            var urlRequest = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 10.0 * 1000)
            urlRequest.httpMethod = "POST"
            urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
    
            //Set Image Data
            let uiImage: UIImage = loginData.userImage!
            let imgData = uiImage.jpegData(compressionQuality: 0.5)!
            let userNameWithoutSpace = loginData.mainUserFullName.replacingOccurrences(of: " ", with: "%20", options: .literal, range: nil)
        
           // Now Execute
            AF.upload(multipartFormData: { multiPart in
                
                multiPart.append(("").data(using: String.Encoding.utf8)!, withName: "user_id")
                multiPart.append(("").data(using: String.Encoding.utf8)!, withName: "Full_name")
                multiPart.append(("").data(using: String.Encoding.utf8)!, withName: "Experience")
                multiPart.append(("").data(using: String.Encoding.utf8)!, withName: "jid")
                multiPart.append(("").data(using: String.Encoding.utf8)!, withName: "applicationId")
                multiPart.append(("").data(using: String.Encoding.utf8)!, withName: "status")
                multiPart.append(("").data(using: String.Encoding.utf8)!, withName: "self_introduction")
                multiPart.append(imgData, withName: "resume", fileName: "mediapost"+randomString(length: 6)+"resume.png", mimeType: "image/png")
                
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

    
//MARK: - fetch service


    func getAppliedJobs(globalVM: GlobalViewModel, loginData: LoginViewModel) {
    
        globalVM.appliedJobs = [AppliedJobsModel]()
        //Updating the user Interest
        print("Starting to get applied jobs")
    
        guard let url = URL(string: "http://64.227.150.47/main/appliedjob/\(loginData.mainUserID)") else {
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
                    let decodedData = try decoder.decode([AppliedJobsModel].self, from: data)
                    
                    globalVM.appliedJobs = decodedData
    
                } catch {
                    print("Error: Trying to convert JSON data to string")
                    return
                }
            }
        }
        task.resume()
    }
    
//MARK: - fetch service


    func getDesignations(globalVM: GlobalViewModel, loginData: LoginViewModel) {
    
        globalVM.designationnList = [DesignationnModel]()
        
        //Updating the user Interest
        print("Starting to get applied jobs")
    
        guard let url = URL(string: "http://64.227.150.47/main/getdesignation") else {
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
                    let decodedData = try decoder.decode([DesignationnModel].self, from: data)
                    
                    globalVM.designationnList = decodedData
    
                } catch {
                    print("Error: Trying to convert JSON data to string")
                    return
                }
            }
        }
        task.resume()
    }
    
    
//MARK: - fetch service


    func getSpecificJobByID(globalVM: GlobalViewModel, loginData: LoginViewModel, jobID: String) {
    
        globalVM.jobDetails = JobDetailsModel(id: "", userID: "", jobApplicants: [JSONAny](), jid: "", jobTitle: "", companyName: "", workplaceType: "", jobType: "", designationType: "", noticePeriod: "", expectedCTC: "", jobLocation: "", jobDescription: "", skillsRecq: "", bookmarked: [JSONAny](), displayStatus: "", hotelLogoURL: "", hotelID: "", v: 0)
        
        //Updating the user Interest
        print("Starting to get applied jobs")
    
        guard let url = URL(string: "http://64.227.150.47/main/getspecificjob/\(jobID)") else {
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
                    let decodedData = try decoder.decode(JobDetailsModel.self, from: data)
                    
                    globalVM.jobDetails = decodedData
    
                } catch {
                    print("Error: Trying to convert JSON data to string")
                    return
                }
            }
        }
        task.resume()
    }
    
    
}
