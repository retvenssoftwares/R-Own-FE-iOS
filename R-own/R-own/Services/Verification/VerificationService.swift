//
//  VerificationService.swift
//  R-own
//
//  Created by Aman Sharma on 25/07/23.
//

import SwiftUI
import Alamofire

class VerificationService: ObservableObject{
    
    
    // MARK: - fetch service


    func checkVerificationStatus(globalVM: GlobalViewModel, userID: String) {
    
        //Updating the user Interest
        print("Starting to check verification status")
    
        guard let url = URL(string: "http://64.227.150.47/main/checkVerification/\(userID)") else {
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
                    let decodedData = try decoder.decode(NormalMessageResponse.self, from: data)
                    
                    globalVM.verificationStatusResponse = decodedData.message
    
                } catch {
                    print("Error: Trying to convert JSON data to string")
                    return
                }
            }
        }
        task.resume()
    }
    
    
    // MARK: - multipart service
    
    func uplaodVerificationDocuments(userID: String, location: String, documentType: String, userName: String, fullName: String, document: UIImage?) async -> String {
        //Set Your URL
        let api_url = "http://64.227.150.47/main/document"
        guard let url = URL(string: api_url) else {
            return "API Error"
        }

        var urlRequest = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 10.0 * 1000)
        urlRequest.httpMethod = "POST"
        urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")

        //Set Image Data
        guard let uiImage = document,
              let imgData = uiImage.jpegData(compressionQuality: 0.3) else {
            return "Invalid Image"
        }

        do {
            let response = try await withUnsafeThrowingContinuation { continuation in
                AF.upload(multipartFormData: { multiPart in
                    multiPart.append((userID).data(using: String.Encoding.utf8)!, withName: "user_id")
                    multiPart.append((location).data(using: String.Encoding.utf8)!, withName: "CountryorRegion")
                    multiPart.append((documentType).data(using: String.Encoding.utf8)!, withName: "Category")
                    multiPart.append((userName).data(using: String.Encoding.utf8)!, withName: "User_name")
                    multiPart.append((fullName).data(using: String.Encoding.utf8)!, withName: "Full_name")
                    multiPart.append(imgData, withName: "Documents", fileName: randomString(length: 7) + "verificationDocument.png", mimeType: "image/png")
                }, with: urlRequest)
                .uploadProgress(queue: .main, closure: { progress in
                    //Current upload progress of file
                    print("Upload Progress: \(progress.fractionCompleted)")
                })
                .responseJSON { data in
                    switch data.result {
                    case .success(_):
                        do {
                            let dictionary = try JSONSerialization.jsonObject(with: data.data!, options: .fragmentsAllowed) as! NSDictionary
                            print("Success!")
                            print(dictionary)
                            continuation.resume(returning: "Success")
                        } catch {
                            // catch error.
                            print("catch error")
                            continuation.resume(returning: "Failure")
                        }
                    case .failure(let error):
                        print("failure")
                        print(error)
                        if let data = data.data, let responseString = String(data: data, encoding: .utf8) {
                            print(responseString)
                        }
                        continuation.resume(returning: "Failure")
                    }
                }
            }

            return response
        } catch {
            return "Error: \(error)"
        }
    }

    
}


