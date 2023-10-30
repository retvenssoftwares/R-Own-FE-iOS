//
//  DeleteAccountService.swift
//  R-own
//
//  Created by Aman Sharma on 24/07/23.
//

import SwiftUI

class DeleteAccountService: ObservableObject{
    
    
    // MARK: - patch service
    func deleteAccount(userID: String) async -> String {
        print("deleting account.. ")
        
        guard let url = URL(string: "http://64.227.150.47/main/deleteAcc") else {
            print("Error: cannot create URL")
            return "Failure: Invalid URL"
        }
        
        // Create & Add data to the model
        let body: [String: AnyHashable] = [
            "User_id": userID
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
                return "Failure: HTTP request failed"
            }
            
            let decoder = JSONDecoder()
            let decodedData = try decoder.decode(NormalMessageResponse.self, from: data)
            
            print("user data updated on server")
            
            return "Success"
        } catch {
            print("Error: \(error.localizedDescription)")
            return "Failure: \(error.localizedDescription)"
        }
    }

    
    
}

//struct DeleteAccountService_Previews: PreviewProvider {
//    static var previews: some View {
//        DeleteAccountService()
//    }
//}
