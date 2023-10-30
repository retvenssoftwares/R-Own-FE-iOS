//
//  HotelOwnerUserProfileCompletionService.swift
//  R-own
//
//  Created by Aman Sharma on 25/05/23.
//


import Foundation
import Alamofire
import UIKit


class HotelOwnerUserProfileCompletionService: ObservableObject{
    
//    func updateSingleHotelDataInfo(loginData: LoginViewModel, hotelLogo: UIImage, hotelBG: UIImage) {
//    //        let userphonenumber: Int = (loginData.mainUserPhoneNumber.deletingPrefix("+") as NSString).integerValue
//        //Set Your URL
//            let api_url = "http://64.227.150.47/main/hotelOwner/\(loginData.mainUserID)"
//            guard let url = URL(string: api_url) else {
//                return
//            }
//
//            var urlRequest = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 10.0 * 1000)
//            urlRequest.httpMethod = "PATCH"
//            urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
//
//            //Set Hotel Logo Data
//            let uiImage1: UIImage = loginData.userImage!
//            let imgData1 = uiImage1.jpegData(compressionQuality: 0.5)!
//            let userNameWithoutSpace1 = loginData.mainUserFullName.replacingOccurrences(of: " ", with: "%20", options: .literal, range: nil)
//
//
//            //Set Hotel BG Data
//            let uiImage: UIImage = loginData.userImage!
//            let imgData = uiImage.jpegData(compressionQuality: 0.5)!
//            let userNameWithoutSpace = loginData.mainUserFullName.replacingOccurrences(of: " ", with: "%20", options: .literal, range: nil)
//           // Now Execute
//            AF.upload(multipartFormData: { multiPart in
//                multiPart.append((loginData.mainUserFullName).data(using: String.Encoding.utf8)!, withName: "Full_name")
//                print(22)
//                multiPart.append((loginData.mainUserEmail).data(using: String.Encoding.utf8)!, withName: "Email")
//                print(23)
//                multiPart.append(imgData, withName: "Profile_pic", fileName: userNameWithoutSpace+randomString(length: 6), mimeType: "image/png")
//                multiPart.append(imgData, withName: "Profile_pic", fileName: userNameWithoutSpace+randomString(length: 6), mimeType: "image/png")
//            }, with: urlRequest)
//                .uploadProgress(queue: .main, closure: { progress in
//                    //Current upload progress of file
//                    print("Upload Progress: \(progress.fractionCompleted)")
//                })
//                .responseJSON(completionHandler: { data in
//
//                           switch data.result {
//
//                           case .success(_):
//
//                            do {
//
//                            let dictionary = try JSONSerialization.jsonObject(with: data.data!, options: .fragmentsAllowed) as! NSDictionary
//
//                                print("Success!")
//                                print(dictionary)
//                                self.updateMesiboDataOnUserProfile(loginData: loginData)
//                           }
//                           catch {
//                              // catch error.
//                            print("catch error")
//
//                                  }
//                            break
//
//                           case .failure(_):
//                            print("failure")
//
//                            break
//
//                        }
//
//
//                })
//    }
//
//
//    func updateMultiChainHotel(loginData: LoginViewModel) {
//    //        let userphonenumber: Int = (loginData.mainUserPhoneNumber.deletingPrefix("+") as NSString).integerValue
//        //Set Your URL
//            let api_url = "http://64.227.150.47/main/update/\(loginData.mainUserID)"
//            guard let url = URL(string: api_url) else {
//                return
//            }
//
//            var urlRequest = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 10.0 * 1000)
//            urlRequest.httpMethod = "PATCH"
//            urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
//
//            //Set Image Data
//            let uiImage: UIImage = loginData.userImage!
//            let imgData = uiImage.jpegData(compressionQuality: 0.5)!
//            let userNameWithoutSpace = loginData.mainUserFullName.replacingOccurrences(of: " ", with: "%20", options: .literal, range: nil)
//           // Now Execute
//            AF.upload(multipartFormData: { multiPart in
//                multiPart.append((loginData.mainUserFullName).data(using: String.Encoding.utf8)!, withName: "Full_name")
//                print(22)
//                multiPart.append((loginData.mainUserEmail).data(using: String.Encoding.utf8)!, withName: "Email")
//                print(23)
//                multiPart.append(imgData, withName: "Profile_pic", fileName: userNameWithoutSpace+"profilepic.png", mimeType: "image/png")
//            }, with: urlRequest)
//                .uploadProgress(queue: .main, closure: { progress in
//                    //Current upload progress of file
//                    print("Upload Progress: \(progress.fractionCompleted)")
//                })
//                .responseJSON(completionHandler: { data in
//
//                           switch data.result {
//
//                           case .success(_):
//
//                            do {
//
//                            let dictionary = try JSONSerialization.jsonObject(with: data.data!, options: .fragmentsAllowed) as! NSDictionary
//
//                                print("Success!")
//                                print(dictionary)
//                                self.updateMesiboDataOnUserProfile(loginData: loginData)
//                           }
//                           catch {
//                              // catch error.
//                            print("catch error")
//
//                                  }
//                            break
//
//                           case .failure(_):
//                            print("failure")
//
//                            break
//
//                        }
//
//
//                })
//    }
    
    
    
