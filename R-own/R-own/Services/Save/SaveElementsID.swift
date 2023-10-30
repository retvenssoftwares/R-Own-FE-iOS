//
//  SaveElementsID.swift
//  R-own
//
//  Created by Aman Sharma on 28/05/23.
//

import Foundation
import SwiftUI
import Alamofire

class SaveElemetsIDService: ObservableObject{
    
    
    // MARK: - save services

    func savePostID(loginData: LoginViewModel, postID: String) {
    
        //Updating the user Interest
        print("Starting to update user profile without image")
        print("using these info to update: ")
        print(loginData.mainUserID)
        print(postID)
    
        guard let url = URL(string: "http://64.227.150.47/main/saveId/\(loginData.mainUserID)") else {
            print("Error: cannot create URL")
            return
        }
    
        // Create & Add data to the model
        let body: [String: AnyHashable] = [
            "operation": "push",
            "postid": postID
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
    
    func saveJobID(loginData: LoginViewModel, jobID: String) {
    
        //Updating the user Interest
        print("Starting to update user profile without image")
        print("using these info to update: ")
        print(loginData.mainUserID)
        print(jobID)
    
        guard let url = URL(string: "http://64.227.150.47/main/saveId/\(loginData.mainUserID)") else {
            print("Error: cannot create URL")
            return
        }
    
        // Create & Add data to the model
        let body: [String: AnyHashable] = [
            "operation": "push",
            "jobid": jobID
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
    
    func saveBlogID(loginData: LoginViewModel, blogID: String) {
    
        //Updating the user Interest
        print("Starting to update user profile without image")
        print("using these info to update: ")
        print(loginData.mainUserID)
        print(blogID)
    
        guard let url = URL(string: "http://64.227.150.47/main/saveId/\(loginData.mainUserID)") else {
            print("Error: cannot create URL")
            return
        }
    
        // Create & Add data to the model
        let body: [String: AnyHashable] = [
            "operation": "push",
            "blogid": blogID
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
    
    func saveEventID(loginData: LoginViewModel, eventID: String) {
    
        //Updating the user Interest
        print("Starting to update user profile without image")
        print("using these info to update: ")
        print(loginData.mainUserID)
        print(eventID)
    
        guard let url = URL(string: "http://64.227.150.47/main/saveId/\(loginData.mainUserID)") else {
            print("Error: cannot create URL")
            return
        }
    
        // Create & Add data to the model
        let body: [String: AnyHashable] = [
            "operation": "push",
            "eventid": eventID
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
    
    func saveServiceID(loginData: LoginViewModel, serviceID: String) {
    
        //Updating the user Interest
        print("Starting to update user profile without image")
        print("using these info to update: ")
        print(loginData.mainUserID)
        print(serviceID)
    
        guard let url = URL(string: "http://64.227.150.47/main/saveId/\(loginData.mainUserID)") else {
            print("Error: cannot create URL")
            return
        }
    
        // Create & Add data to the model
        let body: [String: AnyHashable] = [
            "operation": "push",
            "serviceID": serviceID
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
    
    func saveHotelID(loginData: LoginViewModel, hotelID: String) {
    
        //Updating the user Interest
        print("Starting to update user profile without image")
        print("using these info to update: ")
        print(loginData.mainUserID)
        print(hotelID)
    
        guard let url = URL(string: "http://64.227.150.47/main/saveId/\(loginData.mainUserID)") else {
            print("Error: cannot create URL")
            return
        }
    
        // Create & Add data to the model
        let body: [String: AnyHashable] = [
            "operation": "push",
            "hotelid": hotelID
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
    
    
    // MARK: - unsave services
    
    func unsavePostID(loginData: LoginViewModel, postID: String) {
    
        //Updating the user Interest
        print("Starting to update user profile without image")
        print("using these info to update: ")
        print(loginData.mainUserID)
        print(postID)
    
        guard let url = URL(string: "http://64.227.150.47/main/saveId/\(loginData.mainUserID)") else {
            print("Error: cannot create URL")
            return
        }
    
        // Create & Add data to the model
        let body: [String: AnyHashable] = [
            "operation": "pop",
            "postid": postID
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
    
    func unsaveJobID(loginData: LoginViewModel, jobID: String) {
    
        //Updating the user Interest
        print("Starting to update user profile without image")
        print("using these info to update: ")
        print(loginData.mainUserID)
        print(jobID)
    
        guard let url = URL(string: "http://64.227.150.47/main/saveId/\(loginData.mainUserID)") else {
            print("Error: cannot create URL")
            return
        }
    
        // Create & Add data to the model
        let body: [String: AnyHashable] = [
            "operation": "pop",
            "jobid": jobID
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
    
    func unsaveBlogID(loginData: LoginViewModel, blogID: String) {
    
        //Updating the user Interest
        print("Starting to update user profile without image")
        print("using these info to update: ")
        print(loginData.mainUserID)
        print(blogID)
    
        guard let url = URL(string: "http://64.227.150.47/main/saveId/\(loginData.mainUserID)") else {
            print("Error: cannot create URL")
            return
        }
    
        // Create & Add data to the model
        let body: [String: AnyHashable] = [
            "operation": "pop",
            "blogid": blogID
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
    
    func unsaveEventID(loginData: LoginViewModel, eventID: String) {
    
        //Updating the user Interest
        print("Starting to update user profile without image")
        print("using these info to update: ")
        print(loginData.mainUserID)
        print(eventID)
    
        guard let url = URL(string: "http://64.227.150.47/main/saveId/\(loginData.mainUserID)") else {
            print("Error: cannot create URL")
            return
        }
    
        // Create & Add data to the model
        let body: [String: AnyHashable] = [
            "operation": "pop",
            "eventid": eventID
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
    
    func unsaveServiceID(loginData: LoginViewModel, serviceID: String) {
    
        //Updating the user Interest
        print("Starting to update user profile without image")
        print("using these info to update: ")
        print(loginData.mainUserID)
        print(serviceID)
    
        guard let url = URL(string: "http://64.227.150.47/main/saveId/\(loginData.mainUserID)") else {
            print("Error: cannot create URL")
            return
        }
    
        // Create & Add data to the model
        let body: [String: AnyHashable] = [
            "operation": "pop",
            "serviceID": serviceID
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
    
    func unsaveHotelID(loginData: LoginViewModel, hotelID: String) {
    
        //Updating the user Interest
        print("Starting to update user profile without image")
        print("using these info to update: ")
        print(loginData.mainUserID)
        print(hotelID)
    
        guard let url = URL(string: "http://64.227.150.47/main/saveId/\(loginData.mainUserID)") else {
            print("Error: cannot create URL")
            return
        }
    
        // Create & Add data to the model
        let body: [String: AnyHashable] = [
            "operation": "pop",
            "hotelid": hotelID
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


    func getSavePost(globalVM: GlobalViewModel, userID: String, pageNo: Int) {
    
        //Updating the user Interest
        print("Starting to get saved posts")
    
        guard let url = URL(string: "http://64.227.150.47/main/savePost/\(userID)?page=\(pageNo)") else {
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
                    let decodedData = try decoder.decode([GetSavePostModel].self, from: data)
                    
                    
                    for i in 0..<decodedData[0].posts.count {
                        DispatchQueue.main.async {
                            globalVM.getSavePostList[0].posts.append(decodedData[0].posts[i])
                        }
                    }
    
                } catch {
                    print("Error: Trying to convert JSON data to string")
                    return
                }
            }
        }
        task.resume()
    }

    
    // MARK: - fetch service


    func getSaveJob(globalVM: GlobalViewModel, userID: String, pageNo: Int) {
    
        //Updating the user Interest
        print("Starting to get saved jobs")
    
        guard let url = URL(string: "http://64.227.150.47/main/getSaveJob/\(userID)?page=\(pageNo)") else {
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
                    let decodedData = try decoder.decode([GetSaveJobModel].self, from: data)
                    
                    
                    for i in 0..<decodedData[0].jobs.count {
                        DispatchQueue.main.async {
                            globalVM.getSaveJobList[0].jobs.append(decodedData[0].jobs[i])
                        }
                    }
    
                } catch {
                    print("Error: Trying to convert JSON data to string")
                    return
                }
            }
        }
        task.resume()
    }
    
    
    // MARK: - fetch service


    func getSaveEvent(globalVM: GlobalViewModel, userID: String, pageNo: Int) {
    
        //Updating the user Interest
        print("Starting to get saved events")
    
        guard let url = URL(string: "http://64.227.150.47/main/getSaveEvent/\(userID)?page=\(pageNo)") else {
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
                    let decodedData = try decoder.decode([GetSaveEventModel].self, from: data)
                    
                    
                    for i in 0..<decodedData[0].events.count {
                        DispatchQueue.main.async {
                            globalVM.getSaveEventList[0].events.append(decodedData[0].events[i])
                        }
                    }
    
                } catch {
                    print("Error: Trying to convert JSON data to string")
                    return
                }
            }
        }
        task.resume()
    }
    
    
    // MARK: - fetch service


    func getSaveService(globalVM: GlobalViewModel, userID: String, pageNo: Int) {
    
        //Updating the user Interest
        print("Starting to get saved service")
    
        guard let url = URL(string: "http://64.227.150.47/main/getSaveService/\(userID)?page=\(pageNo)") else {
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
                    let decodedData = try decoder.decode([GetSaveServiceModel].self, from: data)
                    
                    
                    for i in 0..<decodedData[0].services.count {
                        DispatchQueue.main.async {
                            globalVM.getSaveServiceList[0].services.append(decodedData[0].services[i])
                        }
                    }
    
                } catch {
                    print("Error: Trying to convert JSON data to string")
                    return
                }
            }
        }
        task.resume()
    }
    
    
    // MARK: - fetch service


    func getSaveHotel(globalVM: GlobalViewModel, userID: String, pageNo: Int) {
    
        //Updating the user Interest
        print("Starting to get saved hotel")
    
        guard let url = URL(string: "http://64.227.150.47/main/getSaveHotel/\(userID)?page=\(pageNo)") else {
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
                    let decodedData = try decoder.decode([GetSaveHotelModel].self, from: data)
                    
                    
                    for i in 0..<decodedData[0].hotels.count {
                        DispatchQueue.main.async {
                            globalVM.getSaveHotelList[0].hotels.append(decodedData[0].hotels[i])
                        }
                    }
                } catch {
                    print("Error: Trying to convert JSON data to string")
                    return
                }
            }
        }
        task.resume()
    }
    
    
    // MARK: - fetch service


    func getSaveBlog(globalVM: GlobalViewModel, userID: String, pageNo: Int) {
    
        //Updating the user Interest
        print("Starting to get saved blog")
    
        guard let url = URL(string: "http://64.227.150.47/main/getSavedBlogs/\(userID)?page=\(pageNo)") else {
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
                    let decodedData = try decoder.decode([GetSaveBlogModel].self, from: data)
                    
                    
                    for i in 0..<decodedData[0].blogs.count {
                        DispatchQueue.main.async {
                            globalVM.getSaveBlogList[0].blogs.append(decodedData[0].blogs[i])
                        }
                    }
                    
    
                } catch {
                    print("Error: Trying to convert JSON data to string")
                    return
                }
            }
        }
        task.resume()
    }
}
