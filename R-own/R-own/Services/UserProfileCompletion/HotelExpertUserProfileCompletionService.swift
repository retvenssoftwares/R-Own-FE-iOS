//
//  HotelExpertUserProfileCompletionService.swift
//  R-own
//
//  Created by Aman Sharma on 25/05/23.
//

import Foundation


class HotelExpertUserProfileCompletionService: ObservableObject{
    
    //this function helps to connect to server and help us verfying the username
    func updateHotelExpertUserInfo(loginData: LoginViewModel, mainUserID: String, mainUserJobTitle: String, mainUserEmploymentType: String, mainUserCompany: String, mainUserJobStart: String, mainUserJobEnd: String) async -> String {
        print("Starting to update hospitlaity user data")

        guard let url = URL(string: "http://64.227.150.47/main/update/\(mainUserID)") else {
            print("Error: cannot create URL")
            return "Failure: Invalid URL"
        }

        let hotelExpertInformation: [String: AnyHashable] = [
            "jobTitle": mainUserJobTitle,
            "jobType": mainUserEmploymentType,
            "jobCompany": mainUserCompany,
            "jobStartYear": mainUserJobStart,
            "jobEndYear": mainUserJobEnd
        ]

        let body: [String: AnyHashable] = [
            "hospitalityExpertInfo": hotelExpertInformation
        ]
        

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "PATCH"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")

        // Convert request to JSON data
        do {
            urlRequest.httpBody = try JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)
        } catch {
            print("Error: \(error)")
            return "Failure: \(error.localizedDescription)"
        }

        do {
            let (data, response) = try await URLSession.shared.data(for: urlRequest)
            guard let httpResponse = response as? HTTPURLResponse, (200 ..< 299) ~= httpResponse.statusCode else {
                print("Error: HTTP request failed")
                return "Failure: HTTP request failed"
            }

            let decoder = JSONDecoder()
            let decodedData = try decoder.decode(NormalMessageResponse.self, from: data)
            
            return "Success"
        } catch {
            print("Error: \(error)")
            return "Failure: \(error.localizedDescription)"
        }
    }

}
