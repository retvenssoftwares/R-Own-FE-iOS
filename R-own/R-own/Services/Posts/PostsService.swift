//
//  PostsService.swift
//  R-own
//
//  Created by Aman Sharma on 29/05/23.
//

import Foundation
import SwiftUI
import Alamofire

class PostsService: ObservableObject{
    
    
    // MARK: - multipart service

    //post normal Status
    func postNormalStatusService(loginData: LoginViewModel, postCaption: String, location: String, postType: String, canSee: String, canComment: String) {
    //        let userphonenumber: Int = (loginData.mainUserPhoneNumber.deletingPrefix("+") as NSString).integerValue
        //Set Your URL
            let api_url = "http://64.227.150.47/main/post/\(loginData.mainUserID)"
            guard let url = URL(string: api_url) else {
                return
            }
    
            var urlRequest = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 10.0 * 1000)
            urlRequest.httpMethod = "POST"
            urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
    
           // Now Execute
            AF.upload(multipartFormData: { multiPart in
                multiPart.append((loginData.mainUserID).data(using: String.Encoding.utf8)!, withName: "user_id")
                multiPart.append((postCaption).data(using: String.Encoding.utf8)!, withName: "caption")
                multiPart.append((location).data(using: String.Encoding.utf8)!, withName: "location")
                multiPart.append((postType).data(using: String.Encoding.utf8)!, withName: "post_type")
                multiPart.append((canSee).data(using: String.Encoding.utf8)!, withName: "Can_See")
                multiPart.append((canComment).data(using: String.Encoding.utf8)!, withName: "Can_comment")
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
    
    
    func postClickNShareService(loginData: LoginViewModel, postCaption: String, location: String, postType: String, canSee: String, canComment: String, image: UIImage) async -> String {
        let userID = await loginData.mainUserID
        let api_url = "http://64.227.150.47/main/post/\(userID)"
        
        guard let url = URL(string: api_url) else {
            return "API Error"
        }

        var urlRequest = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 10.0 * 1000)
        urlRequest.httpMethod = "POST"
        urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")

        let uiImage: UIImage = image
        let imgData = uiImage.jpegData(compressionQuality: 0.3)!

        let userNameWithoutSpace = await loginData.mainUserFullName.replacingOccurrences(of: " ", with: "%20", options: .literal, range: nil)

        do {
            let response = try await withUnsafeThrowingContinuation { continuation in
                AF.upload(multipartFormData: { multiPart in
                    multiPart.append((userID).data(using: String.Encoding.utf8)!, withName: "user_id")
                    multiPart.append((postCaption).data(using: String.Encoding.utf8)!, withName: "caption")
                    multiPart.append((location).data(using: String.Encoding.utf8)!, withName: "location")
                    multiPart.append((postType).data(using: String.Encoding.utf8)!, withName: "post_type")
                    multiPart.append((canSee).data(using: String.Encoding.utf8)!, withName: "Can_See")
                    multiPart.append((canComment).data(using: String.Encoding.utf8)!, withName: "Can_comment")
                    multiPart.append(imgData, withName: "media", fileName: "postclicknshare"+randomString(length: 6)+"postImage1.png", mimeType: "image/png")
                }, with: urlRequest)
                .uploadProgress(queue: .main, closure: { progress in
                    //Current upload progress of file
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
                }
            }

            return response
        } catch {
            return "Error: \(error)"
        }
    }


    
    //post shareSomeMedia
    func postShareSomeMediaService(loginData: LoginViewModel, postCaption: String, location: String, postType: String, canSee: String, canComment: String, imageList: [UIImage?]) async -> String {
        //Set Your URL
        
        let userID: String = await loginData.mainUserID
        let api_url = "http://64.227.150.47/main/post/\(userID)"
        guard let url = URL(string: api_url) else {
            return "API Error"
        }

        var urlRequest = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 10.0 * 1000)
        urlRequest.httpMethod = "POST"
        urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")

        //Set Image Data
        let userNameWithoutSpace = await loginData.mainUserFullName.replacingOccurrences(of: " ", with: "%20", options: .literal, range: nil)

        do {
            let response = try await withUnsafeThrowingContinuation { continuation in
                AF.upload(multipartFormData: { multiPart in
                    multiPart.append((userID).data(using: String.Encoding.utf8)!, withName: "user_id")
                    multiPart.append((postCaption).data(using: String.Encoding.utf8)!, withName: "caption")
                    multiPart.append((location).data(using: String.Encoding.utf8)!, withName: "location")
                    multiPart.append((postType).data(using: String.Encoding.utf8)!, withName: "post_type")
                    multiPart.append((canSee).data(using: String.Encoding.utf8)!, withName: "Can_See")
                    multiPart.append((canComment).data(using: String.Encoding.utf8)!, withName: "Can_comment")
                    for i in 0..<imageList.count {
                        if let uiImage = imageList[i], let imgData = uiImage.jpegData(compressionQuality: 0.3) {
                            multiPart.append(imgData, withName: "media", fileName: "shareSomeMedia"+randomString(length: 6)+"postImage(\(i)).png", mimeType: "image/png")
                        }
                    }
                }, with: urlRequest)
                .uploadProgress(queue: .main, closure: { progress in
                    //Current upload progress of file
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
                }
            }

            return response
        } catch {
            return "Error: \(error)"
        }
    }

    
    //post polls
    func postPollsService(loginData: LoginViewModel, postType: String, poll: PostPollsModel) async -> String {
        
        let userID: String = await loginData.mainUserID
        let api_url = "http://64.227.150.47/main/post/\(userID)"
        
        guard let url = URL(string: api_url) else {
            return "API Error"
        }

        var urlRequest = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 10.0 * 1000)
        urlRequest.httpMethod = "POST"
        urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")

        do {
            let response = try await withUnsafeThrowingContinuation { continuation in
                AF.upload(multipartFormData: { multiPart in
                    multiPart.append((userID).data(using: String.Encoding.utf8)!, withName: "user_id")
                    multiPart.append((postType).data(using: String.Encoding.utf8)!, withName: "post_type")
                    multiPart.append((poll.Question).data(using: String.Encoding.utf8)!, withName: "pollQuestion[0][Question]")
                    for x in 0..<poll.Options.count {
                        multiPart.append((poll.Options[x].Option).data(using: String.Encoding.utf8)!, withName: "pollQuestion[0][Options][\(x)][Option]")
                    }
                }, with: urlRequest)
                .uploadProgress(queue: .main, closure: { progress in
                    //Current upload progress of file
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
                }
            }

            return response
        } catch {
            return "Error: \(error)"
        }
    }

    
    //post checkIns
    func postCheckInsService(loginData: LoginViewModel, postCaption: String, location: String, postType: String, canSee: String, canComment: String, checkInLocation: String, checkInVenue: String, hotelID: String) async -> String {
        //Set Your URL
        let userID = await loginData.mainUserID
        let api_url = "http://64.227.150.47/main/post/\(userID)"
        guard let url = URL(string: api_url) else {
            return "API Error"
        }

        var urlRequest = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 10.0 * 1000)
        urlRequest.httpMethod = "POST"
        urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")

        do {
            let response = try await withUnsafeThrowingContinuation { continuation in
                AF.upload(multipartFormData: { multiPart in
                    multiPart.append((userID).data(using: String.Encoding.utf8)!, withName: "user_id")
                    multiPart.append((postCaption).data(using: String.Encoding.utf8)!, withName: "caption")
                    multiPart.append((location).data(using: String.Encoding.utf8)!, withName: "location")
                    multiPart.append((postType).data(using: String.Encoding.utf8)!, withName: "post_type")
                    multiPart.append((canSee).data(using: String.Encoding.utf8)!, withName: "Can_See")
                    multiPart.append((canComment).data(using: String.Encoding.utf8)!, withName: "Can_comment")
                    multiPart.append((hotelID).data(using: String.Encoding.utf8)!, withName: "hotel_id")
                    multiPart.append((checkInLocation).data(using: String.Encoding.utf8)!, withName: "checkinLocation")
                    multiPart.append((checkInVenue).data(using: String.Encoding.utf8)!, withName: "checkinVenue")
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

    
    //post update event
    func postUpdateEventService(loginData: LoginViewModel, postCaption: String, location: String, postType: String, canSee: String, canComment: String, eventID: String, eventLocation: String) {
    //        let userphonenumber: Int = (loginData.mainUserPhoneNumber.deletingPrefix("+") as NSString).integerValue
        //Set Your URL
            let api_url = "http://64.227.150.47/main/post/\(loginData.mainUserID)"
            guard let url = URL(string: api_url) else {
                return
            }
    
            var urlRequest = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 10.0 * 1000)
            urlRequest.httpMethod = "POST"
            urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
    
           // Now Execute
            AF.upload(multipartFormData: { multiPart in
                multiPart.append((loginData.mainUserID).data(using: String.Encoding.utf8)!, withName: "user_id")
                multiPart.append((postCaption).data(using: String.Encoding.utf8)!, withName: "caption")
                multiPart.append((location).data(using: String.Encoding.utf8)!, withName: "location")
                multiPart.append((postType).data(using: String.Encoding.utf8)!, withName: "post_type")
                multiPart.append((canSee).data(using: String.Encoding.utf8)!, withName: "Can_See")
                multiPart.append((canComment).data(using: String.Encoding.utf8)!, withName: "Can_comment")
                multiPart.append((eventLocation).data(using: String.Encoding.utf8)!, withName: "Event_location")
                multiPart.append((eventID).data(using: String.Encoding.utf8)!, withName: "Event_name")
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
    
    
    // MARK: - fetch service


    func getEventListWhilePosting(globalVM: GlobalViewModel, createPostVM: CreatePostViewModel) {
    
        
        globalVM.eventListWhilePostingList = [EventListWhilePostingModel]()
        //Updating the user Interest
        print("Starting to get events list")
//        let location = String(createPostVM.postLocation.filter { !" \n\t\r".contains($0) })
        
        var location = createPostVM.postLocation.replacingOccurrences(of: " ", with: "%20")
        location = location.replacingOccurrences(of: ",", with: "%20,%20")
        print(location)
        guard let url = URL(string: "http://64.227.150.47/main/getEventPosting/\(location)") else {
            print("Error: cannot create URL")
            return
        }
        print("http://64.227.150.47/main/getEventPosting/\(location)")
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
                    let decodedData = try decoder.decode([EventListWhilePostingModel].self, from: data)
                    
                    globalVM.eventListWhilePostingList = decodedData
    
                } catch {
                    print("Error: Trying to convert JSON data to string")
                    return
                }
            }
        }
        task.resume()
    }
        
    
    // MARK: - patch service

    func updateOptionInPoll(loginData: LoginViewModel, postID: String, optionID: String) {
    
        //Updating the user Interest
        print("updating options")
    
        guard let url = URL(string: "http://64.227.150.47/main/polls/\(postID)/\(optionID)") else {
            print("Error: cannot create URL")
            return
        }
    
        // Create & Add data to the model
        let body: [String: AnyHashable] = [
            "user_id": loginData.mainUserID
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
    
    
    // MARK: - patch service
    func editPost(postID: String, caption: String, location: String, canSee: String, Can_comment: String) async -> String {
        
        // Updating the user Interest
        print("Starting to update user post")
        
        guard let url = URL(string: "http://64.227.150.47/main/editPost/\(postID)") else {
            print("Error: cannot create URL")
            return "URL Creation Failed"
        }
        
        // Create & Add data to the model
        let body: [String: AnyHashable] = [
            "caption": caption,
            "location": location,
            "canSee": canSee,
            "Can_comment": Can_comment
        ]
        
        
        // Create the request
        var request = URLRequest(url: url)
        request.httpMethod = "PATCH"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // Convert request to JSON data
        guard let httpBody = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed) else {
            print("Error: Data serialization failed")
            return "Data Serialization Failed"
        }
        request.httpBody = httpBody
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse, (200 ..< 299) ~= httpResponse.statusCode else {
                print("Error: HTTP request failed")
                return "HTTP Request Failed"
            }
            
            let decoder = JSONDecoder()
            let decodedData = try decoder.decode(NormalMessageResponse.self, from: data)
            
            print("user data updated on server")
            return "Success"
        } catch {
            print("Error: \(error)")
            return "Error: \(error)"
        }
    }
    
    // MARK: - patch service
    func deletePost(postID: String, display_status: String) async -> String {
        
        // Updating the user Interest
        print("Starting to update user post")
        
        guard let url = URL(string: "http://64.227.150.47/main/editPost/\(postID)") else {
            print("Error: cannot create URL")
            return "URL Creation Failed"
        }
        
        // Create & Add data to the model
        let body: [String: AnyHashable] = [
            "display_status": display_status,
        ]
        
        
        // Create the request
        var request = URLRequest(url: url)
        request.httpMethod = "PATCH"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // Convert request to JSON data
        guard let httpBody = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed) else {
            print("Error: Data serialization failed")
            return "Data Serialization Failed"
        }
        request.httpBody = httpBody
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse, (200 ..< 299) ~= httpResponse.statusCode else {
                print("Error: HTTP request failed")
                return "HTTP Request Failed"
            }
            
            let decoder = JSONDecoder()
            let decodedData = try decoder.decode(NormalMessageResponse.self, from: data)
            
            print("user data updated on server")
            return "Success"
        } catch {
            print("Error: \(error)")
            return "Error: \(error)"
        }
    }
}
