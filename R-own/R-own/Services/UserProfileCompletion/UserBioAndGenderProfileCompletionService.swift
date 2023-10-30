//
//  UserBioAndGenderProfileCompletion.swift
//  R-own
//
//  Created by Aman Sharma on 07/06/23.
//

import SwiftUI

import Foundation


class UserBioAndGenderProfileCompletionService: ObservableObject{
    
    
    //this function helps us to update the basic information about the user i.e. fullname and dob
    func postBioAndGenderInfo(loginData: LoginViewModel) {
    
        //Updating the user Interest
        print("Starting to check gender and bio")
        print("using these info to update: ")
        print(loginData.userBio)
        print(loginData.userGender)
    
        guard let url = URL(string: "http://64.227.150.47/main/update/\(loginData.mainUserID)") else {
            print("Error: cannot create URL")
            return
        }
    
        // Create & Add data to the model
        let body: [String: AnyHashable] = [
            "Gender": loginData.userGender,
            "userBio": loginData.userBio,
            "profileCompletionStatus": loginData.profileCompletionPercentage
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
                    
                    loginData.basicProfileInfoCompleted = true
                } catch {
                    print("Error: Trying to convert JSON data to string")
                    return
                }
            }
        }
        task.resume()
    
    }
    
}
    
