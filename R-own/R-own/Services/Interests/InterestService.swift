//
//  InterestService.swift
//  R-own
//
//  Created by Aman Sharma on 21/04/23.
//

import Foundation


class InterestService: ObservableObject{
    
    func fetchInterests(loginData: LoginViewModel){
        
        loginData.interestList = [GetInterest]()
        
        guard let url = URL(string: "http://64.227.150.47/main/getInterest") else {
            print("unable to rectify string in url for api call")
            return
        }
        
        print("Making API Call to get interest list...........")
        
        var request = URLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: request){ data, response, error in

            DispatchQueue.main.async{
                guard let data = data, error == nil else{
                    return
                }
                do{
                    print(data)
                    let responseString = NSString(data: data, encoding: String.Encoding.utf8.rawValue)
                    print("responseString = \(responseString)")
                    let decoder = JSONDecoder()
                    let decodedData = try decoder.decode([GetInterest].self, from: data)
                    
                    DispatchQueue.main.async {
                        loginData.interestList = decodedData
                        print(34)
                        print(loginData.interestList)
                        print(35)
                        loginData.navigateToInterestView.toggle()
                        loginData.onboardingCompleted = true
                        print("345")
                        print(loginData.onboardingCompleted)
                        loginData.showLoader = false
                    }
                    return
                } catch {
                    print(error)
                }
            }
        }
        
        task.resume()
    }
    
    func updateUserInInterest(loginData: LoginViewModel, Interest: GetInterest) {
        
        //Updating the user Interest
        print("Starting to update user id into interest")
        let selectedInterestID = Interest.welcomeID
        print("using this interestId to update: \(selectedInterestID)")
        
        guard let url = URL(string: "http://64.227.150.47/main/update_int/\(selectedInterestID)") else {
            print("Error: cannot create URL")
            return
        }
        
        // Create & Add data to the model
        let body: [String: AnyHashable] = [
            "User_id": loginData.mainUserID
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
    
    func updateInterestInUser(loginData: LoginViewModel, Interest: GetInterest) {
        
        //Updating the user Interest
        print("Starting to update user id into interest")
        let selectedInterestID = Interest.welcomeID
        print("using this interestId to update: \(selectedInterestID)")
        print("using this userId to update: \(loginData.mainUserID)")
        
        guard let url = URL(string: "http://64.227.150.47/main/interest_push/\(loginData.mainUserID)") else {
            print("Error: cannot create URL")
            return
        }
        
        // Create & Add data to the model
        let body: [String: AnyHashable] = [
            "intid" : selectedInterestID
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
    
//    func updateInterestInUser(loginData: LoginViewModel, Interest: GetInterest) {
//        guard let url = URL(string: "https://reqres.in/api/users/2") else {
//            print("Error: cannot create URL")
//            return
//        }
//
//        // Create model
//        struct UploadData: Codable {
//            let name: String
//            let job: String
//        }
//
//        // Add data to the model
//        let uploadDataModel = UploadData(name: "Nicole", job: "iOS Developer")
//
//        // Convert model to JSON data
//        guard let jsonData = try? JSONEncoder().encode(uploadDataModel) else {
//            print("Error: Trying to convert model to JSON data")
//            return
//        }
//
//        // Create the request
//        var request = URLRequest(url: url)
//        request.httpMethod = "PUT"
//        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//        request.httpBody = jsonData
//        URLSession.shared.dataTask(with: request) { data, response, error in
//            guard error == nil else {
//                print("Error: error calling PUT")
//                print(error!)
//                return
//            }
//            guard let data = data else {
//                print("Error: Did not receive data")
//                return
//            }
//            guard let response = response as? HTTPURLResponse, (200 ..< 299) ~= response.statusCode else {
//                print("Error: HTTP request failed")
//                return
//            }
//            do {
//                guard let jsonObject = try JSONSerialization.jsonObject(with: data) as? [String: Any] else {
//                    print("Error: Cannot convert data to JSON object")
//                    return
//                }
//                guard let prettyJsonData = try? JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted) else {
//                    print("Error: Cannot convert JSON object to Pretty JSON data")
//                    return
//                }
//                guard let prettyPrintedJson = String(data: prettyJsonData, encoding: .utf8) else {
//                    print("Error: Could print JSON in String")
//                    return
//                }
//
//                print(prettyPrintedJson)
//            } catch {
//                print("Error: Trying to convert JSON data to string")
//                return
//            }
//        }.resume()
//    }
}

