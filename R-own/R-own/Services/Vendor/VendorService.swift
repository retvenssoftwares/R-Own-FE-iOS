//
//  VendorService.swift
//  R-own
//
//  Created by Aman Sharma on 29/05/23.
//

import Foundation
import SwiftUI
import Alamofire

class VendorProfileService: ObservableObject{
    
    // MARK: - fetch service


    func getVendorServicesByID(loginData: LoginViewModel, globalVM: GlobalViewModel, userID: String) {
    
        globalVM.vendorServicesListByID = [ServiceByIDModel]()
        //Updating the user Interest
        print("Starting to get vendor services by ID")
    
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
                    let decodedData = try decoder.decode([ServiceByIDModel].self, from: data)
                    
                    globalVM.vendorServicesListByID = decodedData
    
                } catch {
                    print("Error: Trying to convert JSON data to string")
                    return
                }
            }
        }
        task.resume()
    }

    // MARK: - patch service

    func updateServicePrice(loginData: LoginViewModel, vendorServiceID: String, updatedPrice: String, displayStatus: String) {
    
        
        //Updating the user Interest
        print("trying to update service price")
        
        guard let url = URL(string: "http://64.227.150.47/main/updatePrice/\(vendorServiceID)") else {
            print("Error: cannot create URL")
            return
        }
    
        // Create & Add data to the model
        let body: [String: AnyHashable] = [
            "vendorServicePrice": updatedPrice,
            "display_status": displayStatus
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
    
    
    func updateVendorProfileData(userID: String, bio: String, profileImage: UIImage!) {
    //        let userphonenumber: Int = (loginData.mainUserPhoneNumber.deletingPrefix("+") as NSString).integerValue
        //Set Your URL
            let api_url = "http://64.227.150.47/main/update/\(userID)"
            guard let url = URL(string: api_url) else {
                return
            }
    
            var urlRequest = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 10.0 * 1000)
            urlRequest.httpMethod = "PATCH"
            urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
    
           // Now Execute
            AF.upload(multipartFormData: { multiPart in
                multiPart.append((bio).data(using: String.Encoding.utf8)!, withName: "userBio")
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
    
    
    // MARK: - patch service
    func deleteVendorService(vendorServiceID: String) async -> Result<String, Error> {
        print("Deleting vendor service")

        guard let url = URL(string: "http://64.227.150.47/main/deleteService/\(vendorServiceID)") else {
            print("Error: cannot create URL")
            return .failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil))
        }

        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        do {
            let (_, response) = try await URLSession.shared.data(for: request)
            if let httpResponse = response as? HTTPURLResponse, (200 ..< 299) ~= httpResponse.statusCode {
                print("Vendor service deleted successfully")
                return .success("Success")
            } else {
                print("Error: HTTP request failed with status code \((response as? HTTPURLResponse)?.statusCode ?? -1)")
                return .failure(NSError(domain: "HTTP request failed", code: (response as? HTTPURLResponse)?.statusCode ?? -1, userInfo: nil))
            }
        } catch {
            print("Error: \(error)")
            return .failure(error)
        }
    }


    
}
