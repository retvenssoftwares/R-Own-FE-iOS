//
//  MesiboChatService.swift
//  R-own
//
//  Created by Aman Sharma on 12/04/23.
//

import SwiftUI
import mesibo
import MesiboUI
import MesiboCall

class MesiboChatService: ObservableObject{
    
    
    // MARK: - post service

    func sendingMessageNotification(receiveruserID: String, sendingUserID: String) {
    
        //Updating the user Interest
        print("Sending message notification")
    
        guard let url = URL(string: "http://64.227.150.47/main/chating/\(receiveruserID)") else {
            print("Error: cannot create URL")
            return
        }
    
        // Create & Add data to the model
        let body: [String: AnyHashable] = [
            "user_id": sendingUserID,
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
    
    
    // MARK: - post service

    func callingNotification(receiveruserID: String, sendingUserID: String) {
    
        //Updating the user Interest
        print("Sending Calling notification")
        print("http://64.227.150.47/main/call/\(receiveruserID)")
        guard let url = URL(string: "http://64.227.150.47/main/call/\(receiveruserID)") else {
            print("Error: cannot create URL")
            return
        }
    
        // Create & Add data to the model
        let body: [String: AnyHashable] = [
            "user_id": sendingUserID
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
    
    
}

//struct MesiboChatService_Previews: PreviewProvider {
//    static var previews: some View {
//        MesiboChatService()
//    }
//}
