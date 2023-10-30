//
//  FAQService.swift
//  R-own
//
//  Created by Aman Sharma on 07/08/23.
//

import SwiftUI


class FAQService: ObservableObject{
    
    // MARK: - fetch service

    func getFAQList(globalVM: GlobalViewModel) async -> String {
        print("Starting to get FAQs")

        guard let url = URL(string: "http://64.227.150.47/main/getFaq") else {
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
            let decodedData = try decoder.decode([FAQModel].self, from: data)
            
            DispatchQueue.main.async {
                globalVM.faqList = decodedData
            }

            return "Success"
        } catch {
            print("Error: \(error)")
            return "Failure"
        }
    }

}
