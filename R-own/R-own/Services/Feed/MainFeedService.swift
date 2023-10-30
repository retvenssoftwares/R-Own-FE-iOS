//
//  MainFeedService.swift
//  R-own
//
//  Created by Aman Sharma on 29/05/23.
//

import Foundation
import SwiftUI
import Alamofire

class MainFeedService: ObservableObject{
    
    // MARK: - fetch service


    func  getFeed(globalVM: GlobalViewModel, userID: String) {
    
        //Updating the user Interest
        print("Starting to get feed")
    
        guard let url = URL(string: "http://64.227.150.47/main/getConnPost/\(userID)") else {
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
                    let decodedData = try decoder.decode([FeedModel].self, from: data)
                    
                    
                    if decodedData[0].posts.count > 0 {
                            DispatchQueue.main.async {
                                globalVM.feedList[0].posts = globalVM.feedList[0].posts + decodedData[0].posts
                            }
                    }
    
                } catch {
                    print("Error: Trying to convert JSON data to string")
                    return
                }
            }
        }
        task.resume()
    }
    
    
    // MARK: - patch service

    func likePost(loginData: LoginViewModel, postID: String, posterID: String) {
    
        //Updating the user Interest
        print("Like Post")
        print("using these info to update: ")
        print(postID)
    
        guard let url = URL(string: "http://64.227.150.47/main/like/\(postID)") else {
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
                    
                    print("liked")
                } catch {
                    print("Error: Trying to convert JSON data to string")
                    return
                }
            }
        }
        task.resume()
    
    }
    
    
    // MARK: - patch service

    func commentPost(loginData: LoginViewModel, postID: String, posterID: String, comment: String) {
    
        //Updating the user Interest
        print("Like Post")
        print("using these info to update: ")
        print(postID)
    
        guard let url = URL(string: "http://64.227.150.47/main/postComment/\(postID)") else {
            print("Error: cannot create URL")
            return
        }
    
        // Create & Add data to the model
        let body: [String: AnyHashable] = [
            "User_id": loginData.mainUserID,
            "comment": comment
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
                    
                    print("commented")
                } catch {
                    print("Error: Trying to convert JSON data to string")
                    return
                }
            }
        }
        task.resume()
    
    }
    
    
    // MARK: - patch service

    func replyCommentPost(loginData: LoginViewModel, postID: String, posterID: String, comment: String, parentCommentID: String) {
    
        //Updating the user Interest
        print("Like Post")
        print("using these info to update: ")
        print(postID)
    
        guard let url = URL(string: "http://64.227.150.47/main/commentReply/\(postID)") else {
            print("Error: cannot create URL")
            return
        }
    
        // Create & Add data to the model
        let body: [String: AnyHashable] = [
            "user_id": loginData.mainUserID,
            "User_id": posterID,
            "comment": comment,
            "parent_comment_id": parentCommentID
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
                    
                    print("comment replied")
                } catch {
                    print("Error: Trying to convert JSON data to string")
                    return
                }
            }
        }
        task.resume()
    
    }
    
    
    // MARK: - fetch service
    func getLikesPost(globalVM: GlobalViewModel, postID: String) async -> String {
        DispatchQueue.main.async {
            globalVM.likesList = LikesModel(post: Post0343(id: "", postID: "", userID: "", likes: [Like0343](), v: 0), likeCount: 0)
        }
            
        print("Starting to likes")
        
        guard let url = URL(string: "http://64.227.150.47/main/fetchLike/\(postID)") else {
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
            let decodedData = try decoder.decode(LikesModel.self, from: data)
            
            DispatchQueue.main.async {
                globalVM.likesList.post.likes = decodedData.post.likes
            }
            
            return "Success"
        } catch {
            print("Error: \(error.localizedDescription)")
            return "Failure: \(error.localizedDescription)"
        }
    }

    
    // MARK: - fetch service


    func getCommentPost(globalVM: GlobalViewModel, postID: String) {
    
        globalVM.commentList = CommentServiceModel(post: Post5355(id: "", userID: "", postID: "", comments: [Comment5355](), v: 0), commentCount: 0)
        
        //Updating the user Interest
        print("Starting to get comments")
        print(postID)
    
        guard let url = URL(string: "http://64.227.150.47/main/comment/\(postID)") else {
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
                    let decodedData = try decoder.decode(CommentServiceModel.self, from: data)
                    
                    globalVM.commentList = decodedData
                } catch {
                    print("Error: Trying to convert JSON data to string")
                    return
                }
            }
        }
        task.resume()
    }

}
