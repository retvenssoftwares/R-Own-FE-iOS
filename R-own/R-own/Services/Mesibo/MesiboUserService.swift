//
//  MesiboUserService.swift
//  R-own
//
//  Created by Aman Sharma on 12/04/23.
//

import Foundation


class MesiboUserService: ObservableObject{
    
    func fetchMesiboUser(){
        guard let url = URL(string: "http://64.227.150.47/main/users") else {
            print("unable to rectify string in url for api call")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url){ data, _, error in

            DispatchQueue.main.async{
                guard let data = data, error == nil else{
                    return
                }
                do{
                    print(data)
                    let decoder = JSONDecoder()
                    let decodedData = try decoder.decode(MesiboUserCodable.self, from: data)
                    
//                    DispatchQueue.main.async {
//                        loginData.mesiboToken = decodedData.token
//                    }
//                    print("Mesibo add user succeed")
//                    print(loginData.mesiboToken)
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
