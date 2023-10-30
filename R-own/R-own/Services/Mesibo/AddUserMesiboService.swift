//
//  AddUserMesiboService.swift
//  R-own
//
//  Created by Aman Sharma on 10/04/23.
//

import Foundation
import SwiftUI

class AddUserMesiboService: ObservableObject{


    func addUserToMesibo(loginData: LoginViewModel) {

        print("Creating messibo user via this number:")

        guard let url = URL(string: "http://64.227.150.47/main/userCreate") else {
            print("unable to rectify string in url for api call")
            return
        }

        print("Making API Call for adding user to mesibo...........")

        var request = URLRequest(url: url)

        //method, body, headers

        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let body: [String: AnyHashable] = [
            "Address": loginData.mainUserPhoneNumber
        ]

        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)

        //Make the request

        let task = URLSession.shared.dataTask(with: request){ data, _, error in

            DispatchQueue.main.async{
                guard let data = data, error == nil else{
                    return
                }
                do{
                    print(data)
                    let decoder = JSONDecoder()
                    let decodedData = try decoder.decode(AddUserResponse.self, from: data)
                    
                    DispatchQueue.main.async {
                        loginData.mainUserMesiboToken = decodedData.token
                        loginData.mainUserMesiboUID = decodedData.uid
                    }
                    
                    print("Mesibo add user succeed")
                    print(loginData.mainUserMesiboToken)
//                    loginData.mesiboToken = addUserResponse.token
                    return
                } catch {
                    print(error)
                }
            }
        }
        task.resume()
    }

}
