//
//  ContactService.swift
//  R-own
//
//  Created by Aman Sharma on 27/04/23.
//


import Foundation


class ContactService: ObservableObject{
    
    func pushContactInServer(loginData: LoginViewModel, contacts: [AnyHashable], globalVM: GlobalViewModel, contactService: ContactService) async -> String {
        print("Starting to update contact data in user profile")
        
        guard let url = URL(string: "http://64.227.150.47/main/contacts") else {
            print("Error: cannot create URL")
            return "Failure: Invalid URL"
        }
        let userID = await loginData.mainUserID
        
        // Create & Add data to the model
        let body: [String: AnyHashable] = [
            "User_id": userID,
            "ContactDetails": contacts
        ]
        
        
        // Create the request
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            // Convert request to JSON data
            request.httpBody = try JSONSerialization.data(withJSONObject: body)
            let (data, response) = try await URLSession.shared.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse, (200 ..< 299) ~= httpResponse.statusCode else {
                print("Error: HTTP request failed")
                return "Failure: HTTP request failed"
            }
            
            let decoder = JSONDecoder()
            let decodedData = try decoder.decode(NormalMessageResponse.self, from: data)
            
            print("contacts data updated on server")
            
            DispatchQueue.main.async {
                loginData.loginStatusFinal = true
            }
            let res = await contactService.getContactsConnections(globalVM: globalVM, userID: loginData.mainUserID, loginData: loginData)
            if res == "Success" {
                DispatchQueue.main.async {
                    loginData.showLoader = false
                }
                return "Success"
            } else {
                DispatchQueue.main.async {
                    loginData.showLoader = false
                }
                return "Failure"
            }
            
        } catch {
            print("Error: \(error)")
            return "Failure: \(error.localizedDescription)"
        }
    }

    
    func getContactsConnections(globalVM: GlobalViewModel, userID: String, loginData: LoginViewModel) async -> String {
        DispatchQueue.main.async {
            
            globalVM.userContactConnectionList = ContactsUserConnectionModel(message: "", matchedContacts: [MatchedContact(matchedNumber: MatchedNumber(id: "", fullName: "", profilePic: "", mesiboAccount: [MesiboAccount](), verificationStatus: "", userBio: "", role: "", normalUserInfo: [NormalUserInfo](), hospitalityExpertInfo: [JSONAny](), userID: "", connections: [Connection](), requests: [Connection]()), connectionStatus: "")])
        }
        
        print("Starting to get connection from contacts")
        guard let url = URL(string: "http://64.227.150.47/main/detailsOf/\(userID)") else {
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
            let decodedData = try decoder.decode(ContactsUserConnectionModel.self, from: data)
            
            DispatchQueue.main.async {
                globalVM.userContactConnectionList = decodedData
                loginData.showLoader = false
            }
            return "Success"
        } catch {
            print("Error: \(error)")
            return "Failure: \(error.localizedDescription)"
        }
    }

    
    
    // MARK: - post service

    func checkIfContactsSynced(loginData: LoginViewModel) {
    
        //Updating the user Interest
        print("Starting to  contacts synced")
    
        guard let url = URL(string: "http://64.227.150.47/main/checkContacts") else {
            print("Error: cannot create URL")
            return
        }
    
        // Create & Add data to the model
        let body: [String: AnyHashable] = [
            "User_id": loginData.mainUserID
        ]
        
    
    
        // Create the request
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
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
                    
                    loginData.contactsSynced = decodedData.message
                    
                } catch {
                    print("Error: Trying to convert JSON data to string")
                    return
                }
            }
        }
        task.resume()
    
    }
    
    // MARK: - fetch service


    func getContactSyncText(loginData: LoginViewModel) {
    
        //Updating the user Interest
        print("Starting to get contact sync text")
    
        guard let url = URL(string: "http://64.227.150.47/main/getsynccontact") else {
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
                    let decodedData = try decoder.decode([ContactSyncTextModel].self, from: data)
                    
                    loginData.contactsText = decodedData[0].conatctSynctext
    
                } catch {
                    print("Error: Trying to convert JSON data to string")
                    return
                }
            }
        }
        task.resume()
    }
    
}
