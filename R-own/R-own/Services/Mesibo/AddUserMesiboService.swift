//
//  AddUserMesiboService.swift
//  R-own
//
//  Created by Aman Sharma on 10/04/23.
//

import Foundation
import SwiftUI

class AddUserMesiboService: ObservableObject{

    func addUserToMesibo(loginData: LoginViewModel) async -> String {
        print("Creating Messibo user via this number:")

        guard let url = URL(string: "http://64.227.150.47/main/userCreate") else {
            print("Unable to rectify string in URL for API call")
            return "Failure: Invalid URL"
        }

        print("Making API Call for adding user to Mesibo...........")

        var request = URLRequest(url: url)

        // method, body, headers
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let body: [String: AnyHashable] = await [
            "Address": loginData.mainUserPhoneNumber
        ]

        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)

        // Make the request
        do {
            let (data, _) = try await URLSession.shared.data(for: request, delegate: nil)
            let decoder = JSONDecoder()
            let decodedData = try decoder.decode(AddUserResponse.self, from: data)
            DispatchQueue.main.async {
                loginData.mainUserMesiboToken = decodedData.token
                loginData.mainUserMesiboUID = decodedData.uid
                
                print("Mesibo add user succeeded")
                print(loginData.mainUserMesiboToken)
            }
            return "Success"
        } catch {
            print("API call failed with error: \(error)")
            return "Failure: \(error.localizedDescription)"
        }
    }


}
