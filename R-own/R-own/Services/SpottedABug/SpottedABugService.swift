//
//  SpottedABugService.swift
//  R-own
//
//  Created by Aman Sharma on 25/07/23.
//

import SwiftUI
import Alamofire

class SpottedABugService: ObservableObject{
    
    
    // MARK: - multipart service
    
    
    func postABug(img: UIImage?, description: String) async -> String {
        print("Starting to post bugs")
        let api_url = "http://64.227.150.47/main/postBug"
        guard let url = URL(string: api_url) else {
            return "Failure: Invalid URL"
        }

        var urlRequest = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 10.0 * 1000)
        urlRequest.httpMethod = "POST"
        urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")

        guard let img = img, let imgData = img.jpegData(compressionQuality: 0.5) else {
            return "Failure: Invalid image data"
        }

        do {
            let response = try await withCheckedThrowingContinuation { (continuation: CheckedContinuation<DataResponse<Any, AFError>, Error>) in
                AF.upload(multipartFormData: { multiPart in
                    multiPart.append(description.data(using: .utf8)!, withName: "description_bug")
                    multiPart.append(imgData, withName: "bugimg", fileName: randomString(length: 7) + "bug.png", mimeType: "image/png")
                }, with: urlRequest)
                .uploadProgress(queue: .main, closure: { progress in
                    // Current upload progress of file
                    print("Upload Progress: \(progress.fractionCompleted)")
                })
                .responseJSON(completionHandler: { dataResponse in
                    continuation.resume(returning: dataResponse)
                })
            }

            switch response.result {
            case .success(_):
                if let data = response.data,
                   let dictionary = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed) as? NSDictionary {
                    print("Success!")
                    print(dictionary)
                    return "Success"
                } else {
                    return "Failure: Unable to parse response data"
                }
            case .failure(let error):
                print("Failure: \(error.localizedDescription)")
                return "Failure: \(error.localizedDescription)"
            }
        } catch {
            print("Failure: \(error.localizedDescription)")
            return "Failure: \(error.localizedDescription)"
        }
    }



    
}

//struct SpottedABugService_Previews: PreviewProvider {
//    static var previews: some View {
//        SpottedABugService()
//    }
//}
