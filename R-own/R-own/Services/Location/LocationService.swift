//
//  LocationService.swift
//  R-own
//
//  Created by Aman Sharma on 24/05/23.
//

import Foundation


class LocationService: ObservableObject{
    
    
    func getCountryList(globalVM: GlobalViewModel) async -> String {
        DispatchQueue.main.async {
            globalVM.countriesList = []
        }
        print("Starting to get countries for login page")

        guard let url = URL(string: "http://64.227.150.47/main/countries") else {
            return "Failure: Invalid URL"
        }

        // Create the request
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        do {
            let (data, response) = try await URLSession.shared.data(for: request)

            guard (200 ..< 299) ~= (response as! HTTPURLResponse).statusCode else {
                return "Failure: HTTP request failed"
            }

            let decoder = JSONDecoder()
            let decodedData = try decoder.decode([CountryModel].self, from: data)
            
            DispatchQueue.main.async {
                globalVM.countriesList = decodedData
            }

            return "Success"
        } catch {
            return "Failure: \(error.localizedDescription)"
        }
    }
    
    func getStateList(globalVM: GlobalViewModel, countryCode: String) async -> String {
        DispatchQueue.main.async {
            globalVM.stateList = []
        }
        print("Starting to get state")

        guard let url = URL(string: "http://64.227.150.47/main/countries/\(countryCode)/states") else {
            print("Error: cannot create URL")
            return "Failure: Invalid URL"
        }

        // Create the request
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            guard (200 ..< 299) ~= (response as! HTTPURLResponse).statusCode else {
                print("Error: HTTP request failed")
                return "Failure: Invalid Response"
            }

            let decoder = JSONDecoder()
            let decodedData = try decoder.decode([StateModel].self, from: data)
            DispatchQueue.main.async {
                globalVM.stateList = decodedData
            }
            return "Success"
        } catch {
            print("Error: \(error.localizedDescription)")
            return "Failure: \(error.localizedDescription)"
        }
    }
    
    
    func getCityList(globalVM: GlobalViewModel, countryCode: String, stateCode: String) async -> String {
        DispatchQueue.main.async {
            globalVM.cityList = []
        }
        print("Starting to get cities")

        guard let url = URL(string: "http://64.227.150.47/main/countries/\(countryCode)/states/\(stateCode)/cities") else {
            return "Failure: Invalid URL"
        }

        // Create the request
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        do {
            let (data, response) = try await URLSession.shared.data(for: request)

            guard (200 ..< 299) ~= (response as! HTTPURLResponse).statusCode else {
                return "Failure: HTTP request failed"
            }

            let decoder = JSONDecoder()
            let decodedData = try decoder.decode([CityModel].self, from: data)
            DispatchQueue.main.async {
                globalVM.cityList = decodedData
            }
            return "Success"
        } catch {
            return "Failure: \(error.localizedDescription)"
        }
    }
    
    
    // MARK: - fetch service


    func getCountriesForBar(loginData: LoginViewModel) {
    
        loginData.countriesList = [CountriesForBar]()
        //Updating the user Interest
        print("Starting to get countries for search bar")
    
        guard let url = URL(string: "http://64.227.150.47/main/fetchCountry") else {
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
                    let decodedData = try decoder.decode([CountriesForBar].self, from: data)
                    
                    loginData.countriesList = decodedData
    
                } catch {
                    print("Error: Trying to convert JSON data to string")
                    return
                }
            }
        }
        task.resume()
    }
    
}
