//
//  ExploreService.swift
//  R-own
//
//  Created by Aman Sharma on 29/05/23.
//

import Foundation
import SwiftUI
import Alamofire

class ExploreService: ObservableObject{
    
    
    // MARK: - fetch service
    func getExplorePosts(globalVM: GlobalViewModel, userID: String, pageNumber: String) async -> String {
        print("Starting to get explore posts")
        print(userID)
        print(pageNumber)
        
        guard let url = URL(string: "http://64.227.150.47/main/getExplorePosts/\(userID)?page=\(pageNumber)") else {
            print("Error: cannot create URL")
            return "Failure: Invalid URL"
        }
        
        // Create the request
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
            let decodedData = try decoder.decode([ExplorePostModel].self, from: data)
            
            
            DispatchQueue.main.async {
                for i in 0..<decodedData[0].posts.count {
                        globalVM.explorePostList[0].posts.append(decodedData[0].posts[i])
                }
            }
            
            return "Success"
        } catch {
            print("Error: \(error)")
            return "Failure: \(error.localizedDescription)"
        }
    }
    
    // MARK: - fetch service


    func getExploreJobs(globalVM: GlobalViewModel, userID: String, pageNumber: String) {
    
        //Updating the user Interest
        print("Starting to get explorejob ")
    
        guard let url = URL(string: "http://64.227.150.47/main/getAllJob?page=\(pageNumber)") else {
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
                    let decodedData = try decoder.decode([ExploreJobModel].self, from: data)
                    
                    
                    for i in 0..<decodedData[0].posts.count {
                        DispatchQueue.main.async {
                            globalVM.exploreJobList[0].posts.append(decodedData[0].posts[i])
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
    
    // MARK: - fetch service


    func getExplorePeople(globalVM: GlobalViewModel, userID: String, pageNumber: String) {
    
        //Updating the user Interest
        print("Starting to get people")
        print("http://64.227.150.47/main/getPeople/\(userID)?page=\(pageNumber)")
        guard let url = URL(string: "http://64.227.150.47/main/getPeople/\(userID)?page=\(pageNumber)") else {
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
                    let decodedData = try decoder.decode([ExplorePeopleModel].self, from: data)
                    
                    
                    for i in 0..<decodedData[0].posts.count {
                        DispatchQueue.main.async {
                            globalVM.explorePeopleList[0].posts.append(decodedData[0].posts[i])
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
    
    // MARK: - fetch service


    func getExploreEvent(globalVM: GlobalViewModel, userID: String, pageNumber: String) {
    
        //Updating the user Interest
        print("Starting to get explore events")
    
        guard let url = URL(string: "http://64.227.150.47/main/event/\(userID)?page=\(pageNumber)") else {
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
                    let decodedData = try decoder.decode([ExploreEventModel].self, from: data)
                    
                    
                    for i in 0..<decodedData[0].events.count {
                        DispatchQueue.main.async {
                            globalVM.exploreEventList[0].events.append(decodedData[0].events[i])
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
    
    // MARK: - fetch service


    func getExploreBlog(globalVM: GlobalViewModel, userID: String, pageNumber: String) {
    
        //Updating the user Interest
        print("Starting to get explore blogs")
    
        guard let url = URL(string: "http://64.227.150.47/main/getBlog/\(userID)?page=\(pageNumber)") else {
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
                    let decodedData = try decoder.decode([ExploreBlogModel].self, from: data)
                    
                    
                    for i in 0..<decodedData[0].blogs.count {
                        DispatchQueue.main.async {
                            globalVM.exploreBlogList[0].blogs.append(decodedData[0].blogs[i])
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
    
    // MARK: - fetch service


    func getExploreHotel(globalVM: GlobalViewModel, userID: String, pageNumber: String) {
    
        //Updating the user Interest
        print("Starting to get explore hotels")
    
        guard let url = URL(string: "http://64.227.150.47/main/getExploreHotel/\(userID)?page=\(pageNumber)") else {
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
                    let decodedData = try decoder.decode([ExploreHotelModel].self, from: data)
                    
                    for i in 0..<decodedData[0].posts.count {
                        DispatchQueue.main.async {
                            globalVM.exploreHotelList[0].posts.append(decodedData[0].posts[i])
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
    
    // MARK: - fetch service


    func getExploreServices(globalVM: GlobalViewModel, userID: String, pageNumber: String) {
    
        //Updating the user Interest
        print("Starting to get explore services")
    
        guard let url = URL(string: "http://64.227.150.47/main/getService?page=\(pageNumber)") else {
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
                    let decodedData = try decoder.decode([ExploreServicesModel].self, from: data)
                    
                    for i in 0..<decodedData[0].vendors.count {
                        DispatchQueue.main.async {
                            globalVM.exploreServiceList[0].vendors.append(decodedData[0].vendors[i])
                        }
                    }
    
                } catch let jsonError{
                    print("Error: Trying to convert JSON data to string: \(jsonError)")
                    return
                }
            }
        }
        task.resume()
    }

    
    
    // MARK: - fetch service


    func getExplorePostsBySearch(globalVM: GlobalViewModel, userID: String, keyword: String, pageNumber: String) {
        
        globalVM.toastSearchLoading = true
        globalVM.exploreSearchPostList = [ExplorePostModel(page: 0, pageSize: 0, posts: [ExplorePost]()) ]
        //Updating the user Interest
        print("Starting to get explore post by search")
        print(userID)
        print(keyword)
    
        guard let url = URL(string: "http://64.227.150.47/main/getAllPostByCaption/\(keyword)/\(userID)?page=\(pageNumber)") else {
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
                    let decodedData = try decoder.decode([ExplorePostModel].self, from: data)
                    
                    
                    for i in 0..<decodedData[0].posts.count {
                        DispatchQueue.main.async {
                            globalVM.exploreSearchPostList[0].posts.append(decodedData[0].posts[i])
                        }
                    }
                    globalVM.toastSearchLoading = true
                } catch {
                    print("Error: Trying to convert JSON data to string")
                    globalVM.toastSearchLoading = true
                    return
                }
            }
        }
        task.resume()
    }
    // MARK: - fetch service


    func getExplorePeopleBySearch(globalVM: GlobalViewModel, userID: String, keyword: String, pageNumber: String) {
        
        globalVM.exploreSearchPeopleList = [ExplorePeopleSearchModel(page: 0, pageSize: 0, posts: [Post344]())]
        //Updating the user Interest
        
        print("Starting to get explore people by search")
        print(userID)
        print(keyword)
    
        guard let url = URL(string: "http://64.227.150.47/main/searchPeople/\(keyword)/\(userID)?page=\(pageNumber)") else {
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
                    let decodedData = try decoder.decode([ExplorePeopleSearchModel].self, from: data)
                    
                    
                    for i in 0..<decodedData[0].posts.count {
                        DispatchQueue.main.async {
                            globalVM.exploreSearchPeopleList[0].posts.append(decodedData[0].posts[i])
                        }
                    }
                    globalVM.toastSearchLoading.toggle()
                } catch {
                    print("Error: Trying to convert JSON data to string")
                    return
                }
            }
        }
        task.resume()
    }
    
    // MARK: - fetch service


    func getExploreBlogsBySearch(globalVM: GlobalViewModel, userID: String, pageNumber: String, keyword: String) {
        
        globalVM.exploreSearchBlogList = [ExploreBlogSearchModel(page: 0, pageSize: 0, blogs: [ExploreBlogSearch]())]
        //Updating the user Interest
        
        print("Starting to get blogs by search")
        print(userID)
        print(keyword)
    
        guard let url = URL(string: "http://64.227.150.47/main/searchBlog/\(keyword)/\(userID)?page=\(pageNumber)") else {
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
                    let decodedData = try decoder.decode([ExploreBlogSearchModel].self, from: data)
                    
                    
                    for i in 0..<decodedData[0].blogs.count {
                        DispatchQueue.main.async {
                            globalVM.exploreSearchBlogList[0].blogs.append(decodedData[0].blogs[i])
                        }
                    }
                    
                    globalVM.toastSearchLoading.toggle()
                } catch {
                    print("Error: Trying to convert JSON data to string")
                    return
                }
            }
        }
        task.resume()
    }
    
    // MARK: - fetch service


    func getExploreSearchHotel(globalVM: GlobalViewModel, userID: String, pageNumber: String, keyword: String) {
    
        //Updating the user Interest
        print("Starting to get explore hotel by search")
    
        guard let url = URL(string: "http://64.227.150.47/main/searchHotel/\(keyword)/\(userID)?page=\(pageNumber)") else {
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
                    let decodedData = try decoder.decode([ExploreHotelModel].self, from: data)
                    
                    for i in 0..<decodedData[0].posts.count {
                        DispatchQueue.main.async {
                            globalVM.exploreSearchHotelList[0].posts.append(decodedData[0].posts[i])
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
    
    // MARK: - fetch service


    func getExploreSearchServices(globalVM: GlobalViewModel, userID: String, pageNumber: String, keyword: String) {
    
        //Updating the user Interest
        print("Starting to get services")
    
        guard let url = URL(string: "http://64.227.150.47/main/getSearchServices/\(keyword)?page=\(pageNumber)") else {
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
                    let decodedData = try decoder.decode([ExploreServiceSearchModel].self, from: data)
                    
                    for i in 0..<decodedData[0].posts.count {
                        DispatchQueue.main.async {
                            globalVM.exploreSearchServiceList[0].posts.append(decodedData[0].posts[i])
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

}