    //this function helps to connect to server and help us verfying the username
    func updateHotelOwnerInfo(loginData: LoginViewModel) {
    
        //Updating the user Interest
        print("Starting to check hotel owner info")
        print("using these info to update: ")
        print(loginData.mainUserUserName)
        print(loginData.hotelType)
        print(loginData.noOfHotels)
        print(loginData.hotelWebsiteLink)
        print(loginData.hotelBookingEngineLink)
    
        guard let url = URL(string: "http://64.227.150.47/main/hotelOwner/\(loginData.mainUserID)") else {
            print("Error: cannot create URL")
            return
        }
    
        // Create & Add data to the model
        
//        let hotelOwnerInformation: [String: AnyHashable] = [
//        ]
        
        let body: [String: AnyHashable] = [
            "hotelownerName": loginData.mainUserFullName,
            "hotelType": loginData.hotelType,
            "hotelCount": loginData.noOfHotels,
            "websiteLink": loginData.hotelWebsiteLink,
            "bookingEngineLink": loginData.hotelBookingEngineLink
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
    
    func updateHotelInfoIndividually(loginData: LoginViewModel, hotelLogo: UIImage, hotelBG: UIImage, hotelName: String, hotelAddress: String, hotelRating: String, hotelDescription: String) {
        //        let userphonenumber: Int = (loginData.mainUserPhoneNumber.deletingPrefix("+") as NSString).integerValue
            //Set Your URL
                let api_url = "http://64.227.150.47/main/hotelPost"
                guard let url = URL(string: api_url) else {
                    return
                }
        
                var urlRequest = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 10.0 * 1000)
                urlRequest.httpMethod = "POST"
                urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
        
                
                //Set Hotel Logo Data
                let uiImage1: UIImage = hotelLogo
                let imgData1 = uiImage1.jpegData(compressionQuality: 0.5)!
                let hotelNameWithoutSpace = loginData.mainUserFullName.replacingOccurrences(of: " ", with: "%20", options: .literal, range: nil)
                //Set Hotel CoverPic Data
                let uiImage2: UIImage = hotelBG
                let imgData2 = uiImage2.jpegData(compressionQuality: 0.5)!
            
               // Now Execute
                AF.upload(multipartFormData: { multiPart in
                    multiPart.append((hotelName).data(using: String.Encoding.utf8)!, withName: "hotelName")
                    multiPart.append((hotelAddress).data(using: String.Encoding.utf8)!, withName: "hotelAddress")
                    multiPart.append((hotelRating).data(using: String.Encoding.utf8)!, withName: "hotelRating")
                    multiPart.append((loginData.mainUserID).data(using: String.Encoding.utf8)!, withName: "user_id")
                    multiPart.append((hotelDescription).data(using: String.Encoding.utf8)!, withName: "Hoteldescription")
                    multiPart.append(imgData1, withName: "hotelLogo", fileName: loginData.mainUserUserName+"logo"+randomString(length: 6)+".png", mimeType: "image/png")
                    multiPart.append(imgData2, withName: "hotelCoverpic", fileName: loginData.mainUserUserName+"cover"+randomString(length: 6)+".png", mimeType: "image/png")
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
}

func randomString(length: Int) -> String {
    let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
    return String((0..<length).map{ _ in letters.randomElement()! })
}
