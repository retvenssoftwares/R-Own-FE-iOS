//
//  VendorUserProfileCompletionService.swift
//  R-own
//
//  Created by Aman Sharma on 25/05/23.
//

import Foundation
import Alamofire
import UIKit


class VendorUserProfileCompletionService: ObservableObject{
    func updateVendorInfoDetails(userID: String, brandName: String, brandDescription: String, brandWebsiteLink: String, vendorImage: UIImage?, portfolio1img: UIImage?, portfolio2img: UIImage?, portfolio3img: UIImage?) async -> String {
        // Your API URL
        let api_url = "http://64.227.150.47/main/vendor/\(userID)"
        
        guard let url = URL(string: api_url) else {
            return "API Error"
        }

        var urlRequest = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 10.0 * 1000)
        urlRequest.httpMethod = "PATCH"
        urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")

        do {
            let response = try await withUnsafeThrowingContinuation { continuation in
                AF.upload(multipartFormData: { multiPart in
                    // Add your multipart form data here
                    multiPart.append((brandName).data(using: String.Encoding.utf8)!, withName: "vendorName")
                    multiPart.append((brandDescription).data(using: String.Encoding.utf8)!, withName: "vendorDescription")
                    multiPart.append((brandWebsiteLink).data(using: String.Encoding.utf8)!, withName: "websiteLink")
                    
                    // Add other image data here if not nil
                    // Example:
                    if let image = vendorImage {
                        let imgData2 = image.jpegData(compressionQuality: 0.3)!
                        multiPart.append(imgData2, withName: "Vendorimg", fileName: randomString(length: 6) + "profilepic.png", mimeType: "image/png")
                    }
                    if let image1 = portfolio1img {
                        let imgData3 = image1.jpegData(compressionQuality: 0.3)!
                        multiPart.append(imgData3, withName: "portfolioImages1", fileName: randomString(length: 6) + "portfolio1.png", mimeType: "image/png")
                    }
                    if let image2 = portfolio2img {
                        let imgData4 = image2.jpegData(compressionQuality: 0.3)!
                        multiPart.append(imgData4, withName: "portfolioImages2", fileName: randomString(length: 6) + "portfolio1.png", mimeType: "image/png")
                    }
                    if let image3 = portfolio3img {
                        let imgData5 = image3.jpegData(compressionQuality: 0.3)!
                        multiPart.append(imgData5, withName: "portfolioImages3", fileName: randomString(length: 6) + "portfolio1.png", mimeType: "image/png")
                    }
                    // Add other images
                    
                }, with: urlRequest)
                .uploadProgress(queue: .main, closure: { progress in
                    // Current upload progress of file
                    print("Upload Progress: \(progress.fractionCompleted)")
                })
                .responseJSON(completionHandler: { data in
                    switch data.result {
                    case .success(_):
                        do {
                            let dictionary = try JSONSerialization.jsonObject(with: data.data!, options: .fragmentsAllowed) as! NSDictionary
                            print("Success!")
                            print(dictionary)
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

    
    //this function helps to connect to server and help us verfying the username
    func updateVendorService(loginData: LoginViewModel, serviceID: String) async -> String {
        print("Starting to check username")
        print("using these info to update: ")
        print(serviceID)
        await print(loginData.mainUserID)

        guard let url = URL(string: "http://64.227.150.47/main/postService") else {
            print("Error: cannot create URL")
            return "Failure: Invalid URL"
        }

        let body: [String: AnyHashable] = await [
            "user_id": loginData.mainUserID,
            "serviceId": serviceID,
        ]
        

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        do {
            let jsonData = try JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)
            request.httpBody = jsonData

            let (data, response) = try await URLSession.shared.data(for: request)
            guard let httpResponse = response as? HTTPURLResponse, (200 ..< 299) ~= httpResponse.statusCode else {
                print("Error: HTTP request failed")
                return "Failure: HTTP request failed"
            }

            let decoder = JSONDecoder()
            let decodedData = try decoder.decode(NormalMessageResponse.self, from: data)
            
            return "Success"
        } catch {
            print("Error: \(error)")
            return "Failure: \(error.localizedDescription)"
        }
    }
    
    //this function helps to connect to server and help us verfying the username
    func addVendorServiceName(loginData: LoginViewModel, serviceID: String) {
    
        //Updating the user Interest
        print("Starting to check username")
        print("using these info to update: ")
        print(loginData.mainUserUserName)
    
        guard let url = URL(string: "http://64.227.150.47/main/postService") else {
            print("Error: cannot create URL")
            return
        }
    
        // Create & Add data to the model
        
        let body: [String: AnyHashable] = [
            "serviceID": serviceID,
            "userID": loginData.mainUserID,
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
    
    func getServicesList(globalVM: GlobalViewModel) async -> String {
        DispatchQueue.main.async {
            globalVM.vendorServicesList = [VendorService]()
        }
        print("Starting to get hotel names")
        
        guard let url = URL(string: "http://64.227.150.47/main/getServiceName") else {
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
            let decodedData = try decoder.decode([VendorService].self, from: data)
            
            DispatchQueue.main.async {
                globalVM.vendorServicesList = decodedData
            }
            
            return "Success"
        } catch {
            print("Error: \(error)")
            return "Failure: \(error.localizedDescription)"
        }
    }

    
    //this function helps us to update the location of a user to the server
    func postuserCompletionStatus(loginData: LoginViewModel) {
    
        //Updating the user Interest
        print("Starting to check username")
        print("using these info to update: ")
        print(loginData.mainUserLocationCountry)
        print(loginData.mainUserLocationState)
        print(loginData.mainUserLocationCity)
    
        guard let url = URL(string: "http://64.227.150.47/main/update/\(loginData.mainUserID)") else {
            print("Error: cannot create URL")
            return
        }
    
        // Create & Add data to the model
        let body: [String: AnyHashable] = [
            "location": loginData.mainUserLocationCity + ", " + loginData.mainUserLocationState + ", " + loginData.mainUserLocationCountry,
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
                    
                    loginData.profileLocationInfoCompleted = true
                } catch {
                    print("Error: Trying to convert JSON data to string")
                    return
                }
            }
        }
        task.resume()
    
    }
    
}
