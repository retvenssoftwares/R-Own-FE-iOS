//
//  UserProfileCompletionService.swift
//  R-own
//
//  Created by Aman Sharma on 24/05/23.
//

import Foundation


class UserProfileCompletionService: ObservableObject{
    
    //this function helps to connect to server and help us verfying the username\
    func verifyUsername(loginData: LoginViewModel, userName: String) async -> String {
        print("Starting to check username")
        print("using these info to update: ")
        await print(loginData.mainUserUserName)

        guard let url = URL(string: "http://64.227.150.47/main/update/\(await loginData.mainUserID)") else {
            print("Error: cannot create URL")
            return "Failure: Invalid URL"
        }

        // Create & Add data to the model
        let body: [String: AnyHashable] = [
            "User_name": userName
        ]
        

        // Create the request
        var request = URLRequest(url: url)
        request.httpMethod = "PATCH"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        // Convert request to JSON data
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)
        } catch {
            print("Error: Failed to serialize JSON data")
            return "Failure: Failed to serialize JSON data"
        }

        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            guard let httpResponse = response as? HTTPURLResponse, (200 ..< 299) ~= httpResponse.statusCode else {
                print("Error: HTTP request failed")
                DispatchQueue.main.async {
                    loginData.usernameStatus = "Unavailable"
                }
                return "Failure: HTTP request failed"
            }

            let decoder = JSONDecoder()
            do {
                let decodedData = try decoder.decode(NormalMessageResponse.self, from: data)
                
                DispatchQueue.main.async {
                    loginData.usernameStatus = "Available"
                }
                return "Success"
            } catch {
                print("Error: Trying to convert JSON data to string")
                return "Failure: \(error.localizedDescription)"
            }
        } catch {
            print("Error: \(error)")
            return "Failure: \(error.localizedDescription)"
        }
    }

    
    //this function helps us to update the basic information about the user i.e. fullname and dob
    func postBasicProfileInfo(loginData: LoginViewModel) {
    
        //Updating the user Interest
        print("Starting to check username")
        print("using these info to update: ")
    
        guard let url = URL(string: "http://64.227.150.47/main/update/\(loginData.mainUserID)") else {
            print("Error: cannot create URL")
            return
        }
    
        // Create & Add data to the model
        let body: [String: AnyHashable] = [
            "Full_name": loginData.mainUserFullName,
            "DOB": stringFromDate(loginData.userDOB),
            "profileCompletionStatus": loginData.profileCompletionPercentage
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
                    
                    loginData.basicProfileInfoCompleted = true
                } catch {
                    print("Error: Trying to convert JSON data to string")
                    return
                }
            }
        }
        task.resume()
    
    }
    func stringFromDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM yyyy HH:mm" //yyyy
        return formatter.string(from: date)
    }
    
    //this function helps us to update the location of a user to the server
    func postUserLocationInfo(loginData: LoginViewModel) {
    
        //Updating the user Interest
        print("Starting to check username")
        print("using these info to update: ")
        print(loginData.mainUserLocationCountry)
        print(loginData.mainUserLocationState)
        print(loginData.mainUserLocationCity)
        
        if loginData.mainUserLocationCity != "" {
            let manualLocation = loginData.mainUserLocationCity + ", " + loginData.mainUserLocationState + ", " + loginData.mainUserLocationCountry
            loginData.mainUserLocation = manualLocation
        }
    
        guard let url = URL(string: "http://64.227.150.47/main/update/\(loginData.mainUserID)") else {
            print("Error: cannot create URL")
            return
        }
        
        
        // Create & Add data to the model
        let body: [String: AnyHashable] = [
            "location": loginData.mainUserLocation,
            "profileCompletionStatus": loginData.profileCompletionPercentage
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
                    
                    loginData.profileLocationInfoCompleted = true
                } catch {
                    print("Error: Trying to convert JSON data to string")
                    return
                }
            }
        }
        task.resume()
    
    }
    
    func getDesignationList(globalVM: GlobalViewModel) async -> String {
        DispatchQueue.main.async {
            globalVM.designationList = [Designation]()
        }
        
        print("Starting to get job titles")
        guard let url = URL(string: "http://64.227.150.47/main/getdesignation") else {
            print("Error: cannot create URL")
            return "Failure: Invalid URL"
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            let (data, response) = try await URLSession.shared.data(for: urlRequest)
            guard let httpResponse = response as? HTTPURLResponse, (200 ..< 299) ~= httpResponse.statusCode else {
                print("Error: HTTP request failed")
                return "Failure: HTTP request failed"
            }
            
            let decoder = JSONDecoder()
            let decodedData = try decoder.decode([Designation].self, from: data)
            
            DispatchQueue.main.async {
                globalVM.designationList = decodedData
            }
            return "Success"
        } catch {
            print("Error: \(error)")
            return "Failure: \(error.localizedDescription)"
        }
    }

    func getCompanyList(globalVM: GlobalViewModel) async -> String {
        DispatchQueue.main.async {
            globalVM.companyList = [Company]()
        }
        print("Starting to get company list")
        
        guard let url = URL(string: "http://64.227.150.47/main/getCompany") else {
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
            let decodedData = try decoder.decode([Company].self, from: data)
            
            DispatchQueue.main.async {
                globalVM.companyList = decodedData
            }
            
            return "Success"
        } catch {
            print("Error: \(error)")
            return "Failure: \(error.localizedDescription)"
        }
    }

    
    func getHotelNameList(globalVM: GlobalViewModel) async -> String {
        DispatchQueue.main.async {
            globalVM.hotelNameList = [HotelNameModel]()
        }
        
        print("Starting to get hotel names")
        guard let url = URL(string: "http://64.227.150.47/main/getCompany") else {
            print("Error: cannot create URL")
            return "Failure: Invalid URL"
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            let (data, response) = try await URLSession.shared.data(for: urlRequest)
            guard let httpResponse = response as? HTTPURLResponse, (200 ..< 299) ~= httpResponse.statusCode else {
                print("Error: HTTP request failed")
                return "Failure: HTTP request failed"
            }
            
            let decoder = JSONDecoder()
            let decodedData = try decoder.decode([HotelNameModel].self, from: data)
            
            DispatchQueue.main.async {
                globalVM.hotelNameList = decodedData
            }
            return "Success"
        } catch {
            print("Error: \(error)")
            return "Failure: \(error.localizedDescription)"
        }
    }


    
    
    //this function helps us to update the basic information about the user i.e. fullname and dob
    func updateUserRoleInfo(loginData: LoginViewModel, mainUserID: String, mainUserCollege: String, mainUserSessionStart: String, mainUserSessionEnd: String, mainUserJobTitle: String, mainUserRole: String, profileCompletionPercentage: String) async -> String {
        print("Starting to check update user role and other info")
        
        
        
        
        guard let url = URL(string: "http://64.227.150.47/main/update/\(mainUserID)") else {
            print("Error: cannot create URL")
            return "Failure: Invalid URL"
        }

        let schoolEducation: [String: AnyHashable] = [
            "educationPlace": mainUserCollege,
            "education_session_start": mainUserSessionStart,
            "education_session_end": mainUserSessionEnd
        ]

        let normalUserinformation: [String: AnyHashable] = [
            "jobTitle": mainUserJobTitle
        ]

        // Create & Add data to the model
        let body: [String: AnyHashable] = [
            "Role": mainUserRole,
            "profileCompletionStatus": profileCompletionPercentage,
            "studentEducation": schoolEducation,
            "normalUserInfo": normalUserinformation
        ]
        

        // Create the request
        var request = URLRequest(url: url)
        request.httpMethod = "PATCH"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        // Convert request to JSON data
        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)

        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            guard let httpResponse = response as? HTTPURLResponse, (200 ..< 299) ~= httpResponse.statusCode else {
                print("Error: HTTP request failed")
                return "Failure: HTTP request failed"
            }

            let decoder = JSONDecoder()
            let decodedData = try decoder.decode(NormalMessageResponse.self, from: data)
            
            DispatchQueue.main.async {
                loginData.basicProfileInfoCompleted = true
            }
            return "Success"
        } catch {
            print("Error: \(error)")
            return "Failure: \(error.localizedDescription)"
        }
    }

    
    //this function helps us to update the basic information about the user i.e. fullname and dob
    func updateUserProfileCompletionStatus(loginData: LoginViewModel) {
    
        //Updating the user Interest
        print("Starting to update profile completion status")
        
    
        guard let url = URL(string: "http://64.227.150.47/main/update/\(loginData.mainUserID)") else {
            print("Error: cannot create URL")
            return
        }
    
        // Create & Add data to the model
        let body: [String: AnyHashable] = [
            "profileCompletionStatus": "100"
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
                    
                    loginData.profileCompleted = true
                } catch {
                    print("Error: Trying to convert JSON data to string")
                    return
                }
            }
        }
        task.resume()
    
    }
}
