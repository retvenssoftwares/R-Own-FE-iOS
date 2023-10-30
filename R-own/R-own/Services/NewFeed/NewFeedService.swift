//
//  NewFeedService.swift
//  R-own
//
//  Created by Aman Sharma on 28/07/23.
//

import SwiftUI
import Alamofire

class NewFeedServices: ObservableObject{
    
    
    
    // MARK: - fetch service
    func getNewFeed(globalVM: GlobalViewModel, userID: String) async -> String {
        print("Starting to get new feed")
        
        guard let url = URL(string: "http://64.227.150.47/main/getFeed/\(userID)") else {
            print("Error: cannot create URL")
            return "Failure: Invalid URL"
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            let (data, response) = try await URLSession.shared.data(for: urlRequest)
            let httpResponse = response as? HTTPURLResponse
            
            if let statusCode = httpResponse?.statusCode {
                switch statusCode {
                case 200 ..< 300:
                    let decoder = JSONDecoder()
                    let decodedData = try decoder.decode([NewFeedModel].self, from: data)
                    
                    
                    DispatchQueue.main.async {
                        if decodedData.count > 0 {
                            for posts in decodedData[0].posts {
                                globalVM.newFeedList[0].posts.append(posts)
                            }
                            if decodedData[0].blogs.count > 0 {
                                for posts in decodedData[0].blogs {
                                    globalVM.newFeedList[0].blogs = [NewFeedBlog]()
                                    globalVM.newFeedblog = globalVM.newFeedList[0].blogs.count
                                    globalVM.newFeedList[0].blogs.append(posts)
                                }
                            }
                            if decodedData[0].communities.count > 0 {
                                for posts in decodedData[0].communities {
                                    globalVM.newFeedList[0].communities = [NewFeedCommunity]()
                                    globalVM.newFeedcommunities = globalVM.newFeedList[0].communities.count
                                    globalVM.newFeedList[0].communities.append(posts)
                                }
                            }
                            if decodedData[0].hotels.count > 0 {
                                for posts in decodedData[0].hotels {
                                    globalVM.newFeedList[0].hotels = [NewFeedHotel]()
                                    globalVM.newFeedhotel = globalVM.newFeedList[0].hotels.count
                                    globalVM.newFeedList[0].hotels.append(posts)
                                }
                            }
                            if decodedData[0].services.count > 0 {
                                for posts in decodedData[0].services {
                                    globalVM.newFeedList[0].services = [NewFeedService]()
                                    globalVM.newFeedservices = globalVM.newFeedList[0].services.count
                                    globalVM.newFeedList[0].services.append(posts)
                                }
                            }
                        }
                    }
                    
                    return "Success"
                case 429:
                    print("Error: Too Many Requests (429)")
                    return "Try again"
                case 502:
                    print("Error: Bad Gateway (502)")
                    return "Server Error"
                default:
                    print("Error: HTTP request failed with status code \(statusCode)")
                    return "Failure: HTTP request failed"
                }
            } else {
                print("Error: HTTP response is nil")
                return "Failure: HTTP response is nil"
            }
        } catch {
            print("Error: \(error)")
            return "Failure: \(error.localizedDescription)"
        }
    }




    
    
}

//struct NewFeedService_Previews: PreviewProvider {
//    static var previews: some View {
//        NewFeedService()
//    }
//}
