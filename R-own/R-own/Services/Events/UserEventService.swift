//
//  UserEventService.swift
//  R-own
//
//  Created by Aman Sharma on 28/05/23.
//

import Foundation
import SwiftUI
import Alamofire

class UserEventService: ObservableObject{
    
    
//MARK: - fetch service


    func getNearestConcertsList(globalVM: GlobalViewModel, loginData: LoginViewModel, userID: String) {
    
        globalVM.nearestConcertList = [NearestConcertModel]()
        //Updating the user Interest
        print("Starting to get events")
    
        guard let url = URL(string: "http://64.227.150.47/main/allEvent/\(userID)") else {
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
                    let decodedData = try decoder.decode([NearestConcertModel].self, from: data)
                    
                    globalVM.nearestConcertList = decodedData
    
                } catch {
                    print("Error: Trying to convert JSON data to string")
                    return
                }
            }
        }
        task.resume()
    }
    
//MARK: - fetch service


    func getEventCategory(globalVM: GlobalViewModel, loginData: LoginViewModel, userID: String) {
    
        globalVM.eventCategoryList = [EventCategoryModel]()
        //Updating the user Interest
        print("Starting to get event categories")
    
        guard let url = URL(string: "http://64.227.150.47/main/getEventCategory") else {
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
                    let decodedData = try decoder.decode([EventCategoryModel].self, from: data)
                    
                    globalVM.eventCategoryList = decodedData
    
                } catch {
                    print("Error: Trying to convert JSON data to string")
                    return
                }
            }
        }
        task.resume()
    }
    
    
//MARK: - fetch service


    func getOngoingEvent(globalVM: GlobalViewModel, loginData: LoginViewModel, userID: String) {
    
        globalVM.ongoingEventList = [OngoingEventModel]()
        //Updating the user Interest
        print("Starting to get ongoing event")
    
        guard let url = URL(string: "http://64.227.150.47/main/ongoingEvent") else {
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
                    let decodedData = try decoder.decode([OngoingEventModel].self, from: data)
                    
                    globalVM.ongoingEventList = decodedData
    
                } catch {
                    print("Error: Trying to convert JSON data to string")
                    return
                }
            }
        }
        task.resume()
    }
    
    
//MARK: - post evennt service
    
    func postEvent(loginData: LoginViewModel, eventVM: EventViewModel, eventBG: UIImage?) {
        
        let formatter1 = DateFormatter()
        formatter1.dateStyle = .short
            let formatter2 = DateFormatter()
            formatter2.timeStyle = .medium
        //Set Your URL
            let api_url = "http://64.227.150.47/main/postEvent"
            guard let url = URL(string: api_url) else {
                return
            }
    
            var urlRequest = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 10.0 * 1000)
            urlRequest.httpMethod = "POST"
            urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
    
            //Set Image Data
            let uiImage: UIImage = eventBG!
            let imgData = uiImage.jpegData(compressionQuality: 0.5)!
        
           // Now Execute
            AF.upload(multipartFormData: { multiPart in
                
                multiPart.append((eventVM.eventCategoryID).data(using: String.Encoding.utf8)!, withName: "category_id")
                multiPart.append((loginData.mainUserID).data(using: String.Encoding.utf8)!, withName: "User_id")
                multiPart.append((eventVM.eventLocationLocation).data(using: String.Encoding.utf8)!, withName: "location")
                multiPart.append((eventVM.selectedVenueID).data(using: String.Encoding.utf8)!, withName: "venue")
                multiPart.append(("").data(using: String.Encoding.utf8)!, withName: "country")
                multiPart.append(("").data(using: String.Encoding.utf8)!, withName: "state")
                multiPart.append(("").data(using: String.Encoding.utf8)!, withName: "city")
                multiPart.append((eventVM.eventTitle).data(using: String.Encoding.utf8)!, withName: "event_title")
                multiPart.append((eventVM.eventDescription).data(using: String.Encoding.utf8)!, withName: "event_description")
                multiPart.append((eventVM.eventCategory).data(using: String.Encoding.utf8)!, withName: "event_category")
                multiPart.append((eventVM.eventSupportEmail).data(using: String.Encoding.utf8)!, withName: "email")
                multiPart.append((eventVM.eventPhoneNumber).data(using: String.Encoding.utf8)!, withName: "phone")
                multiPart.append((eventVM.eventWebsite).data(using: String.Encoding.utf8)!, withName: "website_link")
                multiPart.append((eventVM.eventBookingLink).data(using: String.Encoding.utf8)!, withName: "booking_link")
                multiPart.append((eventVM.eventPrice).data(using: String.Encoding.utf8)!, withName: "price")
                multiPart.append((formatter1.string(from: eventVM.eventStartDate) ).data(using: String.Encoding.utf8)!, withName: "event_start_date")
                multiPart.append((formatter2.string(from: eventVM.eventStartTime) ).data(using: String.Encoding.utf8)!, withName: "event_start_time")
                multiPart.append((formatter1.string(from: eventVM.eventEndDate)).data(using: String.Encoding.utf8)!, withName: "event_end_date")
                multiPart.append((formatter2.string(from: eventVM.eventEndTime)).data(using: String.Encoding.utf8)!, withName: "event_end_time")
                multiPart.append((formatter1.string(from: eventVM.eventRegistrationStartDate)).data(using: String.Encoding.utf8)!, withName: "registration_start_date")
                multiPart.append((formatter2.string(from: eventVM.eventRegistrationStartTime)).data(using: String.Encoding.utf8)!, withName: "registration_start_time")
                multiPart.append((formatter1.string(from: eventVM.eventRegistrationEndDate)).data(using: String.Encoding.utf8)!, withName: "registration_end_date")
                multiPart.append((formatter2.string(from: eventVM.eventRegistrationEndTime)).data(using: String.Encoding.utf8)!, withName: "registration_end_time")
                multiPart.append(imgData, withName: "event_thumbnail", fileName: loginData.mainUserUserName+randomString(length: 6)+"eventThumbnail.png", mimeType: "image/png")
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
    
    
//MARK: - fetch service


    func getEventInfoByUserID(globalVM: GlobalViewModel, loginData: LoginViewModel, userID: String) {
    
        globalVM.eventInfo = [EventsByUserIDModel]()
        //Updating the user Interest
        print("Starting to get ongoing event")
    
        guard let url = URL(string: "http://64.227.150.47/main/getEvent/\(userID)") else {
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
                    let decodedData = try decoder.decode([EventsByUserIDModel].self, from: data)
                    
                    globalVM.eventInfo = decodedData
    
                } catch {
                    print("Error: Trying to convert JSON data to string")
                    return
                }
            }
        }
        task.resume()
    }
    
    
