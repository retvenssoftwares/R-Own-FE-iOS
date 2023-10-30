//
//  BlogsService.swift
//  R-own
//
//  Created by Aman Sharma on 28/05/23.
//

import Foundation
import SwiftUI
import Alamofire

class BlogsService: ObservableObject{
    
    
//MARK: - fetch service

    func getBlogs(globalVM: GlobalViewModel, loginData: LoginViewModel, userID: String) {
    
        //Updating the user Interest
        print("Starting to get events")
    
        guard let url = URL(string: "http://64.227.150.47/main/getBlog/\(userID)") else {
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
                    let decodedData = try decoder.decode(BlogsModel.self, from: data)
                    
                    globalVM.blogsList = decodedData
    
                } catch {
                    print("Error: Trying to convert JSON data to string")
                    return
                }
            }
        }
        task.resume()
    }
    
//MARK: - fetch service

    func getBlogsCategory(globalVM: GlobalViewModel, loginData: LoginViewModel, userID: String) {
    
        globalVM.blogsCategory = [BlogsCategoryModel]()
        //Updating the user Interest
        print("Starting to get events")
    
        guard let url = URL(string: "http://64.227.150.47/main/getCategory") else {
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
                    let decodedData = try decoder.decode([BlogsCategoryModel].self, from: data)
                    
                    globalVM.blogsCategory = decodedData
    
                } catch {
                    print("Error: Trying to convert JSON data to string")
                    return
                }
            }
        }
        task.resume()
    }
    
//MARK: - fetch service

    func getBlogsByCategory(globalVM: GlobalViewModel, loginData: LoginViewModel, userID: String, categoryID: String) {
    
        globalVM.blogsListByCategory = [BlogListModel]()
        
        //Updating the user Interest
        print("Starting to get events")
    
        guard let url = URL(string: "http://64.227.150.47/main/getBlogCategory/\(userID)/\(categoryID)") else {
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
                    let decodedData = try decoder.decode([BlogListModel].self, from: data)
                    
                    globalVM.blogsListByCategory = decodedData
    
                } catch {
                    print("Error: Trying to convert JSON data to string")
                    return
                }
            }
        }
        task.resume()
    }
    
    
    // MARK: - patch service

    func likeBlogs(loginData: LoginViewModel, blogID: String) {
    
        //Updating the user Interest
        print("Starting to update user profile without image")
        print("using these info to update: ")
        print(loginData.mainUserFullName)
        print(loginData.mainUserEmail)
        print(loginData.mainUserProfilePic)
    
        guard let url = URL(string: "http://64.227.150.47/main/likeBlog/\(blogID)") else {
            print("Error: cannot create URL")
            return
        }
    
        // Create & Add data to the model
        let body: [String: AnyHashable] = [
            "user_id": loginData.mainUserID,
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
                    
                    print("like updated on server")
                } catch {
                    print("Error: Trying to convert JSON data to string")
                    return
                }
            }
        }
        task.resume()
    
    }
    
    
    // MARK: - patch service

    func commentBlogs(loginData: LoginViewModel, blogID: String, comment: String) {
    
        //Updating the user Interest
        print("Starting to comment on  blog \(blogID)")
    
        guard let url = URL(string: "http://64.227.150.47/main/comment/\(blogID)") else {
            print("Error: cannot create URL")
            return
        }
    
        // Create & Add data to the model
        let body: [String: AnyHashable] = [
            "user_id": loginData.mainUserID,
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
                    
                    print("commented updated on server")
                } catch {
                    print("Error: Trying to convert JSON data to string")
                    return
                }
            }
        }
        task.resume()
    
    }
    
    
    // MARK: - patch service

    func replycommentBlogs(loginData: LoginViewModel, blogID: String, comment: String, commentID: String) {
    
        //Updating the user Interest
        print("Starting to reply a comment of id \(commentID)")
    
        guard let url = URL(string: "http://64.227.150.47/main/replyComment/\(blogID)") else {
            print("Error: cannot create URL")
            return
        }
    
        // Create & Add data to the model
        let body: [String: AnyHashable] = [
            "user_id": loginData.mainUserID,
            "comment": comment,
            "parent_comment_id": commentID
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
                    
                    print("commented updated on server")
                } catch {
                    print("Error: Trying to convert JSON data to string")
                    return
                }
            }
        }
        task.resume()
    
    }
    
//MARK: - fetch service

    func getBlogsByBlogID(globalVM: GlobalViewModel, loginData: LoginViewModel, blogID: String) async -> String {
        
        DispatchQueue.main.async {
            globalVM.blogByBlogID = [BlogByBlogIDModel]()
        }
        let userID = await loginData.mainUserID
        
        
        guard let url = URL(string: "http://64.227.150.47/main/getBlog/\(blogID)/\(userID)") else {
            print("Error: cannot create URL")
            return "Failure: Invalid URL"
        }
        
        // Create the request
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            
            guard let httpResponse = response as? HTTPURLResponse, (200 ..< 299) ~= httpResponse.statusCode else {
                print("Error: HTTP request failed")
                return "Failure: HTTP request failed"
            }
            
            let decoder = JSONDecoder()
            do {
                let decodedData = try decoder.decode([BlogByBlogIDModel].self, from: data)
                
                DispatchQueue.main.async {
                    globalVM.blogByBlogID = decodedData
                }
                return "Success"
            } catch {
                print("Error: Trying to convert JSON data to string")
                return "Failure: Error decoding JSON data"
            }
        } catch {
            print("Error: error calling GET")
            return "Failure: \(error.localizedDescription)"
        }
    }

    
    
//MARK: - fetch service

    func getBlogsList(globalVM: GlobalViewModel, loginData: LoginViewModel) {
    
        globalVM.blogList = [BlogListModel]()
        //Updating the user Interest
        print("Starting to get events")
    
        guard let url = URL(string: "http://64.227.150.47/main/getBlogPost/\(loginData.mainUserID)") else {
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
                    let decodedData = try decoder.decode([BlogListModel].self, from: data)
                    
                    globalVM.blogList = decodedData
    
                } catch {
                    print("Error: Trying to convert JSON data to string")
                    return
                }
            }
        }
        task.resume()
    }
    
    
    
}
