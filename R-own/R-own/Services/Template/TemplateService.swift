//
//  TemplateService.swift
//  R-own
//
//  Created by Aman Sharma on 24/05/23.
//

import Foundation

// MARK: - fetch service


//func getCountryList(globalVM: GlobalViewModel) {
//
//    //Updating the user Interest
//    print("Starting to get country list")
//
//    guard let url = URL(string: "http://64.227.150.47/main/countries") else {
//        print("Error: cannot create URL")
//        return
//    }
//
//
//
//    // Create the request
//    var request = URLRequest(url: url)
//    request.httpMethod = "GET"
//    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//
//
//    let task = URLSession.shared.dataTask(with: request) { data, response, error in
//
//        DispatchQueue.main.async {
//            guard error == nil else {
//                print("Error: error calling GET")
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
//                let decoder = JSONDecoder()
//                let decodedData = try decoder.decode([CountryModel].self, from: data)
//                
//                globalVM.countriesList = decodedData
//
//            } catch {
//                print("Error: Trying to convert JSON data to string")
//                return
//            }
//        }
//    }
//    task.resume()
//}


// MARK: - post service

//func updateuserDataAfterLoginWithoutImage(loginData: LoginViewModel) {
//
//    //Updating the user Interest
//    print("Starting to update user profile without image")
//    print("using these info to update: ")
//    print(loginData.mainUserFullName)
//    print(loginData.mainUserEmail)
//    print(loginData.mainUserProfilePic)
//
//    guard let url = URL(string: "http://64.227.150.47/main/update/\(loginData.mainUserID)") else {
//        print("Error: cannot create URL")
//        return
//    }
//
//    // Create & Add data to the model
//    let body: [String: AnyHashable] = [
//        "Full_name": loginData.mainUserFullName,
//        "Email": loginData.mainUserEmail,
//        "Profile_pic": loginData.mainUserProfilePic
//    ]
//    
//
//
//    // Create the request
//    var request = URLRequest(url: url)
//    request.httpMethod = "POST"
//    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//
//    // Convert request to JSON data
//    request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)
//
//    let task = URLSession.shared.dataTask(with: request) { data, response, error in
//
//        DispatchQueue.main.async {
//            guard error == nil else {
//                print("Error: error calling PATCH")
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
//                let decoder = JSONDecoder()
//                let decodedData = try decoder.decode(NormalMessageResponse.self, from: data)
//                
//                print("user data updated on server")
//                self.updateMesiboDataOnUserProfile(loginData: loginData)
//            } catch {
//                print("Error: Trying to convert JSON data to string")
//                return
//            }
//        }
//    }
//    task.resume()
//
//}

// MARK: - patch service

//func updateuserDataAfterLoginWithoutImage(loginData: LoginViewModel) {
//
//    //Updating the user Interest
//    print("Starting to update user profile without image")
//    print("using these info to update: ")
//    print(loginData.mainUserFullName)
//    print(loginData.mainUserEmail)
//    print(loginData.mainUserProfilePic)
//
//    guard let url = URL(string: "http://64.227.150.47/main/update/\(loginData.mainUserID)") else {
//        print("Error: cannot create URL")
//        return
//    }
//
//    // Create & Add data to the model
//    let body: [String: AnyHashable] = [
//        "Full_name": loginData.mainUserFullName,
//        "Email": loginData.mainUserEmail,
//        "Profile_pic": loginData.mainUserProfilePic
//    ]
//    
//
//
//    // Create the request
//    var request = URLRequest(url: url)
//    request.httpMethod = "PATCH"
//    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//
//    // Convert request to JSON data
//    request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)
//
//    let task = URLSession.shared.dataTask(with: request) { data, response, error in
//
//        DispatchQueue.main.async {
//            guard error == nil else {
//                print("Error: error calling PATCH")
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
//                let decoder = JSONDecoder()
//                let decodedData = try decoder.decode(NormalMessageResponse.self, from: data)
//                
//                print("user data updated on server")
//                self.updateMesiboDataOnUserProfile(loginData: loginData)
//            } catch {
//                print("Error: Trying to convert JSON data to string")
//                return
//            }
//        }
//    }
//    task.resume()
//
//}

// MARK: - multipart service


//func updateUserDataAfterLogin(loginData: LoginViewModel) {
////        let userphonenumber: Int = (loginData.mainUserPhoneNumber.deletingPrefix("+") as NSString).integerValue
//    //Set Your URL
//        let api_url = "http://64.227.150.47/main/update/\(loginData.mainUserID)"
//        guard let url = URL(string: api_url) else {
//            return
//        }
//
//        var urlRequest = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 10.0 * 1000)
//        urlRequest.httpMethod = "PATCH"
//        urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
//
//        //Set Image Data
//        let uiImage: UIImage = loginData.userImage!
//        let imgData = uiImage.jpegData(compressionQuality: 0.5)!
//       // Now Execute
//        AF.upload(multipartFormData: { multiPart in
//            multiPart.append((loginData.mainUserFullName).data(using: String.Encoding.utf8)!, withName: "Full_name")
//            print(22)
//            multiPart.append((loginData.mainUserEmail).data(using: String.Encoding.utf8)!, withName: "Email")
//            print(23)
//            multiPart.append(imgData, withName: "Profile_pic", fileName: +\"profilepic.png", mimeType: "image/png")
//        }, with: urlRequest)
//            .uploadProgress(queue: .main, closure: { progress in
//                //Current upload progress of file
//                print("Upload Progress: \(progress.fractionCompleted)")
//            })
//            .responseJSON(completionHandler: { data in
//
//                       switch data.result {
//
//                       case .success(_):
//
//                        do {
//
//                        let dictionary = try JSONSerialization.jsonObject(with: data.data!, options: .fragmentsAllowed) as! NSDictionary
//
//                            print("Success!")
//                            print(dictionary)
//                            self.updateMesiboDataOnUserProfile(loginData: loginData)
//                       }
//                       catch {
//                          // catch error.
//                        print("catch error")
//
//                              }
//                        break
//
//                       case .failure(_):
//                        print("failure")
//
//                        break
//
//                    }
//
//
//            })
//}
