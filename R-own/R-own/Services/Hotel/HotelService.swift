//
//  HotelService.swift
//  R-own
//
//  Created by Aman Sharma on 30/05/23.
//

import Foundation
import SwiftUI
import Alamofire

class HotelService: ObservableObject{
    
    
    // MARK: - fetch service


    func getHotelDataList(globalVM: GlobalViewModel) {
    
        globalVM.hotelDataModelList = [HotelDataModel]()
        //Updating the user Interest
        print("Starting to get hotel data list")
    
        guard let url = URL(string: "http://64.227.150.47/main/getHotel") else {
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
                    let decodedData = try decoder.decode([HotelDataModel].self, from: data)
                    globalVM.hotelDataModelList = decodedData
    
                } catch {
                    print("Error: Trying to convert JSON data to string")
                    return
                }
            }
        }
        task.resume()
    }
    
    // MARK: - fetch service
    
    func getHotelDataByUserID(globalVM: GlobalViewModel, hotelID: String) async -> String {
        
        print("Starting to get hotel data via userID ")
        
        DispatchQueue.main.async {
            globalVM.hotelData = HotelDataModel(id: "", userID: "", hotelName: "", hotelAddress: "", hotelRating: "", hotelLogoURL: "", hotelCoverpicURL: "", bookingengineLink: "", dateAdded: "", hoteldescription: "", displayStatus: "", hotelID: "", gallery: [Gallery](), v: 0)
        }
        
        
        guard let url = URL(string: "http://64.227.150.47/main/getHotelByHotelId/\(hotelID)") else {
            print("Error: cannot create URL")
            return "Failure"
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            
            guard let httpResponse = response as? HTTPURLResponse, (200 ..< 299) ~= httpResponse.statusCode else {
                print("Error: HTTP request failed")
                return "Failure"
            }
            
            let decoder = JSONDecoder()
            let decodedData = try decoder.decode(HotelDataModel.self, from: data)
            DispatchQueue.main.async {
                globalVM.hotelData = decodedData
            }
            return "Success"
        } catch {
            print("Error: \(error)")
            return "Failure"
        }
    }



    
    // MARK: - fetch service


    func getHotelsByUserID(globalVM: GlobalViewModel, loginData: LoginViewModel, userID: String, viewerID: String) {
    
        globalVM.hotelListByID = [HotelDataByUserID]()
        //Updating the user Interest
        print("Starting to get hotels owner data by user id")
    
        guard let url = URL(string: "http://64.227.150.47/main/getHotel/\(userID)/\(viewerID)") else {
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
                    let decodedData = try decoder.decode([HotelDataByUserID].self, from: data)
                    globalVM.hotelListByID = decodedData
    
                } catch {
                    print("Error: Trying to convert JSON data to string")
                    return
                }
            }
        }
        task.resume()
    }

    
    // MARK: - patch service
    func updateHotelData(hotelID: String, hotelCoverpic: UIImage?, galleryImages1: UIImage?, galleryImages2: UIImage?, galleryImages3: UIImage?, hotelName: String, hotelAddress: String, Hoteldescription: String, hotelRating: String) async -> String {
        do {
            
            print("Starting to update hotel data ")
            
            // Create the async task and wait for the response
            let response = try await withUnsafeThrowingContinuation { continuation in
                let api_url = "http://64.227.150.47/main/updateHotelData/\(hotelID)"
                guard let url = URL(string: api_url) else {
                    continuation.resume(returning: "API Error")
                    return
                }

                var urlRequest = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 10.0 * 1000)
                urlRequest.httpMethod = "PATCH"
                urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")

                // Set Image Data
                AF.upload(multipartFormData: { multiPart in
                    multiPart.append((hotelName).data(using: String.Encoding.utf8)!, withName: "hotelName")
                    multiPart.append((hotelAddress).data(using: String.Encoding.utf8)!, withName: "hotelAddress")
                    multiPart.append((Hoteldescription).data(using: String.Encoding.utf8)!, withName: "Hoteldescription")
                    multiPart.append((hotelRating).data(using: String.Encoding.utf8)!, withName: "hotelRating")
                    if let hotelCoverpic = hotelCoverpic, let imgData1 = hotelCoverpic.jpegData(compressionQuality: 0.5) {
                        multiPart.append(imgData1, withName: "hotelCoverpic", fileName: randomString(length: 7)+"hotelCoverPic.png", mimeType: "image/png")
                    }
                    if let galleryImages1 = galleryImages1, let imgData2 = galleryImages1.jpegData(compressionQuality: 0.5) {
                        multiPart.append(imgData2, withName: "galleryImages1", fileName: randomString(length: 7)+"galleryImage1.png", mimeType: "image/png")
                    }
                    if let galleryImages2 = galleryImages2, let imgData3 = galleryImages2.jpegData(compressionQuality: 0.5) {
                        multiPart.append(imgData3, withName: "galleryImages2", fileName: randomString(length: 7)+"galleryImage2.png", mimeType: "image/png")
                    }
                    if let galleryImages3 = galleryImages3, let imgData4 = galleryImages3.jpegData(compressionQuality: 0.5) {
                        multiPart.append(imgData4, withName: "galleryImages3", fileName: randomString(length: 7)+"galleryImage3.png", mimeType: "image/png")
                    }
                }, with: urlRequest)
                .uploadProgress(queue: .main, closure: { progress in
                    // Current upload progress of file
                    print("Upload Progress: \(progress.fractionCompleted)")
                })
                .responseJSON { data in
                    switch data.result {
                    case .success(_):
                        do {
                            let dictionary = try JSONSerialization.jsonObject(with: data.data!, options: .fragmentsAllowed) as! NSDictionary
                            print("Success!")
                            print(dictionary)
                            continuation.resume(returning: "Success")
                        } catch {
                            // Catch error.
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
                }
            }

            return response
        } catch {
            return "Error: \(error)"
        }
    }

    
    // MARK: - patch service
    func updateHotelBEAndLogo(hotelID: String, bookingengineLink: String, hotelLogo: UIImage?) async -> String {
        do {
            
            print("Starting to update hotel backfround and logo ")
            
            // Create the async task and wait for the response
            let response = try await withUnsafeThrowingContinuation { continuation in
                let api_url = "http://64.227.150.47/main/updateHotelData/\(hotelID)"
                guard let url = URL(string: api_url) else {
                    continuation.resume(returning: "API Error")
                    return
                }

                var urlRequest = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 10.0 * 1000)
                urlRequest.httpMethod = "PATCH"
                urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")

                // Set Image Data
                AF.upload(multipartFormData: { multiPart in
                    multiPart.append((bookingengineLink).data(using: String.Encoding.utf8)!, withName: "bookingengineLink")
                    if let hotelCoverpic = hotelLogo, let imgData1 = hotelCoverpic.jpegData(compressionQuality: 0.5) {
                        multiPart.append(imgData1, withName: "hotelLogo", fileName: randomString(length: 7)+"hotelLogo.png", mimeType: "image/png")
                    }
                }, with: urlRequest)
                .uploadProgress(queue: .main, closure: { progress in
                    // Current upload progress of file
                    print("Upload Progress: \(progress.fractionCompleted)")
                })
                .responseJSON { data in
                    switch data.result {
                    case .success(_):
                        do {
                            let dictionary = try JSONSerialization.jsonObject(with: data.data!, options: .fragmentsAllowed) as! NSDictionary
                            print("Success!")
                            print(dictionary)
                            continuation.resume(returning: "Success")
                        } catch {
                            // Catch error.
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
                }
            }

            return response
        } catch {
            return "Error: \(error)"
        }
    }
    
    // MARK: - patch service
    
    func deleteHotelData(loginData: LoginViewModel, hotelID: String) async -> String {
        do {
            
            print("Starting to delete hotel data")
            
            // Create the async task and wait for the response
            let response = try await withUnsafeThrowingContinuation { continuation in
                let api_url = "http://64.227.150.47/main/updateHotelData/\(hotelID)"
                guard let url = URL(string: api_url) else {
                    continuation.resume(returning: "API Error")
                    return
                }

                var urlRequest = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 10.0 * 1000)
                urlRequest.httpMethod = "PATCH"
                urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")

                // Set Image Data
                AF.upload(multipartFormData: { multiPart in
                    multiPart.append(("0").data(using: String.Encoding.utf8)!, withName: "display_status")
                }, with: urlRequest)
                .uploadProgress(queue: .main, closure: { progress in
                    // Current upload progress of file
                    print("Upload Progress: \(progress.fractionCompleted)")
                })
                .responseJSON { data in
                    switch data.result {
                    case .success(_):
                        do {
                            let dictionary = try JSONSerialization.jsonObject(with: data.data!, options: .fragmentsAllowed) as! NSDictionary
                            print("Success!")
                            print(dictionary)
                            continuation.resume(returning: "Success")
                        } catch {
                            // Catch error.
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
                }
            }

            return response
        } catch {
            return "Error: \(error)"
        }
    }
    
    // MARK: - fetch service

    func getHotelOwnerInfoByUserID(globalVM: GlobalViewModel, loginData: LoginViewModel, userID: String) async -> String {
        
        print("Starting to hotel owner info by userID")
        
        DispatchQueue.main.async {
            globalVM.getHotelOwnerInfo = GetHotelOwnerInfoModel(hotelOwnerInfo: [HotelOwnerInfoElement23](), hotelID: "", hotelLogoURL: "")
        }

        guard let url = URL(string: "http://64.227.150.47/main/getHotelInfo/\(userID)") else {
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
            let decodedData = try decoder.decode(GetHotelOwnerInfoModel.self, from: data)
            DispatchQueue.main.async {
                globalVM.getHotelOwnerInfo = decodedData
            }

            return "Success"
        } catch {
            print("Error: \(error)")
            return "Failure: \(error.localizedDescription)"
        }
    }


    
    
    // MARK: - multipart service


    func updateHotelOwnerProfileData(loginData: LoginViewModel, userBio: String, userIdentity: String, profileImage: UIImage!) {
    //        let userphonenumber: Int = (loginData.mainUserPhoneNumber.deletingPrefix("+") as NSString).integerValue
        //Set Your URL
        
        print("Starting to update hotel owner profile data ")
    
        let api_url = "http://64.227.150.47/main/update/\(loginData.mainUserID)"
        guard let url = URL(string: api_url) else {
            return
        }

        var urlRequest = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 10.0 * 1000)
        urlRequest.httpMethod = "PATCH"
        urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")

       // Now Execute
        AF.upload(multipartFormData: { multiPart in
            multiPart.append((userBio).data(using: String.Encoding.utf8)!, withName: "userBio")
            multiPart.append((userIdentity).data(using: String.Encoding.utf8)!, withName: "Gender")
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

    func updatehotelOwnerInfo(loginData: LoginViewModel, hotelOwnerName: String, hotelDescription: String, hotelType: String, websiteLink: String) {
    
        //Updating the user Interest
        print("Starting to update hotelOwnerInfo")
    
        guard let url = URL(string: "http://64.227.150.47/main/hotelOwner/\(loginData.mainUserID)") else {
            print("Error: cannot create URL")
            return
        }
    
        // Create & Add data to the model
        let body: [String: AnyHashable] = [
            "hotelownerName": hotelOwnerName,
            "hotelDescription": hotelDescription,
            "hotelType": hotelType,
            "websiteLink":websiteLink
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
}