//MARK: - fetch service


    func getEventByCategory(globalVM: GlobalViewModel, loginData: LoginViewModel, categoryID: String) {
    
        //Updating the user Interest
        print("Starting to get events by category")
    
        guard let url = URL(string: "http://64.227.150.47/main/getEventCategory/\(loginData.mainUserID)/\(categoryID)") else {
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
                    let decodedData = try decoder.decode([NearestConcertModel].self, from: data)
                    
                    globalVM.eventsByCategory = decodedData
    
                } catch {
                    print("Error: Trying to convert JSON data to string")
                    return
                }
            }
        }
        task.resume()
    }
    
    
//MARK: - fetch service


    func getEventInfoByEventID(globalVM: GlobalViewModel, loginData: LoginViewModel, eventID: String) {
    
        globalVM.eventDetailsByEventID = [EventDetailsByEventIDModel]()
        //Updating the user Interest
        print("Starting to get events by category")
    
        guard let url = URL(string: "http://64.227.150.47/main/fetchEvent/\(eventID)") else {
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
                    let decodedData = try decoder.decode([EventDetailsByEventIDModel].self, from: data)
                    
                    globalVM.eventDetailsByEventID = decodedData
    
                } catch {
                    print("Error: Trying to convert JSON data to string")
                    return
                }
            }
        }
        task.resume()
    }
    
//MARK: - fetch service


    func getEventInfoByEventIDForEdit(globalVM: GlobalViewModel, loginData: LoginViewModel, eventID: String) {
    
        globalVM.eventDetailsByEventIDForEdit = [EventDetailsByEventIDModel(id: "", categoryID: "", profilePic: "", userName: "", categoryName: "", userID: "", location: "", venue: "", country: "", state: "", city: "", eventTitle: "", eventDescription: "", eventCategory: "", email: "", phone: "", websiteLink: "", bookingLink: "", price: "", eventThumbnail: "", eventStartDate: "", eventStartTime: "", eventEndDate: "", eventEndTime: "", registrationStartDate: "", registrationStartTime: "", registrationEndDate: "", registrationEndTime: "", eventID: "", dateAdded: "", v: 0)]
        //Updating the user Interest
        print("Starting to get events by category")
    
        guard let url = URL(string: "http://64.227.150.47/main/fetchEvent/\(eventID)") else {
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
                    let decodedData = try decoder.decode([EventDetailsByEventIDModel].self, from: data)
                    
                    globalVM.eventDetailsByEventIDForEdit = decodedData
    
                } catch {
                    print("Error: Trying to convert JSON data to string")
                    return
                }
            }
        }
        task.resume()
    }
    
    
    
}
