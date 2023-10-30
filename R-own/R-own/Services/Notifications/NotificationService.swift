//
//  NotificationService.swift
//  R-own
//
//  Created by Aman Sharma on 07/06/23.
//

import Foundation
import SwiftUI
import Alamofire

class NotificationService: ObservableObject{
    
    
    // MARK: - fetch service


    func getConnectionNotification(globalVM: GlobalViewModel, loginData: LoginViewModel, pageNo: String) {
        
        //Updating the user Interest
        print("Starting to get connection notifications")
    
        guard let url = URL(string: "http://64.227.150.47/main/getConnectionNotification/\(loginData.mainUserID)?page=\(pageNo)") else {
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
                    let decodedData = try decoder.decode([GetConnectionNotification].self, from: data)
                    for notification in decodedData {
                        globalVM.connectionNotificationList.append(notification)
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


    func getPersonalNotification(globalVM: GlobalViewModel, loginData: LoginViewModel, pageNo: String) {
    
        
        //Updating the user Interest
        print("Starting to get personal notifications")
    
        guard let url = URL(string: "http://64.227.150.47/main/getPersonalNotification/\(loginData.mainUserID)?page=\(pageNo)") else {
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
                    let decodedData = try decoder.decode([GetPersonalNotification].self, from: data)
                    for notification in decodedData {
                        globalVM.personalNotificationList.append(notification)
                    }
                } catch {
                    print("Error: Trying to convert JSON data to string")
                    return
                }
            }
        }
        task.resume()
    }

    
    // MARK: - post service

    func sendMessageNotification(loginData: LoginViewModel, userID: String, header: String, body: String) {
    
        //Updating the user Interest
        print("Starting to send message notification to user with these users")
    
        if userID == "" {
            print("empty user id for sender")
            return
        }
        guard let url = URL(string: "http://64.227.150.47/main/chating/\(userID)") else {
            print("Error: cannot create URL")
            return
        }
    
        // Create & Add data to the model
        let body: [String: AnyHashable] = [
            "user_id": loginData.mainUserID,
            "title": header,
            "body": body
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
                    print("notification sent")
                } catch {
                    print("Error: Trying to convert JSON data to string")
                    return
                }
            }
        }
        task.resume()
    
    }
}
    
